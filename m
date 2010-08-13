From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: workflow with blessed, lieutenant, and developers
Date: Fri, 13 Aug 2010 18:47:36 +0200
Message-ID: <20100813164736.GA27540@nibiru.local>
References: <20100809092152.5f32646a@packard.rktmb.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 18:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjxZS-0007SK-Dy
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 18:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761859Ab0HMQ5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 12:57:23 -0400
Received: from caprica.metux.de ([82.165.128.25]:55145 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754613Ab0HMQ5X convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 12:57:23 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7DGv1k7019858
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 18:57:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7DGu9ku019819
	for git@vger.kernel.org; Fri, 13 Aug 2010 18:56:09 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7DGlaS1015071
	for git@vger.kernel.org; Fri, 13 Aug 2010 18:47:36 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20100809092152.5f32646a@packard.rktmb.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153476>

* Mihamina Rakotomandimby <mihamina@gulfsat.mg> wrote:

Hi,

> I would like to setup a similar thing but with=20
> - Only one lieutenant (me)
> - A blessed repository where I am the only one to push to
> - Developers who push to me (the lieutenant)

if you really want them to push to you (instead of pull-requests),
you could set up an ssh-based git repo, which restricts your devs
to just their own branches (via .ssh/authorized_keys and wrapper
commands) and do whatever you like (eg. generating pull-requests,
open a ticked in some issue tracker, etc) in the post-update hook.

> 1=B0) What command line do developers use to push to me but not to th=
e
> blessed (origin)?
> 2=B0) After they pushed to me, I have the choice to "approve" or "rej=
ect"
> a commit: what is the keyword and git option for that?
> 3=B0) I push the merge of approved commits to the blessed repository:
> what keywords and git options?

depends on your branch naming scheme.

man 1 git-push


you could even go some steps further and hack up wrappers/hooks
which let your dev's pushes to the main repo / mainline branch
to somewhere else (aka: masquerading). lets say your dev "Max"
pushes to master, this will actually create some new branch
"approveme/Max/$timestamp" instead of updating master itself.
now you can regularily look through these branches and decide=20
whether to merge or drop them.=20
(BTW: I'd recommend always rebasing to master before merging
into it - less chance of conflicts and cleaner history).=20

what you need is:

a) ssh key-authentication with individual per-user commands,
   which pass the dev's pushes to intermediate/temporary
   per-user repositories.=20
b) hack up an post-update hook in the intermediate repo(s),
   which push their updates into the main repo with proper
   rewritten ref names (eg. "approveme/$username/$timestamp).


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
