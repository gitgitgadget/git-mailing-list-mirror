From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Wed, 24 Sep 2008 02:10:27 +0200
Message-ID: <20080924001027.GA19264@neumann>
References: <48D95836.6040200@op5.se>
	<20080923162211.d4b15373.stephen@exigencecorp.com>
	<48D95FE1.30200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 24 02:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiHyv-0001oc-DZ
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 02:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYIXAKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Sep 2008 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYIXAKk
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 20:10:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:52045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbYIXAKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 20:10:39 -0400
Received: from [127.0.1.1] (p5B1335E4.dip0.t-ipconnect.de [91.19.53.228])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1KiHxb0gFD-00057t; Wed, 24 Sep 2008 02:10:31 +0200
Content-Disposition: inline
In-Reply-To: <48D95FE1.30200@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+f/qK49qB3dm5NGQ7cc8EjFP+4TEhwAu0y1Aw
 43LjfhEtpOjcYcAOm6KYjo4rtLuaTs6DQ5KIv5MepFRe1q61DR
 XoFw57lYIA31Gu0TwpMmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96614>

Hi Andreas,

=46irst of all, thanks for the work!

On Tue, Sep 23, 2008 at 11:30:09PM +0200, Andreas Ericsson wrote:
> It requires a bit of testing though. All the t/t34* tests pass with
> all the patches applied, and some manual tries worked just fine too,
> but if you wanna give it a twirl where you work, that'd be great.
Unfortunately in my example workflow[1] posted earlier today your
patch series does not work in the way I would like it to behave.

The following DAG is created by the commands below:

  -A---B      master
    \
     C---M    topic
      \ /
       D

  git init
  echo 1 >foo
  git add foo
  git commit -m 'first on master'       # A
  echo 2 >>foo
  git commit -m 'second on master' foo  # B
  git checkout -b topic HEAD^
  echo 1 >bar
  git add bar
  git commit -m 'first on topic'        # C
  git checkout -b subtopic
  echo 1 >baz
  git add baz
  git commit -m 'first on subtopic'     # D
  git checkout topic
  git merge --no-ff subtopic            # M

If I now execute 'git rebase -p master topic', I get the following:

  -A---B            master
    \   \
     \   C'---M'    topic
      \      /
       C----D

But I would rather like to have the following:

  -A---B            master
        \
         C'---M'    topic
          \  /
           D'

Would such a behaviour possible at all?


Thanks,
G=E1bor


[1] http://article.gmane.org/gmane.comp.version-control.git/96548
