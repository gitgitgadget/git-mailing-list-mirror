From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] preserve mtime of local clone
Date: Sat, 12 Sep 2009 10:26:24 +0200
Message-ID: <20090912082624.GA9654@localhost>
References: <20090909195158.GA12968@localhost> <7vmy50lpfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 10:26:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmNwM-0005e6-F1
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 10:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbZILI02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 04:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbZILI02
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 04:26:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:29915 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZILI01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 04:26:27 -0400
Received: by fg-out-1718.google.com with SMTP id 22so550751fge.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OwP5V5M00d3TD8TlbKe9QuPQFHUc+s9S7I6/gKjW88U=;
        b=UzwUk8TNb0ks82IJBywZlqpNmSEIMhnMY/vs+lPVIZcCTPbDBblDOmiSEUxYVnSdlt
         tbmNTWvosWBV3AGdMKvo5BrevoTVC1idxY6lkJTwj8wKe7hlGDZfS+25tt77b18lKuuA
         mmQeevhj9/YTZr0zUcvLIEHX2l9xekV7zGx7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=YGxg2bqgA8ATX5+FhoejqegpfJ4kn7Ht5H5mfdPkIVZeXss9izSJH9GIDdHPqyGYaP
         t/TxKNudD/lZjvMWpa5C3X3uB9hGfiQY9+xWqcG0rta1HsJY2lcA2K5+k0i0jR2hVR0I
         P4lT6f+k9iwBPKOKpzh45gvEbDzQOIChbMESU=
Received: by 10.86.184.35 with SMTP id h35mr3021502fgf.18.1252743989485;
        Sat, 12 Sep 2009 01:26:29 -0700 (PDT)
Received: from darc.lan (p549A7B9E.dip.t-dialin.net [84.154.123.158])
        by mx.google.com with ESMTPS id l19sm828001fgb.12.2009.09.12.01.26.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 01:26:27 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmNw9-0002bb-0u; Sat, 12 Sep 2009 10:26:25 +0200
Content-Disposition: inline
In-Reply-To: <7vmy50lpfr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128240>

On Fri, Sep 11, 2009 at 10:09:12PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > +int copy_times(int ofd, int ifd)
> > +{
> > +	struct stat st;
> > +	struct timespec times[2];
> > +	if (fstat(ifd, &st))
> > +		return -1;
> > +	times[0].tv_nsec = UTIME_OMIT;
> > +	times[1].tv_sec = st.st_mtime;
> > +	times[1].tv_nsec = ST_MTIME_NSEC(st);
> > +	return futimens(ofd, times);
> > +}
> 
> Hmm, futimens() is relatively new.  Are minority platforms folks Ok with
> this patch?
> 
> At least SunOS 5.11 (OpenSolaris 0811) seems to barf on UTIME_OMIT.

If it's a problem we can use utime() instead. I was just trying to use the
file descriptors, since they were available. But the patch would be a little
smaller if I didn't touch copy_fd().

Clemens
