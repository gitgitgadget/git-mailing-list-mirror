From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use
 suffixcmp() instead
Date: Mon, 04 Nov 2013 21:16:27 +0100 (CET)
Message-ID: <20131104.211627.54064800775850019.chriscool@tuxfamily.org>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org>
	<xmqqbo20ynxs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, apenwarr@gmail.com, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 04 21:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdQZz-0003kN-4p
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 21:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab3KDUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 15:16:51 -0500
Received: from [194.158.98.45] ([194.158.98.45]:41244 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750819Ab3KDUQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 15:16:50 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 3F63655;
	Mon,  4 Nov 2013 21:16:28 +0100 (CET)
In-Reply-To: <xmqqbo20ynxs.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237299>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp() instead
Date: Mon, 04 Nov 2013 11:19:43 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> Commit 8cc5b290 (git merge -X<option>, 25 Nov 2009) introduced
>> suffixcmp() with nearly the same implementation as postfixcmp()
>> that already existed since commit 211c8968 (Make git-remote a
>> builtin, 29 Feb 2008).
> 
> This "nearly the same" piqued my curiosity ;-)

Yeah, I realize I should have explained the differences.
 
> The postfixcmp() you are removing will say "f" > ".txt" while
> suffixcmp() will say "f" < ".txt".
> 
> As postfixcmp() is only used to compare for equality, the
> distinction does not matter and does not affect the correctness of
> this patch, but I am not sure which answer is more correct.

Yeah, that's also my opinion. I am not even sure if there is one more
correct answer than the other.

> I do not think anybody sane uses prefixcmp() or suffixcmp() for
> anything but checking with zero; in other words, I suspect that all
> uses of Xcmp() can be replaced with !!Xcmp(), so as a separate
> clean-up patch, we may at least want to make it clear that the
> callers should not expect anything but "does str have sfx as its
> suffix, yes or no?" by doing something like this:
> 
>  int suffixcmp(const char *str, const char *suffix)
>  {
>  	int len = strlen(str), suflen = strlen(suffix);
>  	if (len < suflen)
>  		return -1;
>  	else
> -		return strcmp(str + len - suflen, suffix);
> +		return !!strcmp(str + len - suflen, suffix);
>  }
> 
> I am not absolutely sure about doing the same to prefixcmp(),
> though. It could be used for ordering, even though no existing code
> seems to do so.

I agree.

I will resend a 2 patch long patch series where the first patch will
have an improved commit message and the second patch will do what you suggest above.

Thanks,
Christian.
