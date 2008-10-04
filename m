From: deskinm@umich.edu
Subject: Re: How to list versioned files with modification status
Date: Sat, 4 Oct 2008 18:52:44 -0400
Message-ID: <20081004225244.GD3052@riemann.deskinm.fdns.net>
References: <20081004131256.586a5fbf@smartavionics.com> <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com> <loom.20081004T215458-15@post.gmane.org> <81b0412b0810041534o7b38507qe63db47cd07fdc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 00:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmG2a-0006jo-Ha
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 00:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbYJDWyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 18:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbYJDWyv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 18:54:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:37874 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbYJDWyu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 18:54:50 -0400
Received: by wr-out-0506.google.com with SMTP id 69so953542wri.5
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=b4crOmJB2NVgpYfJ66mSflo5s6nbLi4ANlH2ZzGqOmw=;
        b=AG3Mqgvvpver93ku723IaQVy/rsadRtNOAUTUr1ryHyZUtrcvQ/ucHkAXi3jn3c27u
         gyTjNyG1Rj2pxqdlLgvihtS4r9dqXlAYYfa63fa9/4PjpDPzI4OhAxOJe7ds84eTq2Qt
         oj5HubqlDbf3XC/EBPRFh4ZnqEXNUeeKZE+Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=wRJTjBOQNL9xXTSw2bWTUYqQ4/oxUVKpASz/n5KmnEV5hhK1YQrz8S007laUtpz0ir
         xpM2Z1IDkn69CFbZwr7RL47OdeBrrsK85sQmkbQqLlfMCoAkK5uYoc3j9lMKABa1eUQu
         ct8Ow89tYKn5zP4QDjlVhkM0ec+yEsLYem2jA=
Received: by 10.65.249.3 with SMTP id b3mr4477448qbs.87.1223160888431;
        Sat, 04 Oct 2008 15:54:48 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id k7sm7569329qba.3.2008.10.04.15.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 15:54:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0810041534o7b38507qe63db47cd07fdc16@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97483>

On Sun, Oct 05, 2008 at 12:34:31AM +0200, Alex Riesen wrote:
> 2008/10/5 Mark Burton <markb@ordern.com>:
> > Alex Riesen <raa.lkml <at> gmail.com> writes:
> >> 2008/10/4 Mark Burton <markb <at> smartavionics.com>:
> >> > I would like to be able to easily find those files in a git tree that
> >> > don't have pending modifications. Although ls-files can list the
> >> > files that are modified, it can't list those that aren't or list all
> >> > files with their modification status.
> >>
> >> Maybe if you look at git diff and diff-index,  you will find something
> >> what suits you better? Because "modification" is just a difference
> >> between a known (recorded in a commit or index) state and your
> >> working tree.
> >
> > 'git diff --name-status' looks useful but it only shows the files that have
> > changed - I would like to see the names of the files that haven't changed.
> 
> There is nothing to do something like that, but...
> 
> > Even svn could do that (svn status).
> 
> what exactly are trying to achieve? It is just strange that no one
> asked for something like this before...

Apologies for the duplicate message; fighting between gmail and
vger.kernel.org.

Here's a terrible way to do this:

$ GIT_EDITOR=: git commit -a -m 'throwaway' >/dev/null
$ (git ls-tree -r HEAD; git ls-tree -r HEAD~1) \
| sort | uniq -d | sed -e 's/^[^ ]* [^ ]* [^\t]*\t//'
$ git reset HEAD~1 >/dev/null

Deskin Miller
