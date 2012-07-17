From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix git-svn tests for SVN 1.7.5.
Date: Tue, 17 Jul 2012 12:44:46 -0500
Message-ID: <20120717174446.GA14244@burratino>
References: <5004B772.3090806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:45:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrBpX-0000w1-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab2GQRo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:44:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64035 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab2GQRoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:44:55 -0400
Received: by yhmm54 with SMTP id m54so655092yhm.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=87VmFL/EzNYGR89aP2uTKL7VoJE2FHGifugq6AyJoMw=;
        b=Zl+hABTmzqc4+oIPTmiGHWD55EZXRl1lGV70/DlYegyxnwsjoNloVLgU+G2S55Fw+o
         YKMEE3hAGBTGcCCpMSc/NkLJXzwMqJS0cwhFmes/KTasBNBXOMSWumIPyvHYSVCVL9hm
         ezsPBdf3R58Js7g7D17BajxWpzxJgqs01HIgvsPWhWJv4fm0Nv1AXD/9FGup/G1mDeZ5
         mYJaGx2lGXaztpm1c/8tRFXTCmS3blttxvw7njoGKe/B/F89ln+r4aa4S/50F3QQ63sU
         jyy5ZEckiuJ/dBJ7G1WvmJ19+vk/5o0xZNAJr6gJd3cmNV5AjUfiP8i4gh8Tx/wbkZa8
         0Lng==
Received: by 10.43.63.140 with SMTP id xe12mr2023652icb.57.1342547095098;
        Tue, 17 Jul 2012 10:44:55 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z8sm12127104igi.5.2012.07.17.10.44.53
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:44:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5004B772.3090806@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201611>

Hi!

Michael G Schwern wrote:

> I've fixed the git-svn tests for SVN 1.7 and tested with SVN 1.7.5.

Thanks.  git-svn is not maintained by Junio but by Eric and others on
the list.  I'm cc-ing Eric and Ben Walton so they can benefit from
your work.

>                                                                      SVN 1.7
> changed its expectations of path and URL formats and git-svn did not comply
> with them.  The new code uses SVN's own canonicalization routines where
> available.  This has been reported in several places...
> https://bugs.gentoo.org/show_bug.cgi?id=418431
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678764
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=661094
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678137
> https://trac.macports.org/ticket/32753
>
> It also split the internal classes out of git-svn.perl and into their own
> modules in perl/Git/ to make them easier to work on.  They compile alone, but
> remain heavily intertwined with each other and git-svn.  I didn't want to go
> very far down that rabbit hole.
>
> This makes the tests pass, but I'm pretty sure plenty of canonicalization
> problems remain untested.  Hopefully by attacking the problem at the root (ie.
> in the Git::SVN and Git::SVN::Ra accessors) it will wipe out a range of problems.
>
> t9100-git-svn-basic.sh tests 11-13 continue to fail for what look like
> unrelated reasons to do with SVN and symlinks.
>
> There's a lot of work in this change, so I felt it better to submit the
> patches as a link to a git repository rather than attach a pile of patches.
> Here is my repository, the work is in the fix-canonical branch.
> https://github.com/schwern/git

It is indeed quite the intimidating pile of patches, so I do not think
we will be able to apply it all in one chunk as-is. :(

My advice would be to send five or so of the patches that you would
like to be reviewed first, inline, one per message, in reply to this
message so we can start to work on that.  Presumably the patches do
not regress git-svn's behavior but only make it saner, so even if this
is not a complete fix it should allow us to get started.  See
Documentation/SubmittingPatches for more hints.

Thanks and hope that helps,
Jonathan
