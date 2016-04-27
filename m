From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/29] ref_transaction_commit(): remove local variable n
Date: Wed, 27 Apr 2016 11:16:20 -0700
Message-ID: <xmqqeg9qape3.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<9c31a016aa893e4a3748e31ee3fd48562f63a7a7.1461768689.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:16:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avU0i-0004VE-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcD0SQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:16:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752203AbcD0SQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:16:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 860C91609A;
	Wed, 27 Apr 2016 14:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1TMqdzl4Qem2U9wUZs1rOzGkfAw=; b=boC4pI
	Kzuo0pguOZw3vrtGx0nNmqu0ZLBmHdMNRGAfL+OYl1Za0ld0kMv18jfzNcC8UrPl
	KvYatPvG64PvIXO08uogr7KBGcDg9sHwlo7X83aSDw1P5mJBhnB+PfAKrG/UkFHc
	7c1crdxvbU6RWrUlFTdIRwFsllRAxnTID/I6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xpn8IzexVvMzIdLNO4UvPGBkML0iTtxs
	nfBN9fM+j09geeoKJa9bIxODuF5FyPhL2XDkK1xWwYpJ48x7PI3YZ6GlTNqnsE4o
	JVIeK1xL0F/b3UN/3SaUyae/o7/0RoP5tpgZcBbDMRpiaJyTJyzDhhFUizc8YaJX
	lnWxmqI7SOU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B3C116099;
	Wed, 27 Apr 2016 14:16:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C748116096;
	Wed, 27 Apr 2016 14:16:21 -0400 (EDT)
In-Reply-To: <9c31a016aa893e4a3748e31ee3fd48562f63a7a7.1461768689.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 251E5952-0CA4-11E6-A318-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292782>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This microoptimization doesn't make a significant difference in speed.
> And it causes problems if somebody ever wants to modify the function to
> add updates to a transaction as part of processing it, as will happen
> shortly.
>
> Make the same change in initial_ref_transaction_commit().
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

This particular change also makes the end result easier to read.  I
have no objection to officially declaring that we do support
"adding" new transaction update while we are committing (and we do
not support other futzing like "removing" or "reordering"), either.

I expect that somewhere in this series transaction->nr will not stay
constant even if the client code of ref-transaction API makes no
direct call that adds a new update[] element, though, even if it is
not done in this patch.

Thanks.
