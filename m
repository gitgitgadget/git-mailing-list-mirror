From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 03 Jul 2009 08:14:46 +0200
Message-ID: <4A4DA1D6.40301@viscovery.net>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>	 <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain> <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 08:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMc3L-00014x-2l
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 08:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbZGCGOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 02:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbZGCGOu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 02:14:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37879 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbZGCGOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 02:14:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MMc2o-0001CY-Rz; Fri, 03 Jul 2009 08:14:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 92C576B7; Fri,  3 Jul 2009 08:14:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122683>

Sitaram Chamarty schrieb:
> On Fri, Jul 3, 2009 at 2:28 AM, Linus
> Torvalds<torvalds@linux-foundation.org> wrote:
>> Btw, I think we fixed the problem we had with CIFS. That one was a cifs
>> filesystem problem on Linux, but it should be fixed in 2.6.30+ (commit
>> 0f4d634c: "cifs: flush data on any setattr"). If you have an older kernel
>> (or are just uncertain), you can also work around it with
>>
>>        [core]
>>                fsyncobjectfiles = true
>>
>> which may be a good thing in general (regardless of any cifs issues), but
>> in most cases the performance loss isn't worth it if your filesystem is
>> stable and sane.
> 
> Though I asked this following from a debate on IRC, it now looks as if
> this will solve another of my problems too.
> 
> Let me explain.
> 
> I'm evangelising git at work, and although most projects are happy,
> even eager to setup a proper server for git, and those that can't are
> happy to just use mine, there are a couple of projects that are almost
> exclusively Windows _and_ cannot add another machine _and_ have client
> confidentiality issues so they can't just use my server.

I don't exactly understand why your reply with this Windows story to the
fsyncobjectfiles paragraph. But if you think that fsyncobjectfiles+msysgit
is your killer argument, then you think wrong: fsyncobjectfiles is ignored
in msysgit. (We don't yet have an implementation of fsync() :-( )

The issue that Linus mentioned happened when a Linux client operates in a
repository that lives on a CIFS mount.

> My alternatives for them so far were (1) VirtualBox running Fedora or
> something within one of their beefier Windows servers or (2) the whole
> cygwin install, which is painful compared to msysgit.
> 
> Sounds like we can just do it with traditional Windows fileshares, as
> long as we make sure no one does a "git gc" on the bare repo that is
> being shared.  That's a very small price to pay!

It will work with the caveat you mention. I have such a setup myself.

-- Hannes
