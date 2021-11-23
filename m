Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18168C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhKWLkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhKWLkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:40:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29345C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:37:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so46330217eds.10
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zRemVJ6+3bRFKk1EmAKOyMDpp2awr4cbyreu5EDrs0s=;
        b=NeR+tVdq3VhCKB5WBV/hvtr6MQaPya0sxRvHCB6Vd8TE3vuOmaJGlf3I36cv/7v8I7
         J2JAXNFysd+KvQXArQGeYzAmYmRK9PzyX/N/Cwc+8NKo062G9kp9U9cXmajw18i+lriN
         mgzVTr/+XUiioTtbkutMii4SEynfr3ukdOSg35QqSJjRfRDE5oXArWhQIbCSOV6nQqV0
         x4ILeJ0/c86BiX+AOqVSEfJT/AQyly7OP/YN2Z8LqpM1cslfvIR7FfZGIHzwpp+iG7LT
         n1biEeexPmUmy6Z10OHaOj/aHTPFAfNLIP2FdpK2dRocE0HW15rXQhZCR4om1UIgrmsy
         KP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zRemVJ6+3bRFKk1EmAKOyMDpp2awr4cbyreu5EDrs0s=;
        b=ve5kBbiF8D801CFQM4SMHnIj5FyqYUnyg28L9uOiWZiAQGJPIOf7CPeiwOKsvtApyS
         N8xSJap6UKS8vyPFfwlnd23iooVblqS/1wrLs5cIocXeRbcmjO794LSE2V88+kXDE+qf
         /ZrHsygyqTAhXThyFl7id27sHhb0sJLqYx4ymMmgfCWoS1pzPFD2Xv92lXL4W42dlVgb
         0YlzBPd1Q6Kox8/WpWJhi3bKdxvbH5OJsNC/Wm97oNYecP99Xvz7iNkJ1W64m0xRtybd
         UdE6Pg44sQn+MT9AL3/v9Dr5SUl2xfCz3IyzpCyksJCzZ4d+xrHjaGqlxwLtNgNb9HRV
         hYVA==
X-Gm-Message-State: AOAM532Nf79ZSqv9gNQWIBWa88YNJmQSm/eXFGPahxLJbAi6H5/dEB1T
        ocO0azTjBqAtffKZou1dNyZQzYe2oFvHCg==
X-Google-Smtp-Source: ABdhPJw6ddzmetP05AnULV14nllRWlScOofNzJokQftAvc4u3NQf3p/h1G95VhSh0nDQTDAb9Z6jWQ==
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr6465430ejc.547.1637667456325;
        Tue, 23 Nov 2021 03:37:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm5896948edd.31.2021.11.23.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:37:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpU7D-001L8X-6A;
        Tue, 23 Nov 2021 12:37:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Tue, 23 Nov 2021 12:04:06 +0100
References: <cover.1637567328.git.dyroneteng@gmail.com>
 <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
 <xmqqczmsf2d2.fsf@gitster.g> <211123.86tug3wu8v.gmgdl@evledraar.gmail.com>
 <xmqqpmqrachl.fsf@gitster.g> <211123.868rxfwqdw.gmgdl@evledraar.gmail.com>
 <xmqqlf1fa8cj.fsf@gitster.g> <xmqqh7c3a6hs.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqh7c3a6hs.fsf@gitster.g>
Message-ID: <211123.86mtlvumps.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>>> That is what I would call over-engineering that I would rather not
>>>> to have in low level plumbing.
>>>> ...
>>> We've got --format for for-each-ref and family (also branch etc.), and
>>> for the "log" family.
>>
>> But I didn't comment on them. ls-tree is a lot lower-level plumbing
>> where --format does not belong in my mind.

Yes, you're just talking about ls-tree here. I'm just trying to
understand what you meant with:

    I am not interested in eliminating the _output_ by scripts.
    They should capture and format the pieces we output in any way they
    want.

