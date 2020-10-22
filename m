Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B3C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F2F24656
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsyR7ajp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370158AbgJVTZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370155AbgJVTZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 15:25:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4718C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 12:25:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h140so2926785qke.7
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x8sNaAqzyNZ4gPUwIcGjQ2VDqUbrsSJGEK8M1UCpvi0=;
        b=LsyR7ajpdceChZYH+UWc4pQNC8msb8AinI/nWfNJ/Tf0AapV+3EMJdxrb0HG8tSTqy
         wTPYDwBjxrv+FxoOlISjMZrEf9uVcp5MlEUwb6sDGiDAz1UWI0vkHoLpLdC/qm3QxIHi
         1yjJJuFznAqsxrnCosakfha8onI/pMr9sbA3sr+3MxV9wzwzldEDxDAL8qJLDkNPm+hR
         YL0lbBbBWBQMCRG9KVnmrtbakQEtCYnC7fIdn3v+qSI0FEYlf0XZBofKxFNzHYSszw0c
         eDKotv2EZ2hzIB3/2wcfWa1jf8BAAd3z3MBj/ne9N6F5lmo/lOREJTsMuyT4kol1t+lS
         Fggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x8sNaAqzyNZ4gPUwIcGjQ2VDqUbrsSJGEK8M1UCpvi0=;
        b=UruhrY9JTsJkGj4ddR3uYmnqxHr52uS2Nyg0Z/3PDltJpM2lkiDiUf+0w50/LiL+OQ
         MYJQD0hXk44YlzGl49uaE4XjJN35JIN8Xd2lBpuRd9fIlfvsDFWyK5/+1BPafUu3VFbC
         nsQ5FTN/cXAu16GC3vf0CmICRskecKtNZnjAkcwihePu+EkOG5FmJZCUuFoJSpYbnHUL
         AxhYHLPNQOn00rOCl+n0kNkOufleVbt/578UmS+qLfZRrJiTyZbmg0ROjE2JPpnQL07A
         +xTrt8zxwiceK9fMM37SVP8ku17vKnWWIciZboFn1wdefPVO9AxHIeakVxrAX2UNAH5t
         03ow==
X-Gm-Message-State: AOAM531w1c+Z4Q2iXA9OHcPe8IkmFogQc9ABGHmhk2RbpQ/4sc2y8jla
        RF7Ogp6NkcWUPLif1b3t70E=
X-Google-Smtp-Source: ABdhPJzAABXpwiprwxFm0pEvgk+x0/wKMR9vEsOGUMuBru4vccjD+5quIw7Ycuuy+P/Z3d+WjgmWfg==
X-Received: by 2002:a37:d8b:: with SMTP id 133mr3931341qkn.131.1603394701867;
        Thu, 22 Oct 2020 12:25:01 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t65sm1793191qkc.52.2020.10.22.12.24.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2020 12:25:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] log, show: add tests for messages containing CRLF
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <75a87887be5d8364b37655f0588ed98a52de92bc.1603335680.git.gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 15:24:54 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED48F9A2-A8F6-4332-BB5E-C767D0C23AC0@gmail.com>
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <pull.576.v4.git.1603335680.gitgitgadget@gmail.com> <75a87887be5d8364b37655f0588ed98a52de92bc.1603335680.git.gitgitgadget@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 21 oct. 2020 =C3=A0 23:01, Philippe Blain via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> A previous commit fixed a bug in ref-filter.c causing messages
> containing CRLF to be incorrectly parsed and displayed.
>=20
> Add tests to also check that `git log` and `git show` correctly handle
> such messages, to prevent futur regressions if these commands are
> refactored to use the ref-filter API.
>=20
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> t/t3920-crlf-messages.sh | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>=20
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 3f0ce02c3f..b6e09be412 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -105,4 +105,22 @@ test_crlf_subject_body_and_contents tag --list =
tag-crlf*
>=20
> test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
>=20
> +test_expect_success 'log: --oneline works with messages using CRLF' '
> +	for branch in $LIB_CRLF_BRANCHES
> +	do
> +		cat .crlf-subject-${branch}.txt >expect &&
> +		printf "\n" >>expect &&
> +		git log --oneline -1 ${branch} >tmp-branch &&
> +		git log --oneline -1 tag-${branch} >tmp-tag &&
> +		cut -d" " -f2- <tmp-branch >actual-branch &&
> +		cut -d" " -f2- <tmp-tag >actual-tag &&
> +		test_cmp expect actual-branch &&
> +		test_cmp expect actual-tag
> +	done

I just realized that I'm missing this in this patch :

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index b6e09be412..70ddce3a2e 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -115,7 +115,7 @@ test_expect_success 'log: --oneline works with =
messages using CRLF' '
 		cut -d" " -f2- <tmp-branch >actual-branch &&
 		cut -d" " -f2- <tmp-tag >actual-tag &&
 		test_cmp expect actual-branch &&
-		test_cmp expect actual-tag
+		test_cmp expect actual-tag || return 1
 	done
 '

I'll wait a few days for any further comments and re-send with this =
tweak.

Philippe.=
