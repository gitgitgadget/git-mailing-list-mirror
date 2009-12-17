From: David Antliff <david.antliff@gmail.com>
Subject: Re: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Thu, 17 Dec 2009 02:01:14 +0000 (UTC)
Message-ID: <loom.20091217T024907-524@post.gmane.org>
References: <loom.20091215T225528-115@post.gmane.org> <be6fef0d0912161705q1ef23634rccdc170d69cf9484@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 03:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL5gY-00068A-Fp
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 03:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763695AbZLQCBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 21:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763312AbZLQCBk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 21:01:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:43623 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbZLQCBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 21:01:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NL5gO-00065c-E7
	for git@vger.kernel.org; Thu, 17 Dec 2009 03:01:37 +0100
Received: from 202-27-34-1.dia.global-gateway.net.nz ([202-27-34-1.dia.global-gateway.net.nz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 03:01:36 +0100
Received: from david.antliff by 202-27-34-1.dia.global-gateway.net.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 03:01:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.27.34.1 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135355>

Tay Ray Chuan writes:
> On Wed, Dec 16, 2009 at 6:24 AM, David Antliff wrote:
> > I suspect what is happening is that the line conversion routine in git
> > might be
> > stripping trailing whitespace, as well as converting the line endings. This
> > operation is not properly accounted for in the reverse direction, and the
> > file is flagged as modified.
> 
> I am not a Git expert, but could it be your editor on Windows?

Hi Ray, thank you for responding.

This observation is made immediately after the clone, before any editor (or any
other program) even touches the files. If you can imagine doing a fresh clone
and then immediately doing 'git-status' and seeing modified files, you'd have a
pretty good idea of what I'm seeing. Git itself has somehow marked the files as
modified on check-out. I am fairly certain it's related to trailing whitespace
on one or more lines within the affected files.

If there's no trailing whitespace, git converts the file to CRLF on checkout
and shows no modification (since it knows to convert back when referring to
local repository).

> > Also, as cloned files are converted to DOS-line-endings, by default Cygwins
> > bash cannot run any scripts as they have the wrong line endings. I have to 
> > set the 'permanent' bash variable SHELLOPTS to include 'igncr' before bash
> > scripts can run. Perhaps this is wrong and git on Cygwin (with binary 
> > mounts) should be converting to UNIX line endings instead?
> 
> Again, IANAGE, but according to the manual, this should be expected,
> because Git, when writing to the filesystem, converts LF to CRLF:
> 
>   If true, makes git convert CRLF at the end of lines in text files to
>   LF when reading from the filesystem, and convert in reverse when
>   writing to the filesystem.

Yes, perhaps the advice to use autocrlf=true on Cygwin (in binary mount mode,
since in text mode git doesn't work *at all*) is misplaced since Cygwin is not
expecting CRLF endings in that mode. Apparently it's required for apps like
Kdiff3 however... all so confusing really...

The inability to run bash scripts straight out of git when using autocrlf=true
is almost enough to suggest to me that this mode really shouldn't be used in
Cygwin.
 
> > At one point I tried switching off core.autocrlf for myself but this
> > caused a lot of conflicts due to mismatched line-endings. It seems to me
> > that if we want to switch to this, *everyone* has to do it at once.
> 
> Just make this conversion a commit, and depending on your project's
> workflow, push/pull it.

Yes, I think that's how it has to be done. Unfortunately I have 20+ projects
each with many active branches. The entire conversion is possible but it's
going to take a while... :)

> Although the whole file will be marked as changed, you can always
> double-check that only whitespace changes have been made by running
> git-diff with --ignore-space-at-eol or -b.

That's a helpful option - thank you.


I'd be quite interested to know if people are successfully using git in Cygwin
with autocrlf=true, and if so how they are working around these modified-files
and bash-compatibility problems.

Also, is anyone using autocrlf=false in Cygwin successfully?

Thanks again for your reply.

-- David.
