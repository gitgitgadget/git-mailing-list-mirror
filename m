From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 02 Dec 2014 09:00:32 -0800
Message-ID: <xmqqppc2m1fz.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
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
	<xmqqtx1em2fu.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412021744490.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvqoe-0002Wp-Fd
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbaLBRAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:00:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932303AbaLBRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:00:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F3E023DEC;
	Tue,  2 Dec 2014 12:00:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Nlet3izd3GiUb5Dt8ywO6nk3Xk=; b=i75QPQ
	TV2RejH98ML+uhi/a2FPeDvat0XqCJZKWFOvoKfUj3Mmii1RTFBscmq5Fsyac5p1
	eY8+LGmsG1FPbNL60G+QqhV4XR3SB1NHVw2bhUDlDAvkCbHqGI0OzAaV7CYvvyS1
	i1xPVRIJiJwDM7g+U9fle3RKn+2XDViP1ebwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGeqhvT5htfD0PhjX1IhoFdojZy6SOZo
	YxX92TjAWjKbJXjca3GkMDhda4kgZsKu4SramlKAd8jg7fO4KMHWvQD0pkCf1Zdk
	LaqoCBL0qEQxS4AAs6KnRXdmzYezNcrtNnV/PU3gjUWN7QIbJ5pAkJUekdOWF/e2
	dZcBA1Y9K5I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8676323DEA;
	Tue,  2 Dec 2014 12:00:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A38023DE8;
	Tue,  2 Dec 2014 12:00:34 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412021744490.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 2 Dec 2014 17:45:49 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BAF91262-7A44-11E4-9B44-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260576>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Not really.  You need to remember that we write tests not to show
>> off the new shiny, but to protect essential invariants from being
>> broken by careless others attempting to rewrite the implementation
>> in the future.
>
> Fair enough. You are the boss.
>
> I am not, therefore it does not matter what I think,

It is not that it does not matter because you are not the boss; it
is just that when you are wrong, you are wrong.

You said in your response to Michael:

    the difference between the "touch yep" ... and
    the test originally suggested is ...
    not the extent to which the new code is actually verified.

If your "verification" is based on "faith", you are correct.  You
may be "verifying" the code to the right extent, i.e. "Yes, what I
wrote is actually run, and I write perfect code every time, so what
it does must be correct, as long as it gets run".

But I do not have faith in people who will be touching the relevant
code in the future; "Yes, it is triggered" is far from satisfactory
without faith like yours in the code being tested.

I actually do not have much faith in what I write myself ;-).  That
is why we have tests.
