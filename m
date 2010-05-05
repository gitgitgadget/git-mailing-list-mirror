From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: update-index --really-refresh unsets assume-unchanged bit
Date: Wed, 5 May 2010 17:44:59 +0200
Message-ID: <20100505154459.GA24447@localhost>
References: <20100501092512.GA15941@localhost>
 <20100501092720.GB15941@localhost>
 <20100504085722.GA32217@localhost>
 <z2h32541b131005040941m79724daq4cd8b0c427bb218a@mail.gmail.com>
 <20100504194136.GA19300@localhost>
 <7v39y7mglb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 05 17:45:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9gmv-0004aN-F0
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 17:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760642Ab0EEPpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 11:45:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:54976 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760410Ab0EEPpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 11:45:15 -0400
Received: by fg-out-1718.google.com with SMTP id d23so28221fga.1
        for <git@vger.kernel.org>; Wed, 05 May 2010 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=kKbCWbvwFAg0XxktYKrfNhoeeYwutI7Cewgr15xuUa4=;
        b=Rw84KtO00a2485xbMcpw1kN+ZO+keF5oxyYbOPcTuU8caB3xwJQeRItOmaLzQiX6hK
         MJY9UBr2NHFl9t5/L96YTt1Tda7e/Y4bxc5Jg+nPogLKbU2gCxUITsBBc5rdVxfYeCrW
         WSIc10WguGNF0n/Mw7AMVqNqtpigBUO2zI9xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=PcoqtXlgIK5iL2p0mPmg+IYpENfcneuITVZqU8udrv9XvJBppUZ656KAmex8mXReyr
         BXCQ6ZLsDWWE8OJrkk1vkLByDK9LThIX0JC8MrgWjzDgASC6gp97DGR7g7m2F4EwG6IW
         PF/2m1MMnhPR15ibe+4yuNCLSEQu0vbebKkmo=
Received: by 10.86.6.37 with SMTP id 37mr14505219fgf.7.1273074313457;
        Wed, 05 May 2010 08:45:13 -0700 (PDT)
Received: from darc.lan (p549A472D.dip.t-dialin.net [84.154.71.45])
        by mx.google.com with ESMTPS id f31sm621170fkf.48.2010.05.05.08.45.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 08:45:12 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1O9gmR-0006TB-BS; Wed, 05 May 2010 17:44:59 +0200
Content-Disposition: inline
In-Reply-To: <7v39y7mglb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146407>

On Tue, May 04, 2010 at 03:45:20PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On the contrary. I _want_ git to assume the file is unchanged, even though I
> > know it changed. This is an intended and documented use case (from the
> > git-update-index manpage):
> 
> The intended use of *really* one is to ignore the assume unchanged bit and
> make the bit reflect reality.

Yes, and right below the part you are quoting I explained why this is not
what it does either.

> The bit was originally invented back when
> the machinery was too lstat(2) heavy so that people on slow filesystems
> can say "I haven't changed these paths, and I promise I won't, so you can
> trust this and assume that the working tree file exactly matches what is
> recorded in the index."  Obviously we needed to give such users an way to
> tell git that they broke their promise, and that is what *really* refresh
> meant to give.

Yes, but after the index is refreshed, the file is now, again, unchanged.
Yet, the assume-unchanged bit is unset.

But there is no reason presume that the user will break their promise again
in the future. If they plan to do so, they can always use git update-index
--no-assume-unchanged.

> Note that the promise is _different_ from telling "I may or may not have
> changed the work tree files, but don't bother telling me that I did".  The
> promise you make by "assume unchanged" bit allows git to read from the
> working tree file when it needs the contents of blob recorded in the index
> and the bit is set, as you promised that you will never change it.

And in what case does git do that? I can only find commands which read from
the object store and not from the work tree. This would also break the
"ignore changes to tracked files" use case.

Clemens
