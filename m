From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2 v4] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 14:22:29 -0700
Message-ID: <xmqqbn564noq.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:22:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGcv-000726-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbcDRVWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:22:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbcDRVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:22:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB15141F2;
	Mon, 18 Apr 2016 17:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXva7tOGcYN8PF/K3UgmlkPU3ao=; b=Q+pKxL
	miLLQc0bj3qQBXiFQTu3Ra1uxr4i4Vv/tdy7nbvF8cAvsk0TgEAIKahEUO8dAYyE
	3CRit4zsuoBi7lFqCRLy3S7jY21Bule2Cp41KOOZzjdVvRrnFsd/SSOe8L2A1oUG
	zLEKTq0f2FdJpvHfLP+ddb2UdlYbVgBqCfx7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c+7s6ciSEH6m7bM2pkuNg//5oYenYI1I
	y5vJr6szglI/eZ5vrr1hKDXbd1KPQXK2EfQWTF9eExhnnUl1hmWdSbh2E9fdkx5/
	OUPPeaaVK44yRquSCRrkS+s9IVE2r2XKd6yNYQa/kxeSAC4EQfH3cVuDje6OcHfz
	ZJrBe8AuNHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E8B2D141F0;
	Mon, 18 Apr 2016 17:22:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AB3A141EF;
	Mon, 18 Apr 2016 17:22:31 -0400 (EDT)
In-Reply-To: <1461013950-12503-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 18 Apr 2016 14:12:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8F99CB4-05AB-11E6-A98C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291830>

Stefan Beller <sbeller@google.com> writes:

>> OK, so perhaps either of you two can do a final version people can
>> start having fun with?
>
> Here we go. I squashed in your patch, although with a minor change:
>
> -               if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
> +               if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>
> We did not need that in the "shortest line" heuristic as we know
> a line with the shortest line length must exist. We do not know about
> empty lines though.

Makes sense.  The last hunk of

$ git show 9614b8dcf -- update-cache.c

gives an unexpected result without "&& blank_lines" above.  Lack of
"&& blank_lines" happens to make the result slightly easier to read,
but at the cost of having an extra line in the hunk.

Thanks.
