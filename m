From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Tue, 31 Mar 2009 17:57:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org> <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1799648784-1238515048=:7052"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LogMj-0005ka-JI
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758518AbZCaP5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 11:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZCaP5d
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:57:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51071 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756351AbZCaP5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 11:57:31 -0400
Received: (qmail invoked by alias); 31 Mar 2009 15:57:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp042) with SMTP; 31 Mar 2009 17:57:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JXa86Z/KJOaOx+GOW8KMPDRNwoA2jpf5T7Ws8Na
	brT5w9+NCiZOb+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115272>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1799648784-1238515048=:7052
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

I am a rather intense user of submodules, so I am quite interested.

Please take my comments as encouragement rather than discouragement.

On Tue, 31 Mar 2009, P Baker wrote:

> On 3/30/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> > IMHO, this is too vague.  *What exactly* are the features you want to 
> > add to git submodule?  Break this down by features, not by phases of 
> > coding.
> 
> The features I have been considering are:
> *move objects of submodules into base .git/ directory
> **This would, as I understand it: protect submodules from being
> overwritten and changes lost when switching between branches of the
> superproject that might or might not contain the submodules and
> centralize their management into one location.  The added benefits of
> fully using git's ability to branch and merge submodules makes it
> worth adding some complexity within the .git directory.

The main problem with renaming/deleting is not the repository of the 
submodule, but the working directoy.

> *use .git instead of .gitmodules
> **I actually don't know why this was included with the project
> description, I searched for an explanation of the desired name change
> on the mailing list and in commit messages, but came up with nothing.

AFAICT somebody thought that the information about the locations of the 
submodules should be in .git/ rather than in the working directory.  But 
of course, that is wrong: you want it to be tracked.

> *git submodule update --init should initialize nested levels of submodules
> **As an ease of use command, either an additional flag to recurse can
> be added, or it can act by default. As a requested feature on the
> mailing list, this is worth implementing.

I thought there was a patch to support "git submodule recurse"?  That 
would be rather less limited than yet another option to submodule update.

> *ability to update submodule pulled from svn repo
> **One workaround is to clone it as local copy using git-svn and then
> import that local clone as a submodule; clearly a clunky solution.
> There are many requests for this feature (see
> http://panthersoftware.com/articles/view/4/git-svn-dcommit-workaround-for-git-submodules
> for a typical example), and it makes sense integrating git-submodule
> with git-svn would expand submodule's usefulness.

I do not think that this would be good.  Both "git svn" and "git 
submodule" are rather complex by now, and mixing them would only 
complicate code.

> *make submodules deal with updated references
> **Instead of issuing merge conflicts on updated submodule references,
> this will allow submodules on default detached HEAD so that changes
> from the local repo can be committed without first pulling changes
> from the shared repo.

I'd rather call this "make git-submodule help with merging".

> *protect changes in local submodules when doing “git submodule update”
> **This is similar to the previous point, in that changes need to be
> protected or merged or warnings issued when updating the submodule.
> The potential to lose work with no warning is a big no-no.

One word: Reflogs.

> *make git submodules easy to remove
> ** See http://pitupepito.homelinux.org/?p=24, for an example of why
> this is a pain. Adding a submodule has ui, removing one should as
> well.

AFAIR there was already a patch to implement this, but the OP apparently 
did not address all issues.

> >  Further, you spend roughly a month writing method stubs.
> 
> Week max: end of May to beginning of June, but if I

... yes?

Ciao,
Dscho

--8323329-1799648784-1238515048=:7052--
