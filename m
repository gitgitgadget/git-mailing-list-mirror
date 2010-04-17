From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5] gitk: Use git-difftool for external diffs when git
	>= 1.7.0
Date: Sat, 17 Apr 2010 15:45:58 -0700
Message-ID: <20100417224556.GB9366@gmail.com>
References: <20100408090211.GA31594@gmail.com> <1270717690-32133-1-git-send-email-davvid@gmail.com> <20100417085230.GC6681@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 00:46:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3GmE-000195-9n
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 00:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab0DQWqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 18:46:08 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:57023 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab0DQWqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 18:46:07 -0400
Received: by ywh32 with SMTP id 32so2002723ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=afHHLmp5TkwMiAoLR7VPgYXreaM5NR8+64zhmTJu+3E=;
        b=yDQQilDoXbWbF3SoNs4UXFbYeHhDdxp69CkJOwxMcjNWM5TOdaJPlUVkM6FOhrwoMJ
         +X3eu9fANLPQmeQCISnRPiJqQ9uhmyIlR4Ro48RhTweHinIbmTVlpcjYpdhEyl/izYm5
         Eg4xt6qzbjgZx6CxJzZroquhATNxFLptSvixM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=briFibBiWXKYmLMus6ekGPja1E5VFlpMmGuJ6CxaY9df+ggN4bWk+aDHO8hxqmGs+o
         WZ1HRdjqkL8aF/pDAyxK1I4B4aiD55d3of2Rd84xNi/axJGWCcuNyxkk5zSxUyKQZdpG
         RW5/YrStlL7wpwg32m1t0v1vfhuyztSAx48Zw=
Received: by 10.151.130.18 with SMTP id h18mr3719928ybn.186.1271544363216;
        Sat, 17 Apr 2010 15:46:03 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 21sm1169678ywh.47.2010.04.17.15.46.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 15:46:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100417085230.GC6681@brick.ozlabs.ibm.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145188>

On Sat, Apr 17, 2010 at 06:52:30PM +1000, Paul Mackerras wrote:
> On Thu, Apr 08, 2010 at 02:08:10AM -0700, David Aguilar wrote:
> 
> > git-difftool is used instead of the built-in external diff
> > code when git is >= 1.7.0.  git-difftool's '--extcmd=frotz'
> > feature was first introduced in 1.7.0 and is the mechanism
> > through which we launch the configured difftool.
> > 
> > A benefit of this change is that gitk's external diff feature
> > no longer needs write-access to the current directory.
> 
> I applied this one, and in testing it I noticed that if the git
> difftool invocation fails, for example because the user doesn't have
> meld installed, there is no notification via the GUI.  Instead an
> error message is printed to stderr.  We need to do something more like
> what we do in the old-git case -- use open rather than exec -- and pop
> up an error dialog with error_popup on error so that the user knows
> what the problem is.
> 
> Another minor problem is that the file names that meld (or other diff
> tool) displays are less informative now.  For example I see
> "KyaZ5d_gitk : 8iucke_gitk" as the tab label in meld instead of the
> "[87d24ec87abc...e236e0833ff] gitk" label that we got before, which
> was a little more informative, though the e236e0833ff is the end of
> the second SHA1 rather than the beginning.
> 
> So I backed it out.  The error handling needs to be fixed using
> something like what delete_at_eof does (except that obviously we don't
> have any files to delete).
> 
> Paul.

I'll fix the error handling and add a few more notes to the
final commit message.

The title display is tool-specific so there's something we can
do about it on a tool-by-tool basis.  This'll have to wait until
we can break out the tool-dependent parts of git-mergetool--lib
as was discussed in the past:

http://lists-archives.org/git/707440-mergetool-lib-add-diffmerge-as-a-pre-configured-mergetool-option.html
(sorry, couldn't find it on gmane... :-/)

Jay, you mentioned wanting to give Junio's approach a try as
well as looking into what mercurial did with mergetools.
Do you have any thoughts about it since then?  I can help
factor out the backends if you don't think you'll have time to
get to it soon.

Once we factor out the backends we'll should have an easier
time working in additional variables for doing user-friendly
things like passing the --label= flag to meld.
git-difftool should be able to do it since its GIT_EXTERNAL_DIFF
helper is passed the sha1s.

Thanks all,

-- 
		David
