From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Keeping the file modification date with git
Date: Fri, 28 Jan 2011 20:49:39 +0100
Message-ID: <87bp30vmek.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 21:04:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiuYh-0005Gn-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 21:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab1A1UEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 15:04:34 -0500
Received: from minou.info.enstb.org ([193.50.97.146]:56845 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1A1UEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 15:04:33 -0500
X-Greylist: delayed 890 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2011 15:04:33 EST
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.3/8.14.3/Debian-9.4) with ESMTP id p0SJnd5B005957
	for <git@vger.kernel.org>; Fri, 28 Jan 2011 20:49:40 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165638>

After heavily using git for code development, we plan to use it for
administrative storage and I need to keep the modification date
of the files.

Since I'm fond of git, I don't want to go back to some other tools I
previously used but that keep the modification date... :-)

So I'm envisioning different solutions:

- it is already done. I have missed this. :-) But would be great. :-)

- giving up. Not an option :-)

- it is added to git core functions because it is quite useful for some
  people. Too time-consuming for me since I'm not a git developer... Bu=
t
  someone else could do this...

- add this concept aside. For example, just as there are .gitignore or
  .gitattributes files, we could have a .gitdates that would store in a
  human-readable manner the modification time of the files in its
  directory.

  A nice side effect is that if we have conflicts on modification times
  during merge, we could just resolve conflict in the date file. :-) Of
  course, having merge tools aware of this could help the user to deal
  with this.

  By the way, we could consider modification time as a special attribut=
e
  in .gitattributes to avoid yet another .git file? But I guess that th=
e
  date information may be huge for a big directory, so it may be better
  to keep in a dedicated sorted file, to be processed efficiently
  without messing .gitattributes

  The implementation could be done with helper functions called from
  various hooks such as:

    - updating the .gitdates could be done in the pre-commit hook so
      that they are added to the commit when needed;

    - when a checkout is done, the date of some files may be update. I
      cannot see any hook for this...

  Well there are many things that should be triggered in the git
  plumbing or the user should have to launch explicitly some helper
  functions (for example to commit only a date change, since from the g=
it
  point of view, nothing has changed and the commit is not done...).

  I have no idea about the execution time we would have on a big
  repository with many files, with a naive implementation to test the
  concept...

Any comments on the different approaches?

Thanks,
--=20
  Ronan KERYELL                      |\/  GSM:    (+33|0) 6 13 14 37 66
  HPC Project                        |/)  Fax:    (+33|0) 1 46 01 05 46
  9 Route du Colonel Marcel Moraine  K    E-mail: rk@hpc-project.com
  92360 Meudon La For=C3=AAt              |\   skype:keryell
  FRANCE                             | \  http://hpc-project.com
