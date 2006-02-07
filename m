From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git diff a..b" broken
Date: Tue, 7 Feb 2006 10:26:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602071024270.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602071020120.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Feb 07 19:29:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6XYV-0005qg-Ns
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 19:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWBGS0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 13:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWBGS0s
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 13:26:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964843AbWBGS0s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 13:26:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k17IQgDZ032051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Feb 2006 10:26:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k17IQfhc009441;
	Tue, 7 Feb 2006 10:26:42 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0602071020120.3854@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15705>



On Tue, 7 Feb 2006, Linus Torvalds wrote:
> 
> Just a heads up. I'll try to track down what the breakage is.

Ahh. Very simple.

The "--cc" implies "-p", but without the recursive part.

		Linus

----
diff --git a/diff-tree.c b/diff-tree.c
index f3280a1..7148323 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -284,14 +284,15 @@ int main(int argc, const char **argv)
 		}
 		usage(diff_tree_usage);
 	}
-	if (diff_options.output_format == DIFF_FORMAT_PATCH)
-		diff_options.recursive = 1;
 
 	if (combine_merges) {
 		diff_options.output_format = DIFF_FORMAT_PATCH;
 		ignore_merges = 0;
 	}
 
+	if (diff_options.output_format == DIFF_FORMAT_PATCH)
+		diff_options.recursive = 1;
+
 	diff_tree_setup_paths(get_pathspec(prefix, argv));
 	diff_setup_done(&diff_options);
 
