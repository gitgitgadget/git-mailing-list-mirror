From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/20] rename_tmp_log(): use raceproof_create_file()
Date: Fri, 19 Feb 2016 09:15:11 -0800
Message-ID: <xmqq37soei5c.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<a19192cb3219de9304af7d9b97be45a5e6f0895f.1455626201.git.mhagger@alum.mit.edu>
	<xmqqmvqzhxdf.fsf@gitster.mtv.corp.google.com>
	<56C73DDE.1040606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWoeI-0005Zk-JM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbcBSRPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:15:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751490AbcBSRPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:15:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9390542FE1;
	Fri, 19 Feb 2016 12:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNzvBH4hrsPt+VNEV9bHiZ3HXZE=; b=PnBnZZ
	Kn/wrQnUJcPapeVii2/GypTTN/JTn5n4Jvra0oFvbgc4u7JXuOuVFgOHfcSl8RoY
	N/QEJUFzEE88ulm9PZjjJf4Ys9iKmeH0zBaEEo0LsWZ/RLfgEMPGZUsnZboiAu5m
	MjEy3wOVYLEb5ZS5JXVGu94jVPk1S6BFd52eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CYSkj0shJY3ZCrjvOT+Xkyv1bU6YZIuc
	hYHvZWJSONQYn2cECLe0dFYl3vN8gRGg4RHIOTh0XNlW4NIdfjhyR0jPCVA0URgK
	zHgobrtANcOfyylmIZNUvEqygq4AkrISW5gUxozjJbJVyiRGByzO0HJty4S+5Yhs
	unQMJ45pA+M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8AE0842FE0;
	Fri, 19 Feb 2016 12:15:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0995042FDF;
	Fri, 19 Feb 2016 12:15:13 -0500 (EST)
In-Reply-To: <56C73DDE.1040606@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 19 Feb 2016 17:07:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 564E58EA-D72C-11E5-B478-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286718>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Now, we have to consider the opposite case, namely that we are calling a
> non-buggy implementation of `rename()`, and we artificially change
> ENOTDIR to EISDIR. Can that cause any bad effects?
>
> I don't think so, because the case where a non-buggy implementation can
> yield ENOTDIR is a case, the consequent call to
> `remove_dir_recursively()` would fail with ENOTDIR too, and
> `raceproof_create_file()` would give up immediately.
>
> So I think everything is OK, though I admit that it is not especially
> elegant.

OK, thanks for a clear analysis.

I knew the original and the update were meant to (and would) behave
the same, but the workaround logic in the original looked iffy.
