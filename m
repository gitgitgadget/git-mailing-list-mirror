From: Bill Lear <rael@zopyra.com>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Tue, 13 Nov 2007 17:56:45 -0600
Message-ID: <18234.14781.55429.671459@lisa.zopyra.com>
References: <18228.32091.865519.312011@lisa.zopyra.com>
	<20071109232106.GA3435@steel.home>
	<18232.29603.856766.275854@lisa.zopyra.com>
	<20071112233309.GI2918@steel.home>
	<18233.47472.890658.729250@lisa.zopyra.com>
	<20071113214802.GH3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:57:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5d0-0008Om-71
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbXKMX4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbXKMX4x
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:56:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60194 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbXKMX4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:56:51 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lADNumB10280;
	Tue, 13 Nov 2007 17:56:48 -0600
In-Reply-To: <20071113214802.GH3268@steel.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64914>

On Tuesday, November 13, 2007 at 22:48:02 (+0100) Alex Riesen writes:
>...
>> >I extend the part you quoted. The file is opened here:
>> >...
>> >This is strange. The current git should not produce anything like
>> >this (and does not, here). ...
>> 
>> You are absolutely correct.  My comrade ran this with 1.5.0.1 by
>> mistake.  He reran the strace with 1.5.3.5, and I have replaced
>> the tarball on my server:
>> 
>>     http://www.zopyra.com/~rael/git/git-trace.tar.bz2
>
>Still looks like v1.5.0.1:
>
>    write(2, "fatal: ", 7)                  = 7
>    write(2, "cannot pread pack file: No such "..., 49) = 49

Well, I just grepped for the above string in git-1.5.3.5:

% grep 'cannot pread pack file' *.c
index-pack.c:                   die("cannot pread pack file: %s", strerror(errno));

>I think it got worse:
>
>> write(3, "\360]|\204\205\317|\352\336C\342\316\206\334\326\201\211"..., 4096) = 4096
>> write(3, "\20\t\33if (cached_vias.insert(die,\227\17"..., 4096) = 4096
>
>The data in packs is zlib-compressed. I don't think you should be able
>to see any readable strings in them (except for "PACK" in the header).
>I believe you have a data corruption now.
>
>Does git-fsck --all say anything about that, BTW?

I'll see if we can run it...

>Besides, could you try with a git compiled with NO_PREAD?

I'll try this also.


Bill
