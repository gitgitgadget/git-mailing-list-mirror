Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF1B1F404
	for <e@80x24.org>; Fri, 22 Dec 2017 11:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbdLVL5I (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 06:57:08 -0500
Received: from mout.web.de ([212.227.17.12]:64656 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdLVL5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 06:57:06 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3SxQ-1fIwbF28qO-00r0bu; Fri, 22
 Dec 2017 12:57:01 +0100
Subject: [PATCH v2] http: use internal argv_array of struct child_process
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <504cafe3-2960-af2d-10fe-51e8ba3d2213@web.de>
 <CAPig+cQaQ9ae1e4eMfJMG4wykXe2tTgtvpxB1_Z=3XbitYeQyw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6bebb8a0-31ec-b20c-2430-2d69daa63dea@web.de>
Date:   Fri, 22 Dec 2017 12:56:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAPig+cQaQ9ae1e4eMfJMG4wykXe2tTgtvpxB1_Z=3XbitYeQyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pZRzbjN6e3wT8Xc8KXt8TCx3J/SARokx/VvVdToffzLVtq4Csxu
 CMfHNL9BXrL5LHCTRMotYXxsJb8XxeP0+4fkooj8ITHFdQfHYwEJkPuIOj+TaFV9v46B+u3
 OXVOMoFvyVp0zy3u1rDG2YdRTUbqGzFcnSKXSvhm1sOj9KqguaSI8QAHZI6vc4XjwMqYv6t
 8tEpO7huVnyK1Aik/Lexw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XrOuobjdgoA=:RDiaBLhRWHlEQPnxYJbZTn
 3/x22Et+T2lfZYVdqvi+/gDVJOgTJUdcLwa7VuoL4qUQdGBfoBbWPON8oqrnnCdw2FL4+sA73
 xnYTGGLOCzzEaEVrmlIypQU2KCu1DCkmd5tceaj90ddU4CnXsdLyCSCAj9jGW/Dxl81fcZMDX
 OwWLysFOlWyQc3dY6OOn4H76SZ0UrvUlvAZllD//QoB4MlBJW0uttEIBJMbsaPgwSGQxT8PJO
 xPIMUxg5XY6d515kgSwT2STX76aMq6foKqaoIZjLMZziw+7TDT6jZyOC6ERYIY7XmOmP/fyHp
 9LTa0scfMdHKXMAgXpOUmN1BTNNxd3pJUkSdX4XXU/ap49+Gr0eZua6mSnuU/UiduTEkCKQuO
 fPimh3aKA9kT9JFnVCusscMgtkQ6ldGaYs5EY0kXBfVMYbScuNgsprw4TIOC+x9Qqhgp1P8m/
 HO4wonOTmF120FclvQhVOrzgN3qXjfyl84VaNDvyP+oAoQMSfpqKjgAfGox9LsnIaNVzeWV9j
 /Bv1Mq8vpHD48x1VK1Ivi1B88UJA5hofa17fM6MMumlTBZ3CTY7uJ/xleSQ5WbfV0+z/P+ge5
 sYIXohnEksffd2McqYBkTYcXFovmp0hzG6zp0tIh0/YJ0mJOOS44CeI78ZGlZVjPxc0Se5mp2
 k/ZHz15jAC4o+XIHAOdAPxJPJmPjJeivIIJ+ulg/EVWwBzDQY7ebtiJkVwHodAKtrK0cvz0l8
 fPjqSomeg82ZXekrkBbrBU+uJus5UZSyylFjoqrmBKaSwoc5ZY8wM6l5Fbt6HVA6V7oxHSKyh
 YQ2JmcI2ec6/zekeVI2MLVCsQkhe4gEk2Dz2bnOmwZAGGrEfDBJ5tv/aOHYD0lI2V7Mr4Pz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a strangely magic array size (it's slightly too big) and explicit
index numbers by building the command line for index-pack using the
embedded argv_array of the child_process.  Add the flag -o and its
argument with argv_array_pushl() to make it obvious that they belong
together.  The resulting code is shorter and easier to extend.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Change from v1: use argv_array_pushl for -o and tmp_idx.

Thanks, Eric, good idea!

 http.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 215bebef1b..9f2fcc9ec4 100644
--- a/http.c
+++ b/http.c
@@ -2025,7 +2025,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	char *tmp_idx;
 	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
-	const char *ip_argv[8];
 
 	close_pack_index(p);
 
@@ -2041,13 +2040,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		die("BUG: pack tmpfile does not end in .pack.temp?");
 	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
 
-	ip_argv[0] = "index-pack";
-	ip_argv[1] = "-o";
-	ip_argv[2] = tmp_idx;
-	ip_argv[3] = preq->tmpfile;
-	ip_argv[4] = NULL;
-
-	ip.argv = ip_argv;
+	argv_array_push(&ip.args, "index-pack");
+	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
+	argv_array_push(&ip.args, preq->tmpfile);
 	ip.git_cmd = 1;
 	ip.no_stdin = 1;
 	ip.no_stdout = 1;
-- 
2.15.1
