From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] Documentation/gitignore: "foo/" patterns match
 directories, not files under them
Date: Mon, 7 Nov 2011 02:07:11 -0600
Message-ID: <20111107080711.GA30486@elie.hsd1.il.comcast.net>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 09:07:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNKEm-0001Xu-9k
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 09:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064Ab1KGIHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 03:07:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38700 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1KGIHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 03:07:18 -0500
Received: by ywf7 with SMTP id 7so5009951ywf.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mIiMEDd4LgNjAIqIWehbVeAXuJJtPKWUj80Y5AvjwX4=;
        b=wb6l3fQ9Q8dZ9uonaJJ06W18nv9MktVkChv9hZsJpR+kBf4zb5H5hbWTWad5WSKuJx
         cErB5bGJ9H4+fNXPw9XXOl5DHxw8sngFQPrVGfN9FOs+HfLYRP5Ba8mQ811hQBpok76t
         5QjIpTZ8MePs19PvX9e6/yfHCbmsCPD+jSuY4=
Received: by 10.50.135.40 with SMTP id pp8mr42200509igb.1.1320653237368;
        Mon, 07 Nov 2011 00:07:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j1sm17818688igq.2.2011.11.07.00.07.16
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 00:07:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184958>

The gitignore(5) manpage says that "foo/" will match a directory foo
and paths underneath it.  But that is completely false: as Johannes
Sixt likes to remind us, patterns with a trailing '/' match the named
directory, not files under that directory.  For example, the following
.gitignore file

	/build/
	!/build/tests/results

does not un-ignore build/tests/results since it was never ignored in
the first place; and commands like "git status" will not notice
changes to build/tests/results because git doesn't enter the (ignored)
build/ directory.

Correct the manual to just say that "foo/" matches the directory
"foo", and make the wording a little clearer in other ways while at
it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitignore.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b8..5b070bf0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -72,12 +72,14 @@ PATTERN FORMAT
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
 
- - If the pattern ends with a slash, it is removed for the
-   purpose of the following description, but it would only find
-   a match with a directory.  In other words, `foo/` will match a
-   directory `foo` and paths underneath it, but will not match a
-   regular file or a symbolic link `foo` (this is consistent
-   with the way how pathspec works in general in git).
+ - If the pattern ends with a slash, it will only match
+   directories.  In other words, `foo/` will match a
+   directory `foo` but will not match a regular file or a
+   symbolic link `foo` (this is consistent with the way
+   pathspecs work in general in git).
++
+The trailing slash is removed before applying the remaining
+rules.
 
  - If the pattern does not contain a slash '/', git treats it as
    a shell glob pattern and checks for a match against the
-- 
1.7.8.rc0
