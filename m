From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] sequencer: Expose API to cherry-picking machinery
Date: Tue, 16 Aug 2011 10:51:52 -0700
Message-ID: <7v39h1i6rr.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
 <20110814131303.GF18466@elie.gateway.2wire.net>
 <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
 <20110814152204.GJ18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 19:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtNo1-0008HR-1n
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 19:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab1HPRv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 13:51:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab1HPRvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 13:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5942A494C;
	Tue, 16 Aug 2011 13:51:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rpZnZ5olc9EVyIhu6c7GH4v5GZo=; b=PRqw0j
	HCLvihSFu2kTt4zpgwYcOAYKQ41PwtQhzfolBKmpheLhRyxgyAPKl2JYjS7oviwY
	Zd+WKvMTCE2avGkMeQN/+WTSiTMKephvqT5seu0A/KweP+Grs5NkBBsb8a2FlRBg
	6XN85IdWATuc+VYRf2ms4bo/uJhnSkx9FJyiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QVP1ma6Ugd8nBVjpH1zg3inj29IvyWeX
	l0bHVc/mmWY0JAmg4VTP3i25JQx30BiP3S4VctF1zAkqoQK70L8k0bM4LDnvtAIC
	GnHiE+2PpL8TUMIC1mN3AJPRrgXBJcz0rHlV+iVKl/9qT7mcvXLMg28Px5okotXA
	cScL4RhCLY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FEEF494B;
	Tue, 16 Aug 2011 13:51:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1539494A; Tue, 16 Aug 2011
 13:51:53 -0400 (EDT)
In-Reply-To: <20110814152204.GJ18466@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Sun, 14 Aug 2011 10:22:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D40573E-C830-11E0-A2F6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179463>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Subject: revert: plug memory leak in "cherry-pick root commit" codepath
>
> The empty tree passed as common ancestor to merge_trees() when
> cherry-picking a parentless commit is allocated on the heap and never
> freed.

Thanks for noticing, but shouldn't we be just using

	lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN)

or something, instead of hand-crafting a fake tree object?
