From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] add the FORMATPRINTF macro to declare the gcc function
Date: Thu, 11 Feb 2016 09:59:21 -0800
Message-ID: <xmqq37szxh52.fsf@gitster.mtv.corp.google.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 18:59:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTvWg-0004Rj-8J
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 18:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbcBKR7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 12:59:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbcBKR73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 12:59:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1836C3F425;
	Thu, 11 Feb 2016 12:59:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6KWw1YX6+HQhgdIbE4VSybr6+w=; b=rp0bbJ
	NmqDk+hLRWkWRxarzvv5aGJf6STW8Riu47SMFpLJIWdGJvSgOQut/w2cWn2x/DF3
	qZuOMDs3HmUSNJp9Q5RU7nvm8budXrDm7QfmrhYDQzEymBqgmZSCknDCUYRnv+0z
	R2xp0iboVx8bj3iJSXkyplKMGMg/7Q1gpDLcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VfVv9hrJSc7fllz0wa47PyPq8JxGjw0d
	29TfHKnQBys3q41nVt6UIFIyeo7+Iva9Wztwz5OzeWqd8h3Tkv3aGy9wL2H4MChA
	xVLkAetz1WUAV4t+lLDw+CY0uaOdqZ6cmA65rNxQrVWcP2C5eftmvseQayQNvNGY
	yA27QNO+4VI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 101043F423;
	Thu, 11 Feb 2016 12:59:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79CA13F421;
	Thu, 11 Feb 2016 12:59:22 -0500 (EST)
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 11 Feb 2016 12:38:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E29DB94-D0E9-11E5-ABED-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285987>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add the FORMATPRINTF macro for declaring the gcc function attribute 'format printf'
> for code style consistency with similar macro that git already use for other gcc
> attributes. And use it where necessary.
>
> Elia Pinto (22):
>   git-compat-util.h: add the FORMATPRINTF macro

Hmm.  Given that we already have

#ifndef __GNUC__
#ifndef __attribute__
#define __attribute__(x)
#endif
#endif

in git-compat-util.h, it is really between:

    __attribute__((format (printf, 1, 2)))
    void advise(const char *advice, ...);

    __attribute__((format (printf,2,3)))
    extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);

and

    FORMATPRINTF(1,2)
    void advise(const char *advice, ...);

    FORMATPRINTF(2,3)
    extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);


Perhaps I am biased for staring at our source code for too long, but
somehow the latter looks unnecessarily loud, spelled in all caps.

I dunno.  What does this really buy us?
