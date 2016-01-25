From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line style of the context
Date: Mon, 25 Jan 2016 12:12:47 -0800
Message-ID: <xmqqr3h5fmf4.fsf@gitster.mtv.corp.google.com>
References: <cover.1453632296.git.johannes.schindelin@gmx.de>
	<cover.1453709205.git.johannes.schindelin@gmx.de>
	<26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:13:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNnVU-0004SP-QK
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 21:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbcAYUM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 15:12:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757166AbcAYUM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 15:12:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F1803E6D5;
	Mon, 25 Jan 2016 15:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iUQnShX8jFjRx2YX8XMijqH1dlI=; b=XdFx7w
	ieOC749mYtuunpvB3B2m5OlqDVDoVM56wCTJv9IeeOjgKhAGvoK1sqMXHViK3Fhs
	RymCHJVm1cosv9kmOLNranSI6sXB9Xe5XQS3z+nTNDcFJ7yHCydzA2K1I0yVAVxq
	znNbe4zQkQiDR+p0YPQjYk17VwNi3AqJAMLmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uhv5i7aptmf1jJpedm3XFgUIAnJQphWV
	KT3zt+DuE/LLlZpH2Emi9FlMrreYo6mLJI7fFHnKZMlsRxsTRD8eo31/yZBkdRRv
	scl3NB+FN0JAhClayBaJmz7yj2APyXgD8EWzyGkYHAV1PlbdkCw+KxstX7p09f96
	T2gWAermxRI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 541C73E6D3;
	Mon, 25 Jan 2016 15:12:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8A6A3E6D2;
	Mon, 25 Jan 2016 15:12:48 -0500 (EST)
In-Reply-To: <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 25 Jan 2016 09:07:04 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0147F0C6-C3A0-11E5-BCB4-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284754>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We actually do not have to look at the *entire* context at all: if the
> files are all LF-only, or if they all have CR/LF line endings, it is
> sufficient to look at just a *single* line to match that style. And if
> the line endings are mixed anyway, it is *still* okay to imitate just a
> single line's eol: we will just add to the pile of mixed line endings,
> and there is nothing we can do about that.

Isn't there one thing we can do still?  If we use CRLF for the
marker lines when the content is already mixed, I'd think it would
help Notepad (not necessary for Notepad2 or Wordpad IIUC) by making
sure that they can see where the marker lines end correctly.

I do not care too deeply about this; just throwing it out as a
possibility to help Windowsy folks a bit more.

> Note that while it is true that there have to be at least two lines we
> can look at (otherwise there would be no conflict), the same is not true
> for line *endings*: the three files in question could all consist of a
> single line without any line ending, each. In this case we fall back to
> using LF-only.

Yeah, this is tricky, and from the same "helping Notepad that
concatenates lines with LF-only" perspective I should perhaps be
suggesting to use CRLF in such a case, too, but I would say we
should not do so.  Three variants of a LF-only file may have
conflict at the incomplete last line, and if we only look at their
"no EOL"-ness and decide to add CRLF to the result, that would be
irritatingly wrong.
