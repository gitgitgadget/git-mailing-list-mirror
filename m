Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4C31F4C1
	for <e@80x24.org>; Sun, 13 Oct 2019 13:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfJMNhs (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 09:37:48 -0400
Received: from mout.web.de ([212.227.17.11]:33153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbfJMNhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 09:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570973859;
        bh=eQoFcSAN3hO4FVFgJhRvJigJg7D8g3uR1pD3kuCJGL8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=aZaB/GDvw8mNa0cKIyUVR2UTB179N4HGdyMDX1byOuqtIWecbjnzrz+XlkUOTqzat
         TSoyO9aIeba9BtEaY7uiXYxedPtOeLUh+Tm1iA8o5Qw9LViC6NvoUjEy3LGiXNuJ1E
         JB/GQLOnAf2cgdruqWOrK2lTQimxUBiaPwjlAcq8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1iFmi53410-00EtTJ; Sun, 13
 Oct 2019 15:37:39 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote-curl: use argv_array in parse_push()
Message-ID: <f0eda0fb-7aae-cd64-194e-44a66eabd225@web.de>
Date:   Sun, 13 Oct 2019 15:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6LMRJfxQzjmIDghG4g+UDZ+4JSwuNe99emftWK7FIuIjIW0/OGv
 4RzHQPxWF5x3kUsOWsNZZCT1jBG1pQ3VzD7RqeRqVlyAYplke8HTLtyWDgtFcO3N1dt+QZC
 /fZ9/Fa0hWLQeOihmmamvTpxXGCXFuo6TrtmQ0l+jNwHuOSL/4+fHHQgwoj0Iu6N3JRUpoO
 qmTOFJqMix+yainEjxYcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eGX5XD+oNK8=:1BVkyaMgkyvbraOo3NLsp7
 pUgu4scn+nkCvHte84ShS9AO42EJxUh0zwP57Q45xtmzIde/G0E9aJRVpU+hM6rHhrA8CeW7B
 /GBnIyAO79NKWEb0ycpSYUUXCWtx/uTwpwtoX4xFoVQxUBoaC+zfsLnlb/vVLMkvghxsE5dL2
 kNk2FsJskJHId95UfA6I8h7GhMfy5q9pdgm7FvicVT8Xa+KoecBf0mxL7oasODTDCX0GjO9kG
 xdvfYp6EXXEh/1ePIuuEYFa4hRMMSN4J3xnJYHD3HXl9tHV1HL4s4bTJ7AGwvO7Y/BcgXpcE/
 6HzU8FZZOyiLZemQz7rhxY6BEpteRzfKujqefhou94+pFzJBEY9ekm9KagbQnluvOcjKIQ9a5
 MkGh4jGKq8sRYrk1lfJeKBM1IG9oFnZL5QL80+j9T+J2sO1UUtVugWfkggUMvEPac/Qug9Y+e
 c2V2qU97okNk5cXpt+hxtO3Vm8bPG+Efv9upxMfZgvpL9wNYr2AbMRBa5mWUqGA2sKF76qzwR
 RwZVqhXQoDeKVlrdUa59JTKf6eie7cStFRwZfy4q77nobap1vHfrZPcpIRJiwSI4sDsb9zyAU
 0NFGPL+e4G4Fix2+UzTO16DCmaXvmGfnWJFQbnGoBAd4i9jyhLFBz2TZEdlx3x81+yj/orNGY
 RqnfrrnKTtbjNN9cOupChwUhIrXo5iLLB6vuvCLUKFoWJqkzT2UBwLt1/ncFBkw4OoZhV/vHg
 F3uolS9hlyEVk0kAertw8nxTW5kimdvOFc2AlO7kKOe1c172QdDRc2VvKtShlnTbCOLDclArw
 3+6eP/ex69rgPkjQwZszjbhKxoQdHtybdR2gRPO6yZkjpkl0AOqcvanLsjqB89vTzA3e1d45+
 ef1satwKNa+LjP8Tl+/7zrxK9hLjfJ6DsjFI+Rf2uqG7Wh98nP/W7uyRtTpW38e0jAW5eq7Cs
 G6pZH0gkNr4uNw0cVZSdKXM7GQsZgolvYtO1qBexFH/jBpjA0gGVYBJD8YTNNu3D58v13akpY
 cRcd4h5+ceo9PxvJRES1kMHZr4HN0saYQTT0sRcUaw/dOkz0B8xK8meev8LH0tZUb7ipXt1q/
 4QzyuqVWyLYDp4q2DkT2jKP0Opy9MVmErWNxFajHTHEiG+CoRcpzPdNpdZ3d50wo2EQOja0Bb
 vUUKeMVSTD+bDyKt1jo+jHvmfR4+YiMgE8vwOS6P5/3fDtN1EJ13QpZNoV25Elu7Wvhl2Ed+b
 9ChqwdjWgZ+cTuPCJyi98aE2F/m682ssjFMMoKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use argv_array to build an array of strings instead of open-coding it.
This simplifies the code a bit.

We also need to make the specs parameter of push(), push_dav() and
push_git() const to match the argv member of the argv_array.  That's
fine, as all three only actually read from the specs array anyway.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote-curl.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 051f26629d..1612e7f52d 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -1154,7 +1154,7 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }

-static int push_dav(int nr_spec, char **specs)
+static int push_dav(int nr_spec, const char **specs)
 {
 	struct child_process child =3D CHILD_PROCESS_INIT;
 	size_t i;
@@ -1175,7 +1175,7 @@ static int push_dav(int nr_spec, char **specs)
 	return 0;
 }

-static int push_git(struct discovery *heads, int nr_spec, char **specs)
+static int push_git(struct discovery *heads, int nr_spec, const char **sp=
ecs)
 {
 	struct rpc_state rpc;
 	int i, err;
@@ -1225,7 +1225,7 @@ static int push_git(struct discovery *heads, int nr_=
spec, char **specs)
 	return err;
 }

-static int push(int nr_spec, char **specs)
+static int push(int nr_spec, const char **specs)
 {
 	struct discovery *heads =3D discover_refs("git-receive-pack", 1);
 	int ret;
@@ -1240,14 +1240,12 @@ static int push(int nr_spec, char **specs)

 static void parse_push(struct strbuf *buf)
 {
-	char **specs =3D NULL;
-	int alloc_spec =3D 0, nr_spec =3D 0, i, ret;
+	struct argv_array specs =3D ARGV_ARRAY_INIT;
+	int ret;

 	do {
-		if (starts_with(buf->buf, "push ")) {
-			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
-			specs[nr_spec++] =3D xstrdup(buf->buf + 5);
-		}
+		if (starts_with(buf->buf, "push "))
+			argv_array_push(&specs, buf->buf + 5);
 		else
 			die(_("http transport does not support %s"), buf->buf);

@@ -1258,7 +1256,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);

-	ret =3D push(nr_spec, specs);
+	ret =3D push(specs.argc, specs.argv);
 	printf("\n");
 	fflush(stdout);

@@ -1266,9 +1264,7 @@ static void parse_push(struct strbuf *buf)
 		exit(128); /* error already reported */

  free_specs:
-	for (i =3D 0; i < nr_spec; i++)
-		free(specs[i]);
-	free(specs);
+	argv_array_clear(&specs);
 }

 static int stateless_connect(const char *service_name)
=2D-
2.23.0
