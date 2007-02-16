From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Re: [PATCH] Add git-bundle - pack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 06:45:16 -0600 (CST)
Message-ID: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 13:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI2Sr-0008Ap-VM
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 13:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbXBPMpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 07:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbXBPMpV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 07:45:21 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:34787 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964781AbXBPMpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 07:45:20 -0500
Received: from vms064.mailsrvcs.net ([192.168.1.1])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDK00MDS3FGEVP2@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 06:45:17 -0600 (CST)
Received: from 12.109.151.100 ([12.109.151.100])
 by vms064.mailsrvcs.net (Verizon Webmail) with HTTP; Fri,
 16 Feb 2007 06:45:16 -0600 (CST)
X-Originating-IP: [12.109.151.100]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39910>

>From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
>Date: 2007/02/16 Fri AM 05:57:20 CST
>To: "Shawn O. Pearce" <spearce@spearce.org>
>Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
>Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected transfer

>Shawn O. Pearce wrote:
>> Mark Levedahl <mdl123@verizon.net> wrote:
>>> +# create the tar file, clean up
>>> +tar cf "$bfile" --absolute-names --transform="s,$tmp-,," \
>>> +    --verbose --show-transformed-names \
>>> +    "$references" "$pack"
>> 
>> I'm not sure this will work on FreeBSD.  Both 5.1 and 6.1 use tar
>> that does not know about --absolute-names, --transform, --verbose,
>> or --show-transformed-names.
>
>for portability, pax is the official choice :)  and it can even do path name modifications with -s.  but why again are we using tar there?  this data could easiliy be put in one mixed text/binary file, starting out with
>
>#!/bin/sh
>echo "This is a git bundle.  Use git-unbundle to process me." >&1
>exit
>### DATA ###
>
>or so
>
>cheers
>  simon

... I *tried* that, and it fails under Cygwin. Apparently cygwin's bash (or something) mangles data in the pipe (99% certain it will turn out to be a latent crlf issue)...


cat "$bfile" (
    read refs...
    git index-pack --stdin
)

worked several times, it only failed twice out of 8 bundles I tried. That's just a trifle bit too high a failure rate for my taste. ;^)

Mark
