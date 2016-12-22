Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9DD1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941870AbcLVXQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:16:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:50102 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941861AbcLVXQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:16:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsPwa-1ciUik0KAi-0124KL; Fri, 23
 Dec 2016 00:16:22 +0100
Date:   Fri, 23 Dec 2016 00:16:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Alan Davies <alan.n.davies@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 2/3] mingw: fix colourization on Cygwin pseudo terminals
In-Reply-To: <cover.1482448531.git.johannes.schindelin@gmx.de>
Message-ID: <796e3c4b5bda1170bfbb690a73dab5442b9c77e4.1482448531.git.johannes.schindelin@gmx.de>
References: <cover.1482426497.git.johannes.schindelin@gmx.de> <cover.1482448531.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fX+AfoS5Hiabn0NraiMfbtedNFZEMSs8hyJ1xgegptDVIcA4enp
 ycyKp60ihKUZIfAgvJrrvGKTesQjm2ayKZsH1Sy4Qim2dn0J3boR3wtIz49PkyhadgsgCo5
 o3OFGFmp7+QljdqFlo3L+93fPb0EoaJVMz844R+0NQtSWKFVUq3aisRvYhV6n9CoQoj4LUS
 gVpOzIFwC19grUiT1pd1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5fIhnhTY0+U=:09BEBDJMJTM7SZ2cJfFzIF
 NPgmiqCVhe8zOd25MQpBqVQ/vGVJajCJSP1flIKVwIoYrFA8xw04fdqhnzpdMQZgUlcwQx4oE
 TWaSmBiewygINAPtqVnAWgQih3zlRJKv/d8s/zuhQFKm0fyNnx+1cu4v1H9ZIjQ+B+/Fdeb+b
 GrhF8OARmk4QXlVxi9YNu7v13rdNyzoT6X9G8Ka/1BOwsjaILvSFJPmH/cXqZTeyZeUnl6wAs
 HMAdyeYEXye8F0A6Tlb2lYaqhkNuUhXr8bHRM4nyGxuhYoZgQdNc3bRHESE850T0p3Fq/+a3y
 gODerYjHFdiGux7X6yc9jilgRdFgEe6RSWaecL/S49+qYlX0X7D93hvdGDZD65OrgFzZ5WJg3
 HEFRJuGOFZHQgHAF+wt3EI/w2JnmuSxciF9P2vNgAvZqKgaT/ThMnnf4vP/sfl/7ul4PoRsAK
 6LCMQqM9PZBmvQPJaXcRkW3Rro6n12iGdP9U2kHQDSDstOdpVzJGO2Gv80yP22QQmb8hSGOo3
 kU6LqewTqk5+MH/2nqZ/B4FC/a6AkRvUhBIWw+fCnrER5ayEPwZvX3Em092hAL5Ziqq8sP1AG
 6Ap1WRpJ5+uoTAGdNWi6MK6qsIJlw2IJ4ln0iO6c5AbGwTpayYLsoDAlgZ7y6E2XDo5kXUICk
 iCESGJ1abXeXSDFMMLVt5w2H/CUuWi8WcaBj1G7NVOha4QheifVl+OkJDwtkLgBbOO/rUF0xz
 G8dwkNMIargRjZ8S+xTW+7tRa8MTRu+U8QlIq8VmJNtSe0uhg/7BqjGStF9jUqJPOScfwVCFX
 grdudE9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alan Davies <alan.n.davies@gmail.com>

Git only colours the output and uses pagination if isatty() returns 1.
MSYS2 and Cygwin emulate pseudo terminals via named pipes, meaning that
isatty() returns 0.

f7f90e0f4f (mingw: make isatty() recognize MSYS2's pseudo terminals
(/dev/pty*), 2016-04-27) fixed this for MSYS2 terminals, but not for
Cygwin.

The named pipes that Cygwin and MSYS2 use are very similar. MSYS2 PTY pipes
are called 'msys-*-pty*' and Cygwin uses 'cygwin-*-pty*'. This commit
modifies the existing check to allow both MSYS2 and Cygwin PTY pipes to be
identified as TTYs.

Note that pagination is still broken when running Git for Windows from
within Cygwin, as MSYS2's less.exe is spawned (and does not like to
interact with Cygwin's PTY).

This partially fixes https://github.com/git-for-windows/git/issues/267

Signed-off-by: Alan Davies <alan.n.davies@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 590d61cb1b..fa37695fca 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -562,8 +562,12 @@ static void detect_msys_tty(int fd)
 	name = nameinfo->Name.Buffer;
 	name[nameinfo->Name.Length] = 0;
 
-	/* check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX') */
-	if (!wcsstr(name, L"msys-") || !wcsstr(name, L"-pty"))
+	/*
+	 * Check if this could be a MSYS2 pty pipe ('msys-XXXX-ptyN-XX')
+	 * or a cygwin pty pipe ('cygwin-XXXX-ptyN-XX')
+	 */
+	if ((!wcsstr(name, L"msys-") && !wcsstr(name, L"cygwin-")) ||
+			!wcsstr(name, L"-pty"))
 		return;
 
 	/* init ioinfo size if we haven't done so */
-- 
2.11.0.rc3.windows.1


