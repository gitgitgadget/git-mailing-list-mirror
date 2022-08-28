Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C0ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 10:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiH1Kcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 06:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1Kcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 06:32:50 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101D1AF20
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661682759;
        bh=rssm3EwHdQM44N91E0n02uQ1PnjX6gf+sku1tlAnOsw=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=S0EOIfxKw5y2snyp1O9OeLH9zy1fD33ttJtKzBynudoAhPabOGsTDy3wNNf4yQNkL
         9oOtk4LvrVszNFY13Efx846EtmcT91lmLVv7SqUOuL0Ja+TI93MD5g9ZNPQxxqDhTo
         +9A/RTEQ6rAw4d1shaHhuOFAsy/aE0nVfRGd1JVQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.21.84]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1oq9JH45Un-00T3at; Sun, 28
 Aug 2022 12:32:39 +0200
Message-ID: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>
Date:   Sun, 28 Aug 2022 12:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/2] test-mergesort: reduce memory allocation overhead of sort
 subcommand
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rHHqKRJDu7TFE+DtsGCrlVpTUJK3bkWzsm11nPBF4D1LmrV3vs5
 1WmcbsL1M3O4bDqz1OISRG0HbSZb2TByA8GHkhzSFali9fgTZhDmFc6WTx9rFnxA6e6Nqj8
 +iCqt5euNnqDpslcmfb4Tp7uBNID+MCx2v7dBZ0jQTnJ8jf4zaFdC6Pb3znCAdU7Cs8gddH
 LD8T1GCoc5CHoNYGZPA3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2f2nVB4lVY=:8u30pvPn8OYf1fo4K5VBye
 cRPMTav9zW40bOM/c6vq64osWbhky2Ha6++mFKKjSNDp3Qy/KngE4sVqnBIVMG7PmlZ9JGozq
 QyH5VBela7GpPShNHmYqSbe7au/MlLsZX/YPTNImt+alFFyuoJ8uUsaeqWQrF+yOCbryYRbl4
 W5LmWpgAi+Nsg9Oq1lSOKceTa4TQVvTlfBQv1Ov07R0JcJuzDVeP4yjmzGFhZifK+q8vfZlha
 XuJXZtiOWyYvVZ70zwgTQSdqzBBd4OmElFNmssCLAyGP2n/7NaIMdl4M+qIIHbGkNQNjAcJCp
 qQcmc8ZMhkTXLAaWKcCRir1vwW4u12WA26uu53q/2/WUMSqpaP5OO1T/gtOiC3adTu+xCZyFV
 06Ovp/uh6kfLKs3xBWfE8HAfj8gmmHXw5wnNsQi157XYfk8o45TsNtDn3nIIFgsoB7yvYKmnK
 HBR3J47QSr8pbuZcOCuqAgp9fM8cQHZl1Yfm5JVneM9v2QrQzIp/Bs3izRphzzcXI8pu/SQtN
 03fvdHo4RwVVsA3Ge5kJR02l+kD86RKH9rhNx3ezrRIJjmWalUEVJM/kivh4NT2E0oGohrHh5
 DPAyFgwPtclgzXhVZJe1QBKUhl0CnwhRAco5C7du4UkfvDISjfdu9vP4LOqDxfFOkSEn070C/
 VPJkExyvjgyo5IK27L3wtVfzU7nDpswkusu0BFcNpv0ULhtmN0DDKvu2+waKznFBEf23gL1aU
 3kNsZ6tGEUjAbqT9iA6mUvLRR3Jqbwp9HzP+EN0uRMmTc2hrZSqXbvMo+YPZ+b/iPnvjdsfHL
 dBxhE0pJPtlrl9PdXOHnXXfcXSZSI9iVcDpnRwMEGxBmNGuawTk9iiMxrm/tA5sjQEfwj32hG
 EgegUr+Fi8xEkW6MQ0RWHeXN68vbFF0euM9dYBfRSYdBjoZTDLycHkrNfARSfujqVDq6Rp+vl
 6myJvaEyIVHjhI32+INk5App2SI6eUcnZfODuiD/vnboyTrrSS/8bbpf0YZeryC0tVv3O/ed0
 o/3AqnRH1/rpg1oUuTNi7O1fp+T4hIXob+HSTj/r9KLO7v9qgV6VEyWfhviz7wYDQLfBWxVjI
 gIUUvecxeHqULOKJPsHiNChMuwT6B7RxdWN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sort subcommand of the test-mergesort helper is used by p0071 to
measure the performance of the linked list sort functions built by the
macro DEFINE_LIST_SORT.  It spends a significant amount of time
allocating memory for the test data.  This series reduces it to allow
focusing more on the actual sort performance.

  test-mergesort: read sort input all at once
  test-mergesort: use mem_pool for sort input

 t/helper/test-mergesort.c | 40 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

=2D-
2.30.2
