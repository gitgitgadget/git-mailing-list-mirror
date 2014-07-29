From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] stash: default listing to "--cc --simplify-combined-diff"
Date: Tue, 29 Jul 2014 11:58:52 -0700
Message-ID: <xmqqppgo2dqr.fsf@gitster.dls.corp.google.com>
References: <20140729175300.GA21536@peff.net>
	<20140729175725.GE31181@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCCc8-0007h0-LK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 20:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbaG2S7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 14:59:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51010 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbaG2S7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 14:59:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FA192C3E4;
	Tue, 29 Jul 2014 14:59:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YziT1n24es/ajBMB+7As31SzPjE=; b=kOgspQ
	6VnsGjavMVG/ulR8wjdzMiqzUnIUFgwJmjwHxpXZ8kEDzRAM3EX2lz5Kf+XQNSHU
	pWrT8YFbQh+oj0xQaKfAyXWYaP+TV2sy1kl9Bw1lJepOKf/kuJ75e/lPgySXDE2h
	C3KRS6XX8A1PGrmjd0Z3Xcb73HfINbcrsIfO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvZzrj2IdSgJ6G+NMXZ4Odm51pj4mxBR
	UFEo7RR0z/8AvK2ZfKACxr1vmWiJrGMDO7wz2zEWvWZkg9tkF+JRaWWPNf9jz9BN
	DGBeu88gev4zBBuULE2RbkEcKtZv1hoQqks30VqhuDVlzK7pyYGYQJHT6iPuhcJQ
	vBuvrTzbrGE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 891F42C3E3;
	Tue, 29 Jul 2014 14:59:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E045B2C3D5;
	Tue, 29 Jul 2014 14:58:53 -0400 (EDT)
In-Reply-To: <20140729175725.GE31181@peff.net> (Jeff King's message of "Tue,
	29 Jul 2014 13:57:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62BD2F16-1752-11E4-A4B3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254460>

Jeff King <peff@peff.net> writes:

> When you list stashes, you can provide arbitrary git-log
> options to change the display. However, adding just "-p"
> does nothing, because each stash is actually a merge commit.
>
> This implementation detail is easy to forget, leading to
> confused users who think "-p" is not working. We can make
> this easier by specifying "--cc" as a default ourselves
> (which does nothing if no diff format is requested by the
> user).

Sigh.

"git log --cc" is one of the things I wanted for a long time to fix.
When the user explicitly asks "--cc", we currently ignore it, but
because we know the user wants to view combined diff, we should turn
"-p" on automatically.  And the change this patch introduces will be
broken when we fix "log --cc" ("stash list" will end up always
showing the patch, without a way to disable it).

Can you make this conditional?  Do this only when <options> are
given to "git stash list" command and that includes "-p" or
something?
