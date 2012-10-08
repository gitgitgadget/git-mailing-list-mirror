From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Mon, 08 Oct 2012 09:27:04 -0700
Message-ID: <7vtxu5lyjr.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
 <5072973D.4080703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:27:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGAp-0006lu-1X
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab2JHQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:27:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542Ab2JHQ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:27:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A11E9302;
	Mon,  8 Oct 2012 12:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4lRZtZo5MtcRhSTOZrZnHYGijG8=; b=er49dU
	Nkle16g2H45LwuDlL6RJ6kewg4tEgsMIuKko8FmRvez1h+gQPpLnouTCNUVEoKCL
	8o3W968VFXZHzgG3um6TdleKDgpe5LmWLMGisogqrQjefzhSfzRdfELesNmA/n0q
	nvzKw1aW+BuE6xb55bn6EmlBxWA+KmqAwf/ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ut0hSFbvBGNTsj3OvfZEhRt+feauDXEP
	FNNSga+6H+llFKDyIlilPtqwL5Z7lWuQ4e6isk4toYB0ihk/+d29KlFTxxg6wCrJ
	PxfVL+guzWgALSkwG/PqaPTU4nOkRAOOp62nDpQKPhoFvpQUlNCaViP6T556HFCL
	JxxC4Dt8PMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 255F29301;
	Mon,  8 Oct 2012 12:27:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 891A29300; Mon,  8 Oct 2012
 12:27:05 -0400 (EDT)
In-Reply-To: <5072973D.4080703@op5.se> (Andreas Ericsson's message of "Mon,
 08 Oct 2012 11:05:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF82EB2E-1164-11E2-9E6A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207236>

Andreas Ericsson <ae@op5.se> writes:

> You'll want that to be a single "wants" message to avoid incurring
> insane amounts of roundtrip latency with lots of refs. github and
> other hosted services are quite popular, but with my 120ms ping
> rtt I'd be spending half a minute just telling the other side what
> I want when I fetch from a repo with 250 refs.

Peff's recent patch when applied on the server side would help
alleviate the load to produce these refs, but it obviously would not
cut the network cost.  In order to change this, we need to swap "who
speaks first".

Once we go into "want/have" phase, I do not think there is a need
for fundamental change in the protocol (by this, I am not counting a
change to send "have"s sparsely and possibly backtracking to bisect
history, etc. as "fundamental").
