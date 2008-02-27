From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4 (alternate)] Add '--fixed-strings' option to "git log --grep" and friends
Date: Wed, 27 Feb 2008 10:20:21 +0100
Message-ID: <200802271020.21662.jnareb@gmail.com>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com> <1204028528-18941-2-git-send-email-jnareb@gmail.com> <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 10:21:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUITN-0007KF-G3
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 10:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYB0JUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 04:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbYB0JUc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 04:20:32 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:22534 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYB0JUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 04:20:30 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1891699tif.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=rk1FNYXf+x+CYmvY+arfkJoTpqWZXZ91LOewyKNRmno=;
        b=rSNYIH7prtn0BMns4YTCQ/CUuEtVqOnuMETU1ZSaTMX7Gb/SC4rNXheoKUMVQdXiFNLgcUTocj2ZEJa84tzOKtWjytAIMacXIOLoaeF48mD8Q5IqcQBssXO22dxgW9NDUoWu+rfZoTaulYEeaa2xjv0hakCYRrygOh0muD1jRbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eHTR7F0Ynix5QRd/oqLoGHkpOmqnk3TnykWIodssp8o2e1sNuFKKEQq/+tUDhxRwvHDMDY4f/IsmXqP2wVcVSmzD9IyFhR/T4bMDM1cnwHYas+396hwsJAbXhfUfcUlsNKbcxWXFWAJnKJ2RXGBZa+4Nk1D2/e31sb9TdvDy4pg=
Received: by 10.150.230.2 with SMTP id c2mr2151137ybh.161.1204104026855;
        Wed, 27 Feb 2008 01:20:26 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.204.229])
        by mx.google.com with ESMTPS id g12sm13345097nfb.27.2008.02.27.01.20.24
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 01:20:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75216>

Add support for '--fixed-strings' option to "git log --grep"
and friends: "git log --author", "git log --committer".
Code is based on implementation of this option in "git grep".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Wed, 27 Feb 2008, Junio C Hamano wrote:

> So I am reluctant to
> see it grab a short-and-sweet -F option letter that might have
> better uses, but I do not have major objection against a more
> explicit --fixed-strings.

This version doesn't use '-F' short option.

 Documentation/git-rev-list.txt     |    1 +
 Documentation/rev-list-options.txt |    5 +++++
 revision.c                         |    9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 5b96eab..0291225 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -31,6 +31,7 @@ SYNOPSIS
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case | \-i ]
 	     [ \--extended-regexp | \-E ]
+	     [ \--fixed-strings ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a8138e2..826ac62 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -153,6 +153,11 @@ limiting may be applied.
 	Consider the limiting patterns to be extended regular expressions
 	instead of the default basic regular expressions.
 
+--fixed-strings::
+
+	Consider the limiting patterns to be fixed strings (don't interpret
+	pattern as a regular expression).
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index d3e8658..4daeac1 100644
--- a/revision.c
+++ b/revision.c
@@ -942,6 +942,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	int left = 1;
 	int all_match = 0;
 	int regflags = 0;
+	int fixed = 0;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1238,6 +1239,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				regflags |= REG_ICASE;
 				continue;
 			}
+			if (!strcmp(arg, "--fixed-strings")) {
+				fixed = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--all-match")) {
 				all_match = 1;
 				continue;
@@ -1293,8 +1298,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (revs->grep_filter)
+	if (revs->grep_filter) {
 		revs->grep_filter->regflags |= regflags;
+		revs->grep_filter->fixed = fixed;
+	}
 
 	if (show_merge)
 		prepare_show_merge(revs);
-- 
1.5.4.2
