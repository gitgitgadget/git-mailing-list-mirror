Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D4C3F2D1
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 09:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71D21775
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 09:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8eARpmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAJ7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 04:59:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCAJ7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 04:59:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so8710203wrj.7
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5u4ou+PZEMd1XzrTjmWhbsnW9nDmlaUniXFujvoOUCY=;
        b=Y8eARpmoRF2mkcOhWSebfXc4cZeLuFDFoC6mPtFr7L3ltoqoio2K1BVodt2OSS9H85
         rLkMzR08pUsLM0q5laeSXniY9dqPflodWBmjzIe4iSXPtKrO9zfnPM7RaPADJzd72i1r
         XAEg/Kf8RcoX6tsRTlcaUeQtKHMLXge2OPUbLt4Si56k4Rw2DnF2zI3q6T4d8c7+Pbd4
         AnEdNCrmqkLgxzKkUw4RzKoOhsX5W3ywWfd04rjSWmojeDQbUEc+Hb/OT5+43b8gn6RD
         OVKEmwoK9jUuzwANhs1UYDw9rJYpq6yloXY3CFpzYKG/c6uVQc5J6efTwKfpfg524mKr
         fdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5u4ou+PZEMd1XzrTjmWhbsnW9nDmlaUniXFujvoOUCY=;
        b=NPORsjvnM/njhn/TFA446/VmSNw3aw9xvHw8LW/H25fN9iV2OvaIkuT/TkBvPufBOV
         JZXVLiRgHa1BA92fX27gpuU4mLetzj9m24XRSjO9s6CyDxYfd3/3yQkYr4zDmFe0fVMd
         OyAsl6iY17wNXl7XJQm04AuD72FvFHrU72HwplPpoDrDJJ0p37ONr4OOYQIIUq3FV/Cf
         PkSRkWx3XDXVMqiQ0jhGAomhijvnUB16XLZXFOogesCMUE4dTBU3ooJ26yz/gcD7fTLt
         Ys3dgLiAD3dm6UbKiTDEmPCYpNYRAQQkVeWC0OG0Aj5W1wty2OdTnFu1wIX1hlenSns/
         pRMw==
X-Gm-Message-State: APjAAAWdnEtQEY3jzddfmZracXaKf3f7F43RAO/Ky7cpJAm4mZq20y0Q
        GAWd5fc6eh6DFeWLwq/+uSI=
X-Google-Smtp-Source: APXvYqy23dh9hzoA6ujW17U7oVVai2vfnEJfT4DPIBs1mvGNcWWT1Y/ksWyT6di3cActwlp93QfGOg==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr16578461wro.254.1583056744529;
        Sun, 01 Mar 2020 01:59:04 -0800 (PST)
Received: from ?IPv6:2a02:a210:ca2:9c00:add9:431:aa3d:7449? ([2a02:a210:ca2:9c00:add9:431:aa3d:7449])
        by smtp.gmail.com with ESMTPSA id p10sm15592638wrx.81.2020.03.01.01.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 01:59:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [External] Git Rebase: test failing with
 GIT_TEST_STASH_USE_BUILTIN=false
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <710DB9BA-D134-48E7-8CAB-B8816FED8AB8@booking.com>
Date:   Sun, 1 Mar 2020 10:59:03 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89C2FD92-5616-4834-98ED-22630DA61925@gmail.com>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
 <710DB9BA-D134-48E7-8CAB-B8816FED8AB8@booking.com>
