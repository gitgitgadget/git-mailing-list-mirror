From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH v2] maint: check return of split_cmdline to avoid bad
	config strings
Date: Wed, 24 Sep 2008 10:50:29 -0400
Message-ID: <20080924145029.GA3052@riemann.deskinm.fdns.net>
References: <20080924061028.GA2792@riemann.deskinm.fdns.net> <20080924092847.GD23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:53:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVjI-0000rI-FN
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYIXOv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYIXOv1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:51:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:37330 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYIXOv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:51:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so407477yxm.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=68SonweEugmUOsLOnF92RmcVPxzy0K2KKEj1gVOxldE=;
        b=MbX7EneXXQgDvvxKzPPt0i6wnr15AU/hjo1v+5dOyeN+uGpp10mPjV08t0S/xCgUsl
         rTSeRb2v9C5AqFJklVFhaj8BuKDCBkVKc9BLoXWBdS3tI9+MTIFEpwfw0NO0tB2qZLTz
         W2HiT8UsUecBwJNsi8jNwhKFQvnWxQugCXeOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=lv/6z2V9qQ2/i2v1uWaEZxtHQoWMttnpwG/r2NFr1mgYTEw0J3Qblg+c2nTd6fMWlY
         ECZ9mWuLnc5uwxPL/Di0xK3LwmMk9a4X8Mgm5cmAQxgQDUSbVnRHP253wj6tVbRqgQx8
         wCqzOz52QtpcGgdjI5iv3vgedfZJHtcQappYY=
Received: by 10.90.81.19 with SMTP id e19mr8350772agb.24.1222267885576;
        Wed, 24 Sep 2008 07:51:25 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id p60sm2229173hsa.8.2008.09.24.07.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Sep 2008 07:51:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080924092847.GD23137@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96641>

>From 0d52afa86d757220fefa2440c78c81bd2c8b790a Mon Sep 17 00:00:00 2001
From: Deskin Miller <deskinm@umich.edu>
Date: Mon, 22 Sep 2008 11:06:41 -0400
Subject: [PATCH] maint: check return of split_cmdline to avoid bad config strings

As the testcase demonstrates, it's possible for split_cmdline to return -1 and
deallocate any memory it's allocated, if the config string is missing an end
quote.  In both the cases below, which are the only calling sites, the return
isn't checked, and using the pointer causes a pretty immediate segfault.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
On Wed, Sep 24, 2008 at 11:28:47AM +0200, Miklos Vajna wrote:
> On Wed, Sep 24, 2008 at 02:10:28AM -0400, Deskin Miller <deskinm@umich.edu> wrote:
> > As the testcase demonstrates, it's possible to have split_cmdline return -1 and
> > deallocate any memory it's allocated, if the config string is missing an end
> > quote.  In both the cases below, the return isn't checked, causing a pretty
> > immediate segfault.
> 
> I think this could go to the commit message.

Done in v2.

> > +	git merge master || test \$? = 128
> > +	"
> 
> Why don't you use test_must_fail here?

Didn't know about it.  Fixed in v2.

Thanks for the advice.

 builtin-merge.c        |    2 ++
 git.c                  |    2 ++
 t/t1300-repo-config.sh |   10 ++++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b280444..dcaf368 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -442,6 +442,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
+		if (argc < 0)
+			die("Bad branch.%s.mergeoptions string", branch);
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
diff --git a/git.c b/git.c
index fdb0f71..5582c51 100644
--- a/git.c
+++ b/git.c
@@ -162,6 +162,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			    alias_string + 1, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
+		if (count < 0)
+			die("Bad alias.%s string", alias_command);
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 64567fb..11b82f4 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -741,4 +741,14 @@ test_expect_success 'symlinked configuration' '
 
 '
 
+test_expect_success 'check split_cmdline return' "
+	git config alias.split-cmdline-fix 'echo \"' &&
+	test_must_fail git split-cmdline-fix &&
+	echo foo > foo &&
+	git add foo &&
+	git commit -m 'initial commit' &&
+	git config branch.master.mergeoptions 'echo \"' &&
+	test_must_fail git merge master
+	"
+
 test_done
-- 
1.6.0.2.GIT
