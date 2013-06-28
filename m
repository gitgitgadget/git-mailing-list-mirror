From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 28 Jun 2013 09:09:53 +0100
Message-ID: <20130628080953.GD2232@serenity.lan>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 10:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsTut-0004jo-Cf
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 10:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab3F1IUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 04:20:21 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52255 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3F1IUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 04:20:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D58C2606547;
	Fri, 28 Jun 2013 09:20:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XvjJSPCny2Lk; Fri, 28 Jun 2013 09:20:13 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 5A055198007;
	Fri, 28 Jun 2013 09:20:08 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id F3FDA161E513;
	Fri, 28 Jun 2013 09:10:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0s7R0ECQz1u; Fri, 28 Jun 2013 09:10:04 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BB541161E4DF;
	Fri, 28 Jun 2013 09:09:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229179>

On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> Because letting a trivial merge automatically handled by Git is so
> easy with "git pull", a person who is new to Git may not realize
> that the project s/he is interacting with may prefer "rebase"
> workflow.  Add a safety valve to fail "git pull" that is not a
> fast-forward until/unless the user expressed her preference between
> the two.
> 
> Those who want the existing behaviour could just do
> 
>     git config --global pull.rebase false
> 
> once, and they'd not even notice.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
> 
> for a full discussion.
> 
> The fallout from this change to test suite is not very pretty, though.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
[snip]
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index c56a77d..af02c6d 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -79,7 +79,7 @@ test_expect_success \
>  
>  test_expect_success \
>      'merge-setup part 3' \
> -    'git pull . branch1'
> +    'git pull --merge . branch1'

I think the "--merge" should be implied here because the suer has
specified an explicit remote and branch.  Similarly, if "--ff",
"--no-ff" or "--ff-only" are given then we can infer "--merge" in the
absence of any other configuration.

However, when I looked at doing this I decided that it would be
difficult to get that ideal behaviour without rewriting git-pull as a
builtin.
