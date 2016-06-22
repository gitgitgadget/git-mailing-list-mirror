Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11E520189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbcFVUq3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:46:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752096AbcFVUq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:46:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39918267F9;
	Wed, 22 Jun 2016 16:46:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JmOHtf/pjKmKPkRxCu260b5VzHQ=; b=HEjKsM
	1b4JufYkBgEyjzkUDlPwUOz6LU7LfQ9vkoSh6hgGY9iN/t3eDNTkVi9Fxcx5RiTs
	+ZzeCXH4FjkYW5K7s2hJdCEpRqS6wV/t39+qFNzFJjqdLO8QYujSWKhVBi3/kZIg
	7Mou+6OhUrBMfiOBzYxhTFOQU/3TE1iNFBdlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddkkbVLAw8KDRkVeAKc/Qnhshtfy2GFp
	XWa3lCZ9ixO4q/x4wDpOQQWJHW+Dy4ahuglNToL7Yg5dQc7GU2MCCGcGraqUcJ7l
	UT+Eg9LdGediKCbzlw2918UlcX0luiBh6W+FUHGLX1KD8qgY6Ib2tdjypLR9Lonq
	TP8JeaC7ZII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 315A4267F8;
	Wed, 22 Jun 2016 16:46:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC0F1267F7;
	Wed, 22 Jun 2016 16:46:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t/perf: fix regression in testing older versions of git
References: <20160622193904.GA1509@sigill.intra.peff.net>
	<20160622194013.GA1697@sigill.intra.peff.net>
Date:	Wed, 22 Jun 2016 13:46:25 -0700
In-Reply-To: <20160622194013.GA1697@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jun 2016 15:40:13 -0400")
Message-ID: <xmqqmvmdkl3y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 642D7AAA-38BA-11E6-B531-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So let's introduce a new variable, $MODERN_GIT, that we can
> use both in perf-lib and in the test setup to get a reliable
> set of git features (we might change git and break some
> tests, of course, but $MODERN_GIT is tied to the same
> version of git as the t/perf scripts, so they can be fixed
> or adjusted together).

I can see how this works for "git -C ... rev-parse ..." or any other
built-in commands, but I am not sure if this is sufficient when any
non-built-in command is used in the perf framework.  How does it
interact with GIT_EXEC_PATH we set in ../test-lib.sh that is
dot-sourced by ./perf-lib.sh that everybody dot-sources?

