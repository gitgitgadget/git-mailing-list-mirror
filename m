From: Hannu Koivisto <azure@iki.fi>
Subject: git add --patch bug with split+edit?
Date: Sat, 17 Jan 2009 03:37:43 +0200
Organization: NOYB
Message-ID: <833afihfvc.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 02:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO09i-0006h0-4e
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 02:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbZAQBh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 20:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbZAQBh5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 20:37:57 -0500
Received: from main.gmane.org ([80.91.229.2]:50950 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355AbZAQBh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 20:37:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LO08F-0000my-V3
	for git@vger.kernel.org; Sat, 17 Jan 2009 01:37:51 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 01:37:51 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 01:37:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:rjv/Zces1sNSHmK5wXFjk4FU960=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106007>

Greetings,

If I have a hunk that adds three lines, I can edit the hunk and
remove the last line but I can't split it in two, stage the first
part, edit the second part and remove the last line.  An example:

mkdir gittest
cd gittest
git init
echo "baz\nbaz" > baz
git add baz
git commit -m baz baz
rm baz
echo "sur\nbaz\nbaz\njee\njee" > baz
git add --patch

Now say 's RET y RET e RET' and remove the second "+jee" line using
your editor.  The output for me looks like this:

--8<-----------------------------------------------------------------
diff --git a/baz b/baz
index 1f55335..48a5f83 100644
--- a/baz
+++ b/baz
@@ -1,2 +1,5 @@
+sur
 baz
 baz
+jee
+jee
Stage this hunk [y/n/a/d/s/e/?]? s
Split into 2 hunks.
@@ -1,2 +1,3 @@
+sur
 baz
 baz
Stage this hunk [y/n/a/d/j/J/e/?]? y
@@ -1,2 +2,4 @@
 baz
 baz
+jee
+jee
Stage this hunk [y/n/a/d/K/e/?]? e
Waiting for Emacs...
error: patch failed: baz:1
error: baz: patch does not apply
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]?
--8<-----------------------------------------------------------------

What I also didn't expect is that if I answer 'n' to that last
question, I get...

@@ -1,2 +1,3 @@
+sur
 baz
 baz
Stage this hunk [y/n/a/d/j/J/e/?]?

...which is the first part of the splitted hunk that I already
staged.  If I answer 'd', git status and git diff indicate that
"+sur" is nevertheless staged.

Now, if instead of splitting the hunk and editing it, I edit the
entire...

@@ -1,2 +1,5 @@
+sur
 baz
 baz
+jee
+jee

...hunk and remove the last "+jee" line, I get no error.

I'm using git 1.6.1 on Linux.

-- 
Hannu
