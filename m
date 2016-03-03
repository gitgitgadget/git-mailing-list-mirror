From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 02 Mar 2016 18:57:19 -0800
Message-ID: <xmqqwppk2rqo.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
	<1456950761-19759-1-git-send-email-gitster@pobox.com>
	<1456950761-19759-5-git-send-email-gitster@pobox.com>
	<CACsJy8AzZsC3_7mWQutko8W=X1Lch3bMZRjoHtjVnWwtbMBt7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 03:57:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abJSB-0006Gv-9g
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 03:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbcCCC5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 21:57:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755675AbcCCC5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 21:57:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8F954A05A;
	Wed,  2 Mar 2016 21:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qYyVJfAeZsUIjeeKEnBUk9gOj/U=; b=fc/098
	ByEz74Xqe/vQBkBXAwvobKdu8Fn9ZylkCws5+MhOaEXOVM+JGa2XJ8TxT0dJhEZc
	Gyhdn4dgFExukT9CJGlWc4L56UqKcoLW+ORZFMHm5knOz4IXk5M6sIfLLmfq1QTq
	dsZgLKQb7D0PM6eNxCKKWE4lxZHpCMwpdBDB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a/h1zjMIHpiQF916FB3NX3lSb5GEwhjy
	O/U5/YyRjwJ7gOpo/2gErUmEIA3cucRNpF4JbtQVp1hLI4qLKpfhIKSCOxmUdqQZ
	Y3WZTABTonhcDPblWiFeB5wS6k6K5iAu/v91IvuBZHVerxbVYOFo5sgt4yaUVsCD
	IcKnTv9CkmY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0F204A059;
	Wed,  2 Mar 2016 21:57:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 406624A058;
	Wed,  2 Mar 2016 21:57:20 -0500 (EST)
In-Reply-To: <CACsJy8AzZsC3_7mWQutko8W=X1Lch3bMZRjoHtjVnWwtbMBt7A@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 3 Mar 2016 08:36:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A578B3A2-E0EB-11E5-9E39-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288162>

Duy Nguyen <pclouds@gmail.com> writes:

> would it be
> ok if we introduced a minimal resumable download service via
> git-daemon to enable this feature with very little setup? Like
> git-shell, you can only download certain packfiles for this use case
> and nothing else with this service.

I think it is a matter of priorities.

A minimalistic site that offers only git-daemon traffic without a
working HTTP server would certainly benefit from such a thing, but
serving static files efficiently over the web is commodity service
these days.  Wouldn't it be sufficient to just recommend having a
normal HTTP server serving static files, which should be "very
little setup" in today's world?

Such a "minimal resumable download service" over the git-daemon
transport still has to reinvent what is already done well by the
HTTP servers and clients (e.g. support of ETag equivalent to make
sure that the client can notice that the underlying data has changed
for a given resource, headers to communicate the total length,
making a range request and responding to it, etc. etc.).

In addition,, by going the custom protocol route, you wouldn't
benefit from caching HTTP proxies available to the clients.

So I am not sure if the benefit outweighs the cost.

I wouldn't stop you if you really want to do it, but again, it is a
matter of priorities.  I personally feel that it would be a waste of
engineering talent, and it certainly would be a waste of review
bandwidth, if you gave priority to this over other more widely
useful parts of the system.  The procedure to repack should be
updated to produce such a base pack with the separate bundle header
on the server side, the protocol needs to be updated to allow
redirection for "clone" traffic, the logic to decide when to
redirect must be designed (e.g. "single branch" clone should not
choose a pack/bundle that represents the full repository, but a pack
for the branch that was asked), etc.  There are still tons of things
that need to be done, and it would be a distraction to invent a
custom download service nobody other than git-daemon talks before
all of the above is done.
