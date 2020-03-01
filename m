Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B93C3F2CE
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C706521775
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 10:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXwHSxqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAKlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:41:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43269 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCAKlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 05:41:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id e10so7357840wrr.10
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qyKEJviu0N0APubzJw+mvCkWy+NY+ZnvWqx9Nah+fU4=;
        b=RXwHSxqU4xytK7oQ6HNKF1E9yfPfzbDG/BcH1QW8nzx7DyVzhy11haXm813wSrcN+7
         /w+qLoGhwUvjMG8sBgnuYnNL32gfZ7I/G2rrVndObxvNA9LaCKiMnQBToQ0scf7RORLN
         UW9/HhvrIecXqKRd81rx0ayZf9wGag36F30p8zqLfEIfnZS04G72ETFeKbiABSrDUs4s
         0CSFcUBx7z4MuZKn79Fo2IjzQiEKlq4n2W5EmFB6C+EI/cKS1v7PPKZpB2gXT61Menr6
         vWcFpflIwvXBijpbXWpgyUso2Ms8KKw317SF6lPcsDn7nlA5gXr/tjNMnlIpm1SBDxWH
         0NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qyKEJviu0N0APubzJw+mvCkWy+NY+ZnvWqx9Nah+fU4=;
        b=mdYslmaQNlUniA+ZTVUT0u+Ilq5JmsQJpLfNeIAZMe7T3m1PUOCr0cWICFaoUaqNLs
         flhNd0/VGebpfXePMi+KfkZYK2vTPIyYDHE/LkjzypsCTUj1DujMOwWd8Q8oKPsj1B1v
         E2LijurHSfRuIxQf3eZW6pTyKnVuBfMsqLg9EE4c4kdSfEyPiwlgIsYOXpCmtZQ1JbEm
         o5AYWRT6iTYHPYFDZVVFPFg5hUT86vLRkI+Sm+QwHDi1bQ82GQzcANAp6pORvCXsUx9L
         m4UHhxrpQ8vwOAvSzw+oqcO62ocyni4A54vuipX4NYw6cMIzbRVV0eduMLdyEMZXU+Vw
         6Y5w==
X-Gm-Message-State: APjAAAVrVGec9ThxYIYHUpU783iGGFnEHNfbHdxZNiAErOlfkkn0hZrg
        5AiYxTV9Wm+kzReDNdisISU=
X-Google-Smtp-Source: APXvYqwC1EfVXcfpfgFCZFiUo6twEVz2IUvFToS7zR7W94N66YXRJKgutD3wOKoduLUkPkb0WEoAnA==
X-Received: by 2002:a5d:6cb3:: with SMTP id a19mr16882883wra.213.1583059259768;
        Sun, 01 Mar 2020 02:40:59 -0800 (PST)
Received: from ?IPv6:2a02:a210:ca2:9c00:add9:431:aa3d:7449? ([2a02:a210:ca2:9c00:add9:431:aa3d:7449])
        by smtp.gmail.com with ESMTPSA id u1sm2864252wrt.78.2020.03.01.02.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 02:40:59 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [External] Git Rebase: test failing with
 GIT_TEST_STASH_USE_BUILTIN=false
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <89C2FD92-5616-4834-98ED-22630DA61925@gmail.com>
Date:   Sun, 1 Mar 2020 11:40:56 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F59C8901-122C-4B75-BCEC-4D8D323C78A0@gmail.com>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
 <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
 <710DB9BA-D134-48E7-8CAB-B8816FED8AB8@booking.com>
 <89C2FD92-5616-4834-98ED-22630DA61925@gmail.com>
To:     Son Luong Ngoc <son.luong@booking.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar strategy was used for t.3904, which has been failing with this =
flag since 2.25.0

$ cat run-test.sh
#!/bin/bash

make -j8 prefix=3D/usr all
(
  cd ./t && GIT_TEST_STASH_USE_BUILTIN=3Dfalse ./t3904-stash-patch.sh
)

