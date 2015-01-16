From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Proper plumbing for porcelain gpg formats on git show?
Date: Fri, 16 Jan 2015 11:57:17 -0500
Organization: PD Inc
Message-ID: <EB979B4B153D49909C78239A333869FB@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:57:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCAD8-0001cq-1G
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 17:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbbAPQ5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 11:57:21 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56369 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbbAPQ5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 11:57:20 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0GGvIeg021131;
	Fri, 16 Jan 2015 11:57:18 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdAxrXxBTS+nAUZWRvi5mPiaB/me2Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262551>

I can't agree that 

COMMITID=ef8df950c8d16dace62e55d18b26617b1268f1bc; \
 git cat-file $COMMITID -p |\
 sed -e '/^ /{H;$!d;}; x;/^gpgsig /!d; s/^gpgsig//;' |\
 cut -c 2- |\
 gpg --list-packets --textmode |\
 sed '/keyid/!d; s/.*keyid \([0-9A-F]\{16\}\).*/\1/I'

is the way to go, when 

COMMITID=ef8df950c8d16dace62e55d18b26617b1268f1bc; \
 git log $COMMITID --pretty=format:%GK -n 1

and

COMMITID=ef8df950c8d16dace62e55d18b26617b1268f1bc; \
 git show $COMMITID --pretty=format:%GK -s

do the same thing.

Is there a way to properly extract the GPG signature object, such that GPG operations may be done on it?

Are the git log formats safe to use in scripts (asking because it was said not to use at http://git.661346.n2.nabble.com/show-pretty-B-without-a-diff-td5852061.html#a5853270)?

If git log with format specifiers is safe to use, would there be interest in accepting a patch for 

%Gs - the raw GPG text from the commit
%Gf - the key fingerprint

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
