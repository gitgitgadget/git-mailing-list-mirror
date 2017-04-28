Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34140207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 13:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426112AbdD1Ntl (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:49:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:61245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426079AbdD1Ntk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:49:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlGoc-1ddzah1hvK-00b0Pz; Fri, 28
 Apr 2017 15:49:29 +0200
Date:   Fri, 28 Apr 2017 15:49:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 01/25] mingw: avoid memory leak when splitting PATH
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <0359bddb6fe5fd74ce2571f9933c18dfeb2a8f7e.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9cOh47NbHujLDOPfemqi1KWMiQAaveiZVUOEt1aaAk2QTYsyU28
 7LKv6JvhHXm5iNl1tpew1WWpGEY8vJ905n7kPc8Uln/1/1eKPt9/5SIbEPoiG9Nl5GkuhwN
 5cOOAn/YGMAU+0hieNF5kT8Dh+g47JpTMdp/y/D3I38udKKVYSsn/uqz6E9OkFGp8+eYj2x
 SINg8tcIR+dhy4mXi0j6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kHQu0dyBjJQ=:EXrYDPHNRnz2PTfVYb0HpQ
 VW8SxO1EG+KhdTMEQx6KD+EhJ5rJeUZwRh4KmDBHVS0SKA/jrd9sVTqR0CZ69cMxsxsy9jphE
 zMIs1h95MmPDywG0AB+TFdVVf3Sc+iyNEGFcACKKXBh7I4A29ceNdjhAV8SiIHIgEYOzrxT/J
 jhOHVifTSNuPOpDFW3w4XJB/i5T4Z82v8fJcX93fcBw/PzqeGLpl9NeHXKN9Ki/GHmdttufK4
 7FEe2FmbI4+p0R/NUaHzHbEeAwUzsOWQNzmMAHNE1PDDIMql0O/4RhgIu9+yX51LPpoNyn4A6
 RfmRgZOvFNt3Lgn8uoTKf62mKopHHXtCMOnKJqzisFvupAW5GUdnH5oZh/oTI7Z7zWiEGk1Zx
 k20vfrnz1DllKxYA8ou9MBYt9BQsND3D5A1nus5eYkSbXrnVw8T4nPockrxIdVq6nZaD+U9hP
 D8or3s9vYZYNxn3X+sq6dE9Z8BqSNdKX2Z8TanmpQIt8098pLomkI0w82IK+pe6tpbtFuaMK3
 l5TLWfZ22VZMiyFGda3Fky53oLyIG8ng3JtwuqwEpZJjLoHK5K3GPOGF7L3mDEb46dim0Sg5K
 eSTRwauWDAKtcBiNbz3GnnDO6bArrR5Ktbo0ZImjJCMHHQFK67r5RmLoTMMMnZVqMyjzeaugs
 SpqbTnxR7+Ob2iP+8wjBVl4dpV4ozHiRf04BpAiloYnXCbBkvrBXDsQMBiEv0MKCU7EyVt9Mv
 fRu2+IEorCOAoskPqEPSvpHxyjGfoWax2l+cmh+Ll9HtQAUYLtU6vTHIeJ8RMgliiH8Oeh2BO
 7b+xPFP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the (admittedly, concocted) case that PATH consists only of colons, we
would leak the duplicated string.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3fbfda5978b..fe0e3ccd248 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -961,8 +961,10 @@ static char **get_path_split(void)
 			++n;
 		}
 	}
-	if (!n)
+	if (!n) {
+		free(envpath);
 		return NULL;
+	}
 
 	ALLOC_ARRAY(path, n + 1);
 	p = envpath;
-- 
2.12.2.windows.2.800.gede8f145e06


