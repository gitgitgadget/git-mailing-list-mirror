From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 23:22:02 -0500
Message-ID: <9e4733910712072022na3369caob48d4b26a56224ea@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	 <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
	 <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
	 <20071208033722.GA27776@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "David Brown" <git@davidb.org>, "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 05:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0rCv-0007nt-Tz
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 05:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbXLHEWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 23:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXLHEWG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 23:22:06 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:36881 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbXLHEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 23:22:03 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7428856roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 20:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XnyKbhfne6pC+o0NU8UyWSaPu/L9G2E10mkhGnu4xRQ=;
        b=PqCZZxYMyeCbXw9rM0rcf2dQFJT7lPTYIINwDhtxWnCeDMiblHlotr/GW9itI40wusgZU3+sWcEYk5SbQbP5iEFP+1Qi3ezPv8vi4ecXRm9CeNisCIFDO8Xe0llD62GARYFd73f7J0NbXkPcmxjvOoWX2U1lM8b7fBuPKw0rot0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JstUfpEn+b+LyPh66FYUppuO9IJMd1jYeQrhDIe+5zPWfS32QR+6n8HuJ2QuRLM6QcI4xN6nyRunu/z2qk5ZwP2dL8scHJvWdRYPIdx+1SfeePmSHs4wxjY8StTwIE1lzNz3UDpz/M/rGInWqg5O6FZXi10Sk0kADahkFpEhoSw=
Received: by 10.114.192.1 with SMTP id p1mr590811waf.1197087722379;
        Fri, 07 Dec 2007 20:22:02 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 20:22:02 -0800 (PST)
In-Reply-To: <20071208033722.GA27776@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67507>

On 12/7/07, David Brown <git@davidb.org> wrote:
> On Fri, Dec 07, 2007 at 10:29:31PM -0500, Jon Smirl wrote:
> >The kernel repo has the same problem but not nearly as bad.
> >
> >Starting from a default pack
> > git repack -a -d -f  --depth=1000 --window=1000
> >Uses 1GB of physical memory
> >
> >Now do the command again.
> > git repack -a -d -f  --depth=1000 --window=1000
> >Uses 1.3GB of physical memory
>
> With my repo that contains a bunch of 50MB tarfiles, I've found I must
> specify --window-memory as well to keep repack from using nearly unbounded
> amounts of memory.  Perhaps it is the larger files found in gcc that
> provokes this.
>
> A window size of 1000 can take a lot of memory if the objects are large.

This is a partial solution to the problem. Adding window size =256M
took memory consumption down from 4.8GB to 2.8GB. It took an hour to
run the test.

It not the complete solution since my git process is still using 2.4GB
physical memory. I also still experiencing a lot of slow down in the
last 10%.

Does the gcc repo contain some giant objects? Why wasn't the memory
freed after their chain was processed?

Most of the last 10% is being done on a single CPU. There must be a
chain of giant objects that is unbalancing everything.

-- 
Jon Smirl
jonsmirl@gmail.com
