Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68B21F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfJCLxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 07:53:33 -0400
Received: from mout.web.de ([212.227.15.14]:38805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfJCLxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 07:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570103606;
        bh=jFikP1MZuYK+6WoBagAPv8lXI6DHTVXplmkHczrUkJM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MN1pQiIJOScc76I/TYSRDARU1Migo8XfiRt2rgKXQbhwwvRwcadkhl1rKx2Hlmxbi
         Dzm0DL7ttpdR71HbBQXb+xsH6OrUpGAA8Q54hHL8swDU3SkA838rL/dU6yTYAL8L7g
         KQ4A9irOji6VD+fA9H95iL1SBsmXhuyyLP+3ABIY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQf77-1ih7rX0JwL-00U5Uz; Thu, 03
 Oct 2019 13:53:26 +0200
Subject: Re: [PATCH v2 2/8] fast-import: fix handling of deleted tags
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
 <20190930211018.23633-3-newren@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f5b70fc3-8aff-7dc6-66c4-df3cc85df312@web.de>
Date:   Thu, 3 Oct 2019 13:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930211018.23633-3-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uM/ogdQoAThyj4VYZL0rEFPKRaZjJsy17G6yh0/E+/cDt/K5Bin
 nevmr/SoE1HJRm6mbfDGJmxX1VIrNjbKm6pz5cfHWHMTDoHOAGTsRbe5gFA3sg+738RuUzD
 GyLBA+CGBk/pVTpCKuNEPCMPVa5IuHcLk1UlKT69QwoSWiOeOHhJ8db2FM681/dc5QZF24K
 0MaHbAjoeCVnSuiqBZzog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApLcgn0Eibo=:R3VE1er1CbAmyWvNADDXcS
 aIcA1sObHz+8Q44J8JsUoOAeJl/4mzqguFgWZISBFg/1CC/PiNyeY9kmASGBpueop7f8kqC1T
 iWECYzAKohDPrTymaEMjNps4QIYtDqOu/gex8r/usojRCt+wOE39QXMemvaANyg7R9vFr8TP0
 A1MEXXnhEL6Fu8wfWnBUeNdwt4GpIarPWBUQIhsiOsEj2hLn/sat0UOd4QGbT+Wa65JZdFw/R
 C80fbRBMJeEbty+huMvHP2H9GuFkjzwqYq+INPcE8VYI6NCbqIwaVdaw2umW5PpYSW4w8Uc/p
 foqd/O8ihwBBGQs2Dx4cFnSrW0jrf+3N0163q8kfhMHzPKoLzICe2bGmolv1UdQckHU1p1nY4
 WRexEVzg9kuO1eicLMAdiOxv9i9BzzG0jxUeULEjXIHw4FfDr/IUIMJd+PLklG7Gr/93hD2Jq
 CcK2wMBAW+1Cs3enrrxTgYDLA3mTCMC+VUkIDGpvkTstwFiJnHWN5D/FpXc3Co5BLEBAmFhty
 BIh2vqrd0UEC3PHqJCR6juMnZGMmEvwPK3x9Bgc0C+bkcWwTr1/1BRud+JC6WFF8KdLZ/UcdC
 KwJ1u6QipObNQceW0slV9AS39rNXqgp059K2gMKe6Ta0Dv/2Hu+hS35/cu3ZBHYbXCRBhxhqT
 rulZnVPvNoEHesMNrjmHMHXAKj+edUtb9GvW+KXvjlFHbeR9SUWrdETtCsLoGG06Wme6y+j73
 yUnSfHV58fsJnjkutGdQu8WQPI9IY+e4f+d2AofWbo+rYQMsUw7yVQFYFlzvwunGAUe7aPY3B
 w8fU5xSCtLUW6zPBaGxl3zyKt3t1qDGQYJgo4adbfUqtnLgy2JK8/y/WxwUfAXPXrYHTeVuZm
 5e3QttQ5bovJANFVfGQ0Zkm/h48h+rjltmFPj3FlEy+bxZsQ1W9RdVtjQv0Mlmwww5+RZeYtY
 9JozsQtXEvv1EQS9nBBDD3kbpJAOkEvmjBTYp2yKIeBkt3fr3ur6U+Hyfd85Zi1HQYm1K48xM
 Mpq5EJnqs4kEDrWpeO2m7fdyErVFL4pDmyn22iagJNQvoPiANvh5GbuujWK5OrPG5BRKSEfX6
 Qo11TmVcIUWsQVAL5zDDVinfUtmtcgUYcxVSjYIE696dtu1h/0SNFnE/nz14u6FXxzO46lkOH
 Nnt/OlEGYWKFjB9nL1MQA03dcLOjQtLolCAhTGjp/3LtqIU3mC0gwesyr3sjnWrZni+NbVruX
 93gaweQfFhz4qj2IhSDPxWTFuHGF7z+8MOZhB6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.19 um 23:10 schrieb Elijah Newren:
> If our input stream includes a tag which is later deleted, we were not
> properly deleting it.  We did have a step which would delete it, but we
> left a tag in the tag list noting that it needed to be updated, and the
> updating of annotated tags occurred AFTER ref deletion.  So, when we
> record that a tag needs to be deleted, also remove it from the list of
> annotated tags to update.
>
> While this has likely been something that has not happened in practice,
> it will come up more in order to support nested tags.  For nested tags,
> we either need to give temporary names to the intermediate tags and then
> delete them, or else we need to use the final name for the intermediate
> tags.  If we use the final name for the intermediate tags, then in order
> to keep the sanity check that someone doesn't try to update the same tag
> twice, we need to delete the ref after creating the intermediate tag.
> So, either way nested tags imply the need to delete temporary inner tag
> references.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  fast-import.c          | 29 +++++++++++++++++++++++++++++
>  t/t9300-fast-import.sh | 13 +++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/fast-import.c b/fast-import.c
> index b44d6a467e..546da3a938 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2793,6 +2793,35 @@ static void parse_reset_branch(const char *arg)
>  		b =3D new_branch(arg);
>  	read_next_command();
>  	parse_from(b);
> +	if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {

b->name is a NUL-terminated string; starts_with() could be used to avoid
the magic number 10.

> +		/*
> +		 * Elsewhere, we call dump_branches() before dump_tags(),
> +		 * and dump_branches() will handle ref deletions first, so
> +		 * in order to make sure the deletion actually takes effect,
> +		 * we need to remove the tag from our list of tags to update.
> +		 *
> +		 * NEEDSWORK: replace list of tags with hashmap for faster
> +		 * deletion?
> +		 */
> +		struct strbuf tag_name =3D STRBUF_INIT;

This adds a small memory leak.

> +		struct tag *t, *prev =3D NULL;
> +		for (t =3D first_tag; t; t =3D t->next_tag) {
> +			strbuf_reset(&tag_name);
> +			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
> +			if (!strcmp(b->name, tag_name.buf))

So the strbuf is used to prefix t->name with "refs/tags/", which we know
b->name starts with, and to compare the result with b->name.  Removing
the "refs/tags/" prefix from b->name using skip_prefix() and comparing
the result with t->name would be easier.

> +				break;
> +			prev =3D t;
> +		}
> +		if (t) {
> +			if (prev)
> +				prev->next_tag =3D t->next_tag;
> +			else
> +				first_tag =3D t->next_tag;
> +			if (!t->next_tag)
> +				last_tag =3D prev;
> +			/* There is no mem_pool_free(t) function to call. */
> +		}
> +	}
>  	if (command_buf.len > 0)
>  		unread_command_buf =3D 1;
>  }

