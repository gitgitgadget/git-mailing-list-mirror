From: "Kelvie Wong" <kelvie@ieee.org>
Subject: git-svn rebase issues (the commiter gets changed)
Date: Thu, 22 Nov 2007 08:15:11 -0800
Message-ID: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 17:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvEil-0000sz-Qj
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 17:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXKVQPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbXKVQPP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 11:15:15 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:55452 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbXKVQPN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 11:15:13 -0500
Received: by nz-out-0506.google.com with SMTP id s18so2287965nze
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=tVM4fncrtipyNa0QzyMC36ZCVUq4YZastnU9VX2grQE=;
        b=l2fvE0B9nrhwOAhNDojrdmhW3jKkBAnA/vvWQZJU4aF6SCBIEcarsy1Yaq8pUYivzo2IrrO7lj8m1rIVVAvqhXVxpSrkW+8Vx+YE2M3bdkYDrqU5M+Un6j60Uvpw1J9qnhujtzuXMotKCiNdTb4iI+YyNT5xzkki2MmlBMt04hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=WS4GUiqexaadvVHw7gBAqn3Z9kyn4lI7tk/GA+iiN2/o323h1yHbCnfAETNssBO9PnIh3pa5OxCnEzoDLR8xwArfDHy7kwo+SXi64tR7G64LTZm4+xLekavSvUB06MCUJ3wQ5ev/JOYCl1Tv1nPZwQTTKF/TVcV6ju14lH7kung=
Received: by 10.114.53.1 with SMTP id b1mr348273waa.1195748111485;
        Thu, 22 Nov 2007 08:15:11 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Thu, 22 Nov 2007 08:15:11 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 76726af4ac988c47
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65829>

When using git-svn rebase (I'm not sure if this happens with a regular
rebase as well, I use use git-svn primarily at work), the following
oddity happens:

kelvie@mudd (working) qt $ git-cat-file commit
c27e6207c9078d4225288d55454d6577f0135c16
tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
committer cscrimgeour
<cscrimgeour@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195691944 +0000

Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now

This is also a reapplication of r39657, which got rolled back.

These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
Solution), and thus, it does not build without it.
<kw>
kelvie@mudd (working) qt $ git-cat-file commit
7075991c67c6d409ec2315dfeef6f45dd328485b
tree 13d9ef9cc67f5e6381d7697e5794c0ab5f72c729
parent b9eb187d3029c5f9a816cb8f5473d9b239952d53
author kwong <kwong@e2d93294-a71b-0410-9dca-e2ea525a67c9> 1195596864 +0000
committer Kelvie Wong <Kelvie.Wong@safe.com> 1195747291 +0000

Qt/FME Extensions: QFMEDialog/QFMEWizard -> Windows only, for now

This is also a reapplication of r39657, which got rolled back.

These have dependencies on QWinWidget (which is a part of the MFC/Qt Migration
Solution), and thus, it does not build without it.
<kw>


These are both the exact same commit (the tree, parent, and author are
equivalent).

Sometimes (not always), the committer in a commit changes to be the
committer of the parent (svn) commit.  This only happens to the
commits whose parent is the SVN commit.  In the above example,
cscrimgeour is a SVN user, who obviously could not have changed my
code; the proper commit is the one at the bottom.

Both of these are the first local commit that I have rebased onto SVN.

-- 
Kelvie Wong
