From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 9 Sep 2011 08:52:21 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87ehzpvn56.fsf@lifelogs.com>
References: <87lityxbg7.fsf@lifelogs.com>
	<CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
	<4E6A165D.5010703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aneesh Bhasin <contact.aneesh@gmail.com>, <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21VR-0003eo-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab1IINw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:52:28 -0400
Received: from cer-mailmxol2.jumptrading.com ([208.78.214.25]:49605 "EHLO
	cer-mailmxol2.jumptrading.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab1IINw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 09:52:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtcGAPAYak7AqF0N/2dsb2JhbABBoVEDhzOBUgEBBXkQCw0UJQ8BBEkOBYd6t3mGbgSHbZBpFowE
Received: from unknown (HELO chiexchange02.w2k.jumptrading.com) ([192.168.93.13])
  by cer-mailmxol2.jumptrading.com with ESMTP; 09 Sep 2011 13:52:27 +0000
Received: from internalsmtp.w2k.jumptrading.com (10.2.4.29) by
 chiexchange02.w2k.jumptrading.com (10.2.4.71) with Microsoft SMTP Server id
 8.2.176.0; Fri, 9 Sep 2011 08:52:26 -0500
Received: from tzlatanov-ubuntu-desktop.jumptrading.com ([10.2.14.81]) by
 internalsmtp.w2k.jumptrading.com with Microsoft SMTPSVC(6.0.3790.1830);	 Fri,
 9 Sep 2011 08:52:26 -0500
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
Gmane-Reply-To-List: yes
In-Reply-To: <4E6A165D.5010703@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 09 Sep 2011 15:36:29 +0200")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
X-OriginalArrivalTime: 09 Sep 2011 13:52:26.0513 (UTC) FILETIME=[B5551010:01CC6EF7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181067>

On Fri, 09 Sep 2011 15:36:29 +0200 Michael J Gruber <git@drmicha.warpmail.net> wrote: 

MJG> Aneesh Bhasin venit, vidit, dixit 09.09.2011 12:50:
>> Hi Ted,
>> 
>> 
>> 2011/9/9 Ted Zlatanov <tzz@lifelogs.com>
>>> 
>>> I need to store some encrypted files in Git but for some clients with
>>> the right GPG keys, decrypt them on checkout (possibly also encrypt them
>>> back on commit, but that's not as important).
>>> 
>>> diff doesn't have to work, this is just for convenience.  Can Git do
>>> this (matching only .gpg files) or do I need my own command to run after
>>> the checkout/fetch and before commit?  It seems pretty out of Git's
>>> scope but perhaps others have done this before.
>>> 
>> 
>> Have you looked at git hooks (e.g. here : http://progit.org/book/ch7-3.html).
>> 
>> You could do the encryption/decryption in pre-commit and post-checkout
>> hooks scripts respectively...

MJG> I'd recommend textconv for diffing and clean/smudge for plaintext
MJG> checkout. That is, there are two convenient versions:

MJG> A) Keep blobs and checkout encrypted
MJG> - Use an editor which can encrypt/decrypt on the fly (e.g. vim)
MJG> - Use "*.gpg diff=gpg" in your attributes and
MJG> [diff "gpg"]
MJG>         textconv = gpg -d
MJG>   in your config to have cleartext diffs. Use cachetextconv with caution ;)

MJG> B) Keep blobs encrypted, checkout decrypted
MJG> - Use Use "*.gpg filter=gpg" in your attributes and
MJG> [filter "gpg"]
MJG> 	smudge = gpg -d
MJG> 	clean = gpg -e -r yourgpgkey
MJG>   in your config.

MJG> I use A on a regular basis. B is untested (but patterned after a similar
MJG> gzip filter I use). You may or may not have better results with "gpg -ea".

MJG> On clients without the keys, you can simply leave out the diff or filter
MJG> config resp. set them to "cat".

That's really helpful, thank you Aneesh and Michael.  Exactly what I was
hoping to achieve.

Ted
