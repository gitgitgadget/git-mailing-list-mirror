From: Wincent Colaiuta <win@wincent.com>
Subject: Re: recovering orphaned commit
Date: Tue, 29 Jun 2010 17:29:18 +0200
Message-ID: <A91ACF1D-6773-4EDA-98F5-DD6F993577CB@wincent.com>
References: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdhu-0001ZR-3w
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab0F2Qah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 12:30:37 -0400
Received: from outmail128165.authsmtp.com ([62.13.128.165]:50660 "EHLO
	outmail128165.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755845Ab0F2Qag convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:30:36 -0400
X-Greylist: delayed 3660 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2010 12:30:36 EDT
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o5TFTPhZ022896;
	Tue, 29 Jun 2010 15:29:25 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o5TFTLaM005433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jun 2010 16:29:23 +0100 (BST)
Received: from [192.168.1.6] (192.Red-88-12-12.dynamicIP.rima-tde.net [88.12.12.192])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o5TFTJWN008308
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jun 2010 11:29:21 -0400
In-Reply-To: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-Server-Quench: 18234f8d-8393-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH aBcdDEdVdwdEHAkR AmABWV1eUl4/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEWEeZWBQ ex4eVx1xdEtBeXdx K0dqXHNfCkwuaE5+ S01JFGxSM3oxOmQZ TUBYdgJcdVdJeRgW Ox4dAXkdIzBUOTw1 BQ41MHg2Jy1fISJY TkkGKlcXQFpj
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149915>

El 29/06/2010, a las 17:09, Mahesh Vaidya escribi=F3:

> I have a situation like this; 2 commits.
>=20
> Example -
>=20
> 2899684ed173063354b7fe4f5ec7216e7d953e2c	 <-- HEAD  ( say C1)
> 1ef67de1a0d6e97470a8c827d2989317600532ff                    ( say C2)
>=20
> To see file at C2 ; I have done git reset --hard C2; I could see the =
file.

"git reset --hard" isn't really intended as a tool for inspecting files=
 in other revisions. Didn't the "--hard" switch suggest that you were a=
bout to do something potentially dangerous? (The danger here, as noted =
in the manpage, is that you will lose any uncommitted changes that migh=
t be in the working tree.)

"git show REV:FILE" could be used to inspect the state of FILE as it wa=
s in commit REV.

If you just want to snoop around the tree you could also just checkout =
the revision ("git checkout REV") and when you're done go back to your =
old HEAD ("git checkout master" or whatever branch you were on).

You could also try using "gitk" for general point-and-click snooping ar=
ound over revisions and trees.

> Now want go to C1 ; Ho do I Determine C1  using git command ?

Well, even though you overwrote the old value of HEAD, it is still in t=
he reflog, which you can inspect with "git reflog".

And if you just want to actually put the HEAD back the way it was befor=
e, you could use "git reset" again (ie. "git reset C1"). As the man pag=
e says, the "--hard" switch here will not only update the HEAD, but als=
o update the contents of the working tree to match it.

Cheers,
Wincent
