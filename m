From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [RFC][PATCH 0/3] Different views on a repository
Date: Fri, 26 Feb 2010 13:01:39 +0100
Organization: SUSE Labs
Message-ID: <201002261301.39243.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de> <c376da901002252012s507a6921q922e606bdce4b4fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkyt8-0001c5-Ke
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 13:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935729Ab0BZMBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 07:01:41 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37919 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935641Ab0BZMBk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 07:01:40 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 1B58F890B6;
	Fri, 26 Feb 2010 13:01:40 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <c376da901002252012s507a6921q922e606bdce4b4fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141123>

On Friday 26 February 2010 05:12:45 Adam Brewster wrote:
> The idea was to push from all of my repositories into a super repository
> with a fancy (and auto-generated) refspec.  The actual code is
> impenetrable, but reconstructing it in everybody's favorite IDE, gmail, I
> came up with
> 
> #!/bin/bash
> PROJECTS=$HOME/projects
> SUPER=$HOME/projects/.git-super-repo
> 
> [[ -d "$SUPER" ]] || \
>   (mkdir "$SUPER"; git --git-dir="$SUPER" init)
> 
> for i in $PROJECTS/*/.git; do
>   name=$(basename "$(dirname "$0")")
>   echo "$SUPER/objects" > $i/.git/objects/info/alternates
>   git --git-dir="$i" push -f "$SUPER" "*:refs/$name/*"
> done
> 
> git --git-dir="$SUPER" gc --aggressive
> 
> for i in $PROJECTS/*/.git; do
>   git --git-dir="$i" repack -Ad #unnecessary?
>   git --git-dir="$i" gc --aggressive
> done

I see, when multiple projects share the same objects, you push them into those 
projects independently first, and the script will later move them to $SUPER.

> Clearly I can lose data if I try to rebase $SUPER or something, but I think
> it's pretty safe for normal use.

It looks safe unless somebody messes with $SUPER.  A lot of repacking will 
still occur as part of moving stuff to $SUPER, though.

I was trying to set things up so that this extra work won't be necessary in 
the first place.

Thanks!

Andreas
