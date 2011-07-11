From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 16:42:36 -0700
Message-ID: <7vfwmc9yfn.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 01:42:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgQ7h-0007iK-44
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab1GKXmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 19:42:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab1GKXmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 19:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9FE05A1B;
	Mon, 11 Jul 2011 19:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=utpebKtSVfTFhmn++LPlH8cPMgU=; b=VIR0K2
	14tyuytz3om2McaG3lstsV17VFNRftik3ssGePunT/+djHQSjgf1R46X5Zy4wX4B
	sy2UPOBDedl4w3ORQTB24UapEL3ntLJisWnbXZZkM4nvVZZG+kEX5FM1YgI3SJmV
	4kl0ioRwQeTC8SvZjwBjyrtOlOHuDTOWFTfuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTUhlGu3Ch5bhHFIhv8WAnTv0tOCm0Ig
	iInesz5PZbPOncESTwop6q9XszK5IsyCuL0jCHE/6bKLLh2HYxsEq1l+eeoKIuPi
	0lRK3x5KVVu4pTirUMjl0+3rURH8IKX2knVHUqRgQ25znB8UKf21Ngdt4RMMgRZO
	Ws6gBdHYKC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1F195A1A;
	Mon, 11 Jul 2011 19:42:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4010B5A19; Mon, 11 Jul 2011
 19:42:38 -0400 (EDT)
In-Reply-To: <7vk4bo9ze5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jul 2011 16:21:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75DC5666-AC17-11E0-A1B8-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176909>

Junio C Hamano <gitster@pobox.com> writes:

> Actually I do not think identifying the ones that can safely skipped is
> such a big issue. The case I am most concerned about is when you see that
> "two reverted back to one" (which you obviously want to avoid, to keep the
> effect of the commit the upstream has to have "two" on that line), but at
> the same time ...

It is even worse if you do not necessarily agree with that "two", which
you might originally have written "t w o". You _still_ want to keep the
version from the upstream (i.e. leaving the result as "two") while
replaying the patch that adds "one" (and correcting the change upstream
did to make it "modified one"), and when it is the "t w o" patch's turn,
you would want to do the same dance to make an incremental correction to
the way the upstream butchered your original change.
