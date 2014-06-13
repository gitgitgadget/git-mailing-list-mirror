From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 5/6] t7510: test verify-commit
Date: Fri, 13 Jun 2014 11:16:25 -0700
Message-ID: <xmqqha3o3cau.fsf@gitster.dls.corp.google.com>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
	<3aaf65288733117909150771cc62508f3236d107.1402655839.git.git@drmicha.warpmail.net>
	<20140613115125.GG14066@sigill.intra.peff.net>
	<539AEB41.6090306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 20:16:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvW1l-0002Zy-4z
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 20:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbaFMSQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 14:16:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65096 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbaFMSQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 14:16:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDF121F252;
	Fri, 13 Jun 2014 14:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnrNJlI4mg1PIqRtMYqqNc5qzQ4=; b=eoAgKY
	MiDOOjr3bDGN9+hXKKWf3SeGmJRqCUgqZ8yhl0ViEerdZnGdvvdhp1+bUBn29Bh1
	Wun1SPIFixH/+kmwIyI660mkKTf+PXsScyJhh58ejNpFHy0Oi/+tBRPcA6BcPanB
	Y5L2kMUkVYiBWF23nSFbOhMQvWhFys4YIqS3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WgE1YqHbYo0DeG6Pz0xjp120OdTmDNcN
	DWCDpWhUaJYA9rfsH67Rc67Z4+n/7l0/IsuYZTPzEGZ0BylhyAHVT6Il9UkOz/WC
	0oFR+fZweUUjMcg+/rj3HunVtFiCCnI37zRk+DpgpP+KDoNtcfypMELf7/+ewTFb
	ruhajFq9TPo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4C2C1F251;
	Fri, 13 Jun 2014 14:16:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADEB61F242;
	Fri, 13 Jun 2014 14:16:27 -0400 (EDT)
In-Reply-To: <539AEB41.6090306@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 13 Jun 2014 14:14:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D614FB56-F326-11E3-9BDA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251625>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 13.06.2014 13:51:
>> On Fri, Jun 13, 2014 at 12:42:47PM +0200, Michael J Gruber wrote:
>> 
>>>  test_expect_success GPG 'detect fudged signature' '
>>>  	git cat-file commit master >raw &&
>>>  
>>>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>>>  	git hash-object -w -t commit forged1 >forged1.commit &&
>>> +	! git verify-commit $(cat forged1.commit) &&
>> 
>> Please use test_must_fail here (and further down), which will catch
>> things like signal death.
>
> Again, that is an issue of keeping the style of the surrounding code
> (which is relatively new) vs. doing it differently. I don't mind
> changing t7510 to a different style, though.

We do not have any "! git anything" in that script, don't we?  We do
not expect "grep" supplied by the platform to lie, and that is why
we should never use test_must_fail on them, but we do want to notice
when git starts segfaulting, and that is what test_must_fail is for.

We tell novices and cluelesses who do not know better to try to
follow and match the surrounding style.  This is because it would at
least not make things worse than if we let them run loose on our
codebase.  It is not about "if we have a bad style, it is better to
match that existing bad style to spread the badness than making it
partly better".  But you have been here long enough and know what is
preferred and and what is to be avoided---more importantly, Peff has
been here long enough to know and has given such an advice, so...

In any case, I do not offhand see anything wrong style-wise in 7510,
so please do not change anything in it for the sake of styles.
