Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3EA2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbdBNLdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:60806 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752193AbdBNLcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:02 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNYxW-1cjeob2EjC-0079fG; Tue, 14
 Feb 2017 12:31:47 +0100
Date:   Tue, 14 Feb 2017 12:31:46 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Message-ID: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4XAU2EOEyJnRSQthaZTvJQD/64YbLmGiJs7pNhL8kPd4u3moj+J
 oL3qCBW8vBfXWxz7c6JI2vUwP9WkNHnV36iGO1giBs1ZEOqCQkixIsHaU5MA9L7u3T9BMbK
 fuuEOWMGGJBnx61nA2ac61hZNQiUw3gcqMDoPPOcYYOeXs2+Cnaa6SMq0jut1vJRJ6bD/Dx
 3+5DEeHu1NEKYUfWqNWEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUXZtUITmwU=:5ABN/WjQh6TtaMI4KC5CU/
 TVHiSbplJ2xIybawC8+yhuVBkekC5+1qXt2/L8JHP2PKAHk+Tylu9fBFa+MABH5EfAAl0IQ6D
 C02hKGM6u+5738XhEgg50MF8XLRVmrY5MgIuzwpTlQivwM7OsZ44shnS5p3UJoEpguwOsSb5Z
 74ObA1mZDWRdthh1XhdgQvN5toemOK0Zr0sVdUWd6UxYSNfLH+7PRm70ObKcbwWUCwlnFUOSB
 9Pw2JFOVanqC6lMtcxAz71BzJsxPTNeJhl59zgQtQSOXLG1iIXXKLXLl0kApRqHpr7W22Nu9A
 tDVFbbAJtqJ9jTE1Fv/38bcc3xno2dLlLnIjghDXX/c2H0JeenbuHYru5dvYUoyIYt33L5/vb
 5t7x9gzvv8xFM89SNYa+ErXEA5SocoQHCHgTi4v9gSgerQzAvZad+d7oX7j4PbJ6+PJfFXs+g
 4TzQQe+wFnyGF/xqSMO7LimzFO/6w3BtuXFPpDxOCnEEeLRpRQG7arwG+X8/8weJVZNRKeE8V
 4swJdDHyGPWRPCL82m0iLSvtBWz6k4wa34GH+r5KojZTUvJFoBoMpcXCdnd/KsIN0Sf9Ih02X
 DMMH9vEcldvGBWkehKsJ4OQX6qdc/IqwG4RGWNmH8lgGDS4/Yhyaj954Hdo+k0mcWpCkXMtED
 wS6A60Gb3O4LXYexwPhmCjemvsVBgM3tu00Z7OHpsfhbNtsLDGsjEuJbhb+CACxG32rQEuJRA
 P2+myP62ePKaN7/NnRy+ZBQ9eIuzcdQtEuCOxM7IpCXm48oV2FGfXYlM2pxFj41t5GFLWIRul
 lsHItmT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, calls to memihash() and maintaining the istate.name_hash and
istate.dir_hash HashMaps take significant time on very large
repositories. This series of changes reduces the overall time taken for
various operations by reducing the number calls to memihash(), moving
some of them into multi-threaded code, and etc.

Note: one commenter in https://github.com/git-for-windows/git/pull/964
pointed out that memihash() only handles ASCII correctly. That is true.
And fixing this is outside the purview of this patch series.

[jes: renamed and reformatted a few places, and replaced global
constants by 1-bit fields, in the hopes to make the contribution a
smoother ride.]


Jeff Hostetler (5):
  name-hash: eliminate duplicate memihash call
  hashmap: allow memihash computation to be continued
  name-hash: precompute hash values during preload-index
  name-hash: specify initial size for istate.dir_hash table
  name-hash: remember previous dir_entry during lazy_init_name_hash

 cache.h         |   6 +++
 hashmap.c       |  14 +++++++
 hashmap.h       |   2 +
 name-hash.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 preload-index.c |   2 +
 read-cache.c    |   3 ++
 6 files changed, 127 insertions(+), 16 deletions(-)


base-commit: 5588dbffbd61e4906e453808c6ad32f792fea521
Published-As: https://github.com/dscho/git/releases/tag/memihash-perf-v1
Fetch-It-Via: git fetch https://github.com/dscho/git memihash-perf-v1

-- 
2.11.1.windows.1

