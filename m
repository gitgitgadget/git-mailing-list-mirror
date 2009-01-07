From: jidanni@jidanni.org
Subject: git rebase orthodontics
Date: Wed, 07 Jan 2009 22:47:43 +0800
Message-ID: <87sknvxje8.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 15:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZmo-0008MP-QV
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 15:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZAGOwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 09:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZAGOwK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 09:52:10 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:40128 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090AbZAGOwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 09:52:09 -0500
Received: from jidanni.org (122-127-41-237.dynamic.hinet.net [122.127.41.237])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 908DEC47CA
	for <git@vger.kernel.org>; Wed,  7 Jan 2009 06:52:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104801>

In today's adventure we follow junior user me as he sets off in his
first bumper car ride on the wrong side of git-rebase, wherein he
discovers there are no guard rails. git version 1.6.0.6.

$ git branch
* jidanni
  master
$ git commit -m bla --allow-empty
$ git rebase --interactive master
(In the editor I change the single pick offered into a squash)
grep: ....git/rebase-merge/done: No such file or directory
Cannot 'squash' without a previous commit
(OK, but the grep error being shown to the user is a bug.)

$ git show --abbrev-commit --pretty=raw jidanni master
commit 07aef4a...
tree 28f9caca33a8294d36b3d42f21ff472c6126da16
parent 3ad166e006afc3ce57a35b6ac650569e557b024a...
commit 3ad166e...
tree 28f9caca33a8294d36b3d42f21ff472c6126da16
parent 726f8d08e2f7642d56a568eb82a685de0da0baf7
$ EDITOR=cat git rebase --interactive master
pick 07aef4a This is a commit with No files, wow. bla.
# Rebase 3ad166e..07aef4a onto 3ad166e ...
Successfully rebased and updated refs/heads/jidanni.
(But it didn't. git show shows no change. ls -l shows
refs/heads/jidanni was not touched.
OK, it seems like all I am doing is changing
              A jidanni
             /
D---E---F---G master
into the same thing, a noop. But shouldn't it warn and quit, instead
of rewarding me with the success message? Let's try it the other way
around:
$ git checkout master
$ git rebase --interactive jidanni #Wherein one sees:
noop
# Rebase 07aef4a..3ad166e onto 07aef4a
Successfully rebased and updated refs/heads/master.
OK, now I have achieved
D---E---F---G---A master, jidanni
Observations:
When I tried a noop, it didn't say noop in the editor.
When I tried a yesop, it did say noop in the editor.
In both cases it gave the same success message.
