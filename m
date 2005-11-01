From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: hgmq vs. StGIT
Date: Tue, 01 Nov 2005 10:20:29 -0500
Organization: Network Appliance, Inc.
Message-ID: <436787BD.9080705@citi.umich.edu>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>	 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>	 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>	 <20051031195010.GM11488@ca-server1.us.oracle.com>	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>	 <20051031213616.GO11488@ca-server1.us.oracle.com>	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>	 <20051031224246.GP11488@ca-server1.us.oracle.com>	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905020002030807070107"
Cc: Petr Baudis <pasky@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, mason@suse.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 16:21:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWxwH-0000SH-Qb
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 16:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVKAPUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 10:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVKAPUi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 10:20:38 -0500
Received: from citi.umich.edu ([141.211.133.111]:50476 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1750861AbVKAPUh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 10:20:37 -0500
Received: from [10.58.48.215] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 5121D1BACD;
	Tue,  1 Nov 2005 10:20:30 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10934>

This is a multi-part message in MIME format.
--------------060905020002030807070107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 01/11/05, Petr Baudis <pasky@suse.cz> wrote:
> 
>>Did anyone do any current detailed comparison between hg mq and StGIT?
> 
> 
> Not AFAIK. I looked a bit at mq but didn't have time to play with it.
> 
> 
>>I'm very happy with StGIT, modulo few UI gripes I'm still not getting
>>around to fix, and the fact that I cannot version my changes to patches
>>- this is one advantage of having quilt stuff tracked by GIT, I think,
>>but that feels ugly.
> 
> 
> That's not too far away. Chuck Lever has a patch (and there were some
> other discussions in the past) for tracking the history of a patch.
> Basically, there would be another commit object, not reachable from
> HEAD but only via an StGIT command, which would chain all the versions
> of a patch. You would be able to view them with gitk for example.
> 
> My main issue was whether we should store every state resulted from a
> refresh  or use a separate command (somebody suggested 'freeze') to
> mark the states that should be preserved in the history. Chuck's patch
> implements the first. The drawback is that a future 'stg prune'
> command would not be able to remove the history and some states of the
> patch might not be useful (there are times when I do a refresh only to
> pop the patch and modify a different one, without any logical meaning
> for the state of the patch).
> 
> I'm open to other suggestions as well. Otherwise, Chuck's patch should
> do the job.

if there is interest i can post what i have.  unfortunately there's some 
other stuff in front of it so i don't think it will apply directly to 
catalin's stgit without some futzing.  in lieu of that, here's a command 
synopsis:

[cel@seattle ~]$ stg revisions -h
usage: stg revisions [options] [patch-name]

Display the change history of a patch or revert a patch to a previous
commit.  By itself, the command will display all committed changes,
ordered by date, of a patch.  Each committed change is listed with a
numeric label.  The label can be used with the --patch or --diff options
to examine specific changes in detail.  The --revert option can revert
a patch to any previous version.

options:
   --commit=commit-label
                         show the commit details of the specified commit
   --diff=commit-label   show changes between the specified commit and 
the next
   --file=<file name>    show changes made to a specific file
   --patch=commit-label  show the state of patch-name at the specified 
commit
   --revert=commit-label
                         revert the patch to the specified previous commit
   -h, --help            show this help message and exit
[cel@seattle ~]$

and some usage examples:

[cel@seattle main]$ stg revisions
Previous revisions of patch "revisions-command":
   0:    Sat Oct 1 21:54:43 2005 -0400
   1:    Sat Oct 1 21:58:45 2005 -0400
   2:    Sat Oct 1 22:13:27 2005 -0400
   3:    Sat Oct 1 22:55:28 2005 -0400
   4:    Sat Oct 1 23:02:22 2005 -0400

  ... snipped ...

   86:   Mon Oct 31 14:19:25 2005 -0500
   87:   Mon Oct 31 14:22:00 2005 -0500
   88:   Mon Oct 31 14:23:40 2005 -0500
   89:   Mon Oct 31 14:24:39 2005 -0500
   90:   Mon Oct 31 14:27:34 2005 -0500
[cel@seattle main]$

an entry is added to this list automatically after every operation that 
does a "refresh".

the idea is to expose and manipulate the change history of a patch 
without having to use cumbersome sha1 hash values.

without options, "stg revisions" shows a list of changes to a patch, by 
date.  each change has a label (just a number) which you can use to 
generate diffs and such.  to wit:

    stg revisions --patch=45

would show a diff between the previous patch, and the state of the patch 
at change 45.

    stg revisions --diff=45

would show a diff between change 45 and change 44.

    stg revisions --commit=45

would show pretty-printed commit information for change 45.

    stg revisions --revert=45

would revert the patch back to the way it was in change 45.  notably, 
you don't throw away changes 46 through 90 when you do this.  a new 
change is added which changes the state of the patch to the way it was 
in change 45.  (well, that's how it's supposed to work, anyway).

i'm interested to hear what folks on the list think of the idea.

--------------060905020002030807070107
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------060905020002030807070107--
