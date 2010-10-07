From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Wed, 06 Oct 2010 21:13:35 -0700
Message-ID: <7vtykyy70w.fsf@alter.siamese.dyndns.org>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 06:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3hrb-0007aZ-8z
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab0JGENn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 00:13:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0JGENm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18DCADC6D3;
	Thu,  7 Oct 2010 00:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mscCawGtgG2CAaedeFa6eCsqC9k=; b=wv4KMKgr3shA4NT4H76Nd2P
	Joi7eaf6qhxRIaoi0rJ/IsRwoYvSGg+0mVK4eV0Aw1f2oo2O7y376183K/Zn4hMA
	oUNndQbf44dIDt/XLezwV7EVe+HHjEFueS/tK9bcfUu3Xjq0IOvi7YFp6vpRX3iy
	holrMGj59OHob1OA5X3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JizfmIWklro1vnypUGqG60mSjCOeKc7oHDxYb6ExnnYDb15SG
	qk1egHVa5G3j0j1JP5ghRU31HLe09nSoqyPMYOnojkP8VJ1GoMLWAAmS3FVZvCtO
	XkcfxPL04M4luzAFAnv56d6z1RcoGayG/x1+K1ECTDjHaiNvA9KokziYD8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1F8ADC6D2;
	Thu,  7 Oct 2010 00:13:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF0C1DC6D0; Thu,  7 Oct
 2010 00:13:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 438D1EB2-D1C9-11DF-8A15-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158364>

David Miller <davem@davemloft.net> writes:

> From: David Miller <davem@davemloft.net>
> Date: Wed, 06 Oct 2010 17:37:14 -0700 (PDT)
>
>> 
>> When I ask git to format-patch a commit that is just a file
>> permission change, it ends up generating an empty file, not
>> even the commit message is included.
>
> Ok it turns out that the commit in question was a NOP since the file
> permissions didn't change.
>
> But even if the patch is truly empty, format-patch should still give
> me the commit message shouldn't it?

Probably; we have strongly encouraged people not to commit no-op, so I
guess nobody stumbled upon this corner case.

Perhaps something like this?

 builtin/log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 22d1290..6baba7d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1057,6 +1057,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.no_merges = 1;
+	rev.always_show_header = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
