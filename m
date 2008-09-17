From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Mismatch between "git status" and "git ls-files" [was Re: Teach git
 status to do "git diff --name-status HEAD"]
Date: Wed, 17 Sep 2008 17:16:16 +0200
Message-ID: <48D11F40.4000307@drmicha.warpmail.net>
References: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com>	<48D0C2DF.7010308@drmicha.warpmail.net> <m3ej3jm3ux.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090503070509000300010107"
Cc: Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfyma-0001oP-Cx
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 17:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYIQPQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 11:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYIQPQX
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 11:16:23 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52346 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399AbYIQPQW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 11:16:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EFE32163240;
	Wed, 17 Sep 2008 11:16:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Sep 2008 11:16:21 -0400
X-Sasl-enc: DZEBOlTRjxs2bjjBOUYZ4G6L6zlcPiINA21CgqjCjuYT 1221664580
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8396615EB0;
	Wed, 17 Sep 2008 11:16:20 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <m3ej3jm3ux.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96120>

This is a multi-part message in MIME format.
--------------090503070509000300010107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Following up on the discussion about "git status" versus
"youknowwhichscm status" and suggestions to use "git diff --name-status"
or "git ls-files -d -m -o -t" I made a little test case, see the
attached script and output (git version 1.6.0.2.249.g97d7f). Observations:

- "git diff --name-status" and "git ls-files" use very similar form,
even the same status letters, but with completely different meaning for
C, M, R. That is highly confusing (this what I mean by mismatch).

- "git diff --name-status" has no way of showing ignored or untracked files

- "git status" has no way of showing ignored files

- "git ls-files -d -m -o -t" does not distinguish between ignored and
untracked (all is ?)

- "git ls-files" is plumbing, one should not need plumbing to get status
output.

I guess what's needed would be a porcelain that:

- shows state in concise form ("X filename" lines like --name-status or
ls-files -t)
- has options to show ignored and untracked file optionally

To me the most direct approach would be: If "git diff" compares with the
work-tree, teach it to include ignored resp. untracked files optionally.

I guess I wouldn't care about the mismatch then. Are there specific
reasons (other than evolution) for the conflicting status letters?

Michael

--------------090503070509000300010107
Content-Type: text/plain;
 name="stats.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stats.out"

Initialized empty Git repository in /tmp/mjg/stats/.git/
Created initial commit 345adf7: files to be changed
 10 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 copied
 create mode 100644 gitmoved
 create mode 100644 gitremoved
 create mode 100644 modified
 create mode 100644 modifiedadded
 create mode 100644 moved
 create mode 100644 removed
 create mode 100644 typechanged
 create mode 100644 typechangedadded
 create mode 100644 unchanged
rm 'gitremoved'
### git status ###
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   added
#	new file:   copiedadded
#	renamed:    gitmoved -> gitmoved2
#	deleted:    gitremoved
#	modified:   modifiedadded
#	modified:   typechangedadded
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#	modified:   modified
#	deleted:    moved
#	deleted:    removed
#	modified:   typechanged
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	copiedonly
#	moved2
#	untracked
### git diff ###
M	modified
D	moved
D	removed
M	typechanged
### git diff HEAD ###
A	added
C100	copied	copiedadded
R100	gitmoved	gitmoved2
D	gitremoved
M	modified
M	modifiedadded
D	moved
D	removed
M	typechanged
M	typechangedadded
### git diff --cached HEAD ###
A	added
C100	copied	copiedadded
R100	gitmoved	gitmoved2
D	gitremoved
M	modifiedadded
M	typechangedadded
### git ls-files
? copiedonly
? ignored
? moved2
? untracked
C modified
R moved
C moved
R removed
C removed
C typechanged

--------------090503070509000300010107
Content-Type: application/x-shellscript;
 name="stats.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="stats.sh"

IyEvYmluL2Jhc2gKcm0gLVJmIHN0YXRzICYmIG1rZGlyIHN0YXRzICYmIGNkIHN0YXRzCmdp
dCBpbml0CmZvciBpIGluIGNvcGllZCBnaXRtb3ZlZCBtb3ZlZCBnaXRyZW1vdmVkIHJlbW92
ZWQgbW9kaWZpZWQgbW9kaWZpZWRhZGRlZCB0eXBlY2hhbmdlZCB0eXBlY2hhbmdlZGFkZGVk
IHVuY2hhbmdlZApkbwogIGVjaG8gJGkgPiAkaQogIGdpdCBhZGQgJGkKZG9uZQplY2hvIGln
bm9yZWQgPiBpZ25vcmVkCmVjaG8gaWdub3JlZCA+PiAuZ2l0L2luZm8vZXhjbHVkZQpnaXQg
Y29tbWl0IC1tICJmaWxlcyB0byBiZSBjaGFuZ2VkIgoKZWNobyBhZGRlZCA+IGFkZGVkCmdp
dCBhZGQgYWRkZWQKCmNwIGNvcGllZCBjb3BpZWRvbmx5CmNwIGNvcGllZCBjb3BpZWRhZGRl
ZApnaXQgYWRkIGNvcGllZGFkZGVkCgpnaXQgbXYgZ2l0bW92ZWQgZ2l0bW92ZWQyCm12IG1v
dmVkIG1vdmVkMgoKZ2l0IHJtIGdpdHJlbW92ZWQKcm0gcmVtb3ZlZAoKZWNobyBtb2RpZmll
ZCA+PiBtb2RpZmllZAplY2hvIG1vZGlmaWVkYWRkZWQgPj4gbW9kaWZpZWRhZGRlZApnaXQg
YWRkIG1vZGlmaWVkYWRkZWQKCmNobW9kICt4IHR5cGVjaGFuZ2VkIHR5cGVjaGFuZ2VkYWRk
ZWQKZ2l0IGFkZCB0eXBlY2hhbmdlZGFkZGVkCgplY2hvIHVudHJhY2tlZCA+IHVudHJhY2tl
ZAoKZWNobyAiIyMjIGdpdCBzdGF0dXMgIyMjIgpnaXQgc3RhdHVzCmVjaG8gIiMjIyBnaXQg
ZGlmZiAjIyMiCmdpdCBkaWZmIC0tbmFtZS1zdGF0dXMgLU0gLUMgLUMKZWNobyAiIyMjIGdp
dCBkaWZmIEhFQUQgIyMjIgpnaXQgZGlmZiAtLW5hbWUtc3RhdHVzIC1NIC1DIC1DIEhFQUQK
ZWNobyAiIyMjIGdpdCBkaWZmIC0tY2FjaGVkIEhFQUQgIyMjIgpnaXQgZGlmZiAtLW5hbWUt
c3RhdHVzIC1NIC1DIC1DIC0tY2FjaGVkIEhFQUQKZWNobyAiIyMjIGdpdCBscy1maWxlcyIK
Z2l0IGxzLWZpbGVzIC1kIC1tIC1vIC10Cg==
--------------090503070509000300010107--
