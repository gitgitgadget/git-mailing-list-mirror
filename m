From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] pathspec: get non matching arguments without reporting.
Date: Thu, 05 May 2016 16:11:52 -0700
Message-ID: <xmqq7ff885hj.fsf@gitster.mtv.corp.google.com>
References: <1462489197-30616-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:11:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySR5-0001a7-70
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbcEEXL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:11:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752560AbcEEXLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:11:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24537192C8;
	Thu,  5 May 2016 19:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y31y6F4O4jQb+TdYIROcMyWGEfM=; b=kCaAZw
	7jcW+QM3fG3WLFpUZW7eMEneWh9i1WpD6vq4uJYmr72R6WMJbikAW2te94xa0OaX
	O5wskQmMWjmHKSrqhoduDGik29VqNn2JPw2ZJ++E7dDqQCqFoIu5nlPsIaSVL4B0
	TIUuIVDz1L544v45yr3kBe1OA+Xw6jZJO1BJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V9CFgS6HehtEhgh0etkPMJH/xav1yF2b
	547UeMZlA1XbrUoxVPbYiAhlBGFl2GdLGCjaqJocTzLR0WskwAoNAU1MvcL0hFkH
	qicE9PflQ3D5dwF1uw0hm7p8ERRtkqR92TsPEhZRGE8iU4bmkdpdgF9inXX7jFaC
	BlzmbZRU6sM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BF63192C7;
	Thu,  5 May 2016 19:11:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B7C5192C6;
	Thu,  5 May 2016 19:11:53 -0400 (EDT)
In-Reply-To: <1462489197-30616-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 5 May 2016 15:59:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C15F056E-1316-11E6-A87A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293723>

Stefan Beller <sbeller@google.com> writes:

> When giving more than just pathspec arguments (e.g. submodule labels),
> we need a way to check all non-matching arguments for the pathspec parsing
> if these are the submodule labels or typos.
>
> This patch prepares for that use case by splitting up `report_path_error`
> into a new checking function `unmatched_pathspec_items` and a
> reporting callback.

I seem to recall that there is a longstanding plan to move the
"seen[]" array that is separate and outside from the pathspec
structure into the pathspec structure.  Wouldn't that be a more
sensible approach to solve the same thing?
