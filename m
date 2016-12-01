Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5411FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934420AbcLAUYY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:24:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59231 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934001AbcLAUYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:24:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4891753A71;
        Thu,  1 Dec 2016 15:24:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZFWqHH0bExGl
        I3Xdvy8c2ZCQunc=; b=RC4E716p3IFEm6XqwMRjMwUJamdCCX5qXyHHhFrnCS/w
        6Rqz2wnSyI6L/asQWQpveHT10utcUxeyNC8f+5i7eb+vZ5WY9hIcYTJWZYG98DOU
        EzOa8c/abII/jTy6JfwUQ7DBBDW0mZgIOqntoro+6EUsr8dSoSsXMg/0+l20mJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=V2lwFs
        vpsfWmqwr3aSg38HWKkz078a2tvdROuyAy2JxCfdQdypkQTxI5aMMj6SFE6E/J8z
        Et4yN9BcwncCLsEfCy9gdSTxrwTsNI16xL07dKnLgcbskV6+aBG2DJgrIzIVreKl
        1C/4cHSctkO6VHobbs6fgdQsg3ewZjSQYnPjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F60053A70;
        Thu,  1 Dec 2016 15:24:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C635E53A6D;
        Thu,  1 Dec 2016 15:24:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git mailing list <git@vger.kernel.org>,
        eevee.reply@veekun.com
Subject: Re: [PATCH v2 1/1] convert: git cherry-pick -Xrenormalize did not work
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
        <20161130170232.19685-1-tboegi@web.de>
        <CA+P7+xoJb=SukbnJVJrXR6WV9+UtGnsn776KGkrHC7X-T_wZWg@mail.gmail.com>
Date:   Thu, 01 Dec 2016 12:24:20 -0800
In-Reply-To: <CA+P7+xoJb=SukbnJVJrXR6WV9+UtGnsn776KGkrHC7X-T_wZWg@mail.gmail.com>
        (Jacob Keller's message of "Thu, 1 Dec 2016 12:07:13 -0800")
Message-ID: <xmqqtwan8kjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24CE1F3A-B804-11E6-8A43-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Nov 30, 2016 at 9:02 AM,  <tboegi@web.de> wrote:
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>> diff --git a/convert.c b/convert.c
>> index be91358..f8e4dfe 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -281,13 +281,13 @@ static int crlf_to_git(const char *path, const c=
har *src, size_t len,
>>                 /*
>>                  * If the file in the index has any CR in it, do not c=
onvert.
>>                  * This is the new safer autocrlf handling.
>> +                  - unless we want to renormalize in a merge or cherr=
y-pick
>
> Style nit, usually this line should begin with an aligned *? I think
> it's not really that big a deal, though.

Yup, this is what I queued.

-- >8 --
From: Torsten B=C3=B6gershausen <tboegi@web.de>
Date: Wed, 30 Nov 2016 18:02:32 +0100
Subject: [PATCH] convert: git cherry-pick -Xrenormalize did not work

Working with a repo that used to be all CRLF. At some point it
was changed to all LF, with `text=3Dauto` in .gitattributes.
Trying to cherry-pick a commit from before the switchover fails:

    $ git cherry-pick -Xrenormalize <commit>
    fatal: CRLF would be replaced by LF in [path]

Commit 65237284 "unify the "auto" handling of CRLF" introduced
a regression:

Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
SAFE_CRLF_RENORMALIZE was feed into check_safe_crlf().  This is
wrong because here everything else than SAFE_CRLF_WARN is treated as
SAFE_CRLF_FAIL.

Call check_safe_crlf() only if checksafe is SAFE_CRLF_WARN or
SAFE_CRLF_FAIL.

Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 077f5e601e..2f90f363c6 100644
--- a/convert.c
+++ b/convert.c
@@ -274,15 +274,16 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 		if (convert_is_binary(len, &stats))
 			return 0;
 		/*
-		 * If the file in the index has any CR in it, do not convert.
-		 * This is the new safer autocrlf handling.
+		 * If the file in the index has any CR in it, do not
+		 * convert.  This is the new safer autocrlf handling,
+		 * unless we want to renormalize in a merge or
+		 * cherry-pick.
 		 */
-		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
-			checksafe =3D SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
+		if ((checksafe !=3D SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
 			convert_crlf_into_lf =3D 0;
 	}
-	if (checksafe && len) {
+	if ((checksafe =3D=3D SAFE_CRLF_WARN ||
+	    (checksafe =3D=3D SAFE_CRLF_FAIL)) && len) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
--=20
2.11.0-192-gbadfaabe38

