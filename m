From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Mon, 7 Jan 2013 00:37:14 -0500
Organization: PD Inc
Message-ID: <FBDECCA565D94DF9838DD81FE2E2543A@black>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 06:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts5Oz-0002hU-V9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 06:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab3AGFhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 00:37:16 -0500
Received: from projects.pdinc.us ([67.90.184.26]:56186 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750865Ab3AGFhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 00:37:15 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r075argb031249
	for <git@vger.kernel.org>; Mon, 7 Jan 2013 00:36:53 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <50E9F7C2.1000603@gmail.com>
Thread-Index: Ac3sW3rMCask9AKSScSE82TTn10I2QAPTiOQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212879>

> -----Original Message-----
> From: Mark Levedahl
> Sent: Sunday, January 06, 2013 17:17
> 
> On 01/06/2013 02:54 PM, Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Mark Levedahl wrote:
> >>
> >>>                                                           
> However, 
> >>> the newer win32api is provided only for the current 
> cygwin release 
> >>> series, which can be reliably identified by having dll version 
> >>> 1.7.x, while the older frozen releases (dll versions 1.6.x from 
> >>> redhat, 1.5.x open source) still have the older api as no 
> updates are being made for the legacy version(s).
> >> Ah.  That makes sense, thanks.
> >>
> >> (For the future, if we wanted to diagnose an out-of-date 
> win32api and 
> >> print a helpful message, I guess cygcheck would be the command to 
> >> use.)
> > Hmph, so we might see somebody who cares about Cygwin to 
> come up with 
> > a solution based on cygcheck (not on uname) to update this part, 
> > perhaps on top of Peff's "split default settings based on 
> uname into 
> > separate file" patch?
> >
> > If I understood what Mark and Torsten wrote correctly, you 
> will have 
> > the new win32api if you install 1.7.17 (or newer) from 
> scratch, but if 
> > you are on older 1.7.x then you can update the win32api part as a 
> > package update (as opposed to the whole-system upgrade).  A 
> test based 
> > on "uname -r" cannot notice that an older 1.7.x (say 1.7.14) 
> > installation has a newer win32api because the user updated 
> it from the 
> > package (hence the user should not define CYGWIN_V15_WIN32API).
> >
> > Am I on the same page as you guys, or am I still behind?
> >
> > In the meantime, perhaps we would need something like this?
> 
> It's perhaps worth noting how we got into this mess. The 
> problems have their root in
> 
>      adbc0b6b6e57c11ca49779d01f549260a920a97d
> 
> Cygwin's entire goal is a completely POSIX compliant 
> environment running under Windows. The above commit 
> circumvents some of Cygwin's API regarding stat/fstat to make 
> things perhaps a bit faster, and definitely not POSIX 

Ug!

> compliant (The commit message is wrong, the commit definitely 
> breaks POSIX compliance). That code is also what will not 
> compile on different w32api versions. It is curious: the 
> Cygwin  mailing list has been absolutely silent since the 
> w32api change was introduced last summer, this is the only 
> piece of code I am aware of that was broken by the new 
> headers, and of course the purpose of this code is to 

Um, going out on a limb here, but those headers are used internally as "cygwin"
apps are most likely to now know about those headers.

> circumvent the Cygwin API (and by extension, Cygwin project goals).
> 
> So, perhaps a better path forward is to disable / remove the 
> above code by default. (Those wanting a native Win32 git 
> should just use the native
> Win32 git).

Or a make option...



--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
