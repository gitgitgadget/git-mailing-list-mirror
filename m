From: Rene Herman <rene.herman@keyaccess.nl>
Subject: git pull versus fetch/merge
Date: Mon, 21 Jul 2008 11:11:50 +0200
Message-ID: <488452D6.1060508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 11:10:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKrPi-0005Hd-VR
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 11:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbYGUJJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 05:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbYGUJJi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 05:09:38 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:45213 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYGUJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 05:09:37 -0400
Received: from [213.51.146.190] (port=45209 helo=smtp1.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKrOi-0003Kv-OW; Mon, 21 Jul 2008 11:09:36 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:50909 helo=[192.168.0.3])
	by smtp1.tilbu1.nb.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1KKrOi-0004dv-FW; Mon, 21 Jul 2008 11:09:36 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89326>

Good day.

A while ago I was here asking about "git pull" versus "git merge" for 
local branches -- now I see a difference for remote ones that I'm not 
sure should be there.

I gathered before that "git pull <remote> <branch>" should basically be 
shorthand for "git fetch <remote>, git merge <remote>/<branch>". Is that 
correct?

I'm seeing a problem I believe with a specific repository:

rene@7ixe4:~/src/linux/7ixe4$ git remote show tiwai
* remote tiwai
   URL: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
   Tracked remote branches
     devel dma-fix for-linus master upstream

with "git pull tiwai devel" everything goes well:

rene@7ixe4:~/src/linux/7ixe4$ git status
# On branch master
nothing to commit (working directory clean)
rene@7ixe4:~/src/linux/7ixe4$ git branch tmp0 v2.6.26
rene@7ixe4:~/src/linux/7ixe4$ git branch tmp1 v2.6.26
rene@7ixe4:~/src/linux/7ixe4$ git checkout tmp0
Switched to branch "tmp0"
rene@7ixe4:~/src/linux/7ixe4$ git pull tiwai devel
Updating bce7f79..e0bf09b
Fast forward
  Documentation/sound/alsa/ALSA-Configuration.txt    |   17 +-
  [ ... ]

and I get a clean merge. On the other hand, if I try to do this with a 
fetch/merge, I get:

rene@7ixe4:~/src/linux/7ixe4$ git checkout tmp1
Switched to branch "tmp1"
rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
 From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
  ! [rejected]        devel      -> tiwai/devel  (non fast forward)
  ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
  ! [rejected]        master     -> tiwai/master  (non fast forward)
rene@7ixe4:~/src/linux/7ixe4$ git merge tiwai/devel
Auto-merged sound/pci/ac97/ac97_patch.c
Auto-merged sound/pci/emu10k1/emu10k1_main.c
Auto-merged sound/pci/hda/patch_analog.c
Auto-merged sound/pci/hda/patch_realtek.c
CONFLICT (content): Merge conflict in sound/pci/hda/patch_realtek.c
Auto-merged sound/pci/hda/patch_sigmatel.c
Automatic merge failed; fix conflicts and then commit the result.

and me no happy...

It probably has something to do with that " ! [rejected]" but what is 
that about? Is the repo bad? (and if so, I suspect owner will want to 
know how to avoid it in the future).

And if it is bad, should I be seeing something with the pull method 
also? Moreover... can I now trust my tmp0 branch?

Rene.
