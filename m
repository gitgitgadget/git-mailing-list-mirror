From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] fast-import doc: split OPTIONS into subsections
Date: Sun, 6 Jan 2013 05:34:15 -0800
Message-ID: <20130106133415.GE22081@elie.Belkin>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 14:36:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrqOZ-0006Vk-B1
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 14:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab3AFNeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 08:34:23 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:44560 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab3AFNeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 08:34:22 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so8195690dad.22
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CBZmB1mpSkfsn4I2kTbeoIUZMyTnpQEbHGCNEvpuiEA=;
        b=p2s6IIHDEUkS6GwGsxrEiRPwqFW6LJM36IIW8yw6dNAsTArN9xq1xEUKqHuzgd5CgS
         VkeCAnF6v5unsCryDPxzHKZVij+vL27oRkEUFbqOk+Txa+GqVHYJalt/jBOmVu7Qfb01
         myg9NrOnKvWp8XcSTLBNpct3knb/zwkJ25kAl0UCf5TMAzqP9+8BKjW5FXjgWHdR0zpX
         RzZK9iKr5+N2vdjjLZuGpwFWbjFt2jGAZHCRrh7QGXkwFkTTrBxvpy8mjGdlBARypEVt
         d0IMfJvsvJ+o8I8EsZ5SDE6A60pJIojvsSE+WFHpulY5PP4Ell2BFfvTQGgozzF2s1Go
         gK/w==
X-Received: by 10.68.241.136 with SMTP id wi8mr179247512pbc.95.1357479261837;
        Sun, 06 Jan 2013 05:34:21 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ov4sm35804947pbb.45.2013.01.06.05.34.19
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 05:34:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130105231151.GD3247@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212801>

The OPTIONS section of this manpage has grown long without any
particular organization to ensure it remains manageable.  Split into
categories to make the documentation for each option easier to find.
The categories:

 1. Features of the input format, such as the date format and whether
    the file is required to end with a "done" command.
 2. How much output the importer should write to stderr.
 3. Marks Handling (Checkpoint/Restart).
 4. Other options that change the behavior in a semantically
    meaningful way (backflow pipe setup, whether to force ref
    updates, where to list pack edges).
 5. Performance and compression tuning.

Reported-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The second-to-last subsection ("Import Semantics") is kind of a
catch-all.  Better ideas for organization or naming would be
welcome.

 Documentation/git-fast-import.txt | 82 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d2c0e357..1676d436 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -32,35 +32,36 @@ the frontend program in use.
 
 OPTIONS
 -------
+Input Syntax
+~~~~~~~~~~~~
 --date-format=<fmt>::
 	Specify the type of dates the frontend will supply to
 	fast-import within `author`, `committer` and `tagger` commands.
 	See ``Date Formats'' below for details about which formats
 	are supported, and their syntax.
 
---force::
-	Force updating modified existing branches, even if doing
-	so would cause commits to be lost (as the new commit does
-	not contain the old commit).
+--done::
+	Terminate with error if there is no 'done' command at the
+	end of the stream.
+	This option might be useful for detecting errors that
+	cause the frontend to terminate before it has started to
+	write a stream.
 
---max-pack-size=<n>::
-	Maximum size of each output packfile.
-	The default is unlimited.
+Verbosity
+~~~~~~~~~
+--quiet::
+	Disable all non-fatal output, making fast-import silent when it
+	is successful.  This option disables the output shown by
+	\--stats.
 
---big-file-threshold=<n>::
-	Maximum size of a blob that fast-import will attempt to
-	create a delta for, expressed in bytes.  The default is 512m
-	(512 MiB).  Some importers may wish to lower this on systems
-	with constrained memory.
-
---depth=<n>::
-	Maximum delta depth, for blob and tree deltification.
-	Default is 10.
-
---active-branches=<n>::
-	Maximum number of branches to maintain active at once.
-	See ``Memory Utilization'' below for details.  Default is 5.
+--stats::
+	Display some basic statistics about the objects fast-import has
+	created, the packfiles they were stored into, and the
+	memory used by fast-import during this run.  Showing this output
+	is currently the default, but can be disabled with \--quiet.
 
+Marks Handling (Checkpoint/Restart)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 --export-marks=<file>::
 	Dumps the internal marks table to <file> when complete.
 	Marks are written one per line as `:markid SHA-1`.
@@ -96,18 +97,18 @@ OPTIONS
 	--(no-)-relative-marks with the --(import|export)-marks=
 	options.
 
+Import Semantics
+~~~~~~~~~~~~~~~~
+--force::
+	Force updating modified existing branches, even if doing
+	so would cause commits to be lost (as the new commit does
+	not contain the old commit).
+
 --cat-blob-fd=<fd>::
 	Specify the file descriptor that will be written to
 	when the `cat-blob` command is encountered in the stream.
 	The default behaviour is to write to `stdout`.
 
---done::
-	Terminate with error if there is no 'done' command at the
-	end of the stream.
-	This option might be useful for detecting errors that
-	cause the frontend to terminate before it has started to
-	write a stream.
-
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -117,16 +118,25 @@ OPTIONS
 	as these commits can be used as edge points during calls
 	to 'git pack-objects'.
 
---quiet::
-	Disable all non-fatal output, making fast-import silent when it
-	is successful.  This option disables the output shown by
-	\--stats.
+Tuning
+~~~~~~
+--max-pack-size=<n>::
+	Maximum size of each output packfile.
+	The default is unlimited.
 
---stats::
-	Display some basic statistics about the objects fast-import has
-	created, the packfiles they were stored into, and the
-	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with \--quiet.
+--big-file-threshold=<n>::
+	Maximum size of a blob that fast-import will attempt to
+	create a delta for, expressed in bytes.  The default is 512m
+	(512 MiB).  Some importers may wish to lower this on systems
+	with constrained memory.
+
+--depth=<n>::
+	Maximum delta depth, for blob and tree deltification.
+	Default is 10.
+
+--active-branches=<n>::
+	Maximum number of branches to maintain active at once.
+	See ``Memory Utilization'' below for details.  Default is 5.
 
 
 Performance
-- 
1.8.1
