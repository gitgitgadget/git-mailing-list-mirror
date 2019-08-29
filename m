Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A67E1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfH2TGf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 15:06:35 -0400
Received: from mout.web.de ([212.227.15.4]:53459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfH2TGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 15:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567105585;
        bh=mrh8aZQTRldTtWy53emJhwxT34pPYDCmPdlkwG5hBvU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BjzFZuGPpBNz9kmfQq89v+YShDzDOCGVA4c8vjMKEDV2YxPSnzU1R4jYiTOLeB76O
         sDGLD3x741L7j/wELPgIpkp3k1j648+zvLI4zIS/wc8HX0PlO2tcdzbERqwD8K0xm3
         LwoZ3iS9LjZlovDcQhRBOBzQr6NrlvdUGvKtG/zU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mh7qL-1hqZrE3NXF-00MKkI; Thu, 29
 Aug 2019 21:06:25 +0200
Subject: Re: [PATCH] fix segv with corrupt tag object
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>
Cc:     git@vger.kernel.org
References: <20190824230944.GA14132@jessup.stsp.name>
 <bcc29199-a4ac-6bdc-6715-9807737253d8@web.de>
 <20190826115715.GB71935@jessup.stsp.name>
 <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c6601cca-7de0-ba82-2e18-916a2e9048d3@web.de>
Date:   Thu, 29 Aug 2019 21:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IHryajEXy4BqUunNqWBauGXZgFicjewhXOSMCmaTKOwatP+f2HO
 hSqS+rXWhw76nd8yDbGYVoSpbNUjo4L82Ka91OUS2LGWSb9MuwUSwK0lp4MizZrgUB1GiMI
 lrwYSnbFPgSdvSqT3uUiO+ylx8RaHnDsWc2yixiWLORWz0t5GfjEe/BNTFSfoFCWnZFq2/J
 ALZHYvyvBZm1DSDpBzsEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/mC2+NWxZgs=:Z/rr9t5hmllj4ZOIuxgWlI
 02c8J/2IjDzUpzLtcWHoOT6gd7kyVCyKXuXjp2JzMOjOJxQVF3siUYDlMIDMWifTaYF+FTYUU
 S6tCCq6eslGTmO7NVQd2WJMrqhPp8LXdMgaT0WqhpTGl/yyPx3irirfJeApcCH4Y+POva4SaS
 23e6ifyCN710YyC9rdgzA8lBeQ9FH78Kl8iIHv9RXCH3zCTURoNtBk+WdxCcjpVGJP1s6NnJs
 g8XAttbPVEF40soPVeM417TwUfn+GfSSUKss1MSVL6WTNAATPFll/CbRfE+8CbTeNj1+05FB7
 IJn18BKoG6F2q0kcx4MHCGSycOF2j9NE4lWi3+swMOL6NHukG4Jty+POtZL4zkY8OAK7+jmZ5
 iDOb0N94nGP2ceVamFHoWWqsyGgT8OHnuLEL7D5AA7yPRW1wUqUDyNxfEN6j2gn3Q++I1YWc4
 9ZofSgod89Hj8vStoNaK7MUk7Z97Xo8rCwOZPfZ6tepMPwObVhNZBuxr3S8GGPS1IfVZ1U/v7
 nrCUZTJbfulbvcwcZQgym8xozYyHSc3bu3Rbk8B/HQ62HhcyPvAyegLz9/Pae4904F1HxPzlm
 BGlZ+Mide/OmqvlCEJl0k+HlqOS08+m/HuL4LucoqHtTbJuI3ZBqzbrbxZ9U//cVEsr1LNubE
 YWbBamPorEgjm00f7Lx/IHEQMKMXY8LjrJDsX/DS1TLWvaXymaHwAGAJ0gMFu17SNmU3qAAhb
 Qo3N5olzeGvcw4b31rWiYpBQJ7uGdI4YMBVLN+RXWC291RxYssJ8nzJwA1tA7d+5OMUSXp2+5
 DDzMUwpu8BwfoYTGmwfN7aR3Qed1T62d2aaOQrnYz2j70eXYuW7eY8O5JfPnY0Y9gQrATXP4Q
 LYWmhnerveaFQ3sa9dfRVDPYuETmQytgUfeN+xoPOcHnSzAsCHpuAaeuWsTHXLnD2nvJhskP7
 lcncs25/IcRPkfcRU+C9tZ3MZNwzzr6pGaCBz5+BUFU6wcIUbEwbzVn7Of+PMdaP+BRtsOTOc
 U4xEf5reOLYRu89y7d8J3wOhumLTqV9aqM45M6df2fGFYNute1/CF4mkFfbXB1PbSnEVrqh0n
 k2K0ZX0GilYS4EaAhJZ/vQVyPFY+agpvyR2VL5Tyi7DYcIbHRWFMJTb5hrENYxzltcUHJN2gA
 HH2U//SP2Op7u4FEfcOkahvW9eT/zwotLGVBw9gtOCNy1LMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.19 um 19:20 schrieb Junio C Hamano:
> Stefan Sperling <stsp@stsp.name> writes:
>
>> The root cause of this bug seems to be that the valid assumption
>> that obj->parsed implies a successfully parsed object is broken by
>> parse_tag_buffer() because this function sets the 'parsed' flag even
>> if errors occur during parsing.
>
> I am mildly negative about that approach.  obj->parsed is about
> "we've done all we need to do to attempt parsing this object" (so
> that next person who gets hold of the object knows that fact---one
> of the reasons why may be that the caller who wants to ensure that
> the fields are ready to be accessed does not have to spend extra
> cycles, but that is not the only one).  Those that want to look at
> various fields in the object (e.g. the tagged object of a tag, the
> tagger identity of a tag, etc.) should be prepared to see and react
> to NULL in there so that they can gracefully handle "slightly"
> corrupt objects.

Not sure how this could happen under normal circumstances, but how
about this here?

=2D- >8 --
Subject: [PATCH] tree: simplify parse_tree_indirect()

Reduce code duplication by turning parse_tree_indirect() into a wrapper
of repo_peel_to_type().  This avoids a segfault when handling a broken
tag where ->tagged is NULL.  The new version also checks the return
value of parse_object() that was ignored by the old one.

Initial-patch-by: Stefan Sperling <stsp@stsp.name>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/tree.c b/tree.c
index 4720945e6a..1466bcc6a8 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -244,19 +244,7 @@ void free_tree_buffer(struct tree *tree)

 struct tree *parse_tree_indirect(const struct object_id *oid)
 {
-	struct object *obj =3D parse_object(the_repository, oid);
-	do {
-		if (!obj)
-			return NULL;
-		if (obj->type =3D=3D OBJ_TREE)
-			return (struct tree *) obj;
-		else if (obj->type =3D=3D OBJ_COMMIT)
-			obj =3D &(get_commit_tree(((struct commit *)obj))->object);
-		else if (obj->type =3D=3D OBJ_TAG)
-			obj =3D ((struct tag *) obj)->tagged;
-		else
-			return NULL;
-		if (!obj->parsed)
-			parse_object(the_repository, &obj->oid);
-	} while (1);
+	struct repository *r =3D the_repository;
+	struct object *obj =3D parse_object(r, oid);
+	return (struct tree *)repo_peel_to_type(r, NULL, 0, obj, OBJ_TREE);
 }
=2D-
2.23.0
