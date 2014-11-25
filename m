From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Tue, 25 Nov 2014 17:41:52 +0700
Message-ID: <20141125104152.GA13038@lanh>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com>
 <54730546.7000200@drmicha.warpmail.net>
 <CACsJy8B5dbYZm25019avX2q0Ymp=f4jt=jt898M_znE8eEcOVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Git Mailing List <git@vger.kernel.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:41:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtEV0-00066R-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 12:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbaKYLlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 06:41:31 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57364 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbaKYKlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 05:41:25 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so330029pdj.23
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1YswMmVffx2PV3r4BcViQ2WfDORl3jpmu4ZjIk85Pyo=;
        b=yJ3m9VnJLctf9gjIm3XNy/fdCalXg/7EcoHdfoMNbPjeIY0uWw/KpS6MzxGmIOVZEX
         /ja3qRjauW0fr0m9v69pwutiHArmUisWbJrt86GCkaePsQh+jEEQp4d+9VEq0eNC7Y7B
         +vYOkYxoswj17+G7nmMD9pAEhiQ1rZylVHO8yV6RjEC0fvZsR7NXYdbGrmKWleKfjcw8
         5a3VfVOAmo9yDi7yu8onFBbSePfZRu//oh6mS9hKjHDgAC3ZAqZ7zempG6c1xYc0CC+N
         DmWlsOni2+J6Rhj4gR45G9Lo6weFaHoVjJLusjuDBy/e41JY/9vvmezsOLPvgjilt1l9
         ccjA==
X-Received: by 10.66.66.76 with SMTP id d12mr41503980pat.111.1416912085101;
        Tue, 25 Nov 2014 02:41:25 -0800 (PST)
Received: from lanh ([115.73.236.26])
        by mx.google.com with ESMTPSA id g8sm1091972pdn.80.2014.11.25.02.41.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 02:41:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Nov 2014 17:41:52 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8B5dbYZm25019avX2q0Ymp=f4jt=jt898M_znE8eEcOVg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260211>

On Mon, Nov 24, 2014 at 06:44:10PM +0700, Duy Nguyen wrote:
> >> I wonder if we can have an option to sign all blob content of the tree
> >> associated to a commit, and the content of parent commit(s). It's more
> >> expensive than signing just commit/tag content. But it's also safer
> >> without completely ditching SHA-1.
> >>
> >
> > This amounts to hashing the blob content with whatever hash you told
> > your gpg to use (hopefully not sha1 ;) ) and signing that.
> >
> > You're free to do that now and store the signature wherever your
> > toolchain deems fit, say in a note or an annotated tag. But that
> > approach won't sign the history, that is: If you are concerned about the
> > breakability of sha1, then history is "possibly broken" no matter how
> > you sign a commit object whose "parent" entry is based on the sha1 of
> > its parent object.
> 
> If you store the singature in commit message, and if you hash the
> parent commit messages as well, which are also signed, then you have
> the same chaining effect that we have with SHA-1. I think this could
> be done with some hooks already, except maybe for the verification
> part.

To demonstrate, a hook like this can take commit object from stdin and
produce some hash lines, which are appended at the end of the commit
message before the new commit object is created. So if I commit "foo"
the final commit message would be

  foo

  SHA512: <long hash>

This script uses sha512sum, but you can add as many hashes as you want
(and pay the penalty at commit time, of course). I think it covers
enough content to validate history up to the last signed commit.

-- 8< --
#!/bin/bash
# commit content
cat >$GIT_DIR/tmp
# parent commit content
sed '/^$/q' $GIT_DIR/tmp |
    grep '^parent ' |
    cut -c 8- |
    xargs -n1 git cat-file commit >>$GIT_DIR/tmp
# all blobs
sed '/^$/q' $GIT_DIR/tmp |
    grep '^tree ' |
    cut -c 6- |
    xargs -n1 git ls-tree -r |
    cut -c 13-52 |
    git cat-file --batch >>$GIT_DIR/tmp
echo
echo "SHA512: `sha512sum < $GIT_DIR/tmp`"
-- 8< --

An extra patch is required to hook this in final commit steps.

-- 8< --
diff --git a/commit.c b/commit.c
index 19cf8f9..c447c1d 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,8 @@
 #include "commit-slab.h"
 #include "prio-queue.h"
 #include "sha1-lookup.h"
+#include "run-command.h"
+#include "sigchain.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1064,6 +1066,36 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static int run_sign_commit_hook(struct strbuf *buf)
+{
+	struct child_process hook = CHILD_PROCESS_INIT;
+	const char *p = find_hook("sign-commit");
+	int len;
+
+	if (!p)
+		return 0;
+
+	argv_array_push(&hook.args, p);
+	hook.in = -1;
+	hook.out = -1;
+	if (start_command(&hook))
+		return error(_("could not run sign-commit hook"));
+	sigchain_push(SIGPIPE, SIG_IGN);
+	if (write_in_full(hook.in, buf->buf, buf->len) != buf->len) {
+		close(hook.in);
+		close(hook.out);
+		finish_command(&hook);
+		return error(_("sign-commit hook did not accept the data"));
+	}
+	close(hook.in);
+	len = strbuf_read(buf, hook.out, 1024);
+	close(hook.out);
+	sigchain_pop(SIGPIPE);
+	if (finish_command(&hook) || len <= 0)
+		return error(_("sign-commit hook failed to sign the data"));
+	return 0;
+}
+
 static const char gpg_sig_header[] = "gpgsig";
 static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
 
@@ -1555,6 +1587,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (run_sign_commit_hook(&buffer))
+		return -1;
+
 	if (sign_commit && do_sign_commit(&buffer, sign_commit))
 		return -1;
 
-- 8< --
