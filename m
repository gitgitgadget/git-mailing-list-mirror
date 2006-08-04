From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 18:39:33 +0200
Message-ID: <44D37845.5010009@dawes.za.net>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 18:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G92i9-0000PE-HX
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 18:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWHDQjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 12:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWHDQjm
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 12:39:42 -0400
Received: from sd-green-bigip-61.dreamhost.com ([208.97.132.61]:17577 "EHLO
	spunkymail-a13.dreamhost.com") by vger.kernel.org with ESMTP
	id S1161291AbWHDQjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 12:39:42 -0400
Received: from [192.168.201.66] (dsl-165-3-155.telkomadsl.co.za [165.165.3.155])
	by spunkymail-a13.dreamhost.com (Postfix) with ESMTP id E82ED129ADB;
	Fri,  4 Aug 2006 09:39:39 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Newsgroups: gmane.comp.version-control.git
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24806>

Jon Smirl wrote:
> On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> I'd suggest against it, but you can (and should) just repack often enough
>> that you shouldn't ever have gigabytes of objects "in flight". I'd have
>> expected that with a repack every few ten thousand files, and most files
>> being on the order of a few kB, you'd have been more than ok, but
>> especially if you have large files, you may want to make things "every 
>> <n>
>> bytes" rather than "every <n> files".
> 
> How about forking off a pack-objects and handing it one file name at a
> time over a pipe. When I hand it the next file name I delete the first
> file. Does pack-objects make multiple passes over the files? This
> model would let me hand it all 1M files.
> 

I'd imagine that this would not necessarily save you a lot, if you have 
to write it to disk, and then read it back again. Your only chance here 
is if you stay in the buffer, and avoid actually writing to disk at all.

Of course, using a ramdisk/tmpfs for your object directories might be 
enough to save you. Just use a symlink to tmpfs for the objects 
directory, and leave the pack files on persistent storage.

That doesn't answer your question about how many passes pack-objects 
does. Nicholas Pitre should be able to answer that.

Rogan
