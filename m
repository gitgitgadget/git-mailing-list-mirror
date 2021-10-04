Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89475C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7359961264
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhJDOOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhJDOOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:14:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80277C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:13:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p11so12463015edy.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KgNbPrb9fF2f6u3OOATGEH2UQZyiJJowD4ccBSHA8EE=;
        b=dPC43B7Q6zcW2kgNtrX5kH3uckmYLdwwGlXoE/dFYAM2ekL0zll29j09bodM0dG3pw
         Yg1izoFEDJgslG3ECjLHH4jSeI00jjhmK1vlWDcgaEdPPQFV0xwj7SW0iX20Rgu+9oyT
         0NKu9cVU7l8lFJx5ztIIzas4ghhhZrEmA/MDE1K/sWkuu5obgvVGSC7ImcW9KXd4Bajv
         XSIBVQE6/JaVT+RGCwWQxgQ2jWiDFnGN7s7A/Ygdtn5lufNNQWHr0WkeRgv/v2YP/nZU
         uMSXkmMiX6x9XFMwSDdZoms0vwRVsAXQcaXuRwOFznNMe5Pzs85L4SBtVitfX1OYG6uj
         MK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KgNbPrb9fF2f6u3OOATGEH2UQZyiJJowD4ccBSHA8EE=;
        b=HEWc8yyG7PHAxc4qWslrwt9Rb1Na9wa5iAslHdqLUGlAnsEBC4Wbcmsh/3GvFiU53a
         yvnnvBq6XKDpOXy8Iev4M8D2l1R7u5hJeRI8Y8YuKtOlqrWe/xL71+5NtOenJOAmbxpc
         HBMldc8DTIX7Cx+hHmZXcV4ON2AuSmGTGKxTSTrzavMfMl62evadZaJRkm8ahTRGxMgN
         K1zDZ1WmJ0P73qsRb7wcjuluoyT+60JwJSLKV18ldjl5NbqmCsSAaLM3bD5rYfccArR0
         /D30+92V6FeFimROLz1Z17cVxhc+/Tp6H48pTRtq2gwdb2+9iUdyhjx8CJcUn1pCFdGV
         3XrA==
X-Gm-Message-State: AOAM531DZnzPTuBYliRkIEfO8AkueFFKW5rJLJ8TbX4brKYxeExurzYo
        wa0wittoJg0u60edHcRppCAWG7Bms1qicQ==
X-Google-Smtp-Source: ABdhPJwSuLyVb5ymu1Cqnp3lgsjROx0XdkbcPDCBdD7vd0ITu0kpIeVOkx9MBhDRc1wXGyWzuJQ9lA==
X-Received: by 2002:a05:6402:4249:: with SMTP id g9mr6853637edb.395.1633356726212;
        Mon, 04 Oct 2021 07:12:06 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx11sm6724797ejb.107.2021.10.04.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:12:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 04/11] unpack-trees: introduce preserve_ignored to
 unpack_trees_options
Date:   Mon, 04 Oct 2021 16:07:31 +0200
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <f1a0700e598e52d6cdb507fe8a09c4fa9291c982.1632760428.git.gitgitgadget@gmail.com>
 <87ilyjviiy.fsf@evledraar.gmail.com>
 <CABPp-BEnGfxqKpqXGKopXFBBshY0tuimQLtwt58wKf9CJS8n5g@mail.gmail.com>
 <87ee97utaq.fsf@evledraar.gmail.com>
 <CABPp-BEEWPF6oBN69PH_GtmqqvAj1HMtDX5ipQxa2bLzyCCu0g@mail.gmail.com>
 <87lf3etaih.fsf@evledraar.gmail.com>
 <CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWatz8-B4RsA@mail.gmail.com>
 <87k0ixrv23.fsf@evledraar.gmail.com>
 <CABPp-BE_aY4smj_b0+Zz=YrURKMniS=DmyMWVc=q2mVDL8zUOg@mail.gmail.com>
 <87k0ivpzfx.fsf@evledraar.gmail.com>
 <CABPp-BFE_5zPCZY8adJSQchdQzxq3uH-oma-S=_Sw0OUXx03OQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BFE_5zPCZY8adJSQchdQzxq3uH-oma-S=_Sw0OUXx03OQ@mail.gmail.com>
