From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is
 ignored by git?
Date: Fri, 9 Apr 2010 10:02:15 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100409140215.GB27899@thyrsus.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com>
 <m3sk74hjkg.fsf@localhost.localdomain>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 16:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0EnP-0006mO-D3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 16:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0DIOCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:02:18 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52109
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0DIOCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 10:02:16 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 5095A475FEF; Fri,  9 Apr 2010 10:02:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3sk74hjkg.fsf@localhost.localdomain>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144433>

Jakub Narebski <jnareb@gmail.com>:
> There is also
> 
>         git status --short

Not documented in my installed version, 1.6.3.3.  Where can I go in the
repo to read about this?

> > Our canonical list (omitting two that apply only to locking systems)
> > is:
> > 
> >   'up-to-date        The working file is unmodified with respect to the
> >                      latest version on the current branch, and not locked.
> 
> In Git you don't have locking, but you have three versions: in the
> working area (the working file), in the index, and latest version on
> the current branch (the HEAD version).
> 
> So 'up-to-date in Git would probably mean working tree = cached = HEAD
> version.

Yes, that was what I thought.  Is this what ls-files is reporting as 'H'?  

(The ls-files -t codes need better documentation.  If I get detailed enough
answers, I will write some.)
 
> > 
> >   'edited            The working file has been edited by the user.
> 
> Does this include stat-dirty files, i.e. if file has been modified
> (mtime), but the contents is the same in working file and in HEAD
> version?

No, it does not.  Thank you for asking that question, I have just
added a note about this to the VC code exactly where it will do the
most good.

> > 
> >   'needs-update      The file has not been edited by the user, but there is
> >                      a more recent version on the current branch stored
> >                      in the master file.
> 
> Needs *update* looks like it came from centralized VCS like CVS and
> Subversion, where you use update-the-commit method.  You can't say
> that HEAD version is more recent that working file...
> 
> The rought equivalent would be that upstream branch for current
> branch (e.g. 'origin/master' can be upstream for 'master' branch) is
> in fast-forward state i.e. current branch is direct ancestor of
> corresponding upstream branch, and the file was modified upstream.

Agreed. But there's no way to tell that this is the case without 
doing a pull operation or otherwise querying origin, and I'm
not going to do that.

Explanation: My general rule for DVCS back ends is that the status commands
aren't allowed to do network operations, and it's OK for them not to
report a state code if that would be required.  This is so VC will fully
support disconnected operation when the VCS does.

I have, however, added a note to vc-git.el explaining that this is
possible if we ever teach the mode front end to behave differently when
it knows it has live Internet.  I might do this in the future.
 
> > 
> >   'needs-merge       The file has been edited by the user, and there is also
> >                      a more recent version on the current branch stored in
> >                      the master file.  This state can only occur if locking
> >                      is not used for the file.
> 
> This, like 'needs-update, looks like it is relevant only in
> update-the-commit workflow centralized VCS.

Following your previous logic, I think it would make sense to set this if 
we could detect that the upstream of the current branch has forward commits 
touching this file.  Again, this would require a network operation in the
general case.

> >   'conflict          The file contains conflicts as the result of a merge.
> 
> Note that with Git you can have other merge conflict than simple
> CONFLICT(contents).  With CONFLICT(rename/rename) for example the file
> would not contain textual conflict, so e.g. it won't have conflict
> markers, etc.

It is unclear what Emacs wants in this situation; I will try to find out.
The documentation says this:

                     For now the conflicts are text conflicts.  In the
                     future this might be extended to deal with metadata
                     conflicts too.

I don't think anyone was thinking about rename/rename conficts...
 
> > I am unclear on what your "unmerged" (M) status means.
> 
> Probably 'conflict.

That was my best guess too.  Can anyone say more definitely?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
