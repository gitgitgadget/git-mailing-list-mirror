From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 2 Dec 2014 09:47:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info> <xmqqh9y32e36.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info> <xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
 <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> <xmqq1tp643yb.fsf@gitster.dls.corp.google.com> <xmqqa936ohs3.fsf@gitster.dls.corp.google.com> <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2057546813-1417509585=:13845"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 09:47:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvj7k-0007rX-DR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 09:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaLBIrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 03:47:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:49428 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaLBIrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 03:47:51 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M2XkX-1YC13O0T1J-00sPl4;
 Tue, 02 Dec 2014 09:47:47 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.1412020940590.13845@s15462909.onlinehome-server.info>
X-Provags-ID: V03:K0:kLZ3BdOap1j4YYmvPHg+SovVJ8ou345PenfAHJnGXnvwMGbLaaJ
 TAl/7kVaMgYwhVJaLNsLyWIJIGPg6NMFBEyWVm1a3pA10JriYfDGW0QQNisfOmRMY3JTJ7X
 56gaesEDxOHkCGk+pCFez6IREcgPeOEehInpxE8Y5tOxb6J4HlqwStZuJcpYjxICJnQDF/K
 GN3+sN+sXZxk17FXw7OAQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260550>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2057546813-1417509585=:13845
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.1.00.1412020940591.13845@s15462909.onlinehome-server.info>

Hi Junio,

On Mon, 1 Dec 2014, Junio C Hamano wrote:

> When receive.denyCurrentBranch is set to updateInstead, this hook
> can be used to override the built-in "push-to-deploy" logic, which
> insists that the working tree and the index must be unchanged
> relative to HEAD.  The hook receives the commit with which the
> tip of the current is going to be updated, and is responsible to
> make any necessary changes to the working tree and to the index to
> bring them to the desired state when the tip of the current branch
> is updated to the new commit.
>=20
> For example, the hook can simply run "git read-tree -u -m HEAD $1"
> to the workflow to emulate "'git fetch' going in the reverse
> direction with 'git push'" better than the push-to-deploy logic, as
> the two-tree form of "read-tree -u -m" is essentially the same as
> "git checkout" that switches branches while keeping the local
> changes in the working tree that do not interfere with the
> difference between the branches.

I like it.

The only sad part is that the already huge test suite is enlarged by yet
another extensive set of test cases (and those tests might not really
need to be that extensive because they essentially only need to make sure
that the hook is run successfully *instead* of trying to update the
working directory, i.e. a simple 'touch yep' hook would have been enough).
It starts to be painful to run the complete test suite, not only on
Windows (where this has been a multi-hour endeavor for me for ages
already). BuildHive (CloudBees' very kind offer of Jenkins CI for Open
Source, integrated conveniently with GitHub) already takes over an hour to
run the Git test suite =E2=80=93 and BuildHive runs on Linux, not Windows!

That means that everytime I push into a GitHub Pull Request, I have to
wait for a full hour to know whether everything is groovy.

Worse: when Git for Windows contributors (yes! they exist!) push into
their Pull Requests, I have to wait for a full hour before I can merge,
unless I want to merge something that the test suite did not validate!

So maybe it is time to start thinking about conciser tests that verify the
bare minimum, especially for rarely exercised functionality? I mean,
testing is always a balance between too much and too little. And at this
point, I am afraid that several well-intended, but overly extensive tests
increase the overall runtime of "make test" to a point where developers
*avoid* running it, costing more time in the long run than necessary.

In this particular case, I think that we really, really *just* need to
verify that the presence of the hook switches off the default behavior of
updateInstead. *Nothing* else is needed to verify that this particular
functionality hasn't regressed. I.e. something like:

+test_expect_success 'updateInstead with push-to-checkout hook' '
+=09rm -fr testrepo &&
+=09git clone . testrepo &&
+=09(
+=09=09cd testrepo &&
+=09=09echo unclean > path1 &&
+=09=09git config receive.denyCurrentBranch updateInstead &&
+=09=09echo 'touch yep' | write_script .git/hooks/push-to-checkout
+=09) &&
+=09git push testrepo HEAD^:refs/heads/master &&
+=09test unclean =3D $(cat testrepo/path1) &&
+=09test -f testrepo/yep
+'

would be more appropriate (although it probably has one or three bugs,
given that I wrote this in the mailer).

Ciao,
Johannes
--1784107012-2057546813-1417509585=:13845--
