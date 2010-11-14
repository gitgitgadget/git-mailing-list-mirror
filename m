From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] do not overwrite untracked during merge from unborn
 branch
Date: Sun, 14 Nov 2010 22:53:15 +0100
Message-ID: <20101114215315.GB29579@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
 <20101114213453.GA29287@localhost>
 <20101114214601.GB29287@localhost>
 <20101114214927.GA29579@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gert Palok <gert@planc.ee>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkVj-0004vr-2u
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312Ab0KNVxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:53:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47413 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0KNVxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:53:13 -0500
Received: by fxm6 with SMTP id 6so1334759fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=DaJRwo9NWxLbxOmtPwTdcmtdgeU0Vi9+mXppLUz50QU=;
        b=dJJk7xsWoBaNHjG73YK+MnWBYb3hOd/H5KwJil63v50CeJeoipfV1OpN2a/BhZ6xbH
         HO36UcxEha89oeG5Ye3i806dSbZCWDZ5I8YUjS+INlV87/4fp7N0DIvP0ZdIgOW0aqWf
         9imVIxuj0m9zNpxm8kRgLzWwLo9Bln+9M52Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=HFb0e//py1/UDP+y5oWSir5og1Fj6oM/+yNi+I5YvsMYJz2xOqOrvvLPvlmNyvM1ap
         I5M9PyKOWRR6XNMaxtmBRTqzYV+74ak83mEX9YMhF1LAAu4RjhoE7576Wxb8ILl5zeSK
         Yd14kz7CdtbZg/w65IJQsW8zD3NtvmFwt8mBQ=
Received: by 10.223.53.68 with SMTP id l4mr3944002fag.44.1289771592709;
        Sun, 14 Nov 2010 13:53:12 -0800 (PST)
Received: from darc.lan (p549A7640.dip.t-dialin.net [84.154.118.64])
        by mx.google.com with ESMTPS id j14sm666961faa.47.2010.11.14.13.53.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:53:12 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PHkVf-0007mB-Ik; Sun, 14 Nov 2010 22:53:15 +0100
Content-Disposition: inline
In-Reply-To: <20101114214927.GA29579@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161452>

In case HEAD does not point to a valid commit yet, merge is
implemented as a hard reset. This will cause untracked files to be
overwritten.

Instead, assume the empty tree for HEAD and do a regular merge. An
untracked file will cause the merge to abort and do nothing. If no
conflicting files are present, the merge will have the same effect
as a hard reset.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Nov 14, 2010 at 10:49:27PM +0100, Clemens Buchacher wrote:
> On Sun, Nov 14, 2010 at 10:46:02PM +0100, Clemens Buchacher wrote:
> > --MfFXiAuoTsnnDAfZ
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > Content-Transfer-Encoding: quoted-printable
> >
> > This is based on next and does not apply cleanly to master because
> > of t7607. I can rebase it to master, but then it will conflict with
> > next later.
> 
> Without signature this time. Oops.

Wrong again! (With args[6] instead of args[7].)  I wonder how many
times I can get it wrong.

Clemens

 builtin/merge.c            |   20 +++++++++++++++++++-
 t/t7607-merge-overwrite.sh |   16 ++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..613543e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -234,6 +234,24 @@ static void save_state(void)
 		die("not a valid object: %s", buffer.buf);
 }
 
+static void read_empty(unsigned const char *sha1, int verbose)
+{
+	int i = 0;
+	const char *args[7];
+
+	args[i++] = "read-tree";
+	if (verbose)
+		args[i++] = "-v";
+	args[i++] = "-m";
+	args[i++] = "-u";
+	args[i++] = EMPTY_TREE_SHA1_HEX;
+	args[i++] = sha1_to_hex(sha1);
+	args[i] = NULL;
+
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die("read-tree failed");
+}
+
 static void reset_hard(unsigned const char *sha1, int verbose)
 {
 	int i = 0;
@@ -985,7 +1003,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die("%s - not something we can merge", argv[0]);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		reset_hard(remote_head->sha1, 0);
+		read_empty(remote_head->sha1, 0);
 		return 0;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index e49dd80..d4a499d 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -127,4 +127,20 @@ test_expect_success SYMLINKS 'will not be confused by symlink in leading path' '
 	git checkout sub
 '
 
+cat >expect <<\EOF
+error: Untracked working tree file 'c0.c' would be overwritten by merge.
+fatal: read-tree failed
+EOF
+
+test_expect_success 'will not overwrite untracked file on unborn branch' '
+	git reset --hard c0 &&
+	git rm -fr . &&
+	git checkout --orphan new &&
+	cp important c0.c &&
+	test_must_fail git merge c0 2>out &&
+	test_cmp out expect &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_cmp important c0.c
+'
+
 test_done
-- 
1.7.3.1.105.g84915