Message-ID: <8735pgop57.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sat, Oct 2, 2021 at 2:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Fri, Oct 01 2021, Elijah Newren wrote:
>>
> ...
>> > So maybe I'll submit some patches on top that rip these direct members
>> > out of of unpack_trees_options and push them inside some opaque
>> > struct.
>>
>> Sure, that sounds good. I only had a mild objection to doing it in a way
>> where you'll need that sort of code I removed in the linked commit in
>> prep_exclude() because you were trying not to expose that at any cost,
>> including via some *_INIT macro. I.e. if it's private we can just name
>> it "priv_*" or have a :
>>
>>     struct dont_touch_this {
>>         struct dir_struct dir;
>>     };
>>
>> Which are both ways of /messaging/ that it's private, and since the
>> target audience is just the rest of the git.git codebase I think that
>> ultimately something that 1) sends the right message 2) makes accidents
>> pretty much impossible suffices. I.e. you don't accidentally introduce a
>> new API user accessing a field called "->priv_*" or
>> "->private_*". Someone will review those patches...
>
> An internal struct with all the members meant to be internal-only
> provides nearly all the advantages that I was going for with the
> opaque struct, while also being a smaller change than what I was
> thinking of doing.  I like that idea; thanks for the suggestion.

Yeah, just to provide an explicit example something like the below. It
compiles to the same assembly (at least under -O3, didn't exhaustively
try other optimization levels).

I'm rather "meh" on it v.s. just prefixing the relevant member names
with "priv_" or "private_", but it results in the same semantics &
machine code, so it's effectively just a way of doing the labeling for
human consumption.

diff --git a/dir.c b/dir.c
index 39fce3bcba7..a714640e782 100644
--- a/dir.c
+++ b/dir.c
@@ -1533,12 +1533,12 @@ static void prep_exclude(struct dir_struct *dir,
 	 * which originate from directories not in the prefix of the
 	 * path being checked.
 	 */
-	while ((stk =3D dir->exclude_stack) !=3D NULL) {
+	while ((stk =3D dir->private.exclude_stack) !=3D NULL) {
 		if (stk->baselen <=3D baselen &&
 		    !strncmp(dir->basebuf.buf, base, stk->baselen))
 			break;
-		pl =3D &group->pl[dir->exclude_stack->exclude_ix];
-		dir->exclude_stack =3D stk->prev;
+		pl =3D &group->pl[dir->private.exclude_stack->exclude_ix];
+		dir->private.exclude_stack =3D stk->prev;
 		dir->pattern =3D NULL;
 		free((char *)pl->src); /* see strbuf_detach() below */
 		clear_pattern_list(pl);
@@ -1584,7 +1584,7 @@ static void prep_exclude(struct dir_struct *dir,
 						 base + current,
 						 cp - base - current);
 		}
-		stk->prev =3D dir->exclude_stack;
+		stk->prev =3D dir->private.exclude_stack;
 		stk->baselen =3D cp - base;
 		stk->exclude_ix =3D group->nr;
 		stk->ucd =3D untracked;
@@ -1605,7 +1605,7 @@ static void prep_exclude(struct dir_struct *dir,
 			    dir->pattern->flags & PATTERN_FLAG_NEGATIVE)
 				dir->pattern =3D NULL;
 			if (dir->pattern) {
-				dir->exclude_stack =3D stk;
+				dir->private.exclude_stack =3D stk;
 				return;
 			}
 		}
@@ -1662,7 +1662,7 @@ static void prep_exclude(struct dir_struct *dir,
 			invalidate_gitignore(dir->untracked, untracked);
 			oidcpy(&untracked->exclude_oid, &oid_stat.oid);
 		}
-		dir->exclude_stack =3D stk;
+		dir->private.exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
 	strbuf_setlen(&dir->basebuf, baselen);
@@ -3302,7 +3302,7 @@ void dir_clear(struct dir_struct *dir)
 	free(dir->ignored);
 	free(dir->entries);
=20
-	stk =3D dir->exclude_stack;
+	stk =3D dir->private.exclude_stack;
 	while (stk) {
 		struct exclude_stack *prev =3D stk->prev;
 		free(stk);
diff --git a/dir.h b/dir.h
index 83f46c0fb4c..d30d294308d 100644
--- a/dir.h
+++ b/dir.h
@@ -209,6 +209,11 @@ struct untracked_cache {
  * record the paths discovered. A single `struct dir_struct` is used regar=
dless
  * of whether or not the traversal recursively descends into subdirectorie=
s.
  */
+
+struct dir_struct_private {
+	struct exclude_stack *exclude_stack;
+};
+
 struct dir_struct {
=20
 	/* The number of members in `entries[]` array. */
@@ -327,7 +332,7 @@ struct dir_struct {
 	 * (sub)directory in the traversal. Exclude points to the
 	 * matching exclude struct if the directory is excluded.
 	 */
-	struct exclude_stack *exclude_stack;
+	struct dir_struct_private private;
 	struct path_pattern *pattern;
 	struct strbuf basebuf;
=20
