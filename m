From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 12:23:20 +0200
Message-ID: <20080721102320.GA19776@atjola.homenet>
References: <488452D6.1060508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsZC-0007gH-6D
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbYGUKXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 06:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYGUKXZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:23:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:50765 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755145AbYGUKXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:23:24 -0400
Received: (qmail invoked by alias); 21 Jul 2008 10:23:22 -0000
Received: from i577B81BB.versanet.de (EHLO atjola.local) [87.123.129.187]
  by mail.gmx.net (mp003) with SMTP; 21 Jul 2008 12:23:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/1HzYdwav1x0Xq2HBo7ZVlTzz3Zmwy4918q5MxLm
	ZGqxLJKZuEN7hJ
Content-Disposition: inline
In-Reply-To: <488452D6.1060508@keyaccess.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89334>

On 2008.07.21 11:11:50 +0200, Rene Herman wrote:
> Good day.
>
> A while ago I was here asking about "git pull" versus "git merge" for=
 =20
> local branches -- now I see a difference for remote ones that I'm not=
 =20
> sure should be there.
>
> I gathered before that "git pull <remote> <branch>" should basically =
be =20
> shorthand for "git fetch <remote>, git merge <remote>/<branch>". Is t=
hat =20
> correct?
>
> I'm seeing a problem I believe with a specific repository:
>
> rene@7ixe4:~/src/linux/7ixe4$ git remote show tiwai
> * remote tiwai
>   URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>   Tracked remote branches
>     devel dma-fix for-linus master upstream
>
> with "git pull tiwai devel" everything goes well:
>
> rene@7ixe4:~/src/linux/7ixe4$ git status
> # On branch master
> nothing to commit (working directory clean)
> rene@7ixe4:~/src/linux/7ixe4$ git branch tmp0 v2.6.26
> rene@7ixe4:~/src/linux/7ixe4$ git branch tmp1 v2.6.26
> rene@7ixe4:~/src/linux/7ixe4$ git checkout tmp0
> Switched to branch "tmp0"
> rene@7ixe4:~/src/linux/7ixe4$ git pull tiwai devel
> Updating bce7f79..e0bf09b
> Fast forward
>  Documentation/sound/alsa/ALSA-Configuration.txt    |   17 +-
>  [ ... ]
>
> and I get a clean merge.

"git pull remote branch" does "git fetch remote branch". That only
fetches that single branch and stores it in FETCH_HEAD. The merge part
then merges what is in FETCH_HEAD into your current branch.

> On the other hand, if I try to do this with a  fetch/merge, I get:
>
> rene@7ixe4:~/src/linux/7ixe4$ git checkout tmp1
> Switched to branch "tmp1"
> rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
> From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>  ! [rejected]        devel      -> tiwai/devel  (non fast forward)
>  ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
>  ! [rejected]        master     -> tiwai/master  (non fast forward)

The rejected branches had their history rewritten since your last fetch=
=2E
Git rejects to update your remote tracking branches in that case. The
history rewriting might have been an accident, or it might have been
intentional. Only the owner of that repo is able to tell that.

You can use -f to force the updates.

> rene@7ixe4:~/src/linux/7ixe4$ git merge tiwai/devel
> Auto-merged sound/pci/ac97/ac97_patch.c
> Auto-merged sound/pci/emu10k1/emu10k1_main.c
> Auto-merged sound/pci/hda/patch_analog.c
> Auto-merged sound/pci/hda/patch_realtek.c
> CONFLICT (content): Merge conflict in sound/pci/hda/patch_realtek.c
> Auto-merged sound/pci/hda/patch_sigmatel.c
> Automatic merge failed; fix conflicts and then commit the result.
>
> and me no happy...
>
> It probably has something to do with that " ! [rejected]" but what is=
 =20
> that about? Is the repo bad? (and if so, I suspect owner will want to=
 =20
> know how to avoid it in the future).
>
> And if it is bad, should I be seeing something with the pull method =20
> also? Moreover... can I now trust my tmp0 branch?

Your fetch/merge approach was different from what your pull approach
did. tiwai/devel did not get updated by the fetch, which means that you
tried to merge the old state of that branch and that caused some
conflicts. OTOH the pull did fetch the latest state from the remote rep=
o
and merged that cleanly.

Your fetch/merge approach was more like "git pull" without any
arguments, but with the current branch setup to track tiwai/devel. In
that case, pull really does a "git fetch tiwai", and it should fail in
the same way.

Bj=F6rn