$ git bisect log
# bad: [2d2118b814c11f509e1aa76cb07110f7231668dc] The seventh batch for =
2.26
# good: [d9589d4051537c387b70dc76e430c61b4c85a86d] Git 2.22.2
git bisect start 'HEAD' 'v2.22.2'
# good: [22dd22dce050f042b3eec165440966186691db42] Merge branch =
'wb/fsmonitor-bitmap-fix'
git bisect good 22dd22dce050f042b3eec165440966186691db42
# good: [6514ad40a1a3cf80b2c25e3318dbf0252599fb8d] Merge branch =
'ra/t5150-depends-on-perl'
git bisect good 6514ad40a1a3cf80b2c25e3318dbf0252599fb8d
# bad: [f52ab33616ee1d241f2292f1c1e47ba84a263523] Merge branch =
'bc/hash-independent-tests-part-7'
git bisect bad f52ab33616ee1d241f2292f1c1e47ba84a263523
# good: [4d924528d8bfe947abfc54ee9bd3892ab509c8cd] Revert "Merge branch =
'ra/rebase-i-more-options'"
git bisect good 4d924528d8bfe947abfc54ee9bd3892ab509c8cd
# good: [f0940743facd619f251009e0307d8d6452cc582e] Merge branch =
'js/builtin-add-i-cmds'
git bisect good f0940743facd619f251009e0307d8d6452cc582e
# good: [381e8e9de142b636e4a25b6df113d70168e21a34] Merge branch =
'dl/test-must-fail-fixes'
git bisect good 381e8e9de142b636e4a25b6df113d70168e21a34
# bad: [d0e70cd32e95df3be2250536f9089c858a298874] Merge branch =
'am/checkout-file-and-ref-ref-ambiguity'
git bisect bad d0e70cd32e95df3be2250536f9089c858a298874
# bad: [94ac3c31f730ab278e1373a942fb4503829f4279] terminal: make the =
code of disable_echo() reusable
git bisect bad 94ac3c31f730ab278e1373a942fb4503829f4279
# bad: [52628f94fc35f57f0b3c54e4f849e490bfa44449] built-in add -p: =
implement the "checkout" patch modes
git bisect bad 52628f94fc35f57f0b3c54e4f849e490bfa44449
# good: [36bae1dc0ee777aa529dd955f2e619281265f262] built-in add -p: =
implement the "stash" and "reset" patch modes
git bisect good 36bae1dc0ee777aa529dd955f2e619281265f262
# bad: [6610e4628ac12396efc20201fe85d67591bed247] built-in stash: use =
the built-in `git add -p` if so configured
git bisect bad 6610e4628ac12396efc20201fe85d67591bed247
# bad: [90a6bb98d11a664f729dbb86c90d9c7a38ea825a] legacy stash -p: =
respect the add.interactive.usebuiltin setting
git bisect bad 90a6bb98d11a664f729dbb86c90d9c7a38ea825a
# first bad commit: [90a6bb98d11a664f729dbb86c90d9c7a38ea825a] legacy =
stash -p: respect the add.interactive.usebuiltin setting

Which was merged in =
https://github.com/gitgitgadget/git/commit/9a5315edfdf662c4d9bf444ebc297bc=
802fa5e04
Author was Johannes Schindelin

Thanks,
Son Luong.

