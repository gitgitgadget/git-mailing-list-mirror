From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 18:34:43 -0700
Message-ID: <20100327013443.GE10910@spearce.org>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org> <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Mar 27 02:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvKvM-00045M-4F
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 02:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0C0Ber (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 21:34:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34268 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0C0Beq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 21:34:46 -0400
Received: by gwaa18 with SMTP id a18so2983728gwa.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 18:34:45 -0700 (PDT)
Received: by 10.101.199.23 with SMTP id b23mr3080825anq.206.1269653685672;
        Fri, 26 Mar 2010 18:34:45 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1295085iwn.15.2010.03.26.18.34.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 18:34:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003262125120.694@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143311>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 26 Mar 2010, Shawn O. Pearce wrote:
> > "Mike.lifeguard" <mike.lifeguard@gmail.com> wrote:
> > > On 10-03-26 08:56 PM, Avery Pennarun wrote:
> > > > The problem is that everything in git works perfectly with these
> > > > invalid file modes *except* fsck, and there's rarely a need to run
> > > > fsck, so this problem can hide for a long time.
> > > 
> > > So, does the error matter or not? If it doesn't matter, then shouldn't
> > > Jgit stop whining? If it does, then whatever-it-is needs to be fixed.
> > 
> > Its less harmful than other types of corruption.  But its quite
> > wrong from a format perspective. The hash of the tree differs even
> > though there is no semantic difference in the tree content.
> > 
> > Given that GitHub has blessed the world with this corruption,
> > we may need to modify JGit to accept it.
> 
> Should we?
> 
> This is going to screw up pack v4 (yes, someday I'll have the time to 
> make it real).

Exactly.  I *really* don't want to permit this sort of corruption
in a Git repository.

But GitHub's approach here seems to be "Meh, its fine, don't worry
about it".

Its *NOT* fine.  But Avery and Junio might disagree with me.  :-)


Though, FWIW, it might not screw up pack v4.  IIRC from our
discussions long ago on pack v4, we store "$mode $name" pairs in
an indexed list, preciously because we needed to support odd modes
like 10664 from ancient Git binaries.  If we continue to allow this
corruption, it means we have to ensure $mode is the octal string
and not the binary value.

-- 
Shawn.
