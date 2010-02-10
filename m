From: Daniele Segato <daniele.bilug@gmail.com>
Subject: cherry-pick from a branch to another with git-svn automatically 
	stripping git-svn-id from commit message
Date: Wed, 10 Feb 2010 16:44:54 +0100
Message-ID: <9accb4401002100744o73a347e0pe86e706bcd2b04be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 16:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfEkt-0001xn-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 16:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab0BJPo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 10:44:58 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34946 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab0BJPo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 10:44:57 -0500
Received: by bwz19 with SMTP id 19so156189bwz.28
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=LL85vYN0CNU9Rk+d3tQ4MEO5enzOMX4atrF4IO12GTc=;
        b=c7tU0SCagFYIPgvncF18gBqf5fWoEey8hA7NAayXNH0QQUScj25phNFll9NCk2Dsxy
         Vuvubz01L1ru0Jw9c7mDWFIHvC2ZRV/yvYOAOWdeRd3g+hDRlcCEGr66A7QavczITsuD
         DP86D30n8rlmy5QPbnatw9e6BV9HKMg/GNnzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DYWxr1gOkecaXJDpWRLeSLjEPyK4bkVDPj20RSMRdcB7I9yz+dwGBcCHz6utQt/RWA
         nop+HyfOc4+K1RsbcqUghfQFlp+XXTKSrnqaqz6XbiRUL9YXQkz/9Yxw96FDPHv50SYi
         C4AVk5k6CrxjcRM0c8/lWqxuXznx/hSX6Powc=
Received: by 10.204.143.3 with SMTP id s3mr260936bku.144.1265816694963; Wed, 
	10 Feb 2010 07:44:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139512>

Hi,

since git-svn modify the commit message when you dcommit something
(git svn dcommit)
and then use the commit message to decide which is the branch to
dcommit next cherry-pick-ing
(and other commands) has some problem when you work through different
svn branch.

Example, you have 2 remote branch: remote/trunk, remote/v1.x
and you are following them with two branches: trunk and v1.x

now say you want to cherry-pick a commit from trunk into v1.x locally
to dcommit it onto the remote/v1.x branch.

the step you had to do are:
git cherry-pick <your-commit-hash-on-trunk>
git commit --amend # removing the line starting with git-svn-id
# or add the -e option to cherry-pick instead of amending
git svn dcommit


now, if you have to do it frequently it is a bit annoying and you man
do some mistake.

I want to make it automatic and easy to use like:

git cherry-pick-svn <your-commit-hash-on-trunk>
git svn dcommit

with an alias.

on #irc charon suggested me to use !GIT_EDITOR="script that strip the
git-svn-id here" git cherry-pick ...

so I tried this from command line (hash is just a random one):

GIT_EDITOR="sed -i '/^git-svn-id:/d'" git cherry-pick -e 9eb6b7de

it works.

so I opened my ~/.gitconfig and added this alias:

[alias]
	cherry-pick-svn =  !GIT_EDITOR="sed -i '/^git-svn-id:/d'" git cherry-pick -e


but with
$ git cherry-pick-svn 9eb6b7de
I get:
sh: -i: command not found
fatal: Failed to run 'GIT_EDITOR=sed -i -e '/^git-svn-id:/d' git
cherry-pick -e '9eb6b7de...'' when expanding alias 'cherry-pick-svn'


but modifying it with this:
[alias]
	cherry-pick-svn =  !GIT_EDITOR='sed -i /^git-svn-id:/d' git cherry-pick -e

made it working.

I just want to share this with you if someone need it.

And may be ask if you find any problem with this or if you have a
better way to do it

Regards,
Daniele
