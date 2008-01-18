From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 11:19:21 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
 <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com>
 <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
 <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
 <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
 <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
 <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Junker <mjscod@web.de>, Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:20:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoKw-00042d-NG
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243AbYARKTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 05:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759054AbYARKTb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:19:31 -0500
Received: from ds9.cixit.se ([193.15.169.228]:34662 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbYARKTa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:19:30 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IAJLZZ020055
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Jan 2008 11:19:21 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IAJL1U020050;
	Fri, 18 Jan 2008 11:19:21 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 18 Jan 2008 11:19:21 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70990>

Linus Torvalds:

> But that's exactly the case he gave - '=E4' vs 'a=A8' are exactly tha=
t:=20
> different strings (not even characters: the second is actually a=20
> multi-character) that just look the same.

But they are not different strings, they are canonically equivalent as
far as Unicode is concerned. They're even supposed to map to the same
glyph (if the font has an "=E4", it should display it in both cases, if
it has an "a" and a combining diaeresis, it should make up one).

You cannot do a binary comparison of text to see if two strings are
equivalent.

> You try to twist the argument by just claiming that they are the same
> "character". They aren't, unless you *define* character to be the
> same as "glyph".

Whereas you are confusing characters and code points.

"=E4" and "a=A8" use different code points, but they encode the same
character, and from the user's perspective it is the *character* that
is interesting (although he might confuse it with the glyph).


> I don't know how NTFS works (I know it is Unicode-aware, and I think
> it encodes filenames in UCS-2 or possibly UTF-16,

Actually, NTFS is a bit broken. It sees file names as a string of
16-bit words. It doesn't check that it is valid UTF-16, or even valid
UCS-2, it allows almost anything.


Apple made Mac OS X handle filenames properly, by seeing that file
names are a string of characters, not code points, so they use a
canonical form for all characters (personally, I would have preferred
the pre-composed form, though).

--=20
\\// Peter - http://www.softwolves.pp.se/
