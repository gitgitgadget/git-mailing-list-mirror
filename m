From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] Add new @ shortcut for HEAD
Date: Mon, 09 Sep 2013 15:54:31 -0700
Message-ID: <xmqq38pd38t4.fsf@gitster.dls.corp.google.com>
References: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
	<1378103670-3394-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opsprq.fsf@gitster.dls.corp.google.com>
	<CAMP44s1-+i30CuTH5uRpu4Qi_hWhHmygc2-quYkTrrBV+4hZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJALu-0003cW-5R
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab3IIWye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:54:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab3IIWye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:54:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9859C40282;
	Mon,  9 Sep 2013 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PhLk4cZO1gZX2kTT3iqqF71zDIo=; b=wvuiNDTTi031M4qUt9Nt
	XLowyvm51W3ml7Y0IsuqPHHi8Z2/o7MAlc5KNaTrxcVO3DhdgDGCFIFUrbbwwH2J
	R1TKntsS3iL9qeC/89L+4Q+yqrn7UwV0kzNfWrP8CAYtTJToL52rpOfCU01AzIM3
	a80qgydgYAwazQ/qZO/QoQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KxhxybqbbFw15gfcBO3Ik3rM3FP/cQa9Ea/o0JY9GyE/IW
	RJoXMTWAsBw0MM9i2UhfY7lWWwcMJddYwLVOfIw0D92aDsIev3ecnEzs66S6YVQM
	60+6cA+yK/coKnzYVu21HMSb0UErX0xDUgYET//jfsLC5uh5nVlQhc7yhpHuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC2540281;
	Mon,  9 Sep 2013 22:54:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9D664027C;
	Mon,  9 Sep 2013 22:54:32 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CACC0E46-19A2-11E3-AD94-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234391>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Hmph, is the above sufficient?  I added a case that mimics Stefano's
>> original regression report (which is handled) and another that uses
>> doubled "@" for the same purpose of introducing a "funny" hierarchy,
>> and it appears that "checkout -b" chokes on it.
>
> This fixes it:
>
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1014,6 +1014,8 @@ static int interpret_empty_at(const char *name,
> int namelen, int len, struct str
>
>         /* make sure it's a single @, or @@{.*}, not @foo */
>         next = strchr(name + len + 1, '@');
> +       if (next && next[1] != '{')
> +               return -1;
>         if (!next)
>                 next = name + namelen;
>         if (next != name + 1)

I think this should be sufficient for all cases, as the sequence
"@{" cannot be a part of valid reference names.

Thanks.

I see v6 was posted yesterday after this message, but it does not
seem to have this fix, nor the additional test case I gave you in
the message upthread.  Sent a wrong version of patch by mistake?
