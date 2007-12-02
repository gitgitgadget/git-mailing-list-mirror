From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Difference in how "git status" and "git diff --name-only" lists filenames
Date: Sun, 02 Dec 2007 10:44:37 -0800
Message-ID: <7vodd9x7fu.fsf@gitster.siamese.dyndns.org>
References: <bf7b2dda0712020604x209d6665i9ab58b32834b2cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gustaf Hendeby" <hendeby@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IytoO-0003uU-PP
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXLBSoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXLBSoo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:44:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60658 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbXLBSon (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 13:44:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 54407310;
	Sun,  2 Dec 2007 13:45:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CBDA69C215;
	Sun,  2 Dec 2007 13:45:02 -0500 (EST)
In-Reply-To: <bf7b2dda0712020604x209d6665i9ab58b32834b2cee@mail.gmail.com>
	(Gustaf Hendeby's message of "Sun, 2 Dec 2007 15:04:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66807>

"Gustaf Hendeby" <hendeby@gmail.com> writes:

> A while ago 'git status' was patched to report relative pathnames.  (I
> like that change it makes cut'n'paste easier.)  However, 'git diff
> --name-only' and 'git diff --name-status' (other commands as well),
> which gives in a sense similar output has not been changed the same
> way.  Is this intentionally, or just because no one has stepped up and
> provided a patch?  If the difference is to stay, maybe this should be
> reflected in the help texts to avoid any confusion.

The commands output from diff always talks about paths relative to the
tree root, and scripts rely on it.  The recent change made exceptions to
the status command.  I agree an additional documentation to git-status
would be beneficial.

Having said that, a switch --relative-name might be an option.  It could
be argued that doing it the other way around (like --full-name option to
ls-files does), defaulting to relative to cwd, would have been a getter
approach if we were doing git from scratch, though.  We may still want
to do so in the longer run, but that would be a huge interface change
that would impact a lot of peoples' scripts.


diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 8fd0fc6..b0cb6bc 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -40,6 +40,10 @@ OUTPUT
 The output from this command is designed to be used as a commit
 template comments, and all the output lines are prefixed with '#'.
 
+The paths mentioned in the output, unlike many other git commands, are
+made relative to the current directory, if you are working in a
+subdirectory (this is on purpose, to help cutting and pasting).
+
 
 CONFIGURATION
 -------------
