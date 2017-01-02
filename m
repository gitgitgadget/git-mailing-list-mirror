Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3668F205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbdABQWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:22:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:50305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932696AbdABQWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:22:51 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrNoG-1cVo6Y1jsi-013ABb; Mon, 02
 Jan 2017 17:22:34 +0100
Date:   Mon, 2 Jan 2017 17:22:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v4 1/4] Avoid Coverity warning about unfree()d
 git_exec_path()
In-Reply-To: <cover.1483373635.git.johannes.schindelin@gmx.de>
Message-ID: <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kkcFBZDs/qKpCQVX1fttMP+WhaacVDy2SVMFAfNz+AKB6h0N7tQ
 hsG+sWYmMFPnimiUJCpsfPO7X1mbpQjQSW22H6gh/NRScAbc/dC9Hs6QZg2ZnaO/jyBdKMS
 Q/o1MgoXNoKA7SMWXUn8dfJO5K5xi34aC+AJ1OU83ZO9FGylxfIjhvVbLtwSdj8Lwph3MlM
 1L9vdXac84amuSnaX4R3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w92z4ko0DKM=:2BFke7IGCpVeuI4RhGJDtH
 xTKXsXiIO0vSRH3Jdus8kQONn/L3lUbjqfycOe+axvTK4wm3OZTvCLKEGw1/L8nrpHbqRNlzI
 LNzeWHhGBVd/PIj4niGFmjyGPy7kVPm1+KNIuKcf4dafTHyzpzaiW6A1Ij4RDPj0gZj9av0Pb
 TaIrkfldSRwPPg+4BZ0kB/gA2ey9t0DoqI22ps6TcfCfNZo+LM2hDx6bztcwApPzdap3LyAWs
 MixXmGmKxaNtBtevhR2wAGcJe/idJGlGEDOb0q+QdezyBxnF4JNAX5ZkjO3Qt2N4FyZa/Up7D
 Bp4DRt8Jl4TrkAvjT7u8zua0d7pjfZQEfJPA1J1l8tOxf8f8zQC0wHbBwHU5+IZMzkB/FVxTl
 Ss5pmYD5iiqMyGRm/OH/NcoH9W9shGB3SfoBwCRRxzYacLb7yIlSON1HMvkEqD1sKiZEJyClL
 FZCiwRNExg9pW/vnXKilvva88BtP6GLi9XbEbZ4+GbDIzKjysGA4Z+uJFDBKTIM1/GRV9Enbf
 ur8mX+1tPaQajSUUsL+dt8ehIrfmg8CeO3tY2sjj+lfKoKjOD+kjhR2qRiCL35rIpOhaCKfvX
 utpmQaWBQW8yTpeSmUaMaW18Tx3DkHE24ogizjBGLTgTBteCd1ZrHjN1LUkzn9yltKOrR4m4p
 TYoHzRjgglZm5JIDKwd1Vcb2yYIAh+bv20HhjGJVs7S3tU6LL94QovQXlAgc3tWI9VuTVMh/E
 bH3wbhIblr86OCVbzuB+zy57E0NB0glC448y0JJLzuR9RlwX6SpAJegAzX/Urs0ePmvFz8L2q
 AO+B6K9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Technically, it is correct that git_exec_path() returns a possibly
malloc()ed string. Practically, it is *sometimes* not malloc()ed. So
let's just use a static variable to make it a singleton. That'll shut
Coverity up, hopefully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 exec_cmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 19ac2146d0..587bd7eb48 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -65,6 +65,7 @@ void git_set_argv_exec_path(const char *exec_path)
 const char *git_exec_path(void)
 {
 	const char *env;
+	static char *system_exec_path;
 
 	if (argv_exec_path)
 		return argv_exec_path;
@@ -74,7 +75,9 @@ const char *git_exec_path(void)
 		return env;
 	}
 
-	return system_path(GIT_EXEC_PATH);
+	if (!system_exec_path)
+		system_exec_path = system_path(GIT_EXEC_PATH);
+	return system_exec_path;
 }
 
 static void add_path(struct strbuf *out, const char *path)
-- 
2.11.0.rc3.windows.1


