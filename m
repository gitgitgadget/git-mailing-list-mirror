From: Alfredo Palhares <masterkorp@masterkorp.net>
Subject: Strange behauviour on Cherry-Pick
Date: Fri, 09 Mar 2012 15:11:54 +0100
Message-ID: <1331296972-sup-5028@masterkorp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 15:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S60iU-0003OW-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 15:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab2CIOWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 09:22:38 -0500
Received: from static.34.107.46.78.clients.your-server.de ([78.46.107.34]:33706
	"EHLO boobierack.masterkorp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760Ab2CIOWh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 09:22:37 -0500
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2012 09:22:37 EST
Received: by boobierack.masterkorp.net (Postfix, from userid 1000)
	id 922FFF06FEC; Fri,  9 Mar 2012 15:11:54 +0100 (CET)
User-Agent: Sup/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192720>

Hello, 

I have a repository[1] with my home files that i keep track off on my machines. 
Until now ive been having everything in the same branch across all the computers, 
but now i have a machine that requires diferences on some files.

So what i did i branched out and keep control the commits i want to the other branch
trough cherry-picking.

So there's how i did it.

  Create the new branch
  $ git checkout -b boobierack 
  Start by removing files i dont need in this machine (one of the reasons  i will not merge this branch)
  $ git rm files
  $ git commit -m "remove files"
  Now editing things i only need here
  $ vim file
  $ git commit -m "Edit file to feature X work in this machine"
  Now i have some sweet weechat configs in this machine i want to committ
  $ git add .weecchat/conffiles
  $ git commit -m "Add swet weechat configs"
  I also added tmux
  ...
  Now i added some sup config files i only need in this branch
  $ git add .sup/whateves
  $ git commit -m "Add sup configs"
  Push branch up
  $ git push origin boobierack

On another computer:
  I wanted that tmux config but i didn't want to merge the branch, so i cherry picked the commit 
  (Maybe this is not the best way to this use case, if so i am open to sugestions, but keep reading
  because i want to know why this is happening ) 
  Since cherry pick gets the diff introduced by that commit, i think using it woulbe nice.
  $ git pull origin
  On branch master
  $ git cherry-pick refspectotmuxcommit
  Maybe those weechat config would be handy in another computers
  $ git cherry-pick refscectoweechatconfigs
  Pushed the commits
  $ git push origin
  Everything seemed ok both on master[2] and boobierack[3] branches

Back to the boobierack machine:
  Pull the commits before adding more stuff
  $ git pull origin 
  remote: Counting objects: 20, done.
  remote: Compressing objects: 100% (13/13), done.
  remote: Total 18 (delta 2), reused 18 (delta 2)
  Unpacking objects: 100% (18/18), done.
  From github.com:masterkorp/Home-files
   * branch            HEAD       -> FETCH_HEAD
   Merge made by recursive.

  I got like... OK ? 
  On branh boobierack
  $ git log --pretty=format:'''%h : %s''' --date-order --graph -n 6
  *   4d7b2e8 : Merge github.com:masterkorp/Home-files into boobierack
  |\  
  | * 9937a0a : Fancier tmux
  * | 811355b : Add sup config files
  * | 9de92a2 : Fancier tmux
  | * aac85ac : Add weechat config files
  * | 90a6162 : Add weechat config files

  And master branch was untouched, i read on recursive merging on man page, but 
  i can't even understand why is git using that method in the first place, since 
  the hashes are diferent and git doesn't care about the diff when fetching iirc.

  Any help would be deeply apreciated.

[1] https://github.com/masterkorp/Home-files
[2] https://github.com/masterkorp/Home-files/commits/master
[3] https://github.com/masterkorp/Home-files/commits/boobierack

--
Regards, 
Alfredo Palhares
