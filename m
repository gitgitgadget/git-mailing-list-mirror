From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: show reference pointed by new tags
Date: Mon, 07 Mar 2016 20:28:06 -0800
Message-ID: <xmqqd1r5mw4p.fsf@gitster.mtv.corp.google.com>
References: <1457303694-16153-1-git-send-email-eric@engestrom.ch>
	<xmqq60wzta2s.fsf@gitster.mtv.corp.google.com>
	<xmqqwppfrtai.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
X-From: git-owner@vger.kernel.org Tue Mar 08 05:28:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad9Ft-0000af-91
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 05:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbcCHE2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 23:28:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753411AbcCHE2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 23:28:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5F644BD86;
	Mon,  7 Mar 2016 23:28:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=241xg63HJntcKmjfwP1sd5AkjFg=; b=pY5C8P
	9zJwa3OHzz2gTELZoGkoeTniOTtlUKKYObkcpxmJThEQVHI4KoT/+1CG6v80Qa1V
	2aD4YdPpzZXsYgLJj+zNjgHzWcb/zqheNDgevSRaO7fJ6ekaztnBpCTu9dUC6q8F
	rwUxhHE5Q9KyvoUdc4DpurDEYqjl55W3x2DZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=McpASjJaeUM5RV/w2pY4dCBu45GKymJQ
	IabHRpSP/97FMip7NgtX9TeK9KCREpgSKVVaTNSKT2Rje5tHuH7OualxfPZaJl3o
	hCu441zSfqVhQoHjk463sCAK6bTD7RMDcGo3yAdeaIrfzFbepoIP1/W/Zi5LzIsw
	1/24MfFwAiI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0FBF4BD85;
	Mon,  7 Mar 2016 23:28:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AA074BD84;
	Mon,  7 Mar 2016 23:28:08 -0500 (EST)
In-Reply-To: <xmqqwppfrtai.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 06 Mar 2016 17:05:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28B52DB0-E4E6-11E5-B639-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288416>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> But I am merely guessing from the your patch text what the reasoning
> behind the change was and you are the one who had the original
> reason why you needed this change, so your "why" may be a lot more
> useful use case than the one I made up and called "semi-sensible"
> here.  The proposed log message needs to explain your "why".
>
> And if you explained "why", you may have heard other people agreeing
> with you that this new piece of information is nice to have.  They
> may even have helped you by suggesting to add this extra information
> somewhere in the output, instead of replacing existing information
> in the output (which would lead to loss of convenience and
> information).

I just thought of another possible explanation why you may have
thought that it is a good idea to clobber the right hand side of the
fetch report.  Perhaps you thought that LHS and RHS say the same
thing and that is redundant?

Because "git fetch" is flexible and allows you to store what the
remote side called X locally as Y, the fetch report in the most
general form must say X on the remot side) was fetched and stored as
Y in the local repository, i.e.

	[new tag] X -> Y

but it is excusable that people new to Git who never saw such a
renaming fetch to misunderstand that we are giving redundant
information.

If that was the motivation, a possible way to change the behaviour
would be to show

	[new tag] X

if and only if the remote side and the local side uses exactly the
sae name for the ref.  The lack of " -> " can clearly tell the user
that the output is telling us that what they call X is fetched and
stored as X (i.e. under the same name) locally.  A fetched ref that
does not update any local ref (i.e. the ones that are recorded only
in the FETCH_HEAD file) is shown as

	tag X -> FETCH_HEAD

so there is no ambiguity there, either.
