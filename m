From: Eric Raymond <esr@thyrsus.com>
Subject: Status of all files (was: Re: How can I tell if a file is ignored
 by git?
Date: Fri, 9 Apr 2010 07:32:48 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100409113248.GB27353@thyrsus.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 13:32:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0CSE-0003Qc-UH
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 13:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab0DILct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 07:32:49 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33069
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0DILcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 07:32:48 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 1AC6120CBBC; Fri,  9 Apr 2010 07:32:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144424>

Jacob Helwig <jacob.helwig@gmail.com>:
> On Thu, Apr 8, 2010 at 21:04, Eric Raymond <esr@snark.thyrsus.com> wrote:
> > I'm planning some work on Emacs VC mode.
> >
> > I need a command I can run on a path to tell if it's ignored by git.
> 
> What about a variant of:
>     git ls-files -i -o --exclude-standard

That will do nicely, thank you.

There could be something better.  Emacs VC mode, and other similar
front ends, would be greatly aided by a command that lists all files,
each with a status code it can understand.  Our canonical list
(omitting two that apply only to locking systems) is:

  'up-to-date        The working file is unmodified with respect to the
                     latest version on the current branch, and not locked.

  'edited            The working file has been edited by the user.

  'needs-update      The file has not been edited by the user, but there is
                     a more recent version on the current branch stored
                     in the master file.

  'needs-merge       The file has been edited by the user, and there is also
                     a more recent version on the current branch stored in
                     the master file.  This state can only occur if locking
                     is not used for the file.

  'added             Scheduled to go into the repository on the next commit.

  'removed           Scheduled to be deleted from the repository on next commit.

  'conflict          The file contains conflicts as the result of a merge.

  'missing           The file is not present in the file system, but the VC
                     system still tracks it.

  'ignored           The file showed up in a dir-status listing with a flag
                     indicating the version-control system is ignoring it,

  'unregistered      The file is not under version control.

The -t mode of ls-files appears to be almost what is wanted, but not quite.
(Among other things, it does not list ignored files.)  I request comment
on some related questions:

1. How do these statuses map to git terminology?  My tentative map, in terms 
of git file-list -t codes, is

up-to-date   = H?
edited       = C
needs-update = no equivalent
needs-merge  = no equivalent
added        = no equivalent
removed      = K
conflict     = no equivalent
missing      = R
ignored      = no equivalent
unregistered = no equivalent

I am unclear on what your "unmerged" (M) status means.

2. I've played with various option combinations, but I can't seem to find one
that lists these codes for all files.  Is there one?

3. Is the use case for -t such that it would make sense to modify it so
it does a complete listing?

4. If the answer to question 3 is 'yes', is there some Emacs user here
who already knows git internals and would be willing to do this in
order to help VC be faster and more effective?  I would handle the VC
end, of course.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
