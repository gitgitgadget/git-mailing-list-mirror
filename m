From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Some issues working with empty/bare repositories...
Date: Sat, 1 Mar 2008 19:40:39 +0000
Message-ID: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 20:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVXaH-0005OL-Pa
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 20:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbYCATkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 14:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYCATks
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 14:40:48 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:19955 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYCATks (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 14:40:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3079485rvb.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=HUm569M00dSWZJ8bBuwrvqZL9+txixebj6PNzmGiDp4=;
        b=Qx9vFVlt3fwN5VkAyk9crfuKr7u9q4avJUc0B10NXXgWMmAdD9txpiZs4dXj6dGht49s0KgSrvq6kmTpI3ScDvp2P9LAPhuUpBiqPLVD0KE3yWu81+NeW8ZOOowxh5tgEXdKfgAVP0E4eXILFTIukFhQ6TgDyG1MSOlCHiUyXOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LWMCSEipcta+7vra+KjNsobk8a9V2zwLF7a1/i8PWpT3ygqCIYysV1GW3g6SaHbLlkXr/S07ZgFi6SgLRaEQOn5zmdpabb+5InX5hWnO0nPCdWLSqhT4YUiTARYugl6P/iWlzBuJe+1zPpIdFcIBBeL5UyD/KLhPHcHtX2qFfIw=
Received: by 10.141.169.9 with SMTP id w9mr3632176rvo.77.1204400439406;
        Sat, 01 Mar 2008 11:40:39 -0800 (PST)
Received: by 10.141.123.8 with HTTP; Sat, 1 Mar 2008 11:40:39 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75692>

Hi,

Some git operations -- only tried clone and log -- require a
repository to contain at least one commit.

    $ git --version
    git version 1.5.3.1

While this is fine when working with existing projects, it can be
confusing/problematic when setting up a new repository.

Consider the following workflow:

    $ mkdir foo
    $ cd foo
    $ git --bare init

    $ git log
    fatal: bad default revision 'HEAD'

This message is confusing for a newbie. Displaying "no commits" would
make more sense here.

    $ cat HEAD
    ref: refs/heads/master
    $ find refs/heads/master
    find: refs/heads/master: No such file or directory

If the user wants to use the bare repository as the main location of
the project, but make changes to it elsewhere (e.g. when setting up a
superproject for adding submodules to), they might want to do
something like:

    $ git clone foo bar
    Initialized empty Git repository in /home/reece/bar/.git/
    $ ls -a /home/reece
    . .. foo

It appears from the git output (with the inconsistently capitalized
git - see --version output above) that the clone succeeded, but it
does not create bar/.git/, even though it said that it did.

- Reece
