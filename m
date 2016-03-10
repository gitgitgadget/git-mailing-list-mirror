From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Problem with git-http-backend.exe as iis cgi
Date: Thu, 10 Mar 2016 07:28:50 +0000
Message-ID: <F0F5A56A22F20D4CB4A03BB8D6658797E260E0E3@SERVER2011.CS-SOFTWARE.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:28:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adv1i-0007E4-5v
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 08:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbcCJH2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 02:28:48 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:44401 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbcCJH2r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 02:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1457594924; l=1200;
	s=domk; d=cs-software-gmbh.de;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	Content-Language:Date:Subject:To:From;
	bh=g/GqcsVNRRHBYjfhDC+ktbpqCqjOAIgQFsx3PdYipfo=;
	b=NMkyc+c6O3QZ3+p9kEt8nApr4G4oJxgKOAiMzRaRvscdwaLeXDWjIfj5cfuW2zrxHn7
	hEZbagPCOPLRKWxFOflB8+GEMRuJTCt8b8vKDP00aXDcvvho80QYT4b8Ji/pvQLUWRXRr
	GtSqq9sBgnMgMhGMYdqx1KITWPZiGuFWEKw=
X-RZG-AUTH: :LWABbUmIevNaG8tCOliF7QMkyOk5UulSewxf/wy7hQxPYOHO9hm9iyo=
X-RZG-CLASS-ID: mo00
Received: from remote.CS-SOFTWARE.local (business-213-023-161-242.static.arcor-ip.net [213.23.161.242])
	by post.strato.de (RZmta 37.21 AUTH)
	with ESMTPA id Y03c0as2A7Sico2
	for <git@vger.kernel.org>;
	Thu, 10 Mar 2016 08:28:44 +0100 (CET)
Received: from SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565]) by
 SERVER2011.CS-SOFTWARE.local ([fe80::5168:c363:4af8:7565%11]) with mapi id
 14.01.0438.000; Thu, 10 Mar 2016 08:28:51 +0100
Thread-Topic: Problem with git-http-backend.exe as iis cgi
Thread-Index: AdF6EInS/Y9CWnY1SWul92/hV1n+2Q==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.1.154]
x-pmwin-version: 3.1.2.0, Antivirus-Engine: 3.63.0, Antivirus-Data: 5.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288598>

Moin,
I tried to setup git-http-backend with iis, as iis provides proper impe=
rsonation for cgi under windows, which leads to have the filesystem acc=
ess performed with the logon user, therefore the webserver doesn't need=
 generic access to the files.
I stumbled across a problem, ending up with post requests hanging forev=
er.
After some investigation I managed to get it work by wrapping the http-=
backend into a bash script, giving a lot of control about the environme=
ntal things, I was unable to solve within IIS configuration.
The workaround, I use currently, is to use "/bin/head -c ${CONTENT_LENG=
TH} | ./git-http-backend.exe", which directly shows the issue.
Git http-backend should check if CONTENT_LENGTH is set to something rea=
sonable (e.g. >0) and should in this case read only CONTENT_LENGTH byte=
s from stdin, instead of reading till EOF what I suspect it is doing cu=
rrently.

Mit freundlichen Gr=FC=DFen / With kind regards
=46lorian Manschwetus

CS Software Concepts and Solutions GmbH
Gesch=E4ftsf=FChrer / Managing director: Dr. Werner Alexi=20
Amtsgericht Wiesbaden HRB 10004 (Commercial registry)
Schiersteiner Stra=DFe 31
D-65187 Wiesbaden
Germany
