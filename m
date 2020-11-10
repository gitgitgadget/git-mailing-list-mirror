Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7859AC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F232074B
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJlrDJFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgKJVdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJVdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:33:47 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1697C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:33:46 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id me8so10314185ejb.10
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CmHXrDb4EJz0dowWoiEKji692r4JL2f/sDsorLWJv30=;
        b=LJlrDJFBdBb8Xt+pJn6GydR+EC2QdOprjIG+foYWHWug/eTQHRGXnSreynfnNsqAtq
         nq+NOvSnp5U78RMt0D8I0JTFzq1Z6S3Cxc/J44tq8F+NCkegPPTcNX6NNlpe6DMBRIwV
         DdHZQqCye5f7+aYGOZ5rxWxopmfP+gDiG44gKge/TjtF2wSknbzeh/YFHyKpYApMo3rw
         QE/ocwLoi63K0NqfxbQmqWQTwFhc37rewolMvGb6WhU8zrqSfAwsRo5fM6ly1uM3h/49
         yD/Hpqsd59fZS5umL6MtDFJvr6xRu1O8mwz/D61AT0HxnuRhz9ZFeHJdqAOQZuMumwCn
         XoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CmHXrDb4EJz0dowWoiEKji692r4JL2f/sDsorLWJv30=;
        b=SxydHOPCjRuTCoHlPGQISMqnnNZyQMRathCZKkk/gAB5mJJPC5Zh3CjbFfa8J7RI3M
         Cp8nsLlX+SLIXu5BMHcbhUgSiJYwDKogXq38P2AXJ1qjfDFCNaSkkna/yWmohLEDDZH1
         WlIGJ57wrpEkx5BhgmBld+ZvOh8TVfKc05srtfr18wgdCdonKqKy/3eG8BZARnto2OQS
         nOYJI416T/37P3IIuTp+ALMSvmzsxqSR/X1qkmaNSuN07tbSzGiGjhXQAIiMn62SJhUv
         yKYTdpWt3ih7PW9Gy6HLxeWztDbJDGfPewtBeXrkW9iD2Z7HamJI7cKZpjSgVvRPND70
         P2sg==
X-Gm-Message-State: AOAM532Jlg3EL/n9SByYd8g0kelGH9l1G8sfeYjnahYj5nXMB6YH/2RJ
        mW9owl5WUxFwS0Jw/ZUK5GA=
X-Google-Smtp-Source: ABdhPJxXB4BUg2ciJz6jjRLK5FuymB3Ry0DLmIxY7iQ4jfC8A0fcXf7gkvps5LUDXcCOTciAiPulmA==
X-Received: by 2002:a17:906:dbf4:: with SMTP id yd20mr21827626ejb.53.1605044025284;
        Tue, 10 Nov 2020 13:33:45 -0800 (PST)
Received: from evledraar (ip18-11-210-87.adsl2.static.versatel.nl. [87.210.11.18])
        by smtp.gmail.com with ESMTPSA id qx6sm28092ejb.10.2020.11.10.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:33:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Demi M. Obenour" <athena@invisiblethingslab.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: check_refname_format allows refs with components that begin with -, even though `git tag` does not
References: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
Date:   Tue, 10 Nov 2020 22:33:42 +0100
Message-ID: <87imachp6x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 10 2020, Demi M. Obenour wrote:

> If I try to create a Git tag with a name beginning with `-`,
> Git complains.  However, Git does not check that a repository does
> not have tags containing `-`.  This almost led to a vulnerability
> in the QubesOS `verify-git-tag` script.  Fortunately, this was not
> exploitable, as neither `git tag -v`, `git verify-tag --raw`, nor
> `git describe` have options that are useful to an attacker.
>
> Since this could cause vulnerabilities in other programs, I initially
> reported it as an embargoed security bug, but was told to post it
> publicly.
>
> The best idea I had for a fix is to print names beginning with `-`
> using the fully-qualified form, such as "refs/tags/-a".  Also, `--`
> is used as a delimiter in many commands, and can=E2=80=99t be escaped,
> so disallowing it might be a good idea.
>
> In the long run, I hope to see leading dashes banned entirely, but
> backwards compatibility might prevent that.

[Re-posted from the very brief discussion on the security list]

I'm inclined to say that we might as well remove the porcelain
limitation of these "-" tags and branches. In reality we support them,
fsck doesn't even warn about them, and git-check-ref-format(1) doesn't
document them as forbidden.

From reading 63486240108 ("disallow branch names that start with a
hyphen", 2010-09-14) and 4f0accd638b ("tag: disallow '-' as tag name",
2011-05-10) I don't see why we'd need to forbid these. A WIP patch of
removing the checks from strbuf_check_branch_ref() and
strbuf_check_tag_ref() fails just one test.

The reason we forbade these seems to have been mainly to avoid the UI
confusion of "git checkout -" or "git checkout -foo" and "git checkout
-- -foo" not working. We can just make the "-" a special-case, and since
then we've had "git switch -- -foo" which works, and you can do "git
checkout refs/heads/-foo".

I'm probably missing some porcelain bits but with my trivial patch "git
[opts] [tag|branch] -- -foo" works.

So I think we should just allow these, since at best it just leads to a
false sense of security.

FWIW this is the very basic WIP patch I was playing with. Fails just one
test that explicitly tests for a branch named "-naster" with
check-ref-format, should probably still disallow refs named just "-" (or
maybe not...).

diff --git a/builtin/tag.c b/builtin/tag.c
index ecf011776dc..86088838bb4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -369,9 +369,6 @@ static int parse_msg_arg(const struct option *opt, cons=
t char *arg, int unset)
=20
 static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 {
-	if (name[0] =3D=3D '-')
-		return -1;
-
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
=20
diff --git a/sha1-name.c b/sha1-name.c
index 0b23b86ceb4..9a01138336c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1592,7 +1592,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const =
char *name)
 	 */
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
=20
-	if (*name =3D=3D '-' ||
+	if (!strcmp(name, "-") ||
 	    !strcmp(sb->buf, "refs/heads/HEAD"))
 		return -1;
=20

