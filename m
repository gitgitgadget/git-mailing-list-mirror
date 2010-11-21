From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebuild repo from data, packfiles?
Date: Sat, 20 Nov 2010 22:19:15 -0600
Message-ID: <20101121041915.GA11884@burratino>
References: <auto-000024044659@sci.utah.edu>
 <20101121001643.GB27666@burratino>
 <auto-000024045093@sci.utah.edu>
 <20101121032707.GA11571@burratino>
 <auto-000024045181@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tom fogal <tfogal@sci.utah.edu>
X-From: git-owner@vger.kernel.org Sun Nov 21 05:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK1Oo-00068F-CT
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 05:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab0KUET2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 23:19:28 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52205 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0KUET1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 23:19:27 -0500
Received: by gxk23 with SMTP id 23so3483235gxk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 20:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ruF4kxYhnElbb+svcFPrCbl1tww8o692bjA827WYHpU=;
        b=ujvcDWzXcGSsU92z3r1XRSJQ8AUQrHAEb6EXiaghW8eOrbDvG9Fq+Ad26y2zRi1Osm
         sw71fFpOQqyKFbROnDtEKtoEWWjtvYeT3fU+JRM/CVGtBHybpiAU4LkrE96HXLksCgbe
         68y6Rh5r9P0ZtSkD1Rj1t9CYLFA5/VOpCBPvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cDToxM8zQwIcP4d3rmbuyXdgce+pVDmZS32+rUSAeHuK33DB4XH4zIaOVg7OYhruii
         XNLJnCIA4xmR9rzOnt/J/v79dbl6Sg/2RsY5CO+JuqXbmb3i+Mod6NftfKcHcxktvFsf
         ccByyp+sXVmhfCXt0aM0GMNwzRT+LiPZbbaYs=
Received: by 10.100.210.17 with SMTP id i17mr2875019ang.116.1290313167144;
        Sat, 20 Nov 2010 20:19:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d8sm3972223ana.2.2010.11.20.20.19.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 20:19:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <auto-000024045181@sci.utah.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161856>

Hi again,

Just a few more quick hints.

tom fogal wrote:

> I can't run it on the repository as-is.  After adding some metadata in
> .git (i.e. refs, config, HEAD), I get a lot of:
> 
>   broken link from    tree a22ef5ea2d15b29ccff0bd64aa2fa2c3259ea201
>                 to    blob 23ffd9cc867a2db93d0eb991383e29243dc4db51
> 
> and then many "dangling commit"s + "missing blob"s.

Nice.  If you're only missing blobs, that's much better than missing
trees or commits.  You might be able to use

 git rev-list --objects --all

to get some sense of paths for the blobs (and trees, if any) that are
missing.

> Sorry, yes, this is what I meant.  I'm hoping I can introduce a couple
> "oops, mucked up the history" gigantic commits into the middle of the
> history, created by saying "i know that I'm missing commits between
> these two; give me the tree diff here"

Thanks, I missed that before.

(In such a case I would use "git archive" to pull out the trees since
the result is closer to the actual data that is available, but your
approach is equally sane.)

> It probably helps that the server is svn; my history is completely
> linear (OTOH, if we were using git, I'm sure I would have cloned this
> at home instead of ssh'ing to work on it at various points...).

Ah!  You can also try using "git svn clone" to re-fetch the remote repo
and then include those objects in the .git/objects directory.  If
you're lucky, some of the missing blobs (or even trees or commits)
will be there. :)

> Don't I wish... this was just my workstation's copy.  There is of
> course the subversion repo && other clones of those revisions.

(or grab the pack and .idx from another clone)

> I had simply waited too long to push, and now I'm paying the price...

Yes, I made the same kind of mistake yesterday (wiped out the .git
dir completely) and ended up re-creating patches from the worktree.

> ./logs:
> total 96
> -rw-r--r-- 1 tf tf 95572 2010-11-04 16:01 HEAD
> drwxr-xr-x 4 tf tf    44 2010-10-26 17:13 refs
[etc]

These can be used to recover the refs in .git/refs, if any of the
branches is particularly important.  Once you've found the right
log entry,

	git update-ref <full ref name> <commit id> ""

will do it.  For example, something like this would print commands
to revive all branches:

	find .git/logs -type f -exec sh -c '
		refname=${1#.git/logs/} &&
		if test "$refname" = HEAD
		then
			exit 0
		fi &&
		printf "$refname " &&
		head -1 "$1"
	' - {} ';' |
	cut -d' ' -f1,3 |
	while read refname value
	do
		echo git update-ref "$refname" "$value" \"\"
	done
