From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 18:18:10 +0100
Message-ID: <200702021818.11368.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702021055.49428.jnareb@gmail.com> <20070202160317.GX10108@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 18:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD21x-0000A7-64
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 18:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945951AbXBBRQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 12:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945985AbXBBRQy
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 12:16:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:5029 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945951AbXBBRQx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 12:16:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so815748uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 09:16:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VjdG0Jg/Av7jZ/xd4Cklb28YEXlZJFGEiiP8W/6goY8J2xsobXPmLgL4uR/hHNBs91jr70k3F3Le725MtWP1gc4mqpO4XmAeKspl6FFtM6E+qsdwDLiUolIBID4vei0udp+zuCRRf+EyLs4d+X+qzeTYRsOw3fO0QuRDgLYZkPQ=
Received: by 10.67.19.20 with SMTP id w20mr4676792ugi.1170436611306;
        Fri, 02 Feb 2007 09:16:51 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id l33sm4606589ugc.2007.02.02.09.16.50;
        Fri, 02 Feb 2007 09:16:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070202160317.GX10108@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38517>

On 02.02.2004, Matt Mackall wrote:
> On Fri, Feb 02, 2007 at 10:55:48AM +0100, Jakub Narebski wrote:

>> How Mercurial solves problem of multiple _persistent_ branches? Does it
>> add pointers to commits somewhere deeper in changelog / revlog?
> 
> Each changeset may have a branch marker.

By changeset you mean commit-revlog (changelog)? 

Where those branch markers are stored? Are those markers moving pointers,
meaning that if you make a commit while on branch, branch marker for
current branch will move?

Static markers cannot identify branch in the presence of branch points:

                   ---a<---b ........ side branch
                  /
  1<---2<---3<---4<---5<---6<---7 ... main branch
            ^
            :   
             ''''' tag

> Here's branches in use with an import of mutt's CVS history:
> 
> $ hg branches
> mutt-0-94                      208:b2cc0abd8fe0
> HEAD                           207:a505693b54c1
> mutt-0-93                      134:d59345944030
> muttintl                       1:29510de8b3fc

What is the first number? I understand that second is shortened (is it
stored shortened, I wonder) hash identifier of a commit...

> $ hg co HEAD
> 176 files updated, 0 files merged, 8 files removed, 0 files unresolved

Git (at least for now) writes nothing on checkout; it is planned that
it would write changes status-like; perhaps summary would be enough...
or is it only working area status that is to be written...

> $ hg branch
> HEAD
> $ hg branch devel
> $ hg branch
> devel
> $ hg branch devel
> 
>> BTW does Mercurial have tags?
> 
> Yes. Both local and revision-controlled.

Revision-controlled (in-tree) tags are inane idea. Tags are non-moving
(and sometimes annotated) pointers to given point in history. They should
not depend on which branch you are, or what version you have checked out.

Otherwise the following would not work:
 $ git reset --hard v1.0.0
 $ git reset --hard v1.4.4.4
(it could be "git checkout" instead of "git reset --hard" in 'master'
version of git, with "detached HEAD" / "anonymous branch" feature).

>> Nice to know. You compress only file deltas, or also file revision
>> metadata? Do you compress manifests (trees) and commits (or at least
>> commit messages) too?
> 
> All three use the same underlying storage format, so yes.

But do you compress metadata (like base of a delta for file deltas,
authorship of a commit and reference to manifest-log entry)? Do manifest
is delta-encoded?

-- 
Jakub Narebski
Poland
