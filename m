From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: git config oddity
Date: Tue, 15 Jul 2008 16:44:51 +0200
Message-ID: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIlnA-0002t0-EU
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 16:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbYGOOoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 10:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbYGOOox
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:44:53 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:10643 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbYGOOow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 10:44:52 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1535052rnd.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=EjqZk2W+0NyOPfsK33x3PzDzFVGzsnIJepVAQ+URznw=;
        b=fSpiuW28Rj9nWsb++KKQWqyrnF+UP8/kHK2W0c186YqxFpu0I3qPz9AUiN1QlsTROv
         4Aoq+qP7Gd8Qtfh4TA9aCCrMBJwxDhDdkLVrH/h9xjQw5jOk4VB9auSw11p8462nmFQ5
         MDn7s3nMyDsehncBh1El4/9rCyfULS/Wok918=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bf5YBzu88wi8/MX12/0KvOFD0V5rnIzKlDey2EyZjfMEruVJ2MdPz3whdxPwM/glPy
         gLaJyBMnvikohRSrVCqA5H2d0fwM0rmNz4zEzLPZHw9aMzVqqupIW3EDnUutztVSSbXN
         TXKJ6jimd/ybJeKLeEmidM/tAyK3Tq2PgcXW4=
Received: by 10.142.203.19 with SMTP id a19mr4691625wfg.179.1216133091606;
        Tue, 15 Jul 2008 07:44:51 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 15 Jul 2008 07:44:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88560>

Heya,

I noticed today that when unsetting the last value in a group git
config leaves the empty group header. I was somewhat surprised here,
but I am guessing it has a purpose? Anyway, I also noticed (and this
threw my manual config parser off) that when later on an option is set
to that empty group, a new group is created with the same name. Is
this something I have to deal with in my parser (e.g., should I keep
scanning the file for occurrences of my header and allow for empty
groups, or is this a bug in git config? Either is fine with me, was
just wondering :).

-----------------
sverre@Laptop-Sverre:~/code$ mkdir config-oddity
sverre@Laptop-Sverre:~/code$ cd config-oddity/
sverre@Laptop-Sverre:~/code/config-oddity$ git init
Initialized empty Git repository in /home/sverre/code/config-oddity/.git/
sverre@Laptop-Sverre:~/code/config-oddity$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
sverre@Laptop-Sverre:~/code/config-oddity$ git config foo.bar spam
sverre@Laptop-Sverre:~/code/config-oddity$ cat .git/config # as expected
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[foo]
	bar = spam
sverre@Laptop-Sverre:~/code/config-oddity$ git config --unset foo.bar
sverre@Laptop-Sverre:~/code/config-oddity$ cat .git/config # dubious,
but acceptable
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[foo]
sverre@Laptop-Sverre:~/code/config-oddity$ git config foo.bar eggs
sverre@Laptop-Sverre:~/code/config-oddity$ cat .git/config # errr? two
[foo] headers?
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[foo]
[foo]
	bar = eggs
sverre@Laptop-Sverre:~/code/config-oddity$
-----------------

-- 
Cheers,

Sverre Rabbelier
