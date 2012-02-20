From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 21:36:44 +0700
Message-ID: <20120220143644.GA13938@do>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzUN2-0006Qy-9w
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab2BTOhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:37:36 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44664 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab2BTOhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:37:35 -0500
Received: by pbcun15 with SMTP id un15so6324681pbc.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 06:37:34 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.190.8 as permitted sender) client-ip=10.68.190.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.190.8 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.190.8])
        by 10.68.190.8 with SMTP id gm8mr55629798pbc.146.1329748654945 (num_hops = 1);
        Mon, 20 Feb 2012 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=97ACmHAVZ1ci2oW/IfBbEgiBIAhyNMPJ6bOWVrnP3FA=;
        b=LLRMBgvRmsUiLOMtiDENnTtnRQnrmR8lbmNujJ+xV5QChtr7M9RICQrV2xK6qLbx0x
         CMakJw6S9jeX51vH61bgmqIlXQ4cJcSUqKDQonC22H/B+D0hzcXS3iJ0I0bhuz4CuBQb
         hCnq71aJe/R/EqWle9e4ArtnpvT99ifB7QuOA=
Received: by 10.68.190.8 with SMTP id gm8mr46537531pbc.146.1329748654893;
        Mon, 20 Feb 2012 06:37:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id d4sm6002462pbe.36.2012.02.20.06.37.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Feb 2012 06:37:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Feb 2012 21:36:44 +0700
Content-Disposition: inline
In-Reply-To: <87ty2l38ay.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191075>

On Mon, Feb 20, 2012 at 03:09:57PM +0100, Thomas Rast wrote:
> > Interestingly, on my git.git repo, I had an empty cache. Running "git
> > read-tree HEAD" filled it (according to test-dump-cache-tree). It seems
> > that running "git checkout" empties the cache.  So perhaps git could do
> > better about keeping the cache valid over time.
> 
> test_expect_failure 'checkout gives cache-tree' '
> 	git checkout HEAD^ &&
> 	test_shallow_cache_tree
> '
> 
> ;-)

Quick and dirty that passes that test. I think we could do better if
we analyse two way merge rules carefully and avoid this diff, but
that's too much for me right now.

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5bf96ba..c06287a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -319,6 +319,10 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
 		die(_("diff_setup_done failed"));
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
+	if (!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
+		struct tree *tree = parse_tree_indirect(head->sha1);
+		prime_cache_tree(&active_cache_tree, tree);
+	}
 }
 
 static void describe_detached_head(const char *msg, struct commit *commit)
@@ -493,13 +497,13 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 	}
 
+	if (!opts->force && !opts->quiet)
+		show_local_changes(&new->commit->object, &opts->diff_options);
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
 
-	if (!opts->force && !opts->quiet)
-		show_local_changes(&new->commit->object, &opts->diff_options);
-
 	return 0;
 }
 
-- 8< --
-- 
Duy
