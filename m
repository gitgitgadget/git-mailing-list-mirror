From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Fri, 23 Sep 2011 12:23:40 -0700
Message-ID: <7vwrczt64j.fsf@alter.siamese.dyndns.org>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
 <7vr53a2icn.fsf@alter.siamese.dyndns.org>
 <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
 <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
 <7vobycxy71.fsf@alter.siamese.dyndns.org>
 <CALUzUxrswZ+AREq+OeqpTsnoB4J+_aExfmAA6X3cauJqj8RnpQ@mail.gmail.com>
 <CALUzUxoujys1eWL6i6YJmFZZakcQx8oa8ZbRjixUzANB1Hpb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Pepper <pepper@inf.fu-berlin.de>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7BLh-0007Ne-OE
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab1IWTXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:23:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab1IWTXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:23:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C1704659;
	Fri, 23 Sep 2011 15:23:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hm2nsEeGMioDuJXNorXpWeRb3+Y=; b=mHF3m1
	YNiZ1kSWbpqQR8TYUj6TyeSoQsJA1W9QM/kU1olAGnxGpTg7k7K+UQyQm1xcsBkS
	C5zLqNFLnAxrs2lx7QH+RV53IlaxjCGh900rrBZworj0jlRZH2lfkwhMJXSlkzJE
	iQq/u9DIpFsnHtqxIc9UmIRUYBRWY9y5JuumI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFGSEhDLh/zHT3o6QGbDlz7T74LaDT3A
	v/9heXjrMfpCRe018PRYKH0etE0NHfev/Jilg1cfUG7AiAeVyYO00e5AQaMwesdK
	9jVhRigEHItYR8OR3Pb0P0HXvi1lxucAqUwYI9EjFCN9qfiIU150YAzpQ2ZEI3Sw
	SWs0Hj57dIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630CC4658;
	Fri, 23 Sep 2011 15:23:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B974A4656; Fri, 23 Sep 2011
 15:23:41 -0400 (EDT)
In-Reply-To: <CALUzUxoujys1eWL6i6YJmFZZakcQx8oa8ZbRjixUzANB1Hpb3Q@mail.gmail.com> (Tay Ray
 Chuan's message of "Sat, 24 Sep 2011 00:38:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BF40912-E619-11E0-832C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181992>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On further thought, I think the patch merely side-steps the problem -
> ie. that -U0 generates "incorrect" diffs.

I do not know if there anything "incorrect" about it.

When the file have common blocks lines in different places that are not
modified, the comparison between preimage and postimage is free to choose
how these common blocks are matched, and for that reason it is incorrect
to expect that "diff -U0", "diff -U3" and "diff -U20" would produce the
identical results.

> I think this function is incorrect. xdl_cleanup_records() and
> xdl_clean_mmatch() may potentially look into common tail lines, so it
> may not be "safe" to drop all common tail lines.

I would prefer to keep that common trimming optimization, and also to see
the same common trimming logic extended to trim (and adjust offsets) at
the beginning as well in the longer term.  If xdl_cleanup_records() and
xdl_clean_mmatch() need to become aware of the change in the total number
of lines made by trim_common_tail(), please make it so.

>
> -- >8 --
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 0e2c169..da4fab6 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -131,7 +131,7 @@
>         mmfile_t a = *mf1;
>         mmfile_t b = *mf2;
>
> -       trim_common_tail(&a, &b, xecfg->ctxlen);
> +/*     trim_common_tail(&a, &b, xecfg->ctxlen);  */
>
>         return xdl_diff(&a, &b, xpp, xecfg, xecb);
>  }
> -- >8 --
