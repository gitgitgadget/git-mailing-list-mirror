From: Benjamin Pabst <benjamin.pabst85@gmail.com>
Subject: Fwd: Error with git-svn pushing a rename
Date: Thu, 14 Nov 2013 16:26:11 +0100
Message-ID: <CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>
	<CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 16:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgyoM-0005ID-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 16:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab3KNP0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 10:26:15 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:33628 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab3KNP0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 10:26:12 -0500
Received: by mail-qa0-f48.google.com with SMTP id w8so1444343qac.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 07:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=YAjgYNJiZH4zbiJhbjLNWYt7tVAR+dovHFt0a4iSKqQ=;
        b=LQR900QTktHS4u7lte+pVgJJvQ6PhSucHXdH8qemW1Rn7EzxS/0/r+KURZOLN/uDwf
         DaU7Fo5pXrJibn9PJPs3V2jqj2tDPvHy6FSL7cVp/4HDCugxwK3wu1aWKti2+fbleR2g
         XbU5Ru186OhZc8y1sO1aM4GpGmPehs5i6PilFNrHQa0eoT/UVTbHhuQtbnx/RvF2RFco
         qaxQDMFT17SMxIAV/WmOwxvcwovBQt5wQbdoKTgM1eybwlrH3l8MUr3uwECKj/OgOZPK
         mEz06h1Rih18MP730S6zCD95E4ZBePbMqygQlcuiYJcWm6c3T18D2n8nbu2xBtLXGF7M
         nEZg==
X-Received: by 10.224.92.81 with SMTP id q17mr3171272qam.51.1384442771683;
 Thu, 14 Nov 2013 07:26:11 -0800 (PST)
Received: by 10.140.84.104 with HTTP; Thu, 14 Nov 2013 07:26:11 -0800 (PST)
In-Reply-To: <CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237854>

Hi guys,

I'm using git as a subversion client, which works great so far. But
today I tried to push back a rename to the subversion server, which
resulted in the following error:

perl: subversion/libsvn_subr/dirent_uri.c:2489:
svn_fspath__skip_ancestor: Assertion
`svn_fspath__is_canonical(child_fspath)' failed.
error: git-svn died of signal 6

After searching the web I found a similar problem at stackoverflow:
http://stackoverflow.com/questions/17693255/git-svn-dcommit-fails-because-of-assertion-error-svn-fspath-is-canonicalchildj

So I tried to downgrade subversion (1.7.x) which didn't help. Then I
also tried to downgrade git (1.7.x) which resulted in a different
error:
'tempfile' can't be called as a method at
/usr/share/perl5/vendor_perl/Git.pm line 1042.

So I updated both packages to the current version:
$ git --version
git version 1.8.4.2

$ svn --version
svn, version 1.8.3 (r1516576)
   compiled Sep 13 2013, 00:34:15 on x86_64-unknown-linux-gnu

Copyright (C) 2013 The Apache Software Foundation.
This software consists of contributions made by many people;
see the NOTICE file for more information.
Subversion is open source software, see http://subversion.apache.org/

The following repository access (RA) modules are available:

* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - using serf 1.3.1
  - handles 'http' scheme
  - handles 'https' scheme

But now I'm back at the first error. Just for completeness, the error
occurs on the following operation:
$ git svn dcommit
Committing to https://xxxxx ...
R xxxx/xxxx/SomeFile => xxxx/xxxx/SomeOtherFile
perl: subversion/libsvn_subr/dirent_uri.c:2489:
svn_fspath__skip_ancestor: Assertion
`svn_fspath__is_canonical(child_fspath)' failed.
error: git-svn died of signal 6

Any ideas on handling this error?

Sorry for the (wrongly sent) first mail (incomplete).

Would be happy to hear from you.

Greetings
Ben
