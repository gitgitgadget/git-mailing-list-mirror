From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Wed, 06 Nov 2013 13:00:42 -0800
Message-ID: <xmqq38n98cud.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
	<CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 22:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeADa-0006Ic-UM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 22:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab3KFVAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 16:00:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756399Ab3KFVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 16:00:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65A764F777;
	Wed,  6 Nov 2013 16:00:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7b4A6BL6yWEQuphROal+gm0VJwc=; b=NkJFDa
	NYN0Mo5JcJKKW3Yxa3eGxcoiu7a4xQVKoL5NQS5W4kXjqPQj3qHb9I/fTcCjHItP
	o7kleeOEzmKCueA+xf603ccG02XiHLpYsHSVb9/BluSFsqaOTJs86OsmDqKUUR+j
	SRAxpQ8WbpphahP36OsDOiPEzj+2EQzngl3PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cO/wPJHKIdaMC6+p9Hii6yRaD/ieplQv
	WUoo/u8h2zFRrSDkiJCzoHUNnm3s0YvXnvdEkmF6rao+beijR8BvMQp8ceKrX2YI
	RGPQAeYpoHkSlGy+jfJewyROKmtedLLvgLbxPcjlyMQYNkT+PD3B2QMc4kQAruJI
	LgZmKT6AEJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B794F776;
	Wed,  6 Nov 2013 16:00:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A78AB4F773;
	Wed,  6 Nov 2013 16:00:43 -0500 (EST)
In-Reply-To: <CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 12:41:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 803C0668-4726-11E3-B8B4-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237369>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +test_expect_success 'use refspec' '
>>> +     git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
>>> +             grep "^commit " | sort | uniq > actual &&
>>
>> It feels somewhat redundant that you have to twice say that you are
>> pushing your "master", once with --refspec and then the branch
>> name.  Is this the best we can do?
>
> As this has been discussed before and no other solution came forward, yes.

We need to take that "no other solution came forward" with a grain
of salt.  After all, this is your itch, and if nobody was interested
in helping you (which I think that we both understand entirely
plausible, given the recent history), it only means you didn't think
of any other solution.

I didn't think things through, but at the external UI level, I see a
possibility of a nicer way to express the above.

In our "push" refspec (and export is about pushing what we have), a
colonless refspec A is a short-hand for A:A, so the traditional

	git fast-export master

can be thought of, in a new world order with a patch that lets you
do a ref mapping, a short-hand for an identical mapping:

	git fast-export master:master

It follows that the syntax naturally support

	git fast-export refs/heads/master:refs/heads/foobar

I would think.

That approach lets you express ref mapping without a new option
--refspec, which goes contrary to existing UI for any commands in
Git (I think nobody takes refspec as a value to a dashed-option in
the transport; both in fetch and push, they are proper operands,
i.e. command line arguments to the command), no?
