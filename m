From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 13:17:41 -0400
Message-ID: <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 19:18:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G93J1-0000z2-SF
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWHDRRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 13:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWHDRRs
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 13:17:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:26736 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161330AbWHDRRr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 13:17:47 -0400
Received: by nf-out-0910.google.com with SMTP id q29so12918nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 10:17:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/6InVhAmI8tusnTh0j3i+e5ll3UVqUTFaIycaFF/BCGkSWm32w1Zzp6MgmnGfeGgOceOWwPGrQWewHBX8bMWkQUwEn++FWVbsiYwarcnJwsIjN2r7dVsHPyInGPeGbGyh+oh71sR3AJYao789XtmWZ4kSEj5IK69eADxE7wF64=
Received: by 10.78.107.8 with SMTP id f8mr1628800huc;
        Fri, 04 Aug 2006 10:17:46 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 10:17:41 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24811>

On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> and you're basically all done. The above would turn each *,v file into a
> *-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many
> pack-files as you have *,v files.

I'll end up with 110,000 pack files. I suspect when I run repack over
that it is going to take 24hrs or more, but maybe not since everything
may be small enough to run in RAM. We'll also get to see the
performance of repack with 110K open file handles. How is it going to
figure out which file handle contains which objects?

A new tool might help. It would concatenate the pack files (while
adjusting the headers) and then build a single index. No attempt at
searching for deltas.

To initially build a single pack file it looks like I need a version
of repack that works in a single pass over the input files. To make
things simple it would just delete the file when it has finished
reading it. Since I'm passing in the revisions in optimal order
sorting them probably hurts the pack size. The number of files in
flight will be a function of the pipe buffer size and file names.

I'll work on the tree writing code over the week end.

-- 
Jon Smirl
jonsmirl@gmail.com