To:     Son Luong Ngoc <son.luong@booking.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(this is a resent due to git@vger.kernel.org blocked HTML content, sry =
for the noises)
(following up on =
https://public-inbox.org/git/xmqq36ayob9a.fsf@gitster-ct.c.googlers.com/T/=
#t )

Hi folks,

I ran a simple git-bisect on this to try to figure-out whats wrong:

$ cat run-test.sh
#!/bin/bash

make -j8 prefix=3D/usr all
(
  cd ./t
  GIT_TEST_STASH_USE_BUILTIN=3Dfalse ./t3903-stash.sh --run=3D'103'
)
$ git bisect start master v2.22.2
$ git bisect run ./run-test.sh
...
$ git bisect log
(b932f6a5e8...)|BISECTING ~/work/booking/git/git> git bisect log
# bad: [2d2118b814c11f509e1aa76cb07110f7231668dc] The seventh batch for =
2.26
# good: [d9589d4051537c387b70dc76e430c61b4c85a86d] Git 2.22.2
git bisect start 'HEAD' 'v2.22.2'
# bad: [22dd22dce050f042b3eec165440966186691db42] Merge branch =
'wb/fsmonitor-bitmap-fix'
git bisect bad 22dd22dce050f042b3eec165440966186691db42
# bad: [fa9e7934c780bc804a09bfc88a93825096b3155e] Merge branch =
'bm/repository-layout-typofix'
git bisect bad fa9e7934c780bc804a09bfc88a93825096b3155e
# good: [3a94cb31d52f061c315b00bfc005f1b1c42ac92d] bin-wrappers: append =
`.exe` to target paths if necessary
git bisect good 3a94cb31d52f061c315b00bfc005f1b1c42ac92d
# bad: [7b70d46ca410f9d37045558329c3143570d47ba6] Merge branch =
'bb/grep-pcre2-bug-message-fix'
git bisect bad 7b70d46ca410f9d37045558329c3143570d47ba6
# good: [d60dc1a0b3829f3c4d69696f43f1c178c0701cdb] Merge branch =
'ew/repack-with-bitmaps-by-default'
git bisect good d60dc1a0b3829f3c4d69696f43f1c178c0701cdb
# good: [43ba21cb574ee3f9a1acf4580868982f4c883ac6] Merge branch =
'tg/range-diff-output-update'
git bisect good 43ba21cb574ee3f9a1acf4580868982f4c883ac6
# good: [080af915a3ee4d9511dc288b29143b9958ac0adc] Merge branch =
'mt/dir-iterator-updates'
git bisect good 080af915a3ee4d9511dc288b29143b9958ac0adc
# bad: [75ce48674889df6a2bb493fb5d6bef0ef60ca7ae] Merge branch =
'di/readme-markup-fix'
git bisect bad 75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
# good: [984da7f8d2589b53cca7c920e597eab30d4c1b36] Merge branch =
'sr/gpg-interface-stop-at-the-end'
git bisect good 984da7f8d2589b53cca7c920e597eab30d4c1b36
# bad: [f8aee8576ac5e01fa993c80b5b888af214c03758] Merge branch =
'tg/stash-keep-index-with-removed-paths'
git bisect bad f8aee8576ac5e01fa993c80b5b888af214c03758
# good: [b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65] stash: fix handling =
removed files with --keep-index
git bisect good b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65
# first bad commit: [f8aee8576ac5e01fa993c80b5b888af214c03758] Merge =
branch 'tg/stash-keep-index-with-removed-paths'

Which pinned point the failure starting from the moment the test was =
added at =
https://github.com/git/git/commit/b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65=
 by @t.gummerer

I would appreciate if we can either deprecate the =
GIT_TEST_STASH_USE_BUILTIN flag entirely or wrap the test with an 'if' =
so that we auto skip it when the flag is enabled.

Thanks,
Son Luong.

> On Feb 25, 2020, at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Son Luong Ngoc <son.luong@booking.com> writes:
>=20
>> I have been trying to build git from source and noticing that some
>> tests have been failing since 2.25 with the flag
>> "GIT_TEST_STASH_USE_BUILTIN=3Dfalse"
>>=20
>> I think in 2.25 t3903.103 started to fail (rebase related) and
>> current master t3904 may be failing also.
>>=20
>> Is "GIT_TEST_STASH_USE_BUILTIN=3Dfalse" is still being tested with
>> or are we totally deprecating this flag?
>=20
> In the longer term, when "git stash" gains new features that did not
> exist in the original scripted version, tests that observe how these
> features work would start failing when using the scripted version.
>=20
> I picked some people from "git shortlog --no-merges builtin/stash.c"
> and placed them on the CC line---perhaps they may know more.  It
> happens that Johannes is also familiar with "rebase", which you
> said is involved in the test failure, so I'd imagine he would be the
> best person to ask.
>=20
> Thanks for a report.
>=20
>=20


