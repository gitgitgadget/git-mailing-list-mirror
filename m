From: Pascal Obry <pascal@obry.net>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 16:21:07 +0100
Organization: Home - http://www.obry.net
Message-ID: <4ECBBDE3.3010904@obry.net>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com> <4ECB8917.8010305@ira.uka.de> <4ECBAFB7.9040505@obry.net> <4ECBBAD4.6080206@ira.uka.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 22 16:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSs9t-0001K5-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 16:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab1KVPVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 10:21:13 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57568 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1KVPVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 10:21:12 -0500
Received: by vcbfk1 with SMTP id fk1so314477vcb.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 07:21:12 -0800 (PST)
Received: by 10.204.50.88 with SMTP id y24mr19558152bkf.53.1321975270813;
        Tue, 22 Nov 2011 07:21:10 -0800 (PST)
Received: from [192.168.0.100] (AVelizy-154-1-55-184.w83-199.abo.wanadoo.fr. [83.199.37.184])
        by mx.google.com with ESMTPS id x14sm10345997bkf.10.2011.11.22.07.21.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 07:21:09 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4ECBBAD4.6080206@ira.uka.de>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185797>


Holger,

> You should also remove src2 and all files in it from the git repository.
> Something like
> 
> git rm -r src2
> git ci
> echo 'src2' >> .git/info/exclude
> 
> instead of
> 
> rm -fr src2
> echo 'src2/*' >> .git/info/exclude

Thanks this is working indeed. But it was not the whole story :)

In fact I want to do that in a branch (say work) and keep master as-is
as this branch is used to pull changes from origin. And in this case,
doing 'git diff master' still shows the files under src2. See script to
reproduce:

<<
#!/bin/sh

# create sd (directory that will replace src2)
mkdir sd
echo sd1 > sd/file1
echo sd2 > sd/file2

# create Git repo
mkdir repo
cd repo
git init
mkdir src1
mkdir src2
echo file > src1/file
echo 3 > src2/file3
git add .
git ci -a -m "first"

# let's replace src2 by sd in branch work

git checkout -b work
git rm src2/*
git ci -m "no more src2"
# ln -s ../sd src2
cp -r ../sd src2

# make sure src2 is excluded

echo 'src2' >> .git/info/exclude

# the following output should be clean

echo '============== Status'
git status

echo '============== Diff'
git diff

echo '============== Diff master'
git diff master
>>

Is that possible?

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
