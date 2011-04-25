From: Jim Meyering <jim@meyering.net>
Subject: "git clone --depth=2 git://git.sv.gnu.org/gnulib" hangs
Date: Mon, 25 Apr 2011 22:28:10 +0200
Message-ID: <87aafedqjp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:28:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QESOt-0002Ep-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab1DYU2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 16:28:21 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33965 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459Ab1DYU2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 16:28:18 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id DC0DE9401D8
	for <git@vger.kernel.org>; Mon, 25 Apr 2011 22:28:11 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A95EF6013A; Mon, 25 Apr 2011 22:28:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172042>

Hello,

We've had a report that this command is hanging:

    git clone --depth=2 git://git.sv.gnu.org/gnulib

cloning without --depth=N works, as well as when using an ssh:// URL,
but most people can use ssh:// URLs.

Normally it wouldn't be much of a problem, but many projects
use gnulib as a submodule, and one of the recommended (scripted)
ways to get a copy is via a shallow clone.

savannah's server is running git-1.7.2.5.
I've confirmed it using these client versions:

    1.7.5.rc3.316.gd1ff9
    1.7.4.4

GIT_TRACE didn't give much info:

    xx$ GIT_TRACE=1 git clone --depth 2 git://git.sv.gnu.org/gnulib
    trace: built-in: git 'clone' '--depth' '2' 'git://git.sv.gnu.org/gnulib'
    Cloning into gnulib...
    trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' \
      '--keep=fetch-pack 645 on xx.meyering.net'
    trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' \
      '--keep=fetch-pack 645 on xx.meyering.net'
    trace: built-in: git 'index-pack' '--stdin' '-v' '--fix-thin' \
      '--keep=fetch-pack 645 on xx.meyering.net'

It appears to be something specific to the gnulib repository,
since I can do a shallow clone of e.g., this one just fine:

    git://git.savannah.gnu.org/parallel.git

Any hints?

At worst I'll set up a git server on a private system and debug it --
eventually.

Regards,

Jim
