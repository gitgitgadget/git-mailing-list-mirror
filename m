Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E7C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356664AbiFORAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357189AbiFORAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:00:37 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C7A51E54
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312398;
        bh=l25bGK4F8qm1yqKuZ/f4WA2c4yj52roMCXYwFXn623Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=beLPnSaIO8plJGvjyQyfCKl6uX2Gi6IYIeLQolYQghUOhVren8hcL9F8jWrdfcI/G
         b0HncmATfrvDzf8N2HBggzWllmREq0CsCVE+vSErGGZrCZw0cFl84m0GLM/Xa3TJkx
         29acX6aHU9sxTEVXSZi/XpJ6oUXIKGm5bPUMo+tI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXXRL-1oDRpJ17xX-00Z4Gf; Wed, 15
 Jun 2022 18:59:58 +0200
Message-ID: <00e5da9f-a3fb-8a5b-ad29-4016873b0e90@web.de>
Date:   Wed, 15 Jun 2022 18:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 2/6] archive: rename archiver data field to filter_command
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gpvrPSwwkPwo5rcJKqESwROALrKP5s+hq+AXciaSZRaANunzLUh
 uN6NmXoldTL5NaImOZTLZUNTxSccGfQJXFTGNzk4IIgUhBY2wGqOxvAsHJls/JAjyOxvM2p
 ng5MnGdtB0Voeuw5Hy9f8fhwTU6KZ5smxyidSuAjXFKkNksSR0iYoYUgveK8Tjcew5NukT9
 xAzAhdG/z1NnOlayEvA/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6afyA4lyfJk=:rTy/YG5Cuy1fcJQ1mwDuxq
 TtyLIdZQLivVDn3MQ5zvAOp53fYlxyuHUrqISFSfwdeYdsPV0Ta8S+h6PewAPFFPvbWRkF1o0
 nfr6MKUHMkxXL0Kll9HhvAEVZMMRIg34vRZmeGLwNePvROSkpV2WLIlDdSgOatkxXUKDqnG1y
 WHOc+YPHD7zPaDmTLCRyrgyNwTjikkgFn1P5/aglIk3+Y3xjThK2CSJtzp7E29Jv+KJLDb50Z
 Cy9FlrgBVixOOTdSYXTDV7EskYTghaQit/cmYlY6GsxIM4ZZe1mx3ba6IXxx9ZJZSPbGKxdXt
 zVtIdocnyuUtm8IyXkb8tgcNhy2aN02AqeHxm5bmraZ7My7HNR8gmOkHlyLPAFbRbNLe20/s3
 zfFjBbXX9ue/BVoL39PoW3x8fR7Y0DwTrHc+JW+76MN8do4hDZ8HJZhomjM3pERSY3P7Vh34Q
 eIT3vUg96iZ6UYcbrceeGOTC2WvNRkc0ThhYN/8dHvp7arALN62omafl7ohHJK7FmfGgKvyYF
 mqNtHf+W/DZPNDPTCK6K7+osNbsWdizuwFvqSx9gihl0Q4oseK12ZakL4NSPhkvjCvLIkgfZ4
 cQdlAiUv8Yeqm7cPgP4tY+/oQ3gOVdz1vcH1LpmsAy3fnsIfNWoFKqSWuHNmz+qUWMGiIRALM
 vp/o16K/bD5xbPw83D7GhEYcV8BqIJmG90iLazUg9AID1sg/FV6mWIyqNsrPptDIP+sqmsmoj
 n+EHBKF2o4GAomg3KKOHGVerMvNIB1Gcu73h0ZRBTCPQLQ1GS+8LlPkNfonp2mze2QhIgrzFn
 AWTYNJPDOEfIj1p0Qy6OXLWlqlQDvPfnnsfTgG79dasIpWzQBYoijHfIvvb92Dq7oLslU12q+
 5D90ycj6dHkD1+BWU+xTDMDOrVCLWo95gx/jDOerRQwat5sYNKjwtKATqKl0msy7BcWQFxn5Q
 G7rBNJxt6oCOTTmyLZJoc99SgJZ5eLvXqbK9ks72zKvzhfsctxe8gY8YHz7zv1XQbNWfnk4U3
 zWMUpPH8obOPrjIBw9qSE+a+VHQPK396ngsUBygpKAipXisupaXma/K2ty+Ydg/GYkBUc08nR
 sbIbpqDBRbv7/zp7vZ+98TJ26nDqfdwewLd
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The void pointer "data" in struct archiver is only used to store filter
commands to pass tar archives to, like gzip.  Rename it accordingly and
also turn it into a char pointer to document the fact that it's a string
reference.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 10 +++++-----
 archive.h     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 042feb66d2..2717e34a1d 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -383,8 +383,8 @@ static int tar_filter_config(const char *var, const ch=
ar *value, void *data)
 	if (!strcmp(type, "command")) {
 		if (!value)
 			return config_error_nonbool(var);
-		free(ar->data);
-		ar->data =3D xstrdup(value);
+		free(ar->filter_command);
+		ar->filter_command =3D xstrdup(value);
 		return 0;
 	}
 	if (!strcmp(type, "remote")) {
@@ -432,10 +432,10 @@ static int write_tar_filter_archive(const struct arc=
hiver *ar,
 	struct child_process filter =3D CHILD_PROCESS_INIT;
 	int r;

-	if (!ar->data)
+	if (!ar->filter_command)
 		BUG("tar-filter archiver called with no filter defined");

-	strbuf_addstr(&cmd, ar->data);
+	strbuf_addstr(&cmd, ar->filter_command);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);

@@ -478,7 +478,7 @@ void init_tar_archiver(void)
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
-		if (tar_filters[i]->data)
+		if (tar_filters[i]->filter_command)
 			register_archiver(tar_filters[i]);
 	}
 }
diff --git a/archive.h b/archive.h
index 49fab71aaf..08bed3ed3a 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -43,7 +43,7 @@ struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
 	unsigned flags;
-	void *data;
+	char *filter_command;
 };
 void register_archiver(struct archiver *);

=2D-
2.36.1
