From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: Understanding behavior of git blame -M
Date: Fri, 15 Aug 2014 13:40:09 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 15:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIHx4-0006oi-EB
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 15:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaHONxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 09:53:45 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:57654 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbaHONxo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 09:53:44 -0400
X-Greylist: delayed 811 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Aug 2014 09:53:43 EDT
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.14.3/8.14.3) with ESMTP id s7FDeBlv025212
	for <git@vger.kernel.org>; Fri, 15 Aug 2014 15:40:11 +0200
Received: from DEFTHW99ERGMSX.ww902.siemens.net (defthw99ergmsx.ww902.siemens.net [139.22.70.132])
	by mail1.sbs.de (8.14.3/8.14.3) with ESMTP id s7FDeBA5027875
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Aug 2014 15:40:11 +0200
Received: from DEFTHW99ERCMSX.ww902.siemens.net (139.22.70.70) by
 DEFTHW99ERGMSX.ww902.siemens.net (139.22.70.132) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 15 Aug 2014 15:40:10 +0200
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.177]) by
 DEFTHW99ERCMSX.ww902.siemens.net ([139.22.70.70]) with mapi id
 14.03.0195.001; Fri, 15 Aug 2014 15:40:10 +0200
Thread-Topic: Understanding behavior of git blame -M
Thread-Index: Ac+4jUNF6aAz44SIRIyypexOO2EquAAAPv+A
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255289>

Hi Folks,

I'm trying to understand the behavior of git blame -M and find that the actual results differ from what I understood from the documentation. I've already asked longer time ago on stackoverflow and on the user mailing list without any satisfactory results. So here is the example:

Initial content of file.txt (2cd9f7f)

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

Move line B to the middle (d4bbd97e):

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

>git blame -s -n -f -w -M20 file.txt
^2cd9f7f 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
^2cd9f7f 3 2) CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
^2cd9f7f 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
d4bbd97e 4 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
^2cd9f7f 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
^2cd9f7f 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
^2cd9f7f 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

I wonder, why line B is not recognized as moved. According to the documentation, I would expect git blame to report that it originates from line 2 in revision 2cd9f7f. Can anybody explain the behavior?

Thanks in advance
Konstantin