Which reads to me like "we provide the data, you pretty-fy it". In this
case the proposed feature doesn't need a patch to git, but can also be
done as:

    git ls-tree HEAD | cut -d$'\t' -f1 | cut -d ' ' -f3

I think it's useful. I'm just trying to understand what you think about
such plumbing output.

> There is a lot more practical reason why I'd prefer a less flexible
> and good enough interface.
>
> I can see, without coding it myself but from mere memory of how the
> code looked like, how such a "we allow you to choose which field to
> include, but you do not get to choose the order of fields or any
> other string in the output" can be done with minimum disruption to
> the existing code and without introducing a bug.  On the other hand,
> I am fairly certain that anything more flexible than that will risk
> new bugs involved in any large shuffling of the code, which I am
> getting tired of.

To be clear, I wasn't talking about running with the WIP patch I had in
<211115.86o86lqe3c.gmgdl@evledraar.gmail.com> here, but that the
interface wolud leave the door open to it. So something like the below.

This works to do what --oid-only does without adding that switch,
instead we add it tou our list of 4 supported hardcoded formats, all of
which map to one of the MODE_* flags.

We could just document that we support that limited list for now, and
that we might add more in the future.

So it's just a way of adding a new MODE_* without supporting an ever
growing list of flags, --oid-only, --objectmode-only, --objectsize-only
etc.

Then if we'd ever want to generalize this in the future we can pick up
someting like my WIP patch and we'd have support for any arbitrary
format.

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 1e4a82e669a..e1e746ae02a 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -30,10 +30,11 @@ static const char * const ls_tree_usage[] =3D {
 	NULL
 };
=20
-enum {
+enum ls_tree_cmdmode {
 	MODE_UNSPECIFIED =3D 0,
 	MODE_NAME_ONLY,
-	MODE_OID_ONLY
+	MODE_OID_ONLY,
+	MODE_LONG,
 };
=20
 static int cmdmode =3D MODE_UNSPECIFIED;
@@ -131,11 +132,22 @@ static int show_tree(const struct object_id *oid, str=
uct strbuf *base,
 	return retval;
 }
=20
+static struct {
+	enum ls_tree_cmdmode cmdmode;
+	const char *fmt;
+} allowed_formats[] =3D {
+	{ MODE_UNSPECIFIED,	"%(objectmode) %(objecttype) %(objectname)%09%(path)"=
 },
+	{ MODE_NAME_ONLY,	"%(path)" },
+	{ MODE_OID_ONLY,	"%(objectname)" },
+	{ MODE_LONG,		"%(objectmode) %(objecttype) %(objectsize) %(objectname)%09=
%(path)" },
+};
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree =3D 0;
+	const char *format =3D NULL;
 	const struct option ls_tree_options[] =3D {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -149,7 +161,8 @@ int cmd_ls_tree(int argc, const char **argv, const char=
 *prefix)
 			LS_SHOW_SIZE),
 		OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MODE_=
NAME_ONLY),
 		OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), MOD=
E_NAME_ONLY),
-		OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_ON=
LY),
+		OPT_STRING(0 , "format", &format, N_("format"),
+			   N_("(limited) format to use for the output")),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -170,6 +183,22 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 		ls_tree_prefix =3D prefix =3D NULL;
 		chomp_prefix =3D 0;
 	}
+
+	if (format && cmdmode)
+		die(_("--format and --name-only, --long etc. are incompatible"));
+	if (format) {
+		size_t i;
+
+		for (i =3D 0; i <=3D ARRAY_SIZE(allowed_formats); i++) {
+			if (i =3D=3D ARRAY_SIZE(allowed_formats))
+				die(_("your --format=3D%s is not on the whitelist of supported formats=
"), format);
+			if (!strcmp(format, allowed_formats[i].fmt)) {
+				cmdmode =3D allowed_formats[i].cmdmode;
+				break;
+			}
+		}
+	}
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) =3D=3D
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
