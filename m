From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 15:15:39 -0600
Message-ID: <20080127211539.GA10993@lintop>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com> <alpine.LSU.1.00.0801272043040.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEsv-0007Vz-FZ
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 22:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbYA0VRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYA0VRS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 16:17:18 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:33243 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYA0VRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 16:17:17 -0500
Received: by an-out-0708.google.com with SMTP id d31so311047and.103
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=/o/97jAtmXJCyM0R3a87YuHOO2iNBxa/Ugb2M+orlDg=;
        b=O3gqYWJ6HdRI3OJiZgQTXDRRM/wMDl1Wgszf+q5zh2vCtb6GoxKSlpF5/nsKkMvpL+QLdAV4uwkh0UrELo9ePrYhx/cgbjoicyKIdGibxltJhdcWdqbwEQ+Cq20y4HG71HTVvKVniYNU+rWivvV883/QqPjBmr3YEX5XFb92dko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lvDNgU6Tfz336WneR8CS2kGkzz+x32NL5rG7DxjqQYDZTieLdOvQ0iuwJNutbveXTsQU9byKrSJzy8Qbg70q5UcluG3C6mcAQL8103iaAj8Fpp+4BcCoVgOxo1R7/vKKOm7pzR1cwiHOLzbXVKJo6NeEvxET+B6Dm6EwK9Ob4hM=
Received: by 10.100.210.9 with SMTP id i9mr9811180ang.92.1201468634687;
        Sun, 27 Jan 2008 13:17:14 -0800 (PST)
Received: from @ ( [70.112.149.232])
        by mx.google.com with ESMTPS id i33sm8162030rng.3.2008.01.27.13.17.12
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 13:17:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801272043040.23907@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71832>

On Sun, Jan 27, 2008 at 08:44:57PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 27 Jan 2008, Shawn Bohrer wrote:
> 
> > base + current already includes the trailing slash so adding
> > one removes the first character of the next directory.
> > 
> > Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
> > ---
> > 
> > This fixes the oops part of the issue Johannes found,
> 
> have I?
 
Sorry I should have been more explicit Johannes Sixt reported the issue,
you were included simply because you had been involved in the thread.

> > but doesn't address the fact that we probably should remove files that 
> > aren't a part of the repository at in the first place.
> 
> I am sorry, but I cannot begin to see what this commit tries to 
> accomplish.  Yes, sure, there is an off-by-one error, and your commit 
> message says how that was fixed.  But I miss a description what usage it 
> would affect, i.e. when this bug triggers.

As far as I can see there are two protential cases that could trigger
this bug, but there may be more.  This first was the arguably invalid
case the Johannes Sixt reported.

git clean -n /

The other case that could trigger this bug and potentially others is if
someone makes their root dircetory a git repository and then uses "/" as
an absolute path.  For example:

cd /
git init
git clean -n /

You may argue that both of these cases are invalid and that is fine by
me, but since I noticed this bug I thought I would send a patch.  If you
wouldlike I can add these two use cases to the commit message.

--
Shawn
