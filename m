From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects
Date: Mon, 29 Aug 2005 01:41:27 -0600
Message-ID: <4312BC27.9010604@tuxrocks.com>
References: <43102727.2050206@tuxrocks.com> <7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 09:45:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9eGz-0005BO-Cd
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 09:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVH2Hli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 03:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVH2Hli
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 03:41:38 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:14853 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751221AbVH2Hlh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 03:41:37 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j7T7fRJA004519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Aug 2005 01:41:29 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7893>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Frank Sorenson <frank@tuxrocks.com> writes:
> 
>>This patch adds an option to git-repack-script to repack all objects,
>>including both packed and unpacked.  This allows a full repack of
>>a git archive (current cogito packs from 39MB to 4.5MB, and git packs
>>from 4.4MB to 3.8MB).
>>
>>Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
> 
> 
> While I agree that giving more flexibility to repack objects is
> a good idea, I am not sure rolling all existing objects into one
> pack and removing the existing one is a good way to go.

It reduces the disk space requirement significantly (linux packs from
135MB to 73MB), and I'm seeing speed improvements as well (probably
because cache-cold operation requires far less seeking, and the caching
requirements are smaller).

What are the benefits to keeping old packs?

> I'd do this slightly differently.  I do not think removing
> existing pack belongs to this command.  We would probably want a
> separate tool to find extra/redundant packs and remove them, or
> more generally optimize packs by selectively exploding them and
> repacking them ("pack optimizer").

I disagree about not removing old packs.  When you "repack" your
suitcase, you take everything out and put it back in again, so a command
named "repack" should remove all existing objects, and put them back again.

Okay, so the pack algorithm could be better, but that only means that
repacking the entire set of objects would improve things more, making
some sort of "git-repack-all" an even more valuable operation.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDErwnaI0dwg4A47wRAkVGAKDqDjQ5IBTO+DC/nKpYl+69w7RESgCg6omQ
xwbQqnXJnfxITC1TAjRtLSk=
=tCyP
-----END PGP SIGNATURE-----
