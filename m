From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 2/3] ls: remove redundant logic
Date: Sat, 20 Mar 2010 19:55:28 +0100
Message-ID: <1269111329-5896-3-git-send-email-kusmabite@gmail.com>
References: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Cc: rene.scharfe@lsrfire.ath.cx, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3rC-0007TB-5R
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0CTS4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:56:43 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45107 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0CTS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:56:41 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so297132ewy.28
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rCDz8VSD8HYgw3r3rKqS9v5j8K4YwMGKPgW+Bz4A9Ow=;
        b=e4px3ZQ/3ueysmPN8XWPbRr5aNonbTp3Df3Xzgg7qZ0KVXD8/VuCaYP/NAO8zxcu3a
         W/UjWSnYAnVeqJ80WMZp6MTTCpRo4QmjtcKDNz4JGsHe1HCuAmqoYEj62RhJA1KFitXf
         K3BTSQjrel1fpsDrA/ajlcrSFlg7PfaxH1SjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tqPJPbTstnOO8wt0aQGWMORY/wnxu4ztuWyh9gpJcH3zCpHOGA3Or8HCg8CCLpq3sL
         vg/Qrc149iuRb9OpgXUOL4ZMZojGaLIqXleDaKNSgtJmiR1Dng8UqbSzn0+yK04iup2+
         22vlLEk6zLMwE7UBrVJwbSXuXd5x4TP1DZOTo=
Received: by 10.213.97.24 with SMTP id j24mr4125411ebn.48.1269111400479;
        Sat, 20 Mar 2010 11:56:40 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 16sm852100ewy.7.2010.03.20.11.56.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 11:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g64f24
In-Reply-To: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142738>

find_unique_abbrev() already returns the full SHA-1 if abbrev = 0,
so we can remove the logic that avoids the call.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/ls-files.c |    7 ++-----
 builtin/ls-tree.c  |    6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b065061..c0fbcdc 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -153,8 +153,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ce->ce_mode,
-		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
-				: sha1_to_hex(ce->sha1),
+		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
@@ -176,9 +175,7 @@ static int show_one_ru(struct string_list_item *item, void *cbdata)
 		if (!ui->mode[i])
 			continue;
 		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-		       abbrev
-		       ? find_unique_abbrev(ui->sha1[i], abbrev)
-		       : sha1_to_hex(ui->sha1[i]),
+		       find_unique_abbrev(ui->sha1[i], abbrev),
 		       i + 1);
 		write_name_quoted(path + offset, stdout, line_terminator);
 	}
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4484185..dc86b0d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -103,13 +103,11 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 			} else
 				strcpy(size_text, "-");
 			printf("%06o %s %s %7s\t", mode, type,
-			       abbrev ? find_unique_abbrev(sha1, abbrev)
-				      : sha1_to_hex(sha1),
+			       find_unique_abbrev(sha1, abbrev),
 			       size_text);
 		} else
 			printf("%06o %s %s\t", mode, type,
-			       abbrev ? find_unique_abbrev(sha1, abbrev)
-			              : sha1_to_hex(sha1));
+			       find_unique_abbrev(sha1, abbrev));
 	}
 	write_name_quotedpfx(base + chomp_prefix, baselen - chomp_prefix,
 			  pathname, stdout, line_termination);
-- 
1.7.0.2.456.g64f24
