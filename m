From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 12:31:42 -0700
Message-ID: <7vppurv8bl.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdde-0002fm-16
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab3GITbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:31:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab3GITbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0B5D2F779;
	Tue,  9 Jul 2013 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wd46Sdn4iusTdN9pQyi+PXwyAWY=; b=CsFeY6
	wb/Lx4wXGkK+bjhII0Ti4MRlpz1V1uiJysz3RVfS383C6TbtMAxAoYgP6edzO7Cc
	+8oMx3gf5ZlYawPLHljbhLM6WESMtsyeEd5aCX5nSJpCBW6/ETWSSeekDqsvrBGF
	33Pf9jvKh04f3+pJH8v3ODWfwFVnXhrMxNtkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZTBVfDEJKCudNjAgBf8DMkYs+nMCIVHj
	wzLSHjZHMUSR3OwuJ5e1s24ybmcvdCncnhKC75JaEcDY54Qswb97VHtiOqPxc7nB
	celCEiMT54VmGmtnha0CcIOX/e7aPhsFwpXfvEMrh+ZyzQWbcb9YGqavwV6MPDkP
	/HfGCL18J8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A453C2F778;
	Tue,  9 Jul 2013 19:31:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 085852F776;
	Tue,  9 Jul 2013 19:31:43 +0000 (UTC)
In-Reply-To: <87a9lvcztv.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Tue, 9 Jul 2013 21:12:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FFB68A8-E8CE-11E2-8399-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229984>

Thomas Rast <trast@inf.ethz.ch> writes:

> If you define it that way, the output of
>
>   git blame -L 4,6; git blame -L /A/,+20
>
> is significantly different from
>
>   git blame -L 4,6 -L /A/,+20
>
> Not just in the presentation or any possible coalescing, but in the
> meaning of the ranges.
>
> Do you really want to make it that way?

Absolutely.  The primary reason I want to be able to specify two
ranges at the same time is to follow two functions in a file that
appear in separate places, and /A/ might not be unique.  When I want
to say "I want to see from here to there, and then from here to
there, and then from here to there", it would be very frustrating if
"and then" resets what I mean by "here" every time and make these
three evaluated independently.
