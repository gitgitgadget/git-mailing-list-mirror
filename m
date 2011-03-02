From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Tue, 01 Mar 2011 18:07:29 -0800
Message-ID: <7vlj0yff6m.fsf@alter.siamese.dyndns.org>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 <7v7hckje4n.fsf@alter.siamese.dyndns.org>
 <20110301205424.GA18793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:08:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PubTr-0004Pu-IL
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 03:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab1CBCHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 21:07:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786Ab1CBCHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 21:07:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A16F54588;
	Tue,  1 Mar 2011 21:09:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3gyD6KvEbuzj0PdPinrKo5dALs=; b=gwrwk3
	LjB0S3m8g2jxy/iE8maN+8qxYkjO6/ACoAvszcaE48qHI6RqJWRmIIisGElSLAas
	XJKgZvXw+SPvOpIR45hVamh6i1H/q8kI78reZXd0CrlfOpGH/eZR4k7s2PsbfSNr
	3r/P5rlZiTRtxFVYCp/StuRrMJkhDJ5AH17mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FHtFnjwqIxiuwynbQwbSibxVaPcV20G7
	Uxkh4/kr27jcvhT3R9oUs7wBgWXw4u+IcLmkPZR6L9IuN5H3D3pW8W2rgJ0529hS
	mlG7xx+GGI5hWWAHFdlYi1lWZlcq2qmAs/ZRrD56nXVe4XmHW7tZSWLQw08NoZsf
	5NLliJGaS1o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 552BD4586;
	Tue,  1 Mar 2011 21:08:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B5B154582; Tue,  1 Mar 2011
 21:08:50 -0500 (EST)
In-Reply-To: <20110301205424.GA18793@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 1 Mar 2011 15\:54\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 080C3866-4472-11E0-A7F8-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168288>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 28, 2011 at 08:52:08AM -0800, Junio C Hamano wrote:
>
>> I am not convinced that this patch nailed that balance at exactly the
>> right place, even though I think we are getting closer than before.  In
>> this sequence:
>> 
>>     $ git checkout somewhere^0
>>     $ git commit
>>     $ git reset --hard somewhere_else
>>     $ git commit
>>     $ git checkout master
>> ...
> I really wouldn't expect it to help here. The problem isn't that you're
> on a detached HEAD. It's that you're using "git reset" at all.

As you would realize later in your message, the "reset --hard" can instead
be "checkout v1.7.3".  And the bothersome thing is that there is no safety
against that.  We don't bother users while they are jumping around on
detached HEAD, and it is not new; we don't say where the previous detached
HEAD was.

Perhaps that needs to be changed to have the same safety?  IOW, regardless
of your "checkout" destination, whenever you leave a detached commit that
would become unreachable, we should warn the same way?

I suspect I would loath it as being too loud; I dunno...
