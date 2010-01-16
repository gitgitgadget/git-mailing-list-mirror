From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
	repository
Date: Fri, 15 Jan 2010 22:51:36 -0800
Message-ID: <20100116065135.GA15104@gmail.com>
References: <201001131713.05505.agruen@suse.de> <7vfx69k0bu.fsf@alter.siamese.dyndns.org> <20100115223259.6117@nanako3.lavabit.com> <7vska71br0.fsf@alter.siamese.dyndns.org> <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org> <20100115210854.GA21540@coredump.intra.peff.net> <7vwrzin9jt.fsf@alter.siamese.dyndns.org> <20100116011512.GA27082@coredump.intra.peff.net> <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 07:51:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW2Vl-0007jt-3t
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 07:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0APGvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 01:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393Ab0APGvs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 01:51:48 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:45120 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0APGvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 01:51:47 -0500
Received: by ywh6 with SMTP id 6so1177948ywh.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7dYxc8Ty9Md/TiqwPCz36PLCL/gRmTDEK2PMHKsB1rQ=;
        b=ZAKh5hjzvZ6hELM9x/761tDrZE501WrQ2zEWaq6B5DcBGFb5vXk5bZ0qEcGHkDg/jF
         75p2Mypn1IUpkBexvdHgfgTmpyZqZWm7ohvGnDuCUzd9bvJvXEv7FawGIwhqtKj6hhlf
         FCFJyILfz/CFDmP03BqVv96hH6gL8SfyTBd8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jV6nVJ67OVYzhtXE2A2YQ+/KJmWwgs+RtFUhbINSMvkNDV5CGlRIKB65T2DFSiSeCC
         JIsET6Uushw1lgoBKrYaP9ebMOg+aAV7MAy2va/PFlkWSOkPuow3pHTIWJVnqH/gycg+
         nBh19b2IUTMk4xRGs3FAaxNiZSA+W3dviP1/c=
Received: by 10.101.87.11 with SMTP id p11mr2147296anl.73.1263624706386;
        Fri, 15 Jan 2010 22:51:46 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 8sm1140564ywg.34.2010.01.15.22.51.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 22:51:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137203>

On Fri, Jan 15, 2010 at 08:15:49PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >>     git grep --all-match -e Junio -e Dscho
> >
> > That one is a little harder (though it is not something I do very often,
> > and I had to actually read the docs to find what --all-match does):
> >
> >   grep Junio `grep -l Dscho *`
> >
> > which of course has problems with exotic filenames.
> 
> Also it doesn't find lines that match Dscho in the result ;-)
> 
> Realistically, this most often is used when grepping in the log, e.g.
> 
>     git log --all-match --author=peff --grep=test
> 
> I actually wish "log" to somehow default to --all-match mode at least when
> using the --author option.  "Change by Jeff, or about test by anybody" is
> rarely what I would want to look for.

Kinda like this?

I originally had it set grep_filter.all_match in --author only,
but then I thought "why author and not commiter too", so changing
the default seemed like the natural thing to do.  Or it could be
a cat brained idea, I dunno ;)

-- -- -- 8< -- -- -- 8< -- -- --
From 2277a6e512c2f597c6240f06c9e7d5ff83e2fe3f Mon Sep 17 00:00:00 2001
From: David Aguilar <davvid@gmail.com>
Date: Fri, 15 Jan 2010 21:18:36 -0800
Subject: [PATCH] Make --all-match the default in "log" family

'git log --author=peff --grep=test' means "search for commits by Jeff,
or about test by anybody," which is rarely what what we want to do.
The original behavior can by achieved by specifying --no-all-match.

Reference: http://article.gmane.org/gmane.comp.version-control.git/137197
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/rev-list-options.txt |    1 +
 revision.c                         |    3 +++
 t/t7002-grep.sh                    |    2 +-
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1f57aed..0ce1008 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -179,6 +179,7 @@ endif::git-rev-list[]
 --all-match::
 	Limit the commits output to ones that match all given --grep,
 	--author and --committer instead of ones that match at least one.
+	--all-match is the defaullt and can be disabled with --no-all-match.
 
 -i::
 --regexp-ignore-case::
diff --git a/revision.c b/revision.c
index 25fa14d..64ebdc5 100644
--- a/revision.c
+++ b/revision.c
@@ -804,6 +804,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
+	revs->grep_filter.all_match = 1;
 	revs->grep_filter.status_only = 1;
 	revs->grep_filter.pattern_tail = &(revs->grep_filter.pattern_list);
 	revs->grep_filter.regflags = REG_NEWLINE;
@@ -1222,6 +1223,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--no-all-match")) {
+		revs->grep_filter.all_match = 0;
 	} else if (!prefixcmp(arg, "--encoding=")) {
 		arg += 11;
 		if (strcmp(arg, "none"))
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 76c5e09..92ef534 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -358,7 +358,7 @@ test_expect_success 'log grep (4)' '
 
 test_expect_success 'log grep (5)' '
 	git log --author=Thor -F --grep=Thu --pretty=tformat:%s >actual &&
-	( echo third ; echo initial ) >expect &&
+	: >expect &&
 	test_cmp expect actual
 '
 
-- 
1.6.6.197.g2277