> On Mar 1, 2020, at 10:59, Son Luong Ngoc <sluongng@gmail.com> wrote:
>=20
> (this is a resent due to git@vger.kernel.org blocked HTML content, sry =
for the noises)
> (following up on =
https://public-inbox.org/git/xmqq36ayob9a.fsf@gitster-ct.c.googlers.com/T/=
#t )
>=20
> Hi folks,
>=20
> I ran a simple git-bisect on this to try to figure-out whats wrong:
>=20
> $ cat run-test.sh
> #!/bin/bash
>=20
> make -j8 prefix=3D/usr all
> (
>  cd ./t
>  GIT_TEST_STASH_USE_BUILTIN=3Dfalse ./t3903-stash.sh --run=3D'103'
> )
> $ git bisect start master v2.22.2
> $ git bisect run ./run-test.sh
> ...
> $ git bisect log
> (b932f6a5e8...)|BISECTING ~/work/booking/git/git> git bisect log
> # bad: [2d2118b814c11f509e1aa76cb07110f7231668dc] The seventh batch =
for 2.26
> # good: [d9589d4051537c387b70dc76e430c61b4c85a86d] Git 2.22.2
> git bisect start 'HEAD' 'v2.22.2'
> # bad: [22dd22dce050f042b3eec165440966186691db42] Merge branch =
'wb/fsmonitor-bitmap-fix'
> git bisect bad 22dd22dce050f042b3eec165440966186691db42
> # bad: [fa9e7934c780bc804a09bfc88a93825096b3155e] Merge branch =
'bm/repository-layout-typofix'
> git bisect bad fa9e7934c780bc804a09bfc88a93825096b3155e
> # good: [3a94cb31d52f061c315b00bfc005f1b1c42ac92d] bin-wrappers: =
append `.exe` to target paths if necessary
> git bisect good 3a94cb31d52f061c315b00bfc005f1b1c42ac92d
> # bad: [7b70d46ca410f9d37045558329c3143570d47ba6] Merge branch =
'bb/grep-pcre2-bug-message-fix'
> git bisect bad 7b70d46ca410f9d37045558329c3143570d47ba6
> # good: [d60dc1a0b3829f3c4d69696f43f1c178c0701cdb] Merge branch =
'ew/repack-with-bitmaps-by-default'
> git bisect good d60dc1a0b3829f3c4d69696f43f1c178c0701cdb
> # good: [43ba21cb574ee3f9a1acf4580868982f4c883ac6] Merge branch =
'tg/range-diff-output-update'
> git bisect good 43ba21cb574ee3f9a1acf4580868982f4c883ac6
> # good: [080af915a3ee4d9511dc288b29143b9958ac0adc] Merge branch =
'mt/dir-iterator-updates'
> git bisect good 080af915a3ee4d9511dc288b29143b9958ac0adc
> # bad: [75ce48674889df6a2bb493fb5d6bef0ef60ca7ae] Merge branch =
'di/readme-markup-fix'
> git bisect bad 75ce48674889df6a2bb493fb5d6bef0ef60ca7ae
> # good: [984da7f8d2589b53cca7c920e597eab30d4c1b36] Merge branch =
'sr/gpg-interface-stop-at-the-end'
> git bisect good 984da7f8d2589b53cca7c920e597eab30d4c1b36
> # bad: [f8aee8576ac5e01fa993c80b5b888af214c03758] Merge branch =
'tg/stash-keep-index-with-removed-paths'
> git bisect bad f8aee8576ac5e01fa993c80b5b888af214c03758
> # good: [b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65] stash: fix handling =
removed files with --keep-index
> git bisect good b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65
> # first bad commit: [f8aee8576ac5e01fa993c80b5b888af214c03758] Merge =
branch 'tg/stash-keep-index-with-removed-paths'
>=20
> Which pinned point the failure starting from the moment the test was =
added at =
https://github.com/git/git/commit/b932f6a5e8cdbb33eff4563fdfb1eae9ebf70a65=
 by @t.gummerer
>=20
> I would appreciate if we can either deprecate the =
GIT_TEST_STASH_USE_BUILTIN flag entirely or wrap the test with an 'if' =
so that we auto skip it when the flag is enabled.
>=20
> Thanks,
> Son Luong.
>=20
>> On Feb 25, 2020, at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> Son Luong Ngoc <son.luong@booking.com> writes:
>>=20
>>> I have been trying to build git from source and noticing that some
>>> tests have been failing since 2.25 with the flag
>>> "GIT_TEST_STASH_USE_BUILTIN=3Dfalse"
>>>=20
>>> I think in 2.25 t3903.103 started to fail (rebase related) and
>>> current master t3904 may be failing also.
>>>=20
>>> Is "GIT_TEST_STASH_USE_BUILTIN=3Dfalse" is still being tested with
>>> or are we totally deprecating this flag?
>>=20
>> In the longer term, when "git stash" gains new features that did not
>> exist in the original scripted version, tests that observe how these
>> features work would start failing when using the scripted version.
>>=20
>> I picked some people from "git shortlog --no-merges builtin/stash.c"
>> and placed them on the CC line---perhaps they may know more.  It
>> happens that Johannes is also familiar with "rebase", which you
>> said is involved in the test failure, so I'd imagine he would be the
>> best person to ask.
>>=20
>> Thanks for a report.
>>=20
>>=20
>=20
>=20

