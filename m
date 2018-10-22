Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DA91F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeJWGN1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:13:27 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34262 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeJWGN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:13:27 -0400
Received: by mail-qt1-f201.google.com with SMTP id e19-v6so7256958qtq.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aeAGa2ZNc8hpSJZmZgsZVD7KBAPDVnJEfxtaxPUbd+U=;
        b=YhjqWpyox5gfG62ZQKwE0jkc9Us+0HLo06ESyxotdhCTQFbsBanAqN68kd2ktC8UeS
         ife0Eyk8umdDFhP4bMeQAWvpr7CfXPmV5xaNqJSvlfiOW5f8pLjNe5ulITnZuhe7KScv
         6EnGNS5z+sB6FpyuwqGzaNVxRRKJA57eHixGY62l87Ma0nLDSrf8eOx+yJz2bvxMHNtY
         VoOp85Pr8TRZ8rTnRkoIzc4NtANMGLK8QoIFEqbMjLDA24t/PllkEq0vcFFGc2dlSiJ+
         wI7BIRxkOD7x27XFctAXIxUODzdoarPNMz4yH+Yk9+0CRgkoYIFMFf1DSmliE3MAOF7d
         h8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aeAGa2ZNc8hpSJZmZgsZVD7KBAPDVnJEfxtaxPUbd+U=;
        b=haTJNH/EBNQ5qoiulkjtMP3lF731vuI/o6slzmg3U04aObIsmTa1wH05i0GGXG9cp2
         yW4S1TLtkxAP5p1au1tVeo5a6R4u7uK+xetSzuC8ENq5TtrqDL69I4rdcv17X0tgg4Fq
         wN+/aELrXmVIWCJKj3H9xVRpK888MRYQK2GzX+IAckahLmx5txXwtp0DiYJZ98FnYLXK
         55psgGoZUBdo4Ju06+v7vkl2JCHyKa8LmkTvNefZBrQU0gVv0GPFEkLf2QFjqSuhxeAc
         8rdDTP2qnB3UUsBKut3lz+cbpqzZwKaeQYOokci3bv2g+SlGivXUcNR6HfU8kg/m/cSJ
         J0jA==
X-Gm-Message-State: AGRZ1gJB+Ogt5zQWfxQOD9U99+6bvpizEvg6Z0745vHhuKciZcgF9JjD
        +xKElnftScAHM1TjAOi7gge72gCEu89H
X-Google-Smtp-Source: ACcGV60xuurfs0WDQhVkcP0WkM26MPBVkEVdrTbDeKGacCTFKhKmvVUfdSHhYTxls0lHWy7kf7ZXFRq6wC92
X-Received: by 2002:ac8:6787:: with SMTP id b7-v6mr5606864qtp.1.1540245185999;
 Mon, 22 Oct 2018 14:53:05 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:52:36 -0700
In-Reply-To: <xmqqd0s2y9o9.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181022215236.72238-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqd0s2y9o9.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0
Subject: Bug with "git mv" and submodules, and with "git submodule add
 something --force"
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, juergen.vogl@jku.at,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 21, 2018 at 7:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > Stefan Beller wrote:
> >
> >> Maybe for now we can do with just an update of the documentation/bugs
> >> section and say we cannot move files in and out of submodules?
> >
> > I think we have some existing logic to prevent "git add"-ing a file
> > within a submodule to the superproject, for example.
>
> There is die_path_inside_submodule() that sanity-checks the pathspec
> and rejects.  But I think that is done primarily to give an error
> message and not strictly necesary for correctness.

c08397e3aa (pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
flag, 2017-05-11) seems to be relevant here, as that factors out the
warning.

> The real safety of "git add" is its call to dir.c::fill_directory();
> it collects untracked paths that match the pathspec so that they can
> be added as new paths, but because it won't cross the module
> boundary, you won't get such a path in the index to begin with.

It would not cross the boundary and fail silently as it would
treat a path into the submodule as a no-op.

> > So "git mv" should learn the same trick.  And perhaps the trick needs
> > to be moved down a layer (e.g. into the index API).  Hints?

Yeah, I think we'd want to teach git-mv about that trick.

Unfortunately git-mv is one of the last remainders of not
properly using pathspecs, and die_path_inside_submodule
expects a pathspec. :-/

> You would want to be able to remove a submodule and replace it with
> a directory, but you can probably do it in two steps, i.e.
>
>         git reset --hard
>         git rm --cached sha1collisiondetection
>         echo Now a regular dir >sha1collisiondetection/READ.ME
>         find sha1collisiondetection ! -type d -print0 |
>         git update-index --add --stdin -z

    "Ignoring path sha1collisiondetection/.git"

Nice!

>
> So from that point of view, forbidding (starting from the same state
> of our project) this sequence:
>
>         git reset --hard
>         echo Now a regular dir >sha1collisiondetection/READ.ME
>         find sha1collisiondetection ! -type d -print0 |
>         git update-index --add --remove --stdin -z
>
> that would nuke the submodule and replace it with a directory within
> which there are files would be OK.  Making the latter's default
> rejection overridable with ADD_CACHE_OK_TO_REPLACE would also be
> fine.

I am having trouble of relating these commands to the original git-mv
across submodule boundaries.

Moving files from the submodule out to the superproject, seems
to fail properly, though having a less-than-optimal error message:

$ git mv sha1collisiondetection/LICENSE.txt .
fatal: not under version control, source=sha1collisiondetection/LICENSE.txt, destination=LICENSE.txt

and moving things inside was the original report, below is a proof of concept
that would yield

./git mv -v cache.h sha1collisiondetection/
fatal: moving across submodule boundaries not supported, source=cache.h, destination=sha1collisiondetection/cache.h

--8<--
Subject: [WIP/PATCH] builtin/mv.c: disallow moving across submodule boundaries

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 80bb967a63..9ec4b2f0a3 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -172,7 +172,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length, src_is_dir, pos;
 		const char *bad = NULL;
 
 		if (show_only)
@@ -243,6 +243,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		else
 			string_list_insert(&src_for_dst, dst);
 
+		pos = cache_name_pos(dst, strlen(dst));
+		if (pos < 0) {
+			pos = -(pos + 1);
+			if (!S_ISGITLINK(active_cache[pos]->ce_mode))
+				bad = _("moving across submodule boundaries not supported");
+		}
+
 		if (!bad)
 			continue;
 		if (!ignore_errors)
-- 
2.19.0

