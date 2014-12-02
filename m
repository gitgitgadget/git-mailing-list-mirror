From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 02 Dec 2014 08:39:01 -0800
Message-ID: <xmqqtx1em2fu.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
	<xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
	<xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
	<xmqqa936ohs3.fsf@gitster.dls.corp.google.com>
	<xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvqTo-0007xq-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbaLBQjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 11:39:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753924AbaLBQjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 11:39:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0706237D1;
	Tue,  2 Dec 2014 11:39:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DqGSX0QzKhQEvuVnCN6AOX3k8DY=; b=oCNIts
	vUwv28tEUBOwyY1cw7XSwwcFn91f5VacJf3qxjgSg14aKLuw4y6lpUX0FzPTrIPT
	lYNno/IRLg6lOAsB31ilyxbdQ9GyK3OJYa0SVPN1XJ6se+y5mObZ9lppXHtw8vzu
	eOlbsqGpxR0j6cnPNZNc24ulGUqZYX3k7Ekd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PscihqoTJ1DsU0EmBRKRYBnpl3+zTzbh
	X0y3cP96irWB37C/V5zsQTJZ+jkov1hCnhc+gACdBaCsGIh29kKYiM7sGCZXn9kZ
	FeAHd5byqWYczpkMdhZbKvDclX1NNS0Asg9WU3mHg8LCUvDp5CqdEvLsCgB5LPX6
	Im1SjjycOII=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7235237D0;
	Tue,  2 Dec 2014 11:39:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B286237CF;
	Tue,  2 Dec 2014 11:39:03 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 2 Dec 2014 09:47:46 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B98E2302-7A41-11E4-B0FF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260573>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In this particular case, I think that we really, really *just* need to
> verify that the presence of the hook switches off the default behavior of
> updateInstead. *Nothing* else is needed to verify that this particular
> functionality hasn't regressed. I.e. something like:
>
> +test_expect_success 'updateInstead with push-to-checkout hook' '
> +	rm -fr testrepo &&
> +	git clone . testrepo &&
> +	(
> +		cd testrepo &&
> +		echo unclean > path1 &&
> +		git config receive.denyCurrentBranch updateInstead &&
> +		echo 'touch yep' | write_script .git/hooks/push-to-checkout
> +	) &&
> +	git push testrepo HEAD^:refs/heads/master &&
> +	test unclean = $(cat testrepo/path1) &&
> +	test -f testrepo/yep
> +'
>
> would be more appropriate (although it probably has one or three bugs,
> given that I wrote this in the mailer).

Not really.  You need to remember that we write tests not to show
off the new shiny, but to protect essential invariants from being
broken by careless others attempting to rewrite the implementation
in the future.

What needs to be tested for the feature are at the minimum:

 * The hook is not triggered when denycurrent is set to
   updateInstead; the posted version does not even test this, but it
   should.

 * The hook is run with the right settings, so that git commands it
   runs will operate on the right repository and its working tree,
   but without overspecifying how that "right settings" happens [*1*].

 * Non-zero exit from the hook will fail "git push", and zero exit
   from the hook will allow "git push" to pass.

 * Whether the hook returns a success or a failure, the working tree
   and the index is in the state the hook expects to give the user
   (i.e. nobody else further munges the working tree and the index
   after hook returns) [*2*].

The patch I posted is minimum to do so.  Compared to that, the "yep"
test is not checking anything of the importance, and only insists on
a single immaterial detail (i.e. hook must be run after cd'ing to
the top of the working tree).

I fail to see why it could be more appropriate.


[Footnote]

*1* Your version above assumes that the hook must run in the working
    tree, but it does not have to, if GIT_DIR and GIT_WORK_TREE are
    both exported; your test is overspecifying what should happen,
    and will reject a legitimate implementation of the feature.

*2* A hook may muck with the index or with the working tree and then
    return a failure.  I do not offhand see why a failing push
    should be allowed to contaminate the working tree that way, but
    whatever the hook does is what the user wishes, and we should
    not lose data coming from that wish.  The hook the test uses
    refrains from touching the working tree or the index when it
    fails, so the test checks that the working tree and the index
    are left as-is when it happens.
