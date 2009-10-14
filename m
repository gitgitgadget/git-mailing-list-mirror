From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Efficient cloning from svn (with multiple branches/tags subdirs)
Date: Wed, 14 Oct 2009 12:28:38 -0400
Message-ID: <32541b130910140928jdac0187x754423e8d5c64e53@mail.gmail.com>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6tb-0005yf-2V
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761707AbZJNQ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756472AbZJNQ3f
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:29:35 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:36517 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850AbZJNQ3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 12:29:34 -0400
Received: by yxe26 with SMTP id 26so5508353yxe.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=QqE061gOCKSwB8ByaWYJiKrQCjiCdFVKeQZ6RLSee0Q=;
        b=BzBfVMRenj+LpeKG0+qJvCQgQd9nui64/awld+3RpxGRAYMXYkd07hVF4aN4NwpeBV
         aYUaJsDx52hP3PEQMgk4pSi4hbAZ8ty+72bSTVgYnoR7DCLNw3DONgO3+Va4+uPenpqE
         6Q8CT3h/0Z8o6cSTVGPL30MIFcSV3xvx8qAWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MWO0ME6WaIPDht7vOGrGuEDhmh4SeHLWNAoyiTcHDrHulWDnICtrbwJzNWUZes3UzP
         dPeleyJ1T2ZICTqxgbnm9/MNYdN0673Ba/j82NTCpqYZmcmVs6HZRpldYzxgC4qHxNtU
         XmLDBxJTpIXWUO4iDCor7hatx0DL6/8R9SiCw=
Received: by 10.150.28.4 with SMTP id b4mr10801455ybb.124.1255537738078; Wed, 
	14 Oct 2009 09:28:58 -0700 (PDT)
In-Reply-To: <20091014060307.GA17178@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130306>

On Wed, Oct 14, 2009 at 2:03 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk> wrote:
>> What surprises me is that it looks like it's looping over and over,
>> since sometimes it starts back from SVN revision 1 when it's trying to
>> import a new tag.
>
> Yeah, that's an unfortunate thing about the flexibility of Subversion,
> basically anything can be a "tag" or a directory and it's extremely
> hard for git svn to support any uncommon cases for tags/branches
> out-of-the box, so the manual config editing is needed.

I've been thinking about this myself for some time.  One option that
might be "interesting" would be to just grab the *entire* svn tree
(from the root), and then use git-subtree[1] to slice and dice it into
branches using your local copy of git (which is fast and uses no
bandwidth) instead of during the svn fetch (which is slow and uses
lots of bandwidth).  I think it would also simplify the git-svn code
quite a lot, at least for fetching, since there would always be a
global view of the tree and SVN things like "copy branch A to tag B"
would just be exactly that.

Of course I have no time to code this up myself, so I apologize for
just dumping ideas on you without code behind them.  If this inspires
anyone, I'd be happy to help with any missing features (or
documentation) this exposes in git-subtree, though.

Have fun,

Avery

[1] http://github.com/apenwarr/git-subtree
