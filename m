From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui clone WTFery
Date: Wed, 3 Feb 2010 11:52:15 -0800
Message-ID: <20100203195215.GE14799@spearce.org>
References: <20100201151647.GB8916@spearce.org> <7vy6jbunu8.fsf@alter.siamese.dyndns.org> <201002031111.29557.barra_cuda@katamail.com> <7vwryuhzsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclHF-0007A0-2e
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662Ab0BCTwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:52:23 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:59059 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab0BCTwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:52:21 -0500
Received: by iwn39 with SMTP id 39so2004576iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:52:20 -0800 (PST)
Received: by 10.231.151.207 with SMTP id d15mr123089ibw.44.1265226740548;
        Wed, 03 Feb 2010 11:52:20 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 22sm39560iwn.0.2010.02.03.11.52.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 11:52:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwryuhzsn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138874>

Junio C Hamano <gitster@pobox.com> wrote:
> Michele Ballabio <barra_cuda@katamail.com> writes:
> > In this case, git-gui is counting objects during a clone; would it be OK
> > to consider "buckets" as synonim of "objects" or "items" or something
> > else?  Then I would translate accordingly.
> 
> A cursory read of the codepath with that message tells me that Shawn is
> calling one [0-9a-f][0-9a-f] directory under .git/objects/ a "bucket" and
> counting the number of them while copying them to implement "git clone"
> inside git-gui (why?---that is a separate issue).

I just had an argument with someone in a private thread about why
commit messages should be more than 30 characters long.  Lets see
if the git-gui history stands up to that and sufficiently explains
why I rewrote clone in Tcl:

  $ git blame lib/choose_repository.tcl
  ...
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  633) 
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  634)           $o_cons start \
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  635)                   [mc "Counting objects"] \
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  636)                   [mc "buckets"]
  ...
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  673)           update
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  674) 
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  675)           file mkdir [file join .git objects pack]
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  676)           foreach i [glob -tails -nocomplain \
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  677)                   -directory [file join $objdir pack] *] {
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  678)                   lappend tolink [file join pack $i]
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  679)           }
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  680)           $o_cons update [incr bcur] $bcnt
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  681)           update
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  682) 
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  683)           foreach i $buckets {
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  684)                   file mkdir [file join .git objects $i]
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  685)                   foreach j [glob -tails -nocomplain \
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  686)                           -directory [file join $objdir $i] *] {
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  687)                           lappend tolink [file join $i $j]
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  688)                   }
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  689)                   $o_cons update [incr bcur] $bcnt
  81d4d3dd (Shawn O. Pearce     2007-09-24 08:40:44 -0400  690)                   update
  ab08b363 (Shawn O. Pearce     2007-09-22 03:47:43 -0400  691)           }


Hmmph. 81d4d3dd and ab08b363 are the relevant commits:

  commit 81d4d3dddc5e96aea45a2623c9b1840491348b92
  Author: Shawn O. Pearce <spearce@spearce.org>
  Date:   Mon Sep 24 08:40:44 2007 -0400

    git-gui: Keep the UI responsive while counting objects in clone
    
    If we are doing a "standard" clone by way of hardlinking the
    objects (or copying them if hardlinks are not available) the
    UI can freeze up for a good few seconds while Tcl scans all
    of the object directories.  This is espeically noticed on a
    Windows system when you are working off network shares and
    need to wait for both the NT overheads and the network.
    
    We now show a progress bar as we count the objects and build
    our list of things to copy.  This keeps the user amused and
    also makes sure we run the Tk event loop often enough that
    the window can still be dragged around the desktop.
    
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

  commit ab08b3630414dfb867825c4a5828438e1c69199d
  Author: Shawn O. Pearce <spearce@spearce.org>
  Date:   Sat Sep 22 03:47:43 2007 -0400

    git-gui: Allow users to choose/create/clone a repository
  ...
    Rather than relying on the git-clone Porcelain that ships with
    git we build the new repository ourselves and then obtain content
    by git-fetch.  This technique simplifies the entire clone process
    to roughly: `git init && git fetch && git pull`.  Today we use
    three passes with git-fetch; the first pass gets us the bulk of
    the objects and the branches, the second pass gets us the tags,
    and the final pass gets us the current value of HEAD to initialize
    the default branch.
    
    If the source repository is on the local disk we try to use a
    hardlink to connect the objects into the new clone as this can
    be many times faster than copying the objects or packing them and
    passing the data through a pipe to index-pack.  Unlike git-clone
    we stick to pure Tcl [file link -hard] operation thus avoiding the
    need to fork a cpio process to setup the hardlinks.  If hardlinks
    do not appear to be supported (e.g. filesystem doesn't allow them or
    we are crossing filesystem boundaries) we use file copying instead.
    
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>


My guess is, around this time period (Sept. 2007) git-clone was
actually git-clone.sh (Yup, it was built-in in 8434c2f1afed "Build
in clone" Apr 2008).  Clone on Cygwin through git-clone.sh was very
slow compared to clone in Tcl using a native Win32 wish process...

Today with git-clone in C, this is a WTF.  But at the time, it was
a nice performance boost on the Windows platform.  And nobody has
tried to clean this up yet in git-gui.

Yay.  My point about commit messages is still valid.  :-)

-- 
Shawn.
