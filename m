From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: git blame -M seems not to work as expected
Date: Wed, 27 Feb 2013 16:45:22 +0100
Message-ID: <6AD84402EDEFAA4D833C4235C5F5CC8D31DA5830@DEFTHW99EF4MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjN7-0002RA-R3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab3B0P4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:56:20 -0500
Received: from gecko.sbs.de ([194.138.37.40]:21031 "EHLO gecko.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab3B0P4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 10:56:19 -0500
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2013 10:56:19 EST
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by gecko.sbs.de (8.13.6/8.13.6) with ESMTP id r1RFjPDG013579
	for <git@vger.kernel.org>; Wed, 27 Feb 2013 16:45:25 +0100
Received: from DEFTHW99ET9MSX.ww902.siemens.net ([157.163.148.60])
	by mail1.sbs.de (8.13.6/8.13.6) with ESMTP id r1RFjPvj029780
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 27 Feb 2013 16:45:25 +0100
Received: from DEFTHW99EF4MSX.ww902.siemens.net ([169.254.1.79]) by
 DEFTHW99ET9MSX.ww902.siemens.net ([157.163.148.60]) with mapi; Wed, 27 Feb
 2013 16:45:25 +0100
Thread-Topic: git blame -M seems not to work as expected 
Thread-Index: Ac4VAXO5mUUUm+WLSPi01E5v5oWsUA==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE, en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217214>

Hi Folks!

I've posed this question already on stackoverflow and on Google Groups - without any (satisfying) answer. So maybe you can help me to understand the behavior of git blame -M.

First I commit the following file(file.cpp):

void func1(){return;}[CR][LF]
int func2(){return 23;}[CR][LF]    

Then I modify it by moving what was in the first line and adding something new instead:

float newFunc(){return 23.0;}[CR][LF]
int func2(){return 23;}[CR][LF]
[CR][LF]
[CR][LF]
void func1(){return;}[CR][LF]
 
The log now looks as follows:

>git log --oneline -2
18c670f modified file.cpp
92b4186 added file.cpp
 
Now I run blame:

git blame -s -w -M file.cpp
18c670fa 1) float newFunc(){return 23.0;}
92b4186d 2) int func2(){return 23;}
18c670fa 3)
18c670fa 4)
18c670fa 5) void func1(){return;}
 
I wonder why the line containing func1() isn't recognized as moved. I've tried to reduce the number of required characters (i.e. -M4 etc.). Furthermore spaces should not matter because of the -w option.

On the other hand, when I move float newFunc(){return 23.0;} from line 1 to line 6 (which was empty before) in the subsequent commit, git blame -M correctly recognizes that it originates from commit 18c670fa even though it firstly appeared in line 6 only in the current commit. 

So what's the reason for this seemingly inconsequent behavior? As far as I understand the documentation, both movements should be recognized. It's very important for us to correctly understand the behavior of git blame -M since we are about to add some code analysis logic on top of git blame. 

Thanks in advance
Konstantin
