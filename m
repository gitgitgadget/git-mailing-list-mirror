Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F4FC433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FBE60ED7
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 14:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhKNOmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 09:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNOmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 09:42:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA53C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 06:39:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so59785830edv.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Cl4TqK+xaYp4IzBN7UXyhFefwGiYMeUVXoF7L1jwP+E=;
        b=G1ovTlonXTfIUA1jYMTjsmkFfWEPsmBST6NM2Le8qy0oY/V+aidpQBOelKgVW5yDaj
         77EI4TWfa8Vri8rrlP4C8ZoA66TSJz0lUUUotimkGAoARmtAtKGIAAIkDU1QAK9/AzjD
         ugg31/IO7yZAsgTHVh3cPpZetGvUTp7IAIdnMOAf19Sf9/1k+jO5ynT9cY7O34ME7gI/
         QouudESfI1tQzToggEkcHlJjOzwvoi/gauPIZ4iuUAO77/0ioV7glJCHXwgtQWpRNNCl
         QIJxuSAl9A66U9PBY9vdYRfCKaTqeNQa05aA40swiLVzEA1PzNd9EDyj9LLy1RyYkYvU
         eMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Cl4TqK+xaYp4IzBN7UXyhFefwGiYMeUVXoF7L1jwP+E=;
        b=1GhOxyyfr3eGHzUrPnIKDUHHRkTMbjfLI8+ETuZovJABHWxqZdl9OfM5KZj/kt8+kq
         fWcWtiTAURDyg1dJdvQgIXVlIbEMRXatfhDoR16VY0GmLATmJZvur9q6gT7gYqr7nh8F
         z17NeDmWCm4eYi+0V/OiFWsu5fppK/BiLm5+mAWGyXnccXXL9h4JH8fBeLcdkeRUCO8b
         ks6SCLFeIRD9lmSK2D9aKToWQHWBinzIEE6WsRJ7ntOb/UtT4a7PuKkW10zxOPxuvNfL
         oDHhbmPWJmZA/8Of+Xf4lu+ureCGN8C6kPerrUwtX70H4fcarS6w/zfJg8Sq4FcQft+0
         sPcA==
X-Gm-Message-State: AOAM533xvKS5cwmw03aA9d4k9piFkaWZPwsp8JK+ShQdl0stAOnQfBLI
        T9Z9+88ah2RpnPQl8gmhgldIUZwAKwc=
X-Google-Smtp-Source: ABdhPJx/wyYG75gHfdLMETpyV/qeanoiSz3VmC0cI27zln6I3DC5zBLTGOGnRLQbERYtTw2lP0Zavw==
X-Received: by 2002:a17:907:724f:: with SMTP id ds15mr38606345ejc.204.1636900753136;
        Sun, 14 Nov 2021 06:39:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm5107704ejy.94.2021.11.14.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 06:39:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmGf2-000neQ-6m;
        Sun, 14 Nov 2021 15:39:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Saksham Mittal <gotlouemail@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>, git@vger.kernel.org
Subject: Is 'for (int i = [...]' bad for C STD compliance reasons? (was:
 [PATCH] MyFirstContribution.txt: fix undeclared variable i in sample code)
Date:   Sun, 14 Nov 2021 15:28:35 +0100
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq7ddbme7q.fsf@gitster.g>
Message-ID: <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 13 2021, Junio C Hamano wrote:

> Saksham Mittal <gotlouemail@gmail.com> writes:
>
>>> It is declared, there is an "int i;" a few lines up.
>>
>> Oh, man, I never even saw that! The patch is completely unnecessary
>> then. Sorry for that!
>
> No need to say sorry; you'd want to be a bit more careful next time,
> that's all.
>
> Also, our code does not introduce a new variable in the first part
> of "for (;;)" loop control, so even if the original lacked decl for
> "i", the posted patch is not how we write our code for this project.

Just curious: Out of preference, or for compatibility with older C
standards?

I'd think with the things we depend on in C99 it's probable that we
could start using this if standards conformance is the only obstacle.

But I haven't tested, so maybe I'm wrong, I'm just assuming that with
the C99 features we do have a hard dependency on surely anyone
implementing those would have implemented this too.

There's also a stylistic reason to avoid this pattern, i.e. some would
argue that it's better to declare variables up-front, since it tends to
encourage one to keep function definitions smaller (various in-tree
evidence to the contrary, but whatever).

I'd generally agree with that viewpoint & desire, but there's also cases
where being able to declare things in-line helps readability, e.g. when
your function needs two for-loops for some reason, they're set a bit
apart. Then the reader doesn't need to scan for whether an "i" is used
in-between the two.

I was thinking of the below code in bundle.c, I suppose some might find
the post-image less readable, but I remember starting to hunt around for
other out-of-loop uses of "i", which the post-image makes clear could be
avoided as far as variable scoping goes:

diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..94edc186187 100644
--- a/bundle.c
+++ b/bundle.c
@@ -194,14 +194,14 @@ int verify_bundle(struct repository *r,
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all", NULL};
 	struct commit *commit;
-	int i, ret = 0, req_nr;
+	int ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
 	if (!r || !r->objects || !r->objects->odb)
 		return error(_("need a repository to verify a bundle"));
 
 	repo_init_revisions(r, &revs, NULL);
-	for (i = 0; i < p->nr; i++) {
+	for (int i = 0; i < p->nr; i++) {
 		struct string_list_item *e = p->items + i;
 		const char *name = e->string;
 		struct object_id *oid = e->util;
@@ -223,12 +223,11 @@ int verify_bundle(struct repository *r,
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
-	i = req_nr;
-	while (i && (commit = get_revision(&revs)))
+	for (int i = req_nr; i && (commit = get_revision(&revs));)
 		if (commit->object.flags & PREREQ_MARK)
 			i--;
 
-	for (i = 0; i < p->nr; i++) {
+	for (int i = 0; i < p->nr; i++) {
 		struct string_list_item *e = p->items + i;
 		const char *name = e->string;
 		const struct object_id *oid = e->util;
@@ -242,7 +241,7 @@ int verify_bundle(struct repository *r,
 	}
 
 	/* Clean up objects used, as they will be reused. */
-	for (i = 0; i < p->nr; i++) {
+	for (int i = 0; i < p->nr; i++) {
 		struct string_list_item *e = p->items + i;
 		struct object_id *oid = e->util;
 		commit = lookup_commit_reference_gently(r, oid, 1);
