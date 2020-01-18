Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA550C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF59524690
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye+R98QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgARVJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:09:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47094 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgARVJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 16:09:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id e25so13347687qtr.13
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ENPnX0s9y+WgHraLdGapI3TbH0+ozMU7JQjINKHxxn4=;
        b=Ye+R98QTJD8WxSpI8mO+8LFGEDdRXrymTmJ/bctxR/5aKxBAP1RNHLDuzPkyt283os
         Y22xq3t1gRIkbtdiUA65HFkM2IMMUf1fdRTGCZYLS8MzRZrAF2X2UY+Y4QsWAPVDjloH
         +rmEGBHAhXux0MdaMMNlv8Lnumct3v7DFMfVyXTjME9pH4h+ZRSsVgHFLaqh2cDYOyZ1
         lqOWoD1ufuduhKJraiOAa+wgIeYCA91L3TWhP38ESf6Z7m5b8Cz2RgniY4xl4OOYVTNZ
         ucSlGY0eYkg7E/fpvJj2UsJ3HyUJvdmWArthDs7Vwkfh6umsbDpzaAE47u6kz6TGpS9r
         lzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ENPnX0s9y+WgHraLdGapI3TbH0+ozMU7JQjINKHxxn4=;
        b=H1ljoCtHMkGXH8wEMXTV0zsK03U00Wp5LGkYWZnaU8qGC7+3/SxFSa/TqrJYqI61J1
         jDYi3tanX1rzZaUw2anbzECdDvgxd2w6r09rBCVU2Att6HDc7FKK6DOpVXdLLiHaHM8T
         sXzZEhmDVeA3TCRFeTGDLhS5cG50OrFTirjAQmwZBrhROuViuWcoskM86Rz5+EkYMoRR
         EqsumunJuXNL4p2/FgALXMnaulxmPUq/ufQ3ORhCv7xoLfuHR8nUmjagXO887FeEimJo
         3UO3qv9yDGjmN/2ibghhA77iuE6OSbP0cOfbFgYfpzVUEwXzhLzKltoO3TJhqVWLw3RF
         pqEg==
X-Gm-Message-State: APjAAAW3hrxTW+n2MCXxHZ/Zhiix/FaBGycVcsmh7pcd8/XIWI6dhBO/
        6bZeXGM2zxNqdth+UaqCABs=
X-Google-Smtp-Source: APXvYqz1Bb4UC/JphcvcvvUig/csYYRYtJTtrTfaI/bihuFUuxepCpnUz++3ZAsgZJfCTt69B8mhVw==
X-Received: by 2002:ac8:6909:: with SMTP id e9mr13766729qtr.339.1579381788955;
        Sat, 18 Jan 2020 13:09:48 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x16sm13438098qki.110.2020.01.18.13.09.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 13:09:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/4] submodule.c: use get_git_dir() instead of get_git_common_dir()
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <b97f7dc2-9cc9-9665-e00e-1cbb8b0996e4@gmail.com>
Date:   Sat, 18 Jan 2020 16:09:47 -0500
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D28196FE-67A1-4D03-8EFD-34ECC5633062@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <72cdb2f95d8c03c7b0324e8132e04e3a10248432.1579263809.git.gitgitgadget@gmail.com> <b97f7dc2-9cc9-9665-e00e-1cbb8b0996e4@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

> Le 17 janv. 2020 =C3=A0 08:24, Derrick Stolee <stolee@gmail.com> a =
=C3=A9crit :
>=20
>> Additionnally, if switching to a commit where the submodule is not =
present,
>=20
> s/Additionnally/Additionally
fixed.
>=20
>> +	cat checkout-recurse/sub/.git > expect-gitfile &&
>=20
> Here, and the rest of these tests, please drop the space between the =
">" and
> the output file: ">expect-gitfile =C2=BB.
fixed.
>=20
>> +	git -C main/sub rev-parse HEAD > expect-head-main &&
>> +	git -C checkout-recurse checkout --recurse-submodules HEAD~1 &&
>> +	cat checkout-recurse/sub/.git > actual-gitfile &&
>> +	git -C main/sub rev-parse HEAD > actual-head-main &&
>> +	test_cmp expect-gitfile actual-gitfile &&
>> +	test_cmp expect-head-main actual-head-main
>> +'
>> +
>> +test_expect_success 'core.worktree is removed in =
$GIT_DIR/modules/<name>/config, not in =
$GIT_COMMON_DIR/modules/<name>/config' '
>> +	git -C main/sub config --get core.worktree > expect &&
>> +	git -C checkout-recurse checkout --recurse-submodules first &&
>> +	test_might_fail git -C =
main/.git/worktrees/checkout-recurse/modules/sub config --get =
core.worktree > linked-config &&
>=20
> Why test_might_fail here, and below? Because the config may not exist, =
which
> would return an error code? Should we _expect_ that failure with =
test_must_fail?
I expected that question and answered in the cover letter (since =
Gitgitgadet can=E2=80=99t (yet, I hope) do in-patch "timely =
commentaries", [1]), but here is my answer:
I used test_might_fail such that when the test is run on the current =
master, only the last test_cmp makes the test fail. If we want to be =
more strict I'll change that to :

diff --git a/t/t2405-worktree-submodule.sh =
b/t/t2405-worktree-submodule.sh

index eba17d9e35..31d156cce7 100755

--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -70,9 +70,9 @@
test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for =
submodules
test_expect_success 'core.worktree is removed in =
$GIT_DIR/modules/<name>/config, not in =
$GIT_COMMON_DIR/modules/<name>/config' '
	git -C main/sub config --get core.worktree > expect &&
	git -C checkout-recurse checkout --recurse-submodules first &&

-	test_might_fail git -C =
main/.git/worktrees/checkout-recurse/modules/sub config --get =
core.worktree >linked-config &&
+	test_expect_code 1 git -C =
main/.git/worktrees/checkout-recurse/modules/sub config --get =
core.worktree >linked-config &&

	test_must_be_empty linked-config &&

-	test_might_fail git -C main/sub config --get core.worktree =
>actual &&
+	git -C main/sub config --get core.worktree >actual &&

	test_cmp expect actual
=E2=80=98
[1] https://github.com/gitgitgadget/gitgitgadget/issues/173

>=20
>> +	test_must_be_empty linked-config &&
>> +	test_might_fail git -C main/sub config --get core.worktree > =
actual &&
>> +	test_cmp expect actual
>=20
> This tests that core.wortkree didn't change throughout the process, =
but
> could we instead confirm an exact value by echoing into "expect" and
> comparing both config outputs against that value?
Good idea, thanks. I=E2=80=99ll harden the test in v2.
>=20
> Perhaps it is worth checking the success of the command that was =
failing
> in submodules that still had core.worktree=3Dtrue before 898c2e6? For =
your
> test, it would be:
>=20
> 	git -C main/.git/worktrees/checkout-recurse/modules/sub log
I=E2=80=99ll also add that.
>=20
> Thanks,
> -Stolee
Thanks for the review!
Philippe.
p.s. Sorry for the re-send, I forgot to CC the list.

