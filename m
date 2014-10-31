From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 21:09:00 +0000
Message-ID: <1414789740.30576.BPMail_high_carrier@web172302.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 22:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkJRT-0006AH-97
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 22:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbaJaVJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 17:09:03 -0400
Received: from nm30-vm6.bullet.mail.ir2.yahoo.com ([212.82.97.84]:56900 "EHLO
	nm30-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889AbaJaVJC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 17:09:02 -0400
Received: from [212.82.98.61] by nm30.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:09:00 -0000
Received: from [212.82.98.103] by tm14.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:09:00 -0000
Received: from [127.0.0.1] by omp1040.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:09:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 275425.1953.bm@omp1040.mail.ir2.yahoo.com
Received: (qmail 80147 invoked by uid 60001); 31 Oct 2014 21:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414789740; bh=K9ZN8Tripgy38XPwo347enHpXrVZ8uIffhgPJ6rn9tU=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=UqRQ4Cv8vw18XgFLTgsUacaXtj0L79GDBodjS6TLh6PCevvhT3/fkpr4HWLcbGKLcYrpbUuHNW7HwXKPOrQHasXYP2Muc8oNrBFXj5++9p9mCzdnloIyD7DRLojSUswrmoOO7I+ef8xxdYBgVD3OIPi1f1pvzYl96EeGj8m610k=
X-YMail-OSG: gJe_wt8VM1kEnz8i2t_ebyl8Qa49Akwtc2qu.E0vrLXbD5y
 GzkQ_uuATR0MQYVpnCw1V_3aumohhVL.UesZeRd6th6yo2u78NbNCVbKd9MW
 hMdUIufni5LEiP.oZXB7.uEBzEMUvsLNCF44w3R8PilD9kwAePwioCzHN1V_
 pb357.tPKl4H0rZ7.qO0SOl7Z4HHdBdrib6byVX0gYmcsYJMdJDBb6bSYBHD
 I2Ku4uR_TT662v7t25aMqzi9odRloe28XKyjCkqBJnsU7QCg57Au7pGOU1lV
 EcRO2CA8vQnL_eQspTOuEGmfuy7Js9ibKubWZYXVCmeI4Pz1szunGBNQkkYR
 LaN6vlOi.hD9KxAhmTZydAwGIzCX.lxZgB7m8QoQ5rtWTT6cfIXQfmUHA0dJ
 MNsOXhfLVCtErYqXb_8XfSeep6i3DTWHbQPeDdRRpaNEiB5eUe1qOC4b3_PI
 EwQxv7bIW51hUZUc7_xRyYNnw9tO3827Jh2EthsMephKFd8nk2yGOeleAoQ7
 09f9Ax9SEYt.uK9BJjP9CKkLwcpirT7FqroRMrHCjDcTu6gdM5EaB9i_WLtD
 hoWScAPb7rIRGGjEgVn5QSAHlrMcIVA1RewqpKzZJdsPCpQBv8IEaF8a0JCu
 XP2LF4jWUobq3wJDs2hM699I-
Received: from [86.30.137.134] by web172302.mail.ir2.yahoo.com via HTTP; Fri, 31 Oct 2014 21:09:00 GMT
X-Rocket-MIMEInfo: 002.001,Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBGcmksIE9jdCAzMSwgMjAxNCAxOTowOCBHTVQgRXJpYyBXb25nIHdyb3RlOg0KDQo.RXJpYyBXb25nIDxub3JtYWxwZXJzb25AeWhidC5uZXQ.IHdyb3RlOg0KPj4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZyBmYWlsdXJlIHdpdGggbm9ybWFsICJnZXRfZGlyIiBvbiBuZXdlcg0KPj4gdmVyc2lvbnMgb2YgU1ZOICh0ZXN0ZWQgd2l0aCBTVk4gMS44LjgtMXVidW50dTMuMSk6DQo.PiANCj4.ICAgSW5jb3JyZWN0IHBhcmFtZXRlcnMgZ2l2ZW4BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



------------------------------
On Fri, Oct 31, 2014 19:08 GMT Eric Wong wrote:

>Eric Wong <normalperson@yhbt.net> wrote:
>> This avoids the following failure with normal "get_dir" on newer
>> versions of SVN (tested with SVN 1.8.8-1ubuntu3.1):
>> 
>>   Incorrect parameters given: Could not convert '%ld' into a number
>
>Filed a bug in Debian since I hit it in sid, too:
>http://bugs.debian.org/767530
>
>Thanks all.


Hmm, but why are you filing at debian? I had the error when i applied the dev code patches on top of 2.1.0, and the error disappeared as soon as I reverted the patches. So it looks like a issue for the upstream developers, rather than distro. Are you saying debian is shipping a dev snapshot of git svn?
