From: Peter Williams <peter_ono@users.sourceforge.net>
Subject: Re: [HELP] Adding git awareness to the darning patch management system.
Date: Thu, 01 Dec 2011 10:56:59 +1000
Message-ID: <4ED6D0DB.3060800@users.sourceforge.net>
References: <4ED59232.3000807@users.sourceforge.net> <20111130072248.GG5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 01:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuxd-0005ah-0f
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab1LAA5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:57:06 -0500
Received: from nskntmtas02p.mx.bigpond.com ([61.9.168.140]:41675 "EHLO
	nskntmtas02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599Ab1LAA5F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 19:57:05 -0500
X-Greylist: delayed 4143 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Nov 2011 19:57:05 EST
Received: from nskntcmgw07p ([61.9.169.167]) by nskntmtas02p.mx.bigpond.com
          with ESMTP
          id <20111201005702.QRY3825.nskntmtas02p.mx.bigpond.com@nskntcmgw07p>;
          Thu, 1 Dec 2011 00:57:02 +0000
Received: from mudlark.pw.nest ([60.231.88.110])
	by nskntcmgw07p with BigPond Outbound
	id 3cwz1i00J2NqvbQ01cx1Vm; Thu, 01 Dec 2011 00:57:02 +0000
X-Authority-Analysis: v=2.0 cv=N56r5hBB c=1 sm=1
 a=4oA8PQ9VxmT3qXC7j3YPcQ==:17 a=h4cPaoHKHVIA:10 a=_56bU5205BEA:10
 a=IkcTkHD0fZMA:10 a=XUcmXZs-X4dhIuhWK6IA:9 a=0knzX4p5ATttZPO9bHIA:7
 a=QEXdDO2ut3YA:10 a=4oA8PQ9VxmT3qXC7j3YPcQ==:117
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
In-Reply-To: <20111130072248.GG5317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186155>

On 30/11/11 17:22, Jeff King wrote:
> On Wed, Nov 30, 2011 at 12:17:22PM +1000, Peter Williams wrote:
>
>> 1. presenting the file tree of the sources being patched in a way
>> that makes sense to the user including the current status of files
>> from the point of view of the underlying SCM (in this case, git), and
>
> I'm not exactly sure what this means.

If you look at the screenshots at sourceforge (which were produced on 
top of a Mercurial repo) you'll notice that file names in the left most 
tree have letters in front of them and appear in different foreground 
colours.  These letters are the same as those returned by Mercurial's 
status command and, hence, give a Mercurial user an easy to understand 
snapshot of the status of the files in the playground.  The colour 
coding is (relatively) arbitrary (and chosen by me) and is intended to 
make it easier to detect the different file statuses.

My main problem is that I can't find a git file status command (and 
there are a lot of them to choose from) that gives a snapshot of the 
statuses of all files in a directory (including those not tracked or 
ignored).  A secondary problem is that, if I could cobble together 
statuses from various commands, mapping git statuses to the Mercurial 
ones for display would not be a good solution as they would not 
necessarily make sense to a git user.  (It's fairly clear to me from my 
inability to make sense of git's CLI that git users think differently to 
me, a Mercurial user, and it's unlikely that I can, without help, make a 
file tree display that makes sense to a git user.)

>
>> 2. detecting files with uncommitted changes (from the SCM's point of
>> view) when the user adds them to a patch (or pushes a patch that
>> contains them) so that they may be alerted to the fact and offered
>> the choice of absorbing the uncommitted changes into the patch (or
>> not).
>
> For this, you probably want "git diff-files --name-only", which will
> show files with differences in the working tree. Keep in mind that git
> has an "index" or "staging area", which means that you have three states
> of content for a given path:
>
>    1. the state of the prior commit (i.e., HEAD)
>
>    2. the state that is marked to be committed when "git commit" is run
>       (i.e., the index)
>
>    3. the state in the working tree

This is a prime example of the different mindset of the git user to the 
hg user.

>
> You can compare the first two with "git diff-index", and the latter two
> with "git diff-files". You can also use "git status --porcelain" to get
> a machine-readable output that shows how the three states match up, with
> one line per file.

This is an example of why I'm confused.  There are too many ways to do 
(similar) things and it's hard to know which to use.

>
>> I've already implemented this interface for Mercurial (with which I
>> am familiar) and looked at doing the same with git but had difficulty
>> discovering the definitive mechanisms for obtaining the necessary
>> data.  So I'm soliciting your help in overcoming these problems.
>
> I hope the above helps you some. If not, just ask. It might be easier to
> understand what you are looking for if you can give concrete examples.

Maybe an example of why I think the feature is useful might help.  Say 
that you start editing a file and then decide that you want to put this 
change into a patch rather than committing it.  If you were using quilt 
you would have to do this manually by any of a number or ways such as:

$ <git diff command> file > temp.patch
$ <git revert command> file
$ quilt new one.patch
$ quilt add file
$ patch -p1 file < temp.patch
$ rm temp.patch

In darning, you just do:

$ darn new one.patch
$ darn add --absorb file

If you're using the GUI (the primary interface), it will report that the 
file has uncommitted changes and offer the choice of absorbing the 
changes into the new patch, forcing the new patch to consider the 
current file state as its starting point or (of course) cancel the 
addition.  The CLI command will fail if an attempt to add a file which 
has uncommitted changes is made unless either the --absorb or --force 
(which uses the file's current content as the starting point from the 
patches point of view) options are used.  (So, whichever interface is in 
use, you have to explicitly state how you want uncommitted changes to be 
treated.

The interface to the SCM to support this is two functions:

1: get_files_with_uncommitted_changes() which called with no arguments 
returns a list of the paths of all files with uncommitted changes or 
when given a list of file paths (the more common case) returns the 
subset of that list which have uncommitted changes; and

2. copy_clean_version_to(filepath, target_path) which makes a copy of 
the file as recorded in the prior commit and places it at the 
target_path (usually where darning stores the "original" for reference 
when creating diffs).

A similar mechanism is in place for the case where a file is added to a 
patch and the file is in an underlying patch with unrefreshed changes 
but this requires no help from the underlying SCM.

Both of these mechanisms also come into play when a patch is 
pushed/applied so that the user has (relatively painless) control over 
which changes end up in which patch.

With MQ and the above example, the file would be automatically added to 
the current patch (or a new patch if you created one) absorbing the 
changes whether you wanted it to or not.  I.e. there is no way of 
creating MQ patches that don't automatically absorb all uncommitted changes.

Thanks for your reply,
Peter
PS Darning can be used on top of git repository without "git awareness" 
but is not as useful as it would be with it.
