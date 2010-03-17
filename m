From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Make bare repository out of git svn init
Date: Wed, 17 Mar 2010 12:45:49 +0100
Message-ID: <7fce93be1003170445x4a9d240cv2ca37737d6c7a244@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 17 12:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrhE-00046V-6V
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 12:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab0CQLpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 07:45:51 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40981 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab0CQLpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 07:45:50 -0400
Received: by wwe15 with SMTP id 15so661245wwe.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 04:45:49 -0700 (PDT)
Received: by 10.216.157.129 with SMTP id o1mr384063wek.197.1268826349131; Wed, 
	17 Mar 2010 04:45:49 -0700 (PDT)
X-Originating-IP: [193.252.57.189]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142375>

Hi,

Here what I did to make a bare repository out of git svn init.
With this repo I do not intend to push to the svn repo nor to commit
into branches comming from it.
svn trunk will become master and is only fetch, not modified nor
rebased (I did not tried to see if it is working tough).

git svn init svn://<host>/ \
--trunk=<project>/trunk \
--branches=<project>/branches \
--tags=<project>/tags \
project.git

cd project.git
cat .git/config | \
sed s#:refs\/remotes\/trunk#:refs\/heads\/master# | \
sed s#:refs\/remotes\/\\*#:refs\/heads\/*# | \
sed s#:refs\/remotes\/tags\/\\*#:refs\/tags\/*# | \
sed "s#bare = false#bare = true#" > .git/config.tmp
mv .git/config.tmp .git/config
git svn fetch
git svn gc
git gc --aggressive
cp -R .git/* .
rm -rf .git

Then I have a cron which does a git svn fetch on this repo every half an hour.

I am interesting if you see things I forgot to do or some use cases
where those modifications would break anything.

Regards.

-- 
Sylvain
