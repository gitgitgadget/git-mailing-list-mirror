Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5AD1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 11:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfHGLPU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 07:15:20 -0400
Received: from mout.web.de ([212.227.15.14]:55093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbfHGLPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565176515;
        bh=7XVNqcF9z+2xF+CvxCvyPHUkM0R/viJBCLprjQjHVIU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=pbBfCtnudjOqli64eXmk971GaVFccZ4hKQykZ4KUA2W1YQBv1SQ/Q6BmjKBhjaCCC
         J27V7NGZEpeW6PrmIcxaH/oQt6qjt+CsBjpiaaXiGkAyRIKMnqucNo529gN3uoeg6M
         DjZxRVA+dyztzv+fE/u73dZXbzGf+7/Lncbw4vtg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYejS-1hqNxR32Qs-00VRiY; Wed, 07
 Aug 2019 13:15:15 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: [PATCH] dir-iterator: release strbuf after use
Message-ID: <3729e2f1-2995-86ae-cfa0-a6fc4ca64917@web.de>
Date:   Wed, 7 Aug 2019 13:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wrIWKWAnMieoaBOnsACDOO+vR9qsMjLHnaP6vgdscbLdK8lSegO
 w/eKa3xqydcKMrZJMtjscsd9294xzi1cGvhkPb9qQEpErIS9fs9qXI1hl/Zg0CCM7BBKBsx
 r8sMJKk20KCgzBYJJxme0VD17ZdKbLNRrMU9KmvxO+XfiBbdP+fkNT5OjLi6TAUfau54u71
 Fr3hCxWUcAc8qcpOfvUiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d3NDRlTFMpQ=:qhWvfZ8vUFM0w3GdloOCUd
 Pb76nPsPU+smkWd6esI/UCJo1By/1t6nBCTeynAJhRiDIKfLjj58RhgHm542dna49bXQkKjBs
 3zDsUsGAg/wNkv7lMLNvd1KKGMJWRrI5YAhP4sAlYrax9iRAyw3Qy1iMnfHYB6SbHeIUDSHJs
 Pm7vpQWp3skrDjmRUkAtGe6pMBu+hiJzXkuxqJzpjiAyH26DHRUB6bhd+zGsoWh8k00Dchf7X
 jLmrjwaK6d7bH+mk4JO/20r2sWCmA23UgOPz472MeE21bzRg5nAGcrQ867SMSWw2yi5mFL/O8
 03dvvQmL09ktp+77EbS1FQjRu81AziedK29tq7qXb/veKbpygxLt0wfeHAaGPJTtQPECcX5dn
 Hm1IpipbY8wF3t8ZfWIckGySJuIsT9Lh0BeU/njDfwpI+QzglZpLIdmS4rPgNlKGeHSHuwZhD
 jO+1Ndic7kdWpt/jYTHsCkr3iCmGLRN6GK2iEyJNliTvHNBS9wn6ZUSnk6tTkYhmCMVMLJjmf
 pkjy8nmRnbb2L43DvSDAH/QCYHv/7KFEy9hpl6rARpU+yKKe2FIAwWb5itCrS6VqO6UULUDjY
 PBL67W1fweRslCnILfaT3R2tKuV2AnUdncrLjH7pYnNfucBBgbX3qFU9kufHo1g+0Ge9GPeSj
 yT0tNcmMDY+NPZa4AVeLNz3mYFOKRlceQkAljMK+s7DFWgvUJ9bazgtSk6vVR0wakzqnJ3LxI
 8jZKnFwKmOEldXXsCeSlw+oeL2kaLWL61P5N/bQln9HuGY44FbmjimANUMF5v0qo2eXYv0ahW
 zoVCV8i5YPEmoVdJ2CyDkmUxcisO5Dz7WDetruv1IzG2SR1qV6Td/j2WWKfwaOY560Jdm3GLb
 9TvbLyDledhVlUBU1q9xdY0BjVl2YZN0i+WSRF16EauZSR5KIGU9ICR7UcSp53i7AwB117KdG
 4VCaiY2qgt6FQd1l6lgmVITW68cwohcqwozWfeiQOZQxZkatgqvFsbyyAbOpHHlPPbNSFMXr9
 FEi5mpLECTQEuGhwlZXBYV3KnArupJc8AIJqUGhgzpLitF48SarOOFOo+/U7idrafE0e9Gk0v
 h+TrHt3V3ohivPy1btkPx60osarMEGstSGDasKxRazA/jSiLToEchVPWuewLiSgRkyxP59k9a
 gtW+s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.

The plugged leak was added after v2.22.0 (2019-06-07) by 3012397e03
(dir-iterator: refactor state machine model, 2019-07-10).

 refs/files-backend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b1f8f53a09..d60767ab73 100644
=2D-- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2143,24 +2143,26 @@ static struct ref_iterator_vtable files_reflog_ite=
rator_vtable =3D {
 static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_s=
tore,
 						  const char *gitdir)
 {
 	struct dir_iterator *diter;
 	struct files_reflog_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	struct strbuf sb =3D STRBUF_INIT;

 	strbuf_addf(&sb, "%s/logs", gitdir);

 	diter =3D dir_iterator_begin(sb.buf, 0);
-	if(!diter)
+	if (!diter) {
+		strbuf_release(&sb);
 		return empty_ref_iterator_begin();
+	}

 	iter =3D xcalloc(1, sizeof(*iter));
 	ref_iterator =3D &iter->base;

 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
 	iter->dir_iterator =3D diter;
 	iter->ref_store =3D ref_store;
 	strbuf_release(&sb);

 	return ref_iterator;
 }
=2D-
2.22.0
