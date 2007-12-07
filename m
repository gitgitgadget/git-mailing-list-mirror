From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:23:35 -0500
Message-ID: <9e4733910712071323w5edccdb1pb5d6b05eb00ec97c@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kfw-0005md-3i
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbXLGVXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXLGVXi
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:23:38 -0500
Received: from ro-out-1112.google.com ([72.14.202.182]:33148 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXLGVXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:23:37 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7313084roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8S+HEMFAUjeqxh8dIud0jbD6Is3gMXOhYTo/FniVcOI=;
        b=fbWVEF8HjBXyfDkZO7/m3VpF/zEnUZhXRHVWnT+URxo+xeahs55/g7oZx/lWMeXNCSpBO4BTRcRW7W6+oIi4rjVwct93PV/jwC3NDOrlfhEkdnf0kFXJ/WTWePvS2NfQ8g/6lr1FM/eSrEcBPo9CNZZWNXGUgPJN3+86HCV185Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q0X8ryg1tyNXWfG4VICOS0a8JMPtKHIfo4cHLXM6mc3NW2qEZxI3Yo4XEbnh9M7OvQhHFoHaaXk/TCv4Th+HpPrkCtvenNZ1tWfmhMdNyvy0+E7G9qzCop4KfmNTnXWUtUG6/20RIAty/LsTocpwJyVBONIU8ceNYsMa9Ldbwtg=
Received: by 10.115.59.4 with SMTP id m4mr1571528wak.1197062615949;
        Fri, 07 Dec 2007 13:23:35 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 13:23:35 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67458>

On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 7 Dec 2007, david@lang.hm wrote:
>
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >
> > > I noticed two things when doing a repack of the gcc repo. First is
> > > that the git process is getting to be way too big. Turning off the
> > > delta caches had minimal impact. Why does the process still grow to
> > > 4.8GB?
> > >
> > > Putting this in perspective, this is a 4.8GB process constructing a
> > > 330MB file. Something isn't right. Memory leak or inefficient data
> > > structure?
> >
> > keep in mind that that 330MB file is _very_ heavily compressed. the simple
> > zlib compression is probably getting you 10:1 or 20:1 compression and the
> > delta compression is a significant multiplier on top of that.
>
> Doesn't matter.  Something is indeed fishy.
>
> The bulk of pack-objects memory consumption can be estimated as follows:
>
> 1M objects * sizeof(struct object_entry) ~= 100MB
> 256 window entries with data (assuming a big 1MB per entry) = 256MB
> Delta result caching was disabled therefore 0MB
> read-side delta cache limited to 16MB
>
> So the purely ram allocation might get to roughly 400MB.
>
> Then add the pack and index map, which, depending on the original pack
> size,
> might be 2GB.

I'm repacking the heavily compress pack, so input pack and index are
about 360MB, not 2GB.

>
> So we're pessimistically talking of about 2.5GB of virtual space.
>
> The other 2.3GB is hard to explain.

More like 3.5MB that is hard to explain.

Is there a simple way to tell what percent is mmap vs anon allocation?


>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
