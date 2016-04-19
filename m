From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 09:51:02 -0700
Message-ID: <xmqqbn5535l5.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jacob.keller@gmail.com, Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:51:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYru-0001da-QA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbcDSQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:51:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754992AbcDSQvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:51:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DB16145A9;
	Tue, 19 Apr 2016 12:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A3QLlG6t5oIOEZh/hG2uquPmwCs=; b=x11FMp
	X/bFSOCj03jNqPozPWLyQSJ2jQWkBQWy+nLBTgGuOp+DDvFSflpAV1xle6qnmX+L
	s7/3QTesQJf4erQC5d6nGZI1bYk+7+gchFfe1veylqZPy9mfarlvbhXHEtpSCBeh
	SDZYSKjcm2yhrsKAEFX1cSpixJJnBfGe0Lq+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=saItVZXQQgro7jh0tfPigPvK0SLpJUOC
	O9YiPJp8qaG++Qe0cRQKNti7ZI9PhrlFaJexba58yNWfpvFNZiCt1hFwPhFd3eBL
	etE7Y4X7p/cCO9yqLBq47jdcMEEJZ/B9qWFeQCcehJsknNjpu5gFp98nlu3U/4mr
	MrL8hUBFXW4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D091145A7;
	Tue, 19 Apr 2016 12:51:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2729E145A5;
	Tue, 19 Apr 2016 12:51:04 -0400 (EDT)
In-Reply-To: <20160419050342.GA19439@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 19 Apr 2016 01:03:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7776B80-064E-11E6-AF80-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291880>

Jeff King <peff@peff.net> writes:

> I guess this will invalidate old patch-ids, but there's not much to be
> done about that.

If we really cared, we could disable this (and any future) change to
the compaction logic to "patch-id --[un]stable" option.

I am not sure if it is worth the effort, though ;-)
