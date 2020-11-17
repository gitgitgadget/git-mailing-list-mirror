Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED7DC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFC3221F1
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wX5d4Th/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgKQUPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 15:15:21 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89CC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 12:15:20 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id y11so11401863qvu.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf0URb1ubPPqZp5uJ2QS6IjzTpWzoKdYpp9N4FEw8Qc=;
        b=wX5d4Th/lQW1ISpgxqys/+J08Re79nTo1J2DZCJfnLW0IHCWbS1aerpF7RpSwYFLlI
         cPpxAwo6BEonQcMiE6m7xIynjNwPfzi7d2iTuY21MwPHbfQRQEhfLZGATIwJ7SX+rNPk
         aTd3ro2WBUvZSklbdIyelg2xSSy7ZJbVttiiGvleacycUnWePuTmXDOaFymDMDpv8mpO
         a1TZijWIYvRUeNZcY2LDGHDNQez7I+IoALcqXXdCwzmMjE7MyGIxMLsu8iAX0YMpBB6c
         XRMpgkd3yM/IG8wb8Xc+nDB1MR1UzVRcdvgJq+IJtaOrhs9ibDXS2cMb5drrgbR8IukA
         lLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf0URb1ubPPqZp5uJ2QS6IjzTpWzoKdYpp9N4FEw8Qc=;
        b=eUSrXHhmAow13GnGt9Fl/D3XqYXu7rEI4NsZdFLmpN3MFKUHuB5Gk97SS6r51cpGyE
         tNztdlelN5uRVvjaT6equ5yVMMLViBZ/KvdSCV9p6o4hAFJu0kuWCWdRJ5IWGA/TSs+P
         6/InwSk4d0RsVjdGLkzAu8N3/vBAyZBYKwbvQHMhRHnzjzy0Kne7TlaQrSdU+Rj5Q+lK
         t+PQ+iS+BckWDoEvHj3yw2yous0NVefcVjIUmaXZAdKtLePQRavIS17I4hLQAXFGAYFz
         CBYdiaEThrMoNXfFmA0Otqe+iHbZO6pE42otlmIAZFbuv/1zjXAWHWZqRdNTZxlCkjZf
         xtAA==
X-Gm-Message-State: AOAM532p4lBqn3z048VQTxblW44pxDJomh0CRolJZS7T4m8S10qoBbmU
        6czSa5z3ewmF+NvCdS+d7Ck8qA==
X-Google-Smtp-Source: ABdhPJyNg3nSMEZcKJ+cE6srWpW7SowS3aZX12lg0uD7Z9ulH+LzGl3Ot1zAbre1BQDaIoNoX20MTg==
X-Received: by 2002:ad4:4514:: with SMTP id k20mr1115733qvu.18.1605644119915;
        Tue, 17 Nov 2020 12:15:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2e3a:4a72:e851:164d])
        by smtp.gmail.com with ESMTPSA id 9sm15459690qke.6.2020.11.17.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:15:19 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:15:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
Message-ID: <X7QvVB8GjI866a8z@nand.local>
References: <cover.1605552016.git.me@ttaylorr.com>
 <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
 <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
 <X7MYifflg7SaTRXm@nand.local>
 <xmqqd00c7qup.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd00c7qup.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 04:46:06PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > It's more about: ...
>
> You do not have to explain that to me here.  Instead explain that to
> future readers of our history in the commit log message.
>
> Thanks.

Understood. Here's a replacement for the final patch (the log message is
updated, but the patch contents are not):

--- >8 ---

Subject: [PATCH] builtin/repack.c: don't move existing packs out of the way

When 'git repack' creates a pack with the same name as any existing
pack, it moves the existing one to 'old-pack-xxx.{pack,idx,...}' and
then renames the new one into place.

Eventually, it would be nice to have 'git repack' allow for writing a
multi-pack index at the critical time (after the new packs have been
written / moved into place, but before the old ones have been deleted).
Guessing that this option might be called '--write-midx', this makes the
following situation (where repacks are issued back-to-back without any
new objects) impossible:

    $ git repack -adb
    $ git repack -adb --write-midx

In the second repack, the existing packs are overwritten verbatim with
the same rename-to-old sequence. At that point, the current MIDX is
invalidated, since it refers to now-missing packs. So that code wants to
be run after the MIDX is re-written. But (prior to this patch) the new
MIDX can't be written until the new packs are moved into place. So, we
have a circular dependency.

This is all hypothetical, since no code currently exists to write a MIDX
safely during a 'git repack' (the 'GIT_TEST_MULTI_PACK_INDEX' does so
unsafely). Putting hypothetical aside, though: why do we need to rename
existing packs to be prefixed with 'old-' anyway?

This behavior dates all the way back to 2ad47d6 (git-repack: Be
careful when updating the same pack as an existing one., 2006-06-25).
2ad47d6 is mainly concerned about a case where a newly written pack
would have a different structure than its index. This used to be
possible when the pack name was a hash of the set of objects. Under this
naming scheme, two packs that store the same set of objects could differ
in delta selection, object positioning, or both. If this happened, then
any such packs would be unreadable in the instant between copying the
new pack and new index (i.e., either the index or pack will be stale
depending on the order that they were copied).

But since 1190a1a (pack-objects: name pack files after trailer hash,
2013-12-05), this is no longer possible, since pack files are named not
after their logical contents (i.e., the set of objects), but by the
actual checksum of their contents. So, this old- behavior can safely go,
which allows us to avoid our circular dependency above.

