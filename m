Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B341FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037918AbdDUKqN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:46:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:61193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037589AbdDUKqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:46:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbgyV-1cHQft34e3-00lDlK; Fri, 21
 Apr 2017 12:46:06 +0200
Date:   Fri, 21 Apr 2017 12:46:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 9/9] show_date_ident(): defer date overflow check
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <3a33b168e96c676592154dc1313a5bdea989831e.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jHoiLa1ZS3ILEt1d7+ELw/eovzqOOGAy9/F1JVXvhSbveEWjUj8
 pP5ho070v4YieBRSF1hTLH2x95mZUJw8DontJNzONr2kj772quPFdVQLn1Vy6DLmr62jiR2
 qRSWN4TZIpsbIX7RY+fBVsQVTMUvds1DwUgq53o5YOrYy9/vk1zCFmbZbFH2gnRC7dIX3eh
 y3MPCfkDE9+hWAPH/mI0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Cq8ZRjx3EQ=:52fLR44IZKxQWspzgP2JkU
 xSFBMbGK9wgz23TiYUuVPHAG4eCr5UgBkwT0pBvNWbIVwYUJ7ukquYlW/D1uYl77jthlCcgAk
 IUHzPqlhfXHOr/S2u0qnm6F77P0SxlktJj3MPKAKxLxIZBo6KMDLmtnWgXjzRuZ+2HBvRM/NI
 Ox4PihS5QE3Ol/gy/tXZbkNyUzcpIjLdoYSZxq4bDdWYB06jtnQm5vl+P/OgBGuHc7+pJbDE7
 AQH6zbys8x0ZbTN/qQp5FL388LYjYNhKrjersuUNC7YgglyvTAJG3XLzlEtrteMwh9MVp2Rhb
 VcRIyBlbBWJgLcDTyRUvCMOODlCQpX/iTFjK1LwQV3AXr/AncvsLEyrzK1KXQrQqumKGSM617
 4B1ylxH4znw/KJCD5Rjbhn73P1RpnbF687uYdNSl7W2hor9PeQHaEPUqNh30J0LiZlkQHWwia
 JBHtV2yvbirHbj8sGKae6c1sZ/WX0Nc0fUTo12+HMQ/gKj1iTWLBtxKsccGy/ElnibjNLQ8Ff
 23MRzx5Q18KDks4hAQtoBrBzr/d7XX8qVNpsUbQ5YPkwGjBb7nxd4DgR9exvOtcgOgc3P3TdI
 xFpFQ+yIT9CKtWDueIqXtoqk9UbyDFOmh5I3Iev3DnWBiQPisp7l5VivE5wXkEdso/5Em9qBB
 BccPvzs4VxCwM3BwJ64W4G/U8Ig1gn4SeVj22h5MewSbjn5SLtmkZYqKyQJz6NDok/bWlB8gM
 V8OjBVKwHZ1d/r3obfU+3DACvRfM0nEBd6n893W0iepXI5OaGsWtaARTBx/Pycoe3TQvtLMNi
 lwKcruL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we use uintmax_t for timestamps, we can represent timestamps
that would not fit inside the time_t data type. As long as we do not
have to use the system functions, we can even display them, e.g. as Unix
epoch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pretty.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 587d48371b0..35fd290096a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -410,14 +410,10 @@ const char *show_ident_date(const struct ident_split *ident,
 
 	if (ident->date_begin && ident->date_end)
 		date = parse_timestamp(ident->date_begin, NULL, 10);
-	if (date_overflows(date))
-		date = 0;
-	else {
-		if (ident->tz_begin && ident->tz_end)
-			tz = strtol(ident->tz_begin, NULL, 10);
-		if (tz >= INT_MAX || tz <= INT_MIN)
-			tz = 0;
-	}
+	if (ident->tz_begin && ident->tz_end)
+		tz = strtol(ident->tz_begin, NULL, 10);
+	if (tz >= INT_MAX || tz <= INT_MIN)
+		tz = 0;
 	return show_date(date, tz, mode);
 }
 
-- 
2.12.2.windows.2.406.gd14a8f8640f
