From: Pavel Roskin <proski@gnu.org>
Subject: Signing by StGIT broken
Date: Wed, 09 Jan 2008 21:53:16 -0500
Message-ID: <1199933596.21499.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 03:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCnYB-0000Qd-1O
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 03:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbYAJCxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2008 21:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbYAJCxT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 21:53:19 -0500
Received: from c60.cesmail.net ([216.154.195.49]:26060 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454AbYAJCxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 21:53:18 -0500
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 09 Jan 2008 21:53:17 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 4AFD4618FE1;
	Wed,  9 Jan 2008 21:53:17 -0500 (EST)
X-Mailer: Evolution 2.12.2 (2.12.2-2.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70034>

Hello!

"stg edit --sign" is not working anymore.  It was working in version
0.14.

$ stg edit --sign
Checking for changes in the working directory ... done
Updating patch "id123" ... Traceback (most recent call last):
  File "/home/proski/bin/stg", line 43, in <module>
    main()
  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 27=
8, in main
  File "home/proski/lib/python2.5/site-packages/stgit/commands/edit.py"=
, line 235, in func
  File "home/proski/lib/python2.5/site-packages/stgit/commands/edit.py"=
, line 93, in __update_patch
  File "home/proski/lib/python2.5/site-packages/stgit/commands/common.p=
y", line 469, in parse_patch
  File "home/proski/lib/python2.5/site-packages/stgit/commands/common.p=
y", line 359, in __split_descr_diff
AttributeError: 'NoneType' object has no attribute 'split'

git-bisect reports this:

a08e424021d32bf93ee7bb13ed0a9d7313367660 is first bad commit
commit a08e424021d32bf93ee7bb13ed0a9d7313367660
Author: Karl Hasselstr=C3=B6m <kha@treskal.com>
Date:   Thu Dec 13 00:13:55 2007 +0100

    Make generic --message/--file/--save-template flags
   =20
    And let "stg edit" use them.
   =20
    Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

:040000 040000 0c9317423123d328e8bf03866c08fa458808dce4 9195692410c3ed8=
171f2f799a8e3efd101a89a14 M      stgit


I suspect this part:

- elif options.file:
- __update_patch(pname, options.file, options)
+ elif any([options.message, options.authname, options.authemail,
+ options.authdate, options.commname, options.commemail,
+ options.sign_str]):
+ out.start('Updating patch "%s"' % pname)
+ __update_patch(pname, options.message, options)
+ out.done()

options.message is passed even if it's None and something else (like
options.sign_str) is defined.

--=20
Regards,
Pavel Roskin
