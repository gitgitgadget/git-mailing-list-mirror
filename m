From: Marin Atanasov <dnaeon@gmail.com>
Subject: Git and cvsimport
Date: Mon, 26 Apr 2010 17:27:20 +0300
Message-ID: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 16:27:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6PHZ-0006H4-KD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 16:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab0DZO1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 10:27:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36785 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0DZO1W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 10:27:22 -0400
Received: by wyg36 with SMTP id 36so1274754wyg.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=hT2Rmd6RQevRyZmm3CmF0gi5M4j9QvnAMLuUbG6MNWA=;
        b=LrJ0u7tPQUZah3pIRamb7WxBqAOLPb+tZjKq02CAPzwmh53gk1tMRcA4lPAlwnzf/t
         vc5Jiq0wg/vn2OXMqKFyxfnx1SsdGfsdKa9ARErvUAmYmrPgo9aWw8X16zwqM6ln6Gor
         xkhesKkd4GOq6KBA0RTC2jkdwYNBApA6P7tis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=wuu/HCdPtLN42LcbJPw3Cq/176mQ73hTigR5teQu+AQqYxxWrf6D7+IX5MfuElzufi
         bCuTE1ezDJkXN6rhJ2SgLaIqBL5aG1ScCpyxTMVF8MVCX9iDJbuVTj7uF3bQjWIc7UoN
         PQsNCwLHJOY67/EX6lG3Vg9o5gnozaSUxwPVA=
Received: by 10.216.88.4 with SMTP id z4mr5733495wee.121.1272292040428; Mon, 
	26 Apr 2010 07:27:20 -0700 (PDT)
Received: by 10.216.19.10 with HTTP; Mon, 26 Apr 2010 07:27:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145820>

Hello,

I need to import an existing CVS repo to Git. Using git-cvsimport
works well for me when importing from the CVS server itself, but I
need to do something different.

Here's a little info about what I'm doing.

$ pwd
/home/<user>/test

$ git --version
git version 1.5.6.5

$ git cvsimport -v -d :pserver:<user>@<server>:/var/
cvsroot -C test.git test-repo
Initialized empty Git repository in /home/<user>/test/test.git/.git/
Running cvsps...
connect error: Network is unreachable
cvs rlog: Logging test-repo
=46etching file1=A0=A0 v 1.1
New file1: 14 bytes
=46etching file2=A0=A0 v 1.1
New file2: 14 bytes
=46etching file3=A0=A0 v 1.1
New file3: 14 bytes
Tree ID bf675ce25c8ca3fd1f4a120ea933510c90ccda16
Parent ID (empty)
Committed patch 1 (origin +0000 2010-04-26 09:40:58)
Commit ID 377641eae81975e214a579da9e6c0c5afd819b17
Created tag 'SOMETAG' on 'origin'
=46etching file1=A0=A0 v 1.2
Update file1: 47 bytes
=46etching file3=A0=A0 v 1.2
Update file3: 47 bytes
Tree ID 10ab70cdcc53bb94684d09e60817bb62cb8c3d98
Parent ID 377641eae81975e214a579da9e6c0c5afd819b17
Committed patch 2 (origin +0000 2010-04-26 09:44:22)
Commit ID fea2a99c906e57df5c4735ba3f9627cbb8fba295
DONE; creating master branch

The above commands works fine, when I directly get the files from the
CVS server, but I want to do the following.

=A0- checkout files from CVS, which are already tagged with certain
names to a local folder
=A0- then import those files to Git with git-cvsimport
=A0- fetch those imports later by a shared bare repo into different
branches, so at the end each branch will contain the files with the
certain tag.

So, If i do the following, then git-cvsimport fails:

$ pwd
/home/<user>/test

$ cvs -d :pserver:<user>@<server>:/var/cvsroot co -r SOMETAG test-repo
cvs checkout: Updating test-repo
U test-repo/file1
U test-repo/file2
U test-repo/file3

$ git cvsimport -v -d /home/<user>/test -C test.git test-repo
Expected Valid-requests from server, but got: E Cannot access
/home/<user>/test/CVSROOT

Can you give me some hints how to do this? Seems that I can import CVS
repos from remote server, but cannot do this from a local folder..

Thanks and regards,
Marin

--
Marin Atanasov Nikolov
dnaeon AT gmail DOT com
daemon AT unix-heaven DOT org
