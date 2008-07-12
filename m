From: Paul Talacko <gnuruandstuff@yahoo.co.uk>
Subject: git-svn and svn properties on upstream
Date: Sat, 12 Jul 2008 19:58:09 +0000 (GMT)
Message-ID: <608871.39190.qm@web27807.mail.ukl.yahoo.com>
Reply-To: gnuruandstuff@yahoo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 22:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHlMB-0000Uc-7J
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 22:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYGLUEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYGLUEw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 16:04:52 -0400
Received: from web27807.mail.ukl.yahoo.com ([217.146.182.12]:34317 "HELO
	web27807.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752229AbYGLUEv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 16:04:51 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jul 2008 16:04:51 EDT
Received: (qmail 39933 invoked by uid 60001); 12 Jul 2008 19:58:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=VwHYrKZZ/ey3T/0Tj5VsRjTVhLQIpgcWClXJQviYbozhPlm7noVxQzB8/ol1CkDg5Tq5KWR+UxbKRG6ukB5PzWfrBKuWNX9yWZm60H/8RvNSKx/ShANC5vI3c/ijtEzebXgpP+NwvHwHC/UL3uswaXjbu9Vqg3vYeMLaxcZwKho=;
Received: from [195.70.154.229] by web27807.mail.ukl.yahoo.com via HTTP; Sat, 12 Jul 2008 19:58:09 GMT
X-Mailer: YahooMailWebService/0.7.199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88263>

Hello,

I know other people have asked how they can set svn properties on files that they are dcommit-ing to an upstream svn repository.

I had just this problem yesterday on a project that is hosted on sourceforge.  I had added some files,  but sourceforge refused the commit because I hadn't added the svn:mime-type and svn:eol-style properties.

I spent some time going through the git-svn source code and I hacked a fix in  &SVN::Git::Editor::A.  It's pretty simple and sorted my problem out quickly.  However, it's a general solution. 

Since then I've been thinking about what could be a general solution. One thing I can think of is this:

* amend SVN::Git::Editor::generate_diffs to add another hash key to amend properties.
* look for ~/.subversion/config or /etc/subversion/config to see whether auto-props are set
* if set, set the properties accordingly in the @mods array of hashes.
* SVN::Git::Editor::A then sets the properties according to the contents of the $mods hash ref, using set_file_prop().

That seems reasonably simple, however, I can already think of some use cases that miss. Notably, if autoprops are unsuitable for the project and properties have to be set for each individual file.  A command line option would seem appropriate, but then we could get very long command lines!

Another way would be to have another git svn command, propset for example, that a user could use at any time. The disadvantage is that this meta-data would have to be stored somewhere; it would be a db of file/path or object keys and svn property values. The A() and M() subroutines would access it when dcommit-ing.  I guess it could be stored under .git/ somewhere.

The projects I'm working on have a svn upstream, so I'd be willing to have a look at some of the options and write some code.

What do people think?  Which of the above ideas would be most appropriate/useful?

Thanks

Paul


      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
