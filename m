From: Pascal Obry <pascal@obry.net>
Subject: git-svn changing file:// to svn+ssh://
Date: Mon, 26 Oct 2009 19:49:57 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AE5EF55.2070902@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:49:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Udc-00057J-LY
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 19:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbZJZStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZJZStm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 14:49:42 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:33368 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbZJZStl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 14:49:41 -0400
Received: by ewy3 with SMTP id 3so4008442ewy.41
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 11:49:45 -0700 (PDT)
Received: by 10.210.4.5 with SMTP id 5mr16741557ebd.23.1256582985615;
        Mon, 26 Oct 2009 11:49:45 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-7-243.w82-124.abo.wanadoo.fr [82.124.69.243])
        by mx.google.com with ESMTPS id 28sm3673822eye.7.2009.10.26.11.49.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 11:49:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131261>


I'm working on preparing Git SVN mirrors.

I had tested my procedure on a small project and it was working fine.

On a large project it is failing. Here is what I have done:

I have cloned the repository using:

    $ git svn clone --prefix=svn/ file:///path/repo \
	--revision=15314:HEAD --trunk=trunk/project \
	--tags=tags/project --branches=branches/project \
	--branches="branches/global/*/project" project

Not simple, ok but working :)

Now I have converted the file:// to svn+ssh:// using:

    $ git gc

    $ git filter-branch --msg-filter \
     'sed "s,git-svn-id: file:///path/repo,git-svn-id: 
svn+ssh://server/repo,g"' \
     $(cat .git/packed-refs | awk '// {print $2}' | grep -v 'pack-refs')

    $ rm -fr .git/svn

I have edited .git/config to change the url string too.

Up to there, no problem. But when trying to rebase and reconstruct all 
rev_map files with:

    $ git svn rebase

I get the following lines again and again:

Rebuilding 
.git/svn/svn/trunk/.rev_map.f8352e7e-cb20-0410-8ce7-b5d9e71c585c ...
Done rebuilding 
.git/svn/svn/trunk/.rev_map.f8352e7e-cb20-0410-8ce7-b5d9e71c585c
Rebuilding 
.git/svn/svn/trunk/.rev_map.f8352e7e-cb20-0410-8ce7-b5d9e71c585c ...
Done rebuilding 
.git/svn/svn/trunk/.rev_map.f8352e7e-cb20-0410-8ce7-b5d9e71c585c

...

The file 
.git/svn/svn/trunk/.rev_map.f8352e7e-cb20-0410-8ce7-b5d9e71c585c is in 
fact not created.

What could be wrong?

How should I proceed to debug this?

Any help appreciated.

Last note I've tried all this with Git 1.6.4 and 1.6.5.

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
