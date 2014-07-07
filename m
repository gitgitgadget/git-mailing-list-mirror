From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Mon, 07 Jul 2014 09:58:14 -0700
Message-ID: <xmqq4mytf6mx.fsf@gitster.dls.corp.google.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	<xmqq8uocx2c5.fsf@gitster.dls.corp.google.com>
	<1404619467.3109.38.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 18:58:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CFO-0002lh-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 18:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaGGQ63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 12:58:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64600 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbaGGQ61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 12:58:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4099326D42;
	Mon,  7 Jul 2014 12:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bEi+ljH2+vxGPI3eEQlZQ3JWf/c=; b=C8M+wZ
	BcBUFW5jYPIuZ0Ur7M82zAJLVdSa26WhiYQuWpnQWKHP1QolLnZdnmupuiwLgG0d
	2wshJ0Vjj833XMKcccQc4Bw0LY156aAD2vPa/0lxInJffkpSsnKE5H1PdxS7gjei
	hpzm9G7EcHJEOKOr1zEbnhDSISPxmMP9ZcKM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R8qMJWPen6UASWL3F5KTKcBDNMRqUZvZ
	ldE0vqWHVMC1wTIl3S9VAqdYPJfWvRX7p8Q+kl12kF7uAxAWxtHYyj4LWagsS2Es
	P+7Mkx9eNuNC2gK7xjJfU8/G3nIjCiZzvQbFEzPwymF2OQ+lpv1inzHXddn2M44d
	OUOZ+CFKmnk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36E4326D41;
	Mon,  7 Jul 2014 12:58:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D86126D38;
	Mon,  7 Jul 2014 12:58:02 -0400 (EDT)
In-Reply-To: <1404619467.3109.38.camel@stross> (David Turner's message of
	"Sat, 05 Jul 2014 21:04:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBCD574E-05F7-11E4-9116-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252967>

David Turner <dturner@twopensource.com> writes:

>> I am not convinced that doing an equivalent of write-tree when you
>> switch branches is the right approach in the first place.  You will
>> eventually write it out as a tree, and having a relatively undamaged
>> cache-tree will help you when you do so, but spending the cycles
>> necessary to compute a fully populated cache-tree, only to let it
>> degrade over time until you are ready to write it out as a tree,
>> somehow sounds like asking for a duplicated work upfront.
>
> As I understand it, the cache-tree extension was originally designed to
> speed up writing the tree later.  However, as Karsten Blees's work (and
> my own tests) have shown, it also speeds up git status.  I use git
> status a lot while working, and I've talked to a few others who do the
> same.  So I think it's worth spending extra time when switching branches
> to have a good working experience within that branch.

You are reading the history of the subsystem correctly.  Since
b65982b6 (Optimize "diff-index --cached" using cache-tree,
2009-05-20), having an undamaged cache-tree does help with "git
status" as well.

> In the new version of the patchset (which I'll post shortly), I've added
> an option WRITE_TREE_REPAIR, which does all of the work to compute a new
> tree object, but only adds it to the cache-tree if it already exists
> on-disk.  This is a little wasteful for the reason that you note.  So if
> you would like, I could add a config option to skip it.  But I think it
> is a good default.

OK, sounds good.
