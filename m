From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 21:01:47 +0200
Message-ID: <20101021190146.GC28700@nibiru.local>
References: <20101020085859.GA13135@do> <7v8w1svate.fsf@alter.siamese.dyndns.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:10:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90XK-0003Qn-Ko
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab0JUTKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:10:33 -0400
Received: from caprica.metux.de ([82.165.128.25]:58995 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757490Ab0JUTKc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 15:10:32 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LJBtds011897
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:12:00 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LJBN6t011844
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:11:23 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LJ1ml7013088
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:01:48 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8w1svate.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159543>

* Junio C Hamano <gitster@pobox.com> wrote:

> If you set GIT_DIR, we do no discovery, so git will work only from the
> root level of the working tree (or bare repository operation) if you do
> not tell us where the working tree is.

Well, we could look at config whether it's an non-bare repo and then
lookup worktree via core.worktree (which would default to "../").


BTW: the whole discovery process IMHO should start w/ looking for 
the gitdir. Could be done this way:

a) explicitly given (via GIT_DIR or --git-dir), take this one.
b) else: recursively scan for a valid .git dir from cwd upstairs to /

Once we've found gitdir, we can look for the worktree. Again:

a) explicitly given, then take it
b) bare repo: dont have any, bail out
c) non-bare repo: look up via core.worktree (w/ default to $GIT_DIR/../)
 
> Shouldn't all of these 16 be the same, if the repository is bare?  What is
> your definition of bareness?  core.bare?  In any case we should say "you
> are using a bare repository, there is no working tree" and cwd shouldn't
> change in these cases.  They are all bare and there is no working tree.

ACK. In a bare repo, the worktree lookup will fail per definition, so
worktree operations can only run with having it explicitly given.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
