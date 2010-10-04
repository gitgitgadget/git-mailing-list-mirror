From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: branch versioning
Date: Mon, 4 Oct 2010 21:10:31 +0700
Message-ID: <20101004141031.GA8349@do>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com> <4CA9DA38.3070103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2lkk-0000hE-Fb
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0JDOKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 10:10:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54947 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0JDOKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 10:10:38 -0400
Received: by pzk34 with SMTP id 34so1335248pzk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5dFpC2Nd/ooDAGZ8cgj5BsVCGlKy2uvu3tiwlCW1FEw=;
        b=poRCFKTnAKCEY/uZrSitw9bilavaThOklquGMGIdhhgonfAJ1lK5sVXWGwUAR08rLn
         u4oScII9FzmzJv0vmdWyaMgjWXcIT/5tOJ2+7r/YNXno2J862Dg3N8WH2qgiE+nBpJB8
         lFgXDZdRvmr0l+erumP0p/2/mQX/YrXopaO+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ldsyqM2p5DYcCfV6OskKNd5rghk4juGOHK6TU22s/J3aObPbslCOlrXMEXrbb6mDPQ
         ujg95cjrpxmrGXkNptWXCkgPDomuEUkLGzpxk8Akrb5mdwZcv36PbVGjMDgftC06mCVD
         DQbJ8fkJyKzygeKMg8z8IowpT699Myo2dbge4=
Received: by 10.142.3.5 with SMTP id 5mr8694462wfc.253.1286201438427;
        Mon, 04 Oct 2010 07:10:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.224.73])
        by mx.google.com with ESMTPS id j13sm120135wfe.1.2010.10.04.07.10.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 07:10:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  4 Oct 2010 21:10:31 +0700
Content-Disposition: inline
In-Reply-To: <4CA9DA38.3070103@drmicha.warpmail.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158053>

On Mon, Oct 04, 2010 at 03:44:24PM +0200, Michael J Gruber wrote:
> That way my branch namespace is reasonably clean, and the graph view on
> github, e.g., is somewhat meaningful. My tag name space is a bit crowded...

This might help you. I don't know. I think the idea is good, but you may
need a negative pattern, or multiple patterns... Just a starting point.

If I git-branch supported pattern matching and negative pattern, then
my "attic/" hidden namespace would be solved. Hmm..

>From 461bd140c71fc242470c08523bc7becefb9aa2cf Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Date: Mon, 4 Oct 2010 21:05:54 +0700
Subject: [PATCH] tag: add core.taglist to let user customize "git tag -l"

Be default "git tag" alone (or "git tag -l") will list all tags.
Let user specify how they want to list in this case via core.taglist
---
 Documentation/git-tag.txt |    3 ++-
 builtin/tag.c             |    7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..770d1d8 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -69,7 +69,8 @@ OPTIONS
 
 -l <pattern>::
 	List tags with names that match the given pattern (or all if no pattern is given).
-	Typing "git tag" without arguments, also lists all tags.
+	Typing "git tag" without arguments, also lists all tags matched
+	by core.taglist ('*' if undefined)
 
 --contains <commit>::
 	Only list tags which contain the specified commit.
diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..33620f6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -22,6 +22,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static char signingkey[1000];
+static const char *default_pattern = "*";
 
 struct tag_filter {
 	const char *pattern;
@@ -96,7 +97,7 @@ static int list_tags(const char *pattern, int lines,
 	struct tag_filter filter;
 
 	if (pattern == NULL)
-		pattern = "*";
+		pattern = default_pattern;
 
 	filter.pattern = pattern;
 	filter.lines = lines;
@@ -234,6 +235,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 		set_signingkey(value);
 		return 0;
 	}
+	if (!strcmp(var, "core.taglist")) {
+		git_config_string(&default_pattern, var, value);
+		return 0;
+	}
 
 	return git_default_config(var, value, cb);
 }
-- 
1.7.0.2.445.gcbdb3
-- 
Duy
