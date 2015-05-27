From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Recovering from 'fatal: core.bare and core.worktree do not make
 sense'
Date: Wed, 27 May 2015 12:31:47 +0200
Message-ID: <20150527123147.Horde.GqzoX-7JvXiOGBlB5moP4A8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 12:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxYdD-0000Ue-LE
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 12:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbE0KcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 06:32:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:53231 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750959AbbE0KcJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 06:32:09 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YxYd6-0006t2-1b
	for <git@vger.kernel.org>; Wed, 27 May 2015 12:32:08 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YxYcl-0005tY-QV
	for git@vger.kernel.org; Wed, 27 May 2015 12:31:47 +0200
Received: from x590c2e9c.dyn.telefonica.de (x590c2e9c.dyn.telefonica.de
 [89.12.46.156]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 27 May 2015 12:31:47 +0200
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1432722728.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270040>


Hi,

the other day I said 'git config core.worktree /somewhere' in a bare
repo while thinking I was in a regular one, user error.  The 'fatal:
core.bare and core.worktree do not make sense' error from the next
command made me realize immediately that I was wrong, that's good.
However...

OK, let's have a look and recover from the situation:

    $ git config --edit
    fatal: core.bare and core.worktree do not make sense

Well, all was well before I set 'core.worktree', so let's unset it:

    $ git config --unset core.worktree
    fatal: core.bare and core.worktree do not make sense

Hmph, not expecting much, but how about unsetting the other
variable?

    $ git config --unset core.bare
    fatal: core.bare and core.worktree do not make sense

Good, at least it's pretty consistent, though I still don't get what
'git config' has to do with the worktree that is so important that
it has to bail out.  Time to look for help:

    $ git help config
    fatal: core.bare and core.worktree do not make sense

WTF :)
Alright, I give up:

    $ vim config
    $ # happy

It was two days later that I had a bit of a lightbulb moment,
reproduced the situation and just for fun tried this:

    $ git -c core.bare=3Dfalse config --unset core.bare

I didn't expect, but it worked!  Great.

Some thoughts:

    1) Perhaps 'git config' should be more careful in the first place
       and refuse to set 'core.worktree' when 'core.bare' is already
       true and vice versa.

    2) The damage was done with 'git config', so I expected that I can
       repair it with "plain" 'git config' (i.e. without 'git -c') as
       well.  'git config' has nothing to do with the path to the
       worktree after all.  And 'git config --edit' should work
       regardless of the mess that might be in the config file.

    3) 'git help <cmd>' should always work, shouldn't it?  (Though
       that's the easiest to remedy, just cd out of the repo, or fire
       up a new terminal window.)


G=C3=A1bor
