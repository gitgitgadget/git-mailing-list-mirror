From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Storing permissions
Date: Sun, 17 Apr 2005 02:22:10 -0400
Message-ID: <42620092.9040402@dwheeler.com>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jackson <pj@sgi.com>, Morten Welinder <mwelinder@gmail.com>,
	mj@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 08:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN35f-0001t2-CH
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 08:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDQGUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDQGUf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 02:20:35 -0400
Received: from cujo.runbox.com ([193.71.199.138]:28801 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261270AbVDQGU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 02:20:27 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DN38m-0002Nb-Pu; Sun, 17 Apr 2005 08:20:20 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DN38i-0000uc-S0; Sun, 17 Apr 2005 08:20:20 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 16 Apr 2005, Paul Jackson wrote:
> 
>>Morten wrote:
>>
>>>It makes some sense in principle, but without storing what they mean
>>>(i.e., group==?) it certainly makes no sense. 
>>
>>There's no "they" there.
>>
>>I think Martin's proposal, to which I agreed, was to store a _single_
>>bit.  If any of the execute permissions of the incoming file are set,
>>then the bit is stored ON, else it is stored OFF.  On 'checkout', if the
>>bit is ON, then the file permission is set mode 0777 (modulo umask),
>>else it is set mode 0666 (modulo umask).
> 
> 
> I think I agree.
> 
> Anybody willing to send me a patch? One issue is that if done the obvious
> way it's an incompatible change, and old tree objects won't be valid any
> more. It might be ok to just change the "compare cache" check to only care
> about a few bits, though: S_IXUSR and S_IFDIR.

There's a minor reason to write out ALL the perm bit data, but
only care about a few bits coming back in: Some people use
SCM systems as a generalized backup system, so you can back up
your system to an arbitrary known state in the past
(e.g., "Change my /etc files to the state I was at
just before I installed that &*#@ program!").
For more on this, see:
  http://www.onlamp.com/pub/a/onlamp/2005/01/06/svn_homedir.html

If you store all the bits, then you CAN restore things
more exactly the way they were.  This is imperfect, since
it doesn't cover more exotic permission
values from SELinux, xattrs, whatever.  For some, that's enough.

Yeah, I know, not the main purpose of git.  But what the heck,
I _like_ flexible infrastructures.

--- David A. Wheeler

