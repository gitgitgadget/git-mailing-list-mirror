From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Fri, 20 Nov 2009 10:55:24 -0800
Message-ID: <20091120185522.GC56351@gmail.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
 <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
 <20091119193913.GA25410@gmail.com>
 <19205.50406.91209.309984@cargo.ozlabs.ibm.com>
 <7vhbsp7htq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 19:55:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBYe2-0000d6-Hh
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 19:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbZKTSzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 13:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZKTSzf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 13:55:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:52425 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZKTSze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 13:55:34 -0500
Received: by ey-out-2122.google.com with SMTP id 4so445250eyf.19
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gsxSdk3Fx76VJGJ0qUXWBc4MqCfxDyF8/8/a3lStwrk=;
        b=t9qRLJs8IuYMoyX1TMclKKdgE4HHxekHnMXUyF5BKJZke4dT6c4jtP/wgxUTkrij0u
         nRIS6WRmjU8PZIDPwUGkY459VqNGRVAOFmzLABImsjSKBaTzk+2MhjPiqWBNzqu68Bu8
         RVxJmiwijxQWlNPFWn2SIq8u3wewWA0HfN9OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GRvE6pr2E6g+SbLL2UvrJpqKXpJmxsRoiPjelxL8dyHCDdVF0jKRqiBD9GrlvQDmZV
         RvCuHiErYzPWOseaEnTkl0Ab2Zo9dwD8mjCORX19gseUBpNR0EKZNLiXCqS5k2S2sJnj
         aW+nfi0OsHEvyAHYpBWc6GPJ+bp5J7YSyT25g=
Received: by 10.213.3.140 with SMTP id 12mr563133ebn.20.1258743339815;
        Fri, 20 Nov 2009 10:55:39 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 10sm439814eyd.37.2009.11.20.10.55.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 10:55:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbsp7htq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133365>

On Thu, Nov 19, 2009 at 11:53:37PM -0800, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > I have no problem with using git difftool if the underlying git is new
> > enough, I just don't want gitk to explode when it isn't.
> 
> I somehow doubt there are many users who use pre 1.6.3 git but keep their
> gitk separately updated to very recent version, so personally I wouldn't
> worry too much about this.
> 
> > Also, I don't think we should remove the ability for the user to
> > choose which external diff tool to use.
> 
> This is a larger concern.  Does "difftool" allow use of an arbitrary tool
> like how gitk does (I have a suspicion that it is not as flexible)?

difftool supports arbitrary tools through configuration.
For arbitrary tools we set difftool.$name.cmd and
diff.tool = $name.

If gitk were to have a difftool paradigm then it might
be nice to have a text field mapped to the diff.tool variable.
The patch didn't address the diff.tool configuration variable
so that's a concern if we are to pursue difftool further.

The argument in favor of difftool is one of user
expectations.  From a user's POV it ~seems~ desirable for
gitk to honor difftool configurations.  The easiest way for
gitk to do that is to use git-difftool and not worry about
the details of how arbitrary tools are setup.

Later work could be done to provide UI for setting up
arbitrary tools inside of gitk.  My gut feeling
is that gitk isn't a git config editor.

This is why the difftool patch took the minimalist approach.
It trusts the user to have things configured to their
liking and trusts git-difftool to do the right thing
when no such configuration exists.

I think it's a question of whether this is something we'd
want to change.  It certainly doesn't bother me either way.

I might be the only person who'd notice such small details
so my vote-in-code is with my v2 $TMPDIR patch until someone
else thinks that using difftool inside of gitk is a good idea.

At which point I would probably pursue it with the minimalist
approach first and then gradually add UI for the pertinent
git config variables.

Just my .02,

-- 
		David
