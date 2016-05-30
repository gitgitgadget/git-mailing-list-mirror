From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [RFC] Triangular Workflow UI improvement
Date: Mon, 30 May 2016 10:46:40 +0200
Message-ID: <521237FA-0DC4-4C47-AB44-778888A7726F@grenoble-inp.org>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org> <xmqqwpmgvfif.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>, peff@peff.net,
	artagnon@gmail.com, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 10:46:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7IqW-0002Rc-9k
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 10:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbcE3Iqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 04:46:44 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:36418 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbcE3Iqo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 04:46:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 81A5F247F;
	Mon, 30 May 2016 10:46:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDfYXDXoI-hQ; Mon, 30 May 2016 10:46:41 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 70559246D;
	Mon, 30 May 2016 10:46:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 6D6AE2077;
	Mon, 30 May 2016 10:46:41 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6yuCW329-8-r; Mon, 30 May 2016 10:46:41 +0200 (CEST)
Received: from eduroam-032091.grenet.fr (eduroam-032091.grenet.fr [130.190.32.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3E78E2066;
	Mon, 30 May 2016 10:46:41 +0200 (CEST)
In-Reply-To: <xmqqwpmgvfif.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295872>

>> We are working on full implementation of triangular workflow feature=
=2E
>> For now, the main options available are:=20
>> 	 - branch.<name>.pushRemote
>> 	 - remote.pushDefault
>> And only setable by hands.=20
>=20
> And once it is set, you do not have to worry about it.  I am not
> sure per-branch thing is all that useful, unless you are always
> working on a single branch like 'master', but the latter would be
> just set once and forget about it.

We got the example of our fork of git(e.g. GitHub).=20
We want :=20
 - some branches that only fetch from git/git and push to our/git
 - the others branches fetch from and push to our/git.=20
=46or now, we have to change branch.<name>.remote and=20
branch.<name>.pushRemote(or remote.pushDefault).=20
With branch.<name>.fetchRemote, we only have to set this one.=20
fetchRemote is more explicit than remote for that case.=20

Another point is that many commands can erase the old=20
value of branch.<name>.remote.=20

>> Context:
>> 	- One main remote repository, e.g. git/git.
>> 	- A remote fork (e.g. a GitHub fork) of git/git, e.g. me/git.
>> 	- A local clone of me/git on the machine
>> Purposes:
>> 	- the local branch master has to fetch to git/git by default
>> 	- the local branch master has to push to me/git by default
>=20
> Wouldn't remote.pushDefault be the single thing you need to set just
> once and forget about it?  Why would your users even want to do
> these things =E2=80=A6

remote.pushDefault overrides branch.<name>.remote for all branches.=20
The goal is to give an easily understandable config for=20
complex configuration.=20
Having all the configuration in the same part (e.g [branch =C2=AB maste=
r =C2=BB])=20
is easier to understand and edit.=20

>=20
>> 	c. add `git fetch --set-default` in order to set remote.fetchDefaul=
t
>> 	d. add `git fetch --set-remote` in order to set branch.<name>.fetch=
Remote
>> 	e. add `git pull --set-default` in order to set remote.fetchDefault
>> 	f. add `git pull --set-remote` in order to set branch.<name>.fetchR=
emote
>> 	a. add `git push --set-default` in order to set remote.pushDefault
>> 	b. add `git push --set-remote` in order to set branch.<name>.pushRe=
mote
>=20
> ... just to configure many variables every time they work on a new
> branch?

branch.<name>.pushRemote and all these options are optional.
Options in commands may not be added. It just gives user=20
friendly interaction with these options. =20



To conclude:=20
This feature is more about configuration clarity than possibility itsel=
f.=20
