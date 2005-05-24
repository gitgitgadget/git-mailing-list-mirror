From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Mon, 23 May 2005 23:33:30 -0400
Message-ID: <4292A08A.5050108@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090800030703000708050102"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 05:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaQAr-00088k-J0
	for gcvg-git@gmane.org; Tue, 24 May 2005 05:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEXDfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 23:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEXDfA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 23:35:00 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:59636 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261355AbVEXDe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 23:34:29 -0400
Received: from [192.168.0.103] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-01.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j4O3Y1T3005486;
	Mon, 23 May 2005 23:34:01 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800030703000708050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Linus Torvalds wrote:
> [ Thomas added to cc, since he seems to have also worked on this ]
> 
> On Fri, 20 May 2005, H. Peter Anvin wrote:
> 
>>Here is my "main" OSS CVS repository; look at the syslinux module.  It 
>>has at least some minor branching.
> 
> 
> Ok, "cvsps" output scares me. I wonder what
> 
> 	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
> 	    memdisk/init32.asm:1.3=after, memdisk/Makefile:1.26=before. Treated as 'before'
> 	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
> 	    memdisk/init32.asm:1.3=after, memdisk/e820test.c:1.7=before. Treated as 'before'
> 	...
> 
> means..
> 

Ok.  I'll tell you.  It means that the committer uses bad practices in 
tagging ;-)  It generally means that force tag (cvs tag -F <file>) was 
used on a specific file.  Here's the scenario:

cvsps is trying to associate a tag to a specific commit.  But in the cvs 
world this is not always at all possible.  If, for example, a commit 
made and  all files are tagged.  Now some random file is modified and 
committed.  Then, a bug is found in a file from the previously tagged 
set, say the file 'memdisk/init32.asm'.  The bug is fixed, committed and 
the tag is MOVED for _just that file_ forward to the new version.  Now 
there is no commit that can be associated with the tag.  In this case, 
cvsps believes this to be a 'FUNKY' tag.  There is a more pathological 
case having to do with 'INVALID' tags...  It's enough to make a grown 
man cry.

> Also, your syslinux repo is interesting and shows another thing: doing a
> 
> 	cvsps -g -p separate
> 
> ends badly with
> 
> 	Directing PatchSet 938 to file separate/938.patch
> 	cvs rdiff: failed to read diff file header /tmp/cvso8PswZ for mdiskchk.com,v: end of file
> 	system command returned non-zero exit status: 1: aborting
> 
> which doesn't look very promising and causes an empty diff for
> mdiskck.com. Trying with --cvs-direct shows the reason:
> 
> 	Index: syslinux/sample/mdiskchk.com
> 	===================================================================
> 	RCS file: 
> 	/home/torvalds/src/osscvs/cvsroot/syslinux/sample/mdiskchk.com,v
> 	retrieving revision 1.1
> 	retrieving revision 1.2
> 	diff -u -r1.1 -r1.2
> 	Binary files /tmp/cvsU6MGU0 and /tmp/cvsiskFVR differ
> 
> which shows that anything that bases itself of diffs (ie uses "-g" with
> cvsps) is just doomed to failure, since there's no good way to handle
> binary data. Both Kay's and Thomas' scripts try to do the "-g" thing, 
> that's just not right.
> 

I accept patches ;-)  Honestly, handling binary data should be trivial I 
just haven't had the interest, and surprisingly noone else on the 
internet ever has.  The only binary file in the kernel appears to be the 
logo.gif, according to Ingo.

[ discussion on working around broken handling of binary files in cvsps]
> 
> There seems to be two questions:
> 
>  - what to do about branch creation (ie a branch name we haven't seen
>    before): it looks like cvsps doesn't tell you what the _originating_
>    branch was for a new branch (that may be my confusion - maybe you can't
>    create branches off branches in CVS?)
> 
>    For syslinux, it looks like you can always base it on HEAD, or possibly 
>    just the previous patch (which looks like it is always HEAD). The above 
>    pseudo-script will actually do that automatically, simply by virtue of
>    the "git-read-tree -m" at the top of the loop failing when the
>    branchname doesn't exist yet.
> 

See attached patch to cvsps.c which displays 'Ancestor branch' when this 
differs from Branch.

>  - whether to bother to create merge entries for when somebody tried to 
>    merge a branch back or forth in CVS. 
> 
>    CVS fundamentally doesn't have the notion of such a thing, and cvsps 
>    can't either. But we could try to guess, based on the commit message, 
>    perhaps.
> 
>    NOTE! Such a "merge" would not have any real GIT merge functionality 
>    what-so-ever. It would just introduce a second parent into the commit, 
>    nothing more.
> 
> Bah. What crud.
> 

Hey, a polished turd is only so shiny...  cvsps is a 99% solution [to 
the problem of extracting metatdata from cvs] only and cvs makes the 
other 1% impossible.

David

--------------090800030703000708050102
Content-Type: text/x-patch;
 name="show-ancestor-branch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="show-ancestor-branch.patch"

--- cvsps.c~	2003-04-11 10:06:01.000000000 -0400
+++ cvsps.c	2005-05-23 23:26:12.110231536 -0400
@@ -1402,6 +1402,16 @@
 	   tm->tm_hour, tm->tm_min, tm->tm_sec);
     printf("Author: %s\n", ps->author);
     printf("Branch: %s\n", ps->branch);
+    
+    /* check if ancestor was different branch */
+    if (!list_empty(&ps->members)) 
+    {
+	    PatchSetMember * psm = list_entry(ps->members.next, PatchSetMember, link);
+	    const char * abr = psm->pre_rev ? psm->pre_rev->branch : NULL;
+	    if (abr && strcmp(ps->branch, abr) != 0)
+		    printf("Ancestor branch: %s\n", abr);
+    }
+
     printf("Tag: %s %s\n", ps->tag ? ps->tag : "(none)", tag_flag_descr[ps->tag_flags]);
     printf("Log:\n%s\n", ps->descr);
     printf("Members: \n");

--------------090800030703000708050102--
