From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT and repo-config
Date: Fri, 26 Jan 2007 22:51:05 +0000
Message-ID: <b0943d9e0701261451y58062564yddad0a7471e0eff6@mail.gmail.com>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
	 <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZuw-000855-Oz
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXAZWvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXAZWvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:51:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:24621 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbXAZWvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:51:06 -0500
Received: by nz-out-0506.google.com with SMTP id s1so808836nze
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:51:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bN1uBcbNrP5vpFAp6HxbLOMxxaW9O+oqxJmCsvxXdzl29dpXnVgDcOVJPKGM8Icl1CtqSA48h3GVlAfFsqA19/OxaGOjbDkbqGSGOV+L4/9hJTL4crGWr/QZKtqacDdsTUDlmokgZl1Ga58do8hxWTEHsdAxkGh06ALx7GxxgbQ=
Received: by 10.114.169.2 with SMTP id r2mr101815wae.1169851865393;
        Fri, 26 Jan 2007 14:51:05 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 26 Jan 2007 14:51:05 -0800 (PST)
In-Reply-To: <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37894>

On 26/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Fri, Jan 26, 2007 at 12:58:38AM +0100, Johannes Schindelin wrote:
> > On Thu, 25 Jan 2007, Catalin Marinas wrote:
> > > The dictionary should also be pre-populated with the default values
> > > (only in memory, not going to the config file on disk).
>
> Pre-filling with default value has a drawback: it will create lots of
> useless entries, especially for per-branch settings.  I'd rather let
> the accessors return the default value when needed.  We can still
> group all defaults in a single dictionnary.

What I meant is that it should pre-fill only with the default entries
needed by StGIT (probably around 10, see stgit.config.config_setup()).
The rest should be filled in when reading the config files.

> > The most important point (to me) which came out of the discussion: It is
> > not at all easy, or straight-forward, to handle multi-vars, i.e. multiple
> > values for the same key.
>
> Right, at least for filling a dictionnary.  We would need to declare
> multi-valued parameters as such, which basically means we must only
> try to read those config items we know about, which has all sorts of
> consequences for config.py :)

But are multi-vars in the same file currently used? There is a clear
situation when a key is written in both the global and the
per-repository config files. From the StGIT point of view, it should
only care about the most specific one, i.e. the one in the per-repo
config and this would be the last one listed by git-repo-config (and
therefore overriding any preceding dictionary entry).

> It would seem reasonable to start without a cache dictionnary, at
> least for now.  After all, there are not so many config items to know
> about in a single stgit run, so IIMHO we're only going to notice a
> difference for the time needed to run the testsuite.

I'd like to avoid calling git-repo-config for every config option,
even if this wouldn't be noticeable (initially, but the tool would
evolve). If we don't care about multi-vars, as I said above, a
dictionary cache would make sense.

-- 
Catalin
