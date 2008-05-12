From: "Dan McGee" <dpmcgee@gmail.com>
Subject: git-svn blame change- doc confusion
Date: Sun, 11 May 2008 23:05:49 -0500
Message-ID: <449c10960805112105w2e362ea7l9b11c53c47952501@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 06:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvPJB-0002JW-1X
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 06:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbYELEFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 00:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYELEFv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 00:05:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:36571 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbYELEFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 00:05:50 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2462857rvb.1
        for <git@vger.kernel.org>; Sun, 11 May 2008 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=npprNISfX9QAf4x4SQxmLB6XqKAfIEpTkNuahbMhybk=;
        b=c9trERvXjP9rkVrFJCl/3HA+0Sn8yL/1IUGYamWXwHXud0hE2PgnvjbuUTc/WBsBvdtQsy8G21JrWgBFtkrEd+dIF4BPadaUTHZCGZPGTbL38QrYl6U8qN/VnJvJ/nVkt/5r04oAcuk7JnV7mSKhI4es0m1KVOSMbFmkm5JJnx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=vjwjL3wNn925OmvHHL8F6IClx0o3OwWxdixOksMfMTsdjB02lwohsn0oqvZbZMYfAysbGsCGKLks+vqvblX+Vfuvd9iQZv24n7LZYvJmowDLhzh5ZPSWnfkSi4A4YoMySesGAJPzZQW2vIsm0xmLlFjNLCRAJZtsDz/elYAkbSo=
Received: by 10.141.71.14 with SMTP id y14mr3448650rvk.253.1210565149689;
        Sun, 11 May 2008 21:05:49 -0700 (PDT)
Received: by 10.141.212.3 with HTTP; Sun, 11 May 2008 21:05:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81830>

Here is the commit snippet. Reading the commit message, I would assume
the default format with no options is SVN, and you need to use the
--git-format arg to get the GIT format.

Reading the new blame description seems to tell me the same thing.

However, reading the --git-format description tells me something real
weird- that using --git-format will give me SVN revision numbers and
not git hashes, and something about revision 0?

Can someone clarify this for me and let me know if I'm the crazy one?

-Dan

commit 4be403815321976bc2ee4c6677799abb06b153aa
Author: Steven Grimm <koreth@midwinter.com>
Date:   Sat May 10 22:11:18 2008 -0700

    Add svn-compatible "blame" output format to git-svn

    git-svn blame produced output in the format of git blame; in environments
    where there are scripts that read the output of svn blame, it's useful
    to be able to use them with the output of git-svn. The git-compatible
    format is still available using the new "--git-format" option.

    This also fixes a bug in the initial git-svn blame implementation; it was
    bombing out on uncommitted local changes.

    Signed-off-by: Steven Grimm <koreth@midwinter.com>
    Acked-by: Eric Wong <normalperson@yhbt.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4ba105..c6b56b4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -166,11 +166,18 @@ environment). This command has the same behaviour.
 Any other arguments are passed directly to `git log'

 'blame'::
-       Show what revision and author last modified each line of a file. This is
-       identical to `git blame', but SVN revision numbers are shown
instead of git
-       commit hashes.
+       Show what revision and author last modified each line of a file. The
+       output of this mode is format-compatible with the output of
+       `svn blame' by default. Like the SVN blame command,
+       local uncommitted changes in the working copy are ignored;
+       the version of the file in the HEAD revision is annotated. Unknown
+       arguments are passed directly to git-blame.
 +
-All arguments are passed directly to `git blame'.
+--git-format;;
+       Produce output in the same format as `git blame', but with
+       SVN revision numbers instead of git commit hashes. In this mode,
+       changes that haven't been committed to SVN (including local
+       working-copy edits) are shown as revision 0.

 --
 'find-rev'::