In addition to avoiding the circular dependency, this patch also makes
'git repack' a lot simpler, since we don't have to deal with failures
encountered when renaming existing packs to be prefixed with 'old-'.

This patch is mostly limited to removing code paths that deal with the
'old' prefixing, with the exception of files that include the pack's
name in their own filename, like .idx, .bitmap, and related files. The
exception is that we want to continue to trust what pack-objects wrote.
That is, it is not the case that we pretend as if pack-objects didn't
write files identical to ones that already exist, but rather that we
respect what pack-objects wrote as the source of truth. That cuts two
ways:

  - If pack-objects produced an identical pack to one that already
    exists with a bitmap, but did not produce a bitmap, we remove the
    bitmap that already exists. (This behavior is codified in t7700.14).

  - If pack-objects produced an identical pack to one that already
    exists, we trust the just-written version of the coresponding .idx,
    .promisor, and other files over the ones that already exist. This
    ensures that we use the most up-to-date versions of this files,
    which is safe even in the face of format changes in, say, the .idx
    file (which would not be reflected in the .idx file's name).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 103 +++++++----------------------------------------
 1 file changed, 14 insertions(+), 89 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bb839180da..279be11a16 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -306,7 +306,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
 	struct strbuf line = STRBUF_INIT;
-	int i, ext, ret, failed;
+	int i, ext, ret;
 	FILE *out;

 	/* variables to be filled by option parsing */
@@ -463,109 +463,34 @@ int cmd_repack(int argc, const char **argv, const char *prefix)

 	/*
 	 * Ok we have prepared all new packfiles.
-	 * First see if there are packs of the same name and if so
-	 * if we can move them out of the way (this can happen if we
-	 * repacked immediately after packing fully.
 	 */
-	failed = 0;
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;

-			fname = mkpathdup("%s/pack-%s%s", packdir,
-						item->string, exts[ext].name);
-			if (!file_exists(fname)) {
-				free(fname);
-				continue;
-			}
-
-			fname_old = mkpathdup("%s/old-%s%s", packdir,
-						item->string, exts[ext].name);
-			if (file_exists(fname_old))
-				if (unlink(fname_old))
-					failed = 1;
-
-			if (!failed && rename(fname, fname_old)) {
-				free(fname);
-				free(fname_old);
-				failed = 1;
-				break;
-			} else {
-				string_list_append(&rollback, fname);
-				free(fname_old);
-			}
-		}
-		if (failed)
-			break;
-	}
-	if (failed) {
-		struct string_list rollback_failure = STRING_LIST_INIT_DUP;
-		for_each_string_list_item(item, &rollback) {
-			char *fname, *fname_old;
-			fname = mkpathdup("%s/%s", packdir, item->string);
-			fname_old = mkpathdup("%s/old-%s", packdir, item->string);
-			if (rename(fname_old, fname))
-				string_list_append(&rollback_failure, fname);
-			free(fname);
-			free(fname_old);
-		}
-
-		if (rollback_failure.nr) {
-			int i;
-			fprintf(stderr,
-				_("WARNING: Some packs in use have been renamed by\n"
-				  "WARNING: prefixing old- to their name, in order to\n"
-				  "WARNING: replace them with the new version of the\n"
-				  "WARNING: file.  But the operation failed, and the\n"
-				  "WARNING: attempt to rename them back to their\n"
-				  "WARNING: original names also failed.\n"
-				  "WARNING: Please rename them in %s manually:\n"), packdir);
-			for (i = 0; i < rollback_failure.nr; i++)
-				fprintf(stderr, "WARNING:   old-%s -> %s\n",
-					rollback_failure.items[i].string,
-					rollback_failure.items[i].string);
-		}
-		exit(1);
-	}
-
-	/* Now the ones with the same name are out of the way... */
-	for_each_string_list_item(item, &names) {
-		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname, *fname_old;
-			struct stat statbuffer;
-			int exists = 0;
 			fname = mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext].name);
 			fname_old = mkpathdup("%s-%s%s",
 					packtmp, item->string, exts[ext].name);
-			if (!stat(fname_old, &statbuffer)) {
-				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
-				chmod(fname_old, statbuffer.st_mode);
-				exists = 1;
-			}
-			if (exists || !exts[ext].optional) {
+
+			if (((uintptr_t)item->util) & (1 << ext)) {
+				struct stat statbuffer;
+				if (!stat(fname_old, &statbuffer)) {
+					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
+					chmod(fname_old, statbuffer.st_mode);
+				}
+
 				if (rename(fname_old, fname))
 					die_errno(_("renaming '%s' failed"), fname_old);
-			}
+			} else if (!exts[ext].optional)
+				die(_("missing required file: %s"), fname_old);
+			else if (unlink(fname) < 0 && errno != ENOENT)
+				die_errno(_("could not unlink: %s"), fname);
+
 			free(fname);
 			free(fname_old);
 		}
 	}
-
-	/* Remove the "old-" files */
-	for_each_string_list_item(item, &names) {
-		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-			char *fname;
-			fname = mkpathdup("%s/old-%s%s",
-					  packdir,
-					  item->string,
-					  exts[ext].name);
-			if (remove_path(fname))
-				warning(_("failed to remove '%s'"), fname);
-			free(fname);
-		}
-	}
-
 	/* End of pack replacement. */

 	reprepare_packed_git(the_repository);
--
2.29.2.312.gabc4d358d8

