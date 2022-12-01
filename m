Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A8C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLANk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiLANk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:40:26 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9076AD98A
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669901995; bh=vN4rs8NxhzgEG5qMQbKKth4Gl71kjJqYQmJkQE3UbsQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=X46iBYvKoP5e0mqwlfCaWo9Lg8dPwVF8nGegWYM+WPnZ+mAxaIsx5ttqEcm1jBxqd
         RpQ0mLRmE8onJx/ykKJSBqLfgWxupFKSb440Thjx+AwIVOjvpuHNYBZ5uTk7SqK8VG
         G+JLF9wZ/e5ZCWIgV77q9J9LzHq+B0HKg45DhBW6t2gVpBur4WTXVnYDSAKIBMZqaC
         ygbfBY0SgicK3Nch3IRn6DEO8Wz3CpXPM5pLBokv5qjELDbnLn1zDOPhMoIj9zdEbu
         CmJ62clOwrcWp/vIYYeCrXtBFBDDhYRUEFym3Kc90o92ZVsTEmMLjWsrvPDL36p7wz
         0NY82/CH7+osA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1pUCdE2uyZ-00Xow1; Thu, 01
 Dec 2022 14:39:55 +0100
Message-ID: <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
Date:   Thu, 1 Dec 2022 14:39:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 0/3] diff: build parseopts array on demand
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N2PEU3jsxRursFVbS193D6P398zt4Hcok5hGpwNAx3qUHAu2sey
 tImsY+NebX/zh3ixoHSFtqAfps4JmPmp837lFcrbfwJfMyr9nqTtmDpFlmyHSn02VCll66g
 xXeZGrdfiZeHNeoNex34fNYxTgIB9f+aBEyoOwu2Z2trVGPSF+kbpE2AMgOjetUVqkDtZQ7
 xKztDMcF7IFr5waUFtYew==
UI-OutboundReport: notjunk:1;M01:P0:HQE8/H9dMfk=;De0IRPJjZ43rz5u0GzFhodyE+Wa
 r7RnuaTT8PgsQC5ACYCdqtRW9FHkoeYQfwfVlkzKb49vxh8Lcr1xtuCmFmyycUQrivyJqalP6
 gpEABqDgitsHZ4ScYZavQhHyKSrNQHmScEzz8uIrimXO6xNkk3n4amxuk99mo1LbENYcEhrpA
 55ECiVLPxHVQ1baR7XYsD9zH7jWVMeXIGOZkMZCG4fKoVjX0hVpA0I5AL/8a5GYI2kVST4rpv
 CIBSaepCF7A4KaKUsq7h4Fs7lweCme4DU3mEWe9yDTf6IBtSb/0CtzeksdRE7M0/YcQJ/GIcs
 /le0/zF9B0D1jHw9rFz7X2C3gCMxoc4sT7BaOX9muZ10M/oDGk+gEDl1E5R9+WzXIUwSUcgky
 nD7VA8DKf/SeuMW3zvGDOE8y+y+HZfDveaes7rXpb2LMhk48Lkg4jpafx62+RH5G5iX+pTPJq
 Fvh/E0Mx09Ped0AhRp7tBEEC3vFUg5mKeBXxvUneySkQhwZP208x/gOyWV3WVyZVz47oyuqQ0
 +snC78H4qOc7dIe0B0ARao+C4jvqiiSmCAKLozrPB9whBEp8V+ozVi6Qx+a00TZ+ZrfqvWsk2
 0xW/+K2MMQghush17LhMGG78kwzU0sSm2RO+ScUo1wDktrp5Z/cwyeJSRQdhi2CWjomjfOqxk
 fP41AzBhzUc+DXAd2zmRsJGyTAOx+qJryBp2ikjVWWRacV3502IO5mMbdOMlUcNTs9c23ct9N
 KvL/mvapXdOrbBzPYAad3O3Ic2A27mofPHkXsbNO1VTNYFRkAJKMEaEDQ9fkY0udq3E1dIKtF
 VcQmFlcA/SId+mnO0dzM4uXuCFBNB+aTTOcbD48CnP9mu/MZ01CyNaVkuFvcmMq8agdZ/u4+R
 +E75hpRiVUBq7xHMUnbkfbZOGUJAGBrPaf/10EBmpvqm7VqqWGKY715ymTtbYU2sHiNytukc2
 R2GCa69Ondl/tJ7WQvhajNZra+I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling repo_init_revisions() and release_revisions() in that order
leaks the memory allocated for the parseopts array in the embedded
struct diff_options member.  Get rid of that leak by reducing the
lifetime of that array.

Original patch:
https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de/

Submitted separately from that thread because it's independent enough.

Change since v1:
- Actually remove the parseopts member.  Its removal got lost during
  refactoring in v1.  Thank you for spotting that, Junio!

  diff: factor out add_diff_options()
  diff: let prep_parse_options() return parseopt array
  diff: remove parseopts member from struct diff_options

 builtin/range-diff.c |  2 +-
 diff-no-index.c      |  3 +--
 diff.c               | 26 +++++++++++++++-----------
 diff.h               |  2 +-
 4 files changed, 18 insertions(+), 15 deletions(-)

Range-Diff gegen v1:
1:  630f95320f =3D 1:  4dc8b2632b diff: factor out add_diff_options()
2:  4b56fa795c =3D 2:  10903d355e diff: let prep_parse_options() return pa=
rseopt array
3:  7e54e4370a ! 3:  24bd18ae79 diff: remove parseopts member from struct =
diff_options
    @@ diff.c: void diff_free(struct diff_options *options)
      }

      void diff_flush(struct diff_options *options)
    +
    + ## diff.h ##
    +@@ diff.h: struct diff_options {
    + 	unsigned color_moved_ws_handling;
    +
    + 	struct repository *repo;
    +-	struct option *parseopts;
    + 	struct strmap *additional_path_headers;
    +
    + 	int no_free;
=2D-
2.38.1
