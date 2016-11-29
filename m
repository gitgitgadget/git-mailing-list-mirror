Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5651FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 20:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbcK2UpT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 15:45:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752420AbcK2UpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 15:45:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A3C84F469;
        Tue, 29 Nov 2016 15:45:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aPxTXao3xLLU
        GEycL+fqLzgxJdM=; b=wpItMOWJWhb9dxrOBYN0D0UDMN+i4A5dXqNisk7mXVQS
        lYW/1SG//70FUUBPQjCejK0JGBsa0i6W9tVzo8XYqR34yEPPFaWqFTn2rdELpxnl
        Qc2+zJU5hEBle2dhMUdP1+ZoR45CIuL+9MpAtYCVQaoD8w+9U0B2Tv0ktSg2uJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iqrkXo
        MT/1mKAlkuAV8/as0S8O0GDrkOCRx3yieLs8YE+0GPHw3Y3X/HKKGK2RTWuXDvdo
        X9dn1z7BpiuxEeTSL+lX0IjNrGfzo6wOBi9Lb4dTuG1bU7IWCOW4GFQ+RFukiGSP
        tEdY9Dn2ETa1nnI6vsh1jE4D8Ku1S5GMOr1XY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C2324F468;
        Tue, 29 Nov 2016 15:45:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C8514F466;
        Tue, 29 Nov 2016 15:45:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, eevee.reply@veekun.com
Subject: Re: [PATCH v1 1/1] convert:  git cherry-pick -Xrenormalize did not work
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
        <20161129163023.23403-1-tboegi@web.de>
        <xmqq7f7mgmb9.fsf@gitster.mtv.corp.google.com>
        <20161129201600.GA14333@tb-raspi>
Date:   Tue, 29 Nov 2016 12:45:14 -0800
In-Reply-To: <20161129201600.GA14333@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
        message of "Tue, 29 Nov 2016 20:16:00 +0000")
Message-ID: <xmqqzikidnhh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB47D528-B674-11E6-B038-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks for the review - how about this:
>
>
> convert: git cherry-pick -Xrenormalize did not work
>
> Working with a repo that used to be all CRLF. At some point it
> was changed to all LF, with `text=3Dauto` in .gitattributes.
> Trying to cherry-pick a commit from before the switchover fails:
>
> $ git cherry-pick -Xrenormalize <commit>
>     fatal: CRLF would be replaced by LF in [path]
>
> Commit 65237284 "unify the "auto" handling of CRLF" introduced
> a regression:
>
> Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
> SAFE_CRLF_RENORMALIZE was feed into check_safe_crlf().
> This is wrong because here everything else than SAFE_CRLF_WARN is
> treated as SAFE_CRLF_FAIL.

What is still left unsaid is that we shouldn't even bother seeing if
it is safe to do crlf conversion when renormalizing.  Perhaps that
is too obvious to state?

In any case, when you put the rationale that way, the impression I
get from it is that the root cause of the problem is that "here"
(aka "check_safe_crlf()") considers anything other than CRLF_WARN as
a failure, when a newer choice other than CRLF_WARN and CRLF_FAIL
(namely, CRLF_RENORMALIZE) exists.  Which hints me that a sensible
change may be to fix that function.

The patch you sent has the effect of not entering this whole block,
not just "don't call check_safe_crlf() because it misbehaves":

	if (checksafe && len) {
		struct text_stat new_stats;
		memcpy(&new_stats, &stats, sizeof(new_stats));
		/* simulate "git add" */
		if (convert_crlf_into_lf) {
			new_stats.lonelf +=3D new_stats.crlf;
			new_stats.crlf =3D 0;
		}
		/* simulate "git checkout" */
		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
			new_stats.crlf +=3D new_stats.lonelf;
			new_stats.lonelf =3D 0;
		}
		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
	}

And it is a sensible thing to do, because all the computation that
happens in the block before check_safe_crlf() is called is done ONLY
to prepare the parameter passed to check_safe_crlf(); if we are to
make the function no-op for CRLF_RENORMALIZE, preparing new_stats is
a wasted effort.

However, futzing with the value of checksafe in the function is
ugly.  It is not even unclear if it is safe to do so without reading
the remainder of the function (i.e. later parts of the function may
care--or start caring in the future--what the caller passed in the
variable).  Yes, the function already modifies the variable, but
that can also be fixed.

In other words, I would have expected that a fix that matches your
description to look more like below.  The condition for the "if"
statement may even want to become

	if ((checksafe =3D=3D SAFE_CRLF_WARN ||
	    (checksafe =3D=3D SAFE_CRLF_FAIL)) && len)

to clarify it further.

Thanks.

 convert.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index f9f7f5e436..d72e0bf0d7 100644
--- a/convert.c
+++ b/convert.c
@@ -282,12 +282,11 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 		 * If the file in the index has any CR in it, do not convert.
 		 * This is the new safer autocrlf handling.
 		 */
-		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
-			checksafe =3D SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
+		if (checksafe !=3D SAFE_CRLF_RENORMALIZE &&
+		    has_cr_in_index(path))
 			convert_crlf_into_lf =3D 0;
 	}
-	if (checksafe && len) {
+	if (checksafe && checksafe !=3D SAFE_CRLF_RENORMALIZE && len) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */


