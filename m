From: Quin Hoxie <qhoxie@gmail.com>
Subject: Bug with mv + stash?
Date: Tue, 5 May 2009 11:47:22 -0700
Message-ID: <6e699a4d0905051147m5c495d5erdb608203d0aa69be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 20:47:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Pg0-00088u-9r
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 20:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbZEESrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2009 14:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbZEESrY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 14:47:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:50818 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZEESrX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2009 14:47:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so3971310wfd.4
        for <git@vger.kernel.org>; Tue, 05 May 2009 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=7dRMG+N3wb/eJ6yeRrXKARtgrjklEjvzjjmL1zGBN/0=;
        b=OjGZ4BoHMH6tX1bklxTjEDwuS3OEE8Qo/OYfFvlqsKPvcXQJYGLgXMfMwOEDnFOac0
         EUGvpMPMd11gRVjh1ORNa364vjtcgYtdT/kZPfIobtb+HHk6ot6WsljeemQzWwKbKplh
         DKfTI+u4rPeaiRWp5XDKQ2ICuob51w79Hsvho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=G0oZZAFMvktxrJGfL+ZMX12Dfg/uBWfHV76usxT8f607dN6rJ5nVj3kgyWT7a3p/Vs
         vtpsbvjFMw98aYPtPJByx75tVPRkwPQ6v8TtjUgjlcuUPnzg7y1uBw7qKcPttDsDOwDE
         71K+wFFCdQV/BUuBCADWW5dKbn5RgH4pAEDIs=
Received: by 10.142.221.11 with SMTP id t11mr145286wfg.115.1241549242775; Tue, 
	05 May 2009 11:47:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118309>

This may or may not be considered a bug, given the empty file, but I
thought it would be prudent to report it just in case.
When moving/renaming a tracked file, and then creating a new file with
the original name, stash loses/deletes the new file.
Below is the full transaction to reproduce the behavior.

--
Quin Hoxie


[quin@qmbp /tmp] $ mkdir repo
[quin@qmbp /tmp] $ cd repo
[quin@qmbp /tmp/repo] $ git init
Initialized empty Git repository in /private/tmp/repo/.git/
[quin@qmbp /tmp/repo] $ echo "hello world" > foo
[quin@qmbp /tmp/repo] $ git add foo
[quin@qmbp /tmp/repo] $ git commit -m "added foo"
[master (root-commit)]: created 9ed55f1: "added foo"
=A01 files changed, 1 insertions(+), 0 deletions(-)
=A0create mode 100644 foo
[quin@qmbp /tmp/repo] $ git mv foo bar
[quin@qmbp /tmp/repo] $ git status
# On branch master
# Changes to be committed:
#=A0=A0 (use "git reset HEAD <file>..." to unstage)
#
#=A0=A0=A0=A0=A0=A0 renamed:=A0=A0=A0 foo -> bar
#
[quin@qmbp /tmp/repo] $ touch foo
[quin@qmbp /tmp/repo] $ git status
# On branch master
# Changes to be committed:
#=A0=A0 (use "git reset HEAD <file>..." to unstage)
#
#=A0=A0=A0=A0=A0=A0 renamed:=A0=A0=A0 foo -> bar
#
# Untracked files:
#=A0=A0 (use "git add <file>..." to include in what will be committed)
#
#=A0=A0=A0=A0=A0=A0 foo
[quin@qmbp /tmp/repo] $ git stash
Saved working directory and index state "WIP on master: 9ed55f1... adde=
d foo"
HEAD is now at 9ed55f1 added foo
(To restore them type "git stash apply")
[quin@qmbp /tmp/repo] $ git stash apply
# On branch master
# Changes to be committed:
#=A0=A0 (use "git reset HEAD <file>..." to unstage)
#
#=A0=A0=A0=A0=A0=A0 new file:=A0=A0 bar
#
# Changed but not updated:
#=A0=A0 (use "git add/rm <file>..." to update what will be committed)
#=A0=A0 (use "git checkout -- <file>..." to discard changes in working =
directory)
#
#=A0=A0=A0=A0=A0=A0 deleted:=A0=A0=A0 foo
#
[quin@qmbp /tmp/repo] $ ls
bar
[quin@qmbp /tmp/repo] $
