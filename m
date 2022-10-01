Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C91C433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJAKXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJAKXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 06:23:53 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808314250F
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664619823; bh=mMaQWAXN2reZizCn/5XRKnRk2r4L9QzMJ+4HlcgcI5A=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=DxjY9q4vsQWC73DRSHOhdRdXrpVrM2aPftFIP1eJVuMzQNaa7vt7KdRFypxE14WwK
         HeZF1WrIm9K8dPN/kWDHWH24o5YggWMduvv0oIJWYP28Ay9JToJM6VkOrFnpZu2og4
         x7JSR5Ms4dzl1Ry8q1zyV6OZfl0H5zJ3o/ie1qLLiDaSzPBuppTlKo/7VjSk3JUAfi
         cH/P0Gbhp0AzANQww54HjXN12RlSyUfVSqEgWwC7tUZVXHgkehQJOY0J7RplBRFOqd
         ZLs3rMmoa0Zri8J6jRI+HZG8G/LufbWqB7C3ODKwI+K8aoKwtpoTWubnyhPT1e5efR
         2/D7L2oHpNmcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1oPTUc24wj-00FS7W; Sat, 01
 Oct 2022 12:23:43 +0200
Message-ID: <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
Date:   Sat, 1 Oct 2022 12:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v3 0/3] diff: support ^! for merges
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Language: en-US
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PXV1xaBcW3ZCBK7ixSNcjfkxRtZkXkc3xjtIpTqSybW6alFNCMh
 N/onV5QhDHKHJSeFBm1EVoIiNnklqLJ4KYEi3lxuj8hkrigWLLx+aYhmtxq0kP8a2x2OnTH
 VS7Gw1KT0+MQsntiCRw5PCRw90izqgyS8mvAr0PGjXBPuswWd2Ls/4djA80QWkBiT2kDJhN
 QLylwHvGYa6LB+5N5vS+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jaKuCu70gVo=:1QGnBx/mios6mH7A3eIapK
 S1K/FucWr4XkigXuHxCilM1fVbibzRnNShNIcKXGtN9k/5MYbdwGWHW1LTCklpG2A1YV6UTFl
 ulQeh+NMTOIQ/vCbRS2RKrLJ1iQ01d/Iy70YJ7zixmJQQnOq7gYGIJFUju/+GfBybPoLcPZZu
 DiaggMZ7+d/PeQWJ6lQK1ZVvBkox0lZUqLP4vSUrd+xUyIT/IXq3YcDIfF47P4NPoEPG69Y3M
 h7PwH5LAU61nf9cJL/SSrMEGtpiZQ1y7l35C3vwKirtmM5zjutPEMlLvYKFpLpA1dWOKzyYfB
 w9htbzaId545lR+dk8T5p15pNJz8s9c7qrvjnnFtuLpGpWoaYdJyuqeT/d34pHfiq2qItucjY
 z4G9KcJU49QwQjq583T9ashhvUtxvqT2MVOQz57fIZutVPQIRghjI8CNxfE1zMn4mh1GHSm59
 MYRLQLVfdxAdwhz1o9XUXTTBxLwhRolCzpnpX6FbHYfihWe/lkyVyvIPzXW2BNxY+yIz75xbE
 AVUhDFG/WMdd1jsZU7uazxZxclxw0a5doBk0SyNYOBB1Nz7B/7CmKPHRHF+n6Yt2zdTFhQ7h9
 J7MA8KYeHo+BJftL/pkjVvYKbfP18c5jLpKR8yt6O9AAS3CVNozhpyNpqv/lg8rVfmOqh4dsb
 2tPKd8BaWDTcyYzG0Zmz7NcJICpnTZiIlAMFPNwZ9lwF8Rhd8QhKLmoSpsKo4gszSDd7zM1uK
 WETiKGKdiGHPc8DA5mQOe7pAEOT7XPkuPauPhrqQKeMV8NenXxSW1SmnI216AUK6jAJiMlMF4
 3bEjoTUv636w4yTqguDOAYZzhvQRRnjDOV1OJemn/hn/90QqimSieL8mrtjw9HHWS0ujsuOgF
 N7BzGiZC0JkDt2xFIawhNk6imEGpM52Qt6dMw6c8MRnsHIkoAUcZL4L+Fad0YYRpdCLKDcMEm
 CfGcJdLi5Xk9LVMwmbTogQ3sENfi8oeTwDAEpxTM23K7UVerGuv5qCm+rtXRSxotaT1nFg3/+
 IiU7+uZeC6/VPUOOljz6LobnwWHVVRIPdmEa1Ju/i3LNkAg+mrtomKZmu2NPzq6VGz5tO8fM+
 JSPHpEg0xwvr/SN2nWIqxTr8sF8+LLRAOx35FR9ozkq8gDM+TdMfOrFwfv1RNGXH0HXt1Be7j
 JSt6Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes between v1 [1] and v2 [2]:
- Single patch, local fix, leave revision.c alone.

Changes since v2 [2]:
- Patch 1 (unrelated cleanup) is back, requested by Chris.
- New patch 2 to remove a broken promise from documentation.
- Move the first_non_parent tracking code to after add_object_array()
  and add a comment, both to (hopefully) improve readability.
- Mention ^! in the documentation of git diff.

  revision: use strtol_i() for exclude_parent
  revisions.txt: unspecify order of resolved parts of ^!
  diff: support ^! for merges

[1] https://lore.kernel.org/git/ba6eea28-fb3a-b376-2529-351727c02f1a@web.d=
e/
[2] https://lore.kernel.org/git/29d50baa-1923-38e1-6ecb-73840376d28e@web.d=
e/

 Documentation/git-diff.txt  |  8 ++++----
 Documentation/revisions.txt |  2 +-
 builtin/diff.c              | 23 ++++++++++++++++++-----
 revision.c                  |  5 ++---
 t/t4038-diff-combined.sh    | 10 ++++++++++
 5 files changed, 35 insertions(+), 13 deletions(-)

=2D-
2.37.3
