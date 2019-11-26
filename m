Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786FC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2DA20722
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LczsodEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfKZPSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:18:34 -0500
Received: from mout.web.de ([212.227.15.14]:50239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKZPSd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574781509;
        bh=Msb4e1HuvqF/NLmp9cayvstzRbI4JvPBDgX/Naf4DH0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=LczsodENCKekRQLFwHnNfNxRL4eW9mS1D2pvFj2r7xsXKRir4lCqMLSyJJxgGdUuW
         QxDAGp4nmmLBewpeuujF8BVKO0StE049AccDd2DSYkq8Giz+WV+r8zIK6D8oisA9/V
         i7+DU04LbSIvNBte8dcwMj5OsoHPw0j+hsBOu7O0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx2Wv-1hkseK2yL3-016cha; Tue, 26
 Nov 2019 16:18:29 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] push: use skip_prefix() instead of starts_with()
Message-ID: <90f94e4b-6cf3-58cc-01dc-c3d731037217@web.de>
Date:   Tue, 26 Nov 2019 16:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LekHn8Gm6MAY65Kxwkr0GT0pKmdMcJgzWM8OLj9dj1SW4xP9NIl
 cwPwPXBVjoglBRMswfzmX3FDhRyZZuX+Qng1Po7nLtG3s1hsHIvZLS7yktSzeW+LAMw3KYd
 Xzhm0dPvGLl1OBxnTdScXu0boy5sBCH9HIZX+1A82xJ4nKAgM/vGUl2dgR1IAhJ+mf5ybW3
 eCT0WAspD4NJHC+3UnWIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M9JIpZyTgrw=:m08gdDPVHJo4EZ6YdnkPvg
 38id+rGZMMfudNwNROAFa/h36t3dHgd6FDeaLiy9g2Q6/8cqFxygTwYKQDJh2vmYIM9r5f9tL
 ODtnPYo1Uy2x+2M809Nf6F/k37bzDT5cxW5WxlT+ENvJbZGH1MF/bhb2NCKp+k/R/DlDu7SeB
 jp1lVeFetLCma7qp6Wpl9yUl900GQo0sr6HsoCfPewC4WLCmoggqxkoxINKtCl3yJdpiHqFkw
 7ASL+WaLA0ntX4hYAqAjm0cCooC6NuE+Jw+X3OHhK9KXoVUAZj/opHPrY1odSW+LC7y3TZU6W
 3fO1ClpPkIzf5VaIvvQD5y/qgG2XZ7ED2NPTkmgnnZqcr3PRkp/0buMl67ypHnXf2OVqQ4zi2
 NcckIjQek8jg3njwU5Yn3UgoYyym9+Ibvd/cQQnxGxgyAmfxNHBrf+TcHx1OHGDx6cUbHr8gX
 D0Xtp+UJnx7uqak7JO+qOX6tt3cBWTTprpuTYOgNpeX1nNU+sHmq5Qlt12qv0a073kbdOUUhz
 Hxh8blXaJv5wB8SHAfdYXgm84j2efWCp3bwIWYAXxh8vGDUgFKor6sYgZfqtrQdhqqef7lhjk
 Sn3EQ/N2qD0171728Zzg/CcOXJxbMkidEzJX/KJNKae5O5X2//b/KVHWLSKPJ7PDJ+zfHJE84
 SGM2TYNFXf9+vE3ujVFaT7UNoASGzYbZbTehz0wqN9muAKsxNab5Lt9HBj49507qGSNmczdwL
 cstnnRJQDUKYBjLL6ukC7YZjYY48mEn2bDzn/oYfc8UvSczBGrqZ5njzAtF+3HJN6DUeogD0n
 X13nfQVp5LKveUvXTljiRMJAho6LjkOCyOYACRBFu7teSiLWGda4thzY+iatAU58xyjBu8IQb
 2GidADdbiedMD+N1sNNmkI+5wv+lgiHcf/t1ZLmg10KjBW3lkE25sd5OWMMgJHQh+3Bt9EHB9
 xH6Sb1JuaPqVfgPYD29/AoB+uV6CMGIx0CTOVNhbBvqneakshUbSS6Mfe570jvtJ548RinV1f
 2qdQgzd0MOI25kU4l0pAg1UGjLM68TCkWztekLJ1Km/BW8dlA+OvGBCo4dwFBfdw7wElszSxz
 239tsQ0bHE7mj51rCwt1L3Xa0ISYiIRkSb7m0/aaaKv1ATCuNUSF/ehzfrXGC9xy6pJ6AoOlD
 E6N2KGQyBBLaX06tz0jTJBlgdcIfn4u3lws3Cs4JZ5g7Vl0gymK9KkT/dYEX5rvsMFJmK8ByS
 vDieUTSoYgK3eLzn8iun1bLtKRxyi3FMlJ4EVIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of a magic number by using skip_prefix().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/push.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 843f5b22a2..6dbf0f0bb7 100644
=2D-- a/builtin/push.c
+++ b/builtin/push.c
@@ -64,6 +64,7 @@ static struct string_list push_options_config =3D STRING=
_LIST_INIT_DUP;
 static const char *map_refspec(const char *ref,
 			       struct remote *remote, struct ref *local_refs)
 {
+	const char *branch_name;
 	struct ref *matched =3D NULL;

 	/* Does "ref" uniquely name our ref? */
@@ -84,8 +85,8 @@ static const char *map_refspec(const char *ref,
 	}

 	if (push_default =3D=3D PUSH_DEFAULT_UPSTREAM &&
-	    starts_with(matched->name, "refs/heads/")) {
-		struct branch *branch =3D branch_get(matched->name + 11);
+	    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
+		struct branch *branch =3D branch_get(branch_name);
 		if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
 			struct strbuf buf =3D STRBUF_INIT;
 			strbuf_addf(&buf, "%s:%s",
=2D-
2.24.0