Here's a squashable patch for that:

=2D--
 fast-import.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 70cd3f0ff4..a109591406 100644
=2D-- a/fast-import.c
+++ b/fast-import.c
@@ -2779,6 +2779,7 @@ static void parse_new_tag(const char *arg)
 static void parse_reset_branch(const char *arg)
 {
 	struct branch *b;
+	const char *tag_name;

 	b =3D lookup_branch(arg);
 	if (b) {
@@ -2794,7 +2795,7 @@ static void parse_reset_branch(const char *arg)
 		b =3D new_branch(arg);
 	read_next_command();
 	parse_from(b);
-	if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {
+	if (b->delete && skip_prefix(b->name, "refs/tags/", &tag_name)) {
 		/*
 		 * Elsewhere, we call dump_branches() before dump_tags(),
 		 * and dump_branches() will handle ref deletions first, so
@@ -2804,12 +2805,9 @@ static void parse_reset_branch(const char *arg)
 		 * NEEDSWORK: replace list of tags with hashmap for faster
 		 * deletion?
 		 */
-		struct strbuf tag_name =3D STRBUF_INIT;
 		struct tag *t, *prev =3D NULL;
 		for (t =3D first_tag; t; t =3D t->next_tag) {
-			strbuf_reset(&tag_name);
-			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
-			if (!strcmp(b->name, tag_name.buf))
+			if (!strcmp(t->name, tag_name))
 				break;
 			prev =3D t;
 		}
=2D-
2.23.0
