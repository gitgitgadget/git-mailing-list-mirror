Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BDEEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjFQUlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbjFQUlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:41:01 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7138E72
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034458; x=1687639258; i=l.s.r@web.de;
 bh=4SEIxANFbIRdpqzIEcjzwrNp/gRTrpOzbQO0LvGX18k=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=tpdDqnO23gV8OWS/QmNY0CdGSaYKulT/OIlBXe1KQWdCUS0W3qm8rfn3o4NIu3UMLuwCngA
 uQfdbmGHzt2+1rxLvdf40qy8ikC8x3ICBjw+4v1TJdM+3tEGLkuwEZiJIYu6lRkkMz0snvn4q
 U5TyDlV/h7JelSlQ/iK/Z7EraZsBAufrZbLFPkpuw4Y/Xbu0Nf+nvttnKXdpnZ/k31ranyusU
 aA+chXO2CGKtgiYZqgJ4a+HFI7w6z1NhrMDM2MGaSGGOi5ac4CuzUqdLuwXfNTi1RNfXZwMt9
 djYnHwd0bm3vgs8nBXboXIU8atPbJEVC37EisscS10q9V2bIDiTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1qcCfO0l36-00YUcl for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:40:58 +0200
Message-ID: <9aee9e14-5459-b62b-6427-23fc0d532b5b@web.de>
Date:   Sat, 17 Jun 2023 22:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH 1/5] pretty: factor out expand_separator()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
In-Reply-To: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WIgyYq1xza4audC/CpVKCa8bF0dEMhe2Kjo/OAmCNQ9n32eGMC6
 jALdzyCphD0MKHjhUrE8g6u8Lniqj06FIcXzwBJIlseiANEYPf9sWY0cjYfbg1XQSyAoj6c
 SajHf7PQpBS3TF4FMCro/0bw1L0S+aYEMkw9r0zHbKaztXYSgVmg1W/tTcH2CxmGAWpu7FZ
 MnX1l0BBvR0whIYjAnBwA==
UI-OutboundReport: notjunk:1;M01:P0:4pbQ8EREbBo=;NTTQ/XmJhQELOv4ab6eVNmnaENa
 kOO2TfIpBoXV4i/ORFM+snwdfJJGuRH+fs+HQP8zQyUldfb/d+U/iovdAHC+hlSY7HN6gVnrb
 f6nhTgiz3a1Cp/B7/PHX4ryuVfOT2TD1dKkFpvOW0W8lPmroHWyPBjH6hxkAstDcpB/vVKW5B
 YGyoWNvL/jbO7HqMmpzXhVSduV4w5YIRx7rm3aXMXsZkxzbj/VbEyNLNS3PSaBeWoSgRKgJQ3
 n424OyttInlggD+tUHzzBklCFIReIoOFkwbedwhMtUNHgF11Kb3dt4Dq7sWlcnyb1lF3moKyS
 L151p4wOWUbe0cX5fR1Ydi5TIrzVtWA3R3zCD2XsN2Svv6yUz0H0/fQNvU4zscb4cQ7OF9ij6
 NT1QwOU2674I020PzFGZO2bRAloFq880sbEtwuDL/5Is9c7nwKS/Jut2WzOPapfHWm7eXnXdS
 sFn2MHArMElzPMaXlqPMEU+r7m4Lm2Diqhrk+Bi0AjUwPihICyaP9lzyv9/X426DgOQkwYhmx
 JoCZgvfeQlXuRrKYnQcEvJlxuWVxDhk0MOuU0YWO8AbYZF9k9cRz105+A8UYhHVDH6mkBvNGX
 2OAm3YMW82Hl+BJmnuE8TafRVK/YLC0Hnw2IM8CTYl+eEReP+/P1MIYxH4C0yjoekmLmDbDMj
 Gt5wEkMlN4lND6xrL0g2izS1JxoMOC4Z5LOZ4XW0XIueYFUUAJn2o7cJMwJO4UpbXCPpcU6os
 dBlbisZ//Gf/SpzrBtimTbLJ2kntZcNFxKNgOdKPv/DWoewsuy3a/ncV+KTbqfjp6aQ3CgD7q
 3/dpGE3TmdkC/v6ivsJ+RJR3a2wxHLVhZhODvP70ZNrSRfM6V+tkAgvBC2xw9z9IKXWCEQHRL
 syjCNBkFN8s0Ctrd6zAX7fB7kT7I8l9UvuQpSpBhRYqJEbPKOQ4E4rWtMmIQe0QqTTaOu6kat
 vJ7rqjyEDnD6LpMEjXikkRaI0kc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Deduplicate the code for setting the options "separator" and
"key_value_separator" by moving it into a new helper function,
expand_separator().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pretty.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0bb938021b..d2df561a05 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1250,6 +1250,17 @@ static int format_trailer_match_cb(const struct str=
buf *key, void *ud)
 	return 0;
 }

+static struct strbuf *expand_separator(struct strbuf *sb,
+				       const char *argval, size_t arglen)
+{
+	char *fmt =3D xstrndup(argval, arglen);
+
+	strbuf_reset(sb);
+	strbuf_expand(sb, fmt, strbuf_expand_literal_cb, NULL);
+	free(fmt);
+	return sb;
+}
+
 int format_set_trailers_options(struct process_trailer_options *opts,
 				struct string_list *filter_list,
 				struct strbuf *sepbuf,
@@ -1278,21 +1289,9 @@ int format_set_trailers_options(struct process_trai=
ler_options *opts,
 			opts->filter_data =3D filter_list;
 			opts->only_trailers =3D 1;
 		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval,=
 &arglen)) {
-			char *fmt;
-
-			strbuf_reset(sepbuf);
-			fmt =3D xstrndup(argval, arglen);
-			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
-			free(fmt);
-			opts->separator =3D sepbuf;
+			opts->separator =3D expand_separator(sepbuf, argval, arglen);
 		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg=
, &argval, &arglen)) {
-			char *fmt;
-
-			strbuf_reset(kvsepbuf);
-			fmt =3D xstrndup(argval, arglen);
-			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
-			free(fmt);
-			opts->key_value_separator =3D kvsepbuf;
+			opts->key_value_separator =3D expand_separator(kvsepbuf, argval, argle=
n);
 		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_t=
railers) &&
 			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
 			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) =
&&
=2D-
2.41.0
