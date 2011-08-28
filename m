From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] checkout: add --verbose, and restrict progress reporting
 (was: Re: [PATCH] checkout: be quiet if not on isatty())
Date: Sun, 28 Aug 2011 19:37:27 +0200
Message-ID: <20110828173644.GA1553@sherwood.local>
References: <cover.1314472512.git.sdaoden@gmail.com>
 <c70a246a601bec0ce973b177bf5553d3fee47014.1314472512.git.sdaoden@gmail.com>
 <7vaaau9hso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: martin f krafft <madduck@madduck.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	sdaoden@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 19:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxjIp-0007tg-4q
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 19:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab1H1Rhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 13:37:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58214 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab1H1Rhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 13:37:39 -0400
Received: by fxh19 with SMTP id 19so3810008fxh.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d03BPd03dkHr/T+hfDTjS8NXBlkR2f4MyEGgcW1tZHk=;
        b=u1fc7Hzae7EP1JeG/BoEuFTs/K9h36/o3k8P3EI9q0T1FsefqMUmqvfwMi7F2A5EeG
         gIzIMoIsE7lFxOPd1uauPbGDYU0wrbtQMNyypjzaDFfrz7voFLsf64k40zMxfJ2k0ZvM
         5caEmOCkVqhe/K+tC4KBtMpWbqbZmz/+RLfTw=
Received: by 10.223.58.73 with SMTP id f9mr606051fah.149.1314553058497;
        Sun, 28 Aug 2011 10:37:38 -0700 (PDT)
Received: from sherwood.local ([82.113.99.150])
        by mx.google.com with ESMTPS id d5sm3096415fak.0.2011.08.28.10.37.31
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 10:37:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaaau9hso.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180279>

This commit adds support for the -v/--verbose pair of options,
and thus offers the possibility to be more specific in deciding
which purely informational feedback message is displayed or not.

Without any of --verbose and --quiet involved, the progress
reporting is now restricted to interactive sessions, i.e. only
shown if the output is send to a terminal.

Analyzed-by: Junio C Hamano <gitster@pobox.com>
Inspired-by: martin f krafft <madduck@madduck.net>
Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---

Well i was stepping down from my hill, actually singing my
sunday's song (was it Elvis..), but i didn't dare to implement the
behaviour Martin suggested.  But isn't he right?
This thing here was also tested a bit.

 Documentation/git-checkout.txt |   13 +++++++++----
 builtin/checkout.c             |   12 +++++++++---
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c0a96e6..77ad4f3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,9 +8,9 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-v] [-q] [-f] [-m] [<branch>]
+'git checkout' [-v] [-q] [-f] [-m] [--detach] [<commit>]
+'git checkout' [-v] [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
 
@@ -66,9 +66,14 @@ file can be discarded to re-create the original conflicted merge result.
 
 OPTIONS
 -------
+-v::
+--verbose::
+	Be verbose, force progress reporting.
+
 -q::
 --quiet::
-	Quiet, suppress feedback messages.
+	Be quiet, suppress feedback messages and progress reporting.
+	Overrides "--verbose", if given.
 
 -f::
 --force::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4eaedff..7297843 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,6 +27,7 @@ static const char * const checkout_usage[] = {
 };
 
 struct checkout_opts {
+	int verbose;
 	int quiet;
 	int merge;
 	int force;
@@ -325,7 +326,7 @@ static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet;
+	opts.verbose_update = o->verbose;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -402,7 +403,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet;
+		topts.verbose_update = opts->verbose;
 		topts.fn = twoway_merge;
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |= DIR_SHOW_IGNORED;
@@ -927,7 +928,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
+		OPT__VERBOSE(&opts.verbose, "force progress reporting"),
+		OPT__QUIET(&opts.quiet, "suppress feedback reporting"),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
@@ -958,6 +960,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
+	if (opts.quiet)
+		opts.verbose = 0;
+	else if (!opts.verbose)
+		opts.verbose = isatty(2);
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
-- 
1.7.7.rc0.dirty
