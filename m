From: "Blum, Robert" <rblum@pandemicstudios.com>
Subject: RE: git-p4, msysgit, and strange behavior
Date: Thu, 31 Jul 2008 12:03:53 -0700
Message-ID: <8778C923356C6541B263428246AE9C2A4FE2966AB2@NA-MAIL-2-2.rws.ad.ea.com>
References: <20080731183641.GB31085@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdUV-0005m5-8i
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbYGaTFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755500AbYGaTFt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:05:49 -0400
Received: from smtp-na3.ea.com ([159.153.6.7]:56913 "EHLO smtp-na3.ea.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747AbYGaTFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 15:05:48 -0400
Received: from EAHQ-BH5.rws.ad.ea.com (eahq-bh5.rws.ad.ea.com [10.30.204.14])
	by smtp-na3.ea.com (Switch-3.3.0/Switch-3.3.0) with ESMTP id m6VJ3x1u008428;
	Thu, 31 Jul 2008 12:04:00 -0700
Received: from na-casht3.rws.ad.ea.com ([10.30.128.50]) by EAHQ-BH5.rws.ad.ea.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 31 Jul 2008 12:03:55 -0700
Received: from NA-MAIL-2-2.rws.ad.ea.com ([10.30.204.156]) by
 na-casht3.rws.ad.ea.com ([192.168.37.21]) with mapi; Thu, 31 Jul 2008
 12:03:55 -0700
Thread-Topic: git-p4, msysgit, and strange behavior
Thread-Index: AcjzPGnjrfM048EcQJm1YaRBa7bBjQAADYkg
In-Reply-To: <20080731183641.GB31085@cuci.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 31 Jul 2008 19:03:55.0392 (UTC) FILETIME=[2DEB7000:01C8F340]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90967>

Hi Stephen!

> greetings from RWTH-Aachen ;-).

Heh - wonder who else from back then is lingering on those lists ;)

>Checked the environment?  I vaguely recall that p4 has some "magical
dependencies" there.

Yes, did that - 'p4 set' prints all relevant environment vars, and they seem to be set correctly.

You set me off on a slightly longer search, though. And indeed, here's the answer to the mystery (for the benefit of google/later readers).

Git-bash sets $PWD to your current working directory, and that variable is not affected by python's os.chdir(). (Neither in 2.5 nor 2.4, at least)

P4, for strange reasons, decides that that takes precedence over the actual working directory.

Well, actually not that strange. If p4 is using libiberty, they're using a version of getpwd that assumes that PWD is always up to date and no chdirs occur between calls to getpwd. I'm sure there was a good reason for that, but I really can't think why anybody would want to implement getpwd that way...


I'll create a patch for git-p4, but it's really up to P4 to actually *fix* that mess...

 - Robert
