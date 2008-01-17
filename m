From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 19:02:00 +0000
Message-ID: <B4BACE1E-C408-4229-A9AB-FBBAA0200019@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org> <alpine.LFD.
 1.00.0801171042330.14959@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFa0s-00037z-28
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYAQTCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYAQTCG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:02:06 -0500
Received: from mail.sl.pt ([212.55.140.13]:33686 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751861AbYAQTCF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 14:02:05 -0500
Received: (qmail 30436 invoked from network); 17 Jan 2008 19:02:00 -0000
X-Virus-Status: Clean (0.01872 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00010 seconds / 0.29004 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[81.193.151.201])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <mjscod@web.de>; 17 Jan 2008 19:02:00 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 81.193.151.201 as permitted sender)
In-Reply-To: <alpine.LFD.1.00.0801171042330.14959@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70905>

Hi,

On Jan 17, 2008, at 6:44 PM, Linus Torvalds wrote:
> On Thu, 17 Jan 2008, Pedro Melo wrote:
>>
>> On Jan 17, 2008, at 6:09 PM, Mark Junker wrote:
>>
>>> IMHO it would be the best solution when git stores all string =20
>>> meta data in
>>> UTF-8 and converts it to the target systems file system encoding. =20
>>> That would
>>> fix all those problems with different locales and file system =20
>>> encodings ...
>>
>> +1.
>>
>> And I would suggest the use of RFC 3454 as the guidelines for UTF-8
>> normalization.
>
> The problem is that there is no way to know what the "target system
> encoding" is.

Correct. Storing or using a normalized version of the filename is =20
only part of the problem.

The full problem is:

User A <-> filesystem A <-#-> git < ...... > git <-#-> filesystem B <-=20
 > user B.

You have to encode/decode/normalize on all the <-#-> and there is no =20
magic bullet. Each user would have to tell git "Hey I'm using utf-8" =20
or "Hey, I'm a masochist using HFS+".

But I think its important for git to store the filenames in something =20
that at least permits this kind of scenario.

All encoding/decoding/normalization is of course optional, and for =20
git, it still is a sequence of bytes.

> And it wouldn't actually solve the bigger problem on OS X anyway: =20
> as long
> as you are case-insensitive, you'll have all the same problems (ie th=
e
> insane OS X filesystem presumably thinks that "M=C4RCHEN" and =20
> "M=E4rchen" are
> also identical, because they are "equivalent" names).

Correct. HFS+ has bigger problems. I'm not sure if this is enough to =20
solve it.

But it would solve two linux users using different encodings.

And given that the filtering layers are optional, you have to =20
configure them, it wont bite nobody.

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
