From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] check-headers: add header usage checks for .c files
Date: Mon, 15 Sep 2014 12:16:54 -0700
Message-ID: <xmqqk35466e1.fsf@gitster.dls.corp.google.com>
References: <1410680445-84593-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbll-0004ak-8w
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbaIOTQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:16:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64271 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbaIOTQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:16:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68EB03A24A;
	Mon, 15 Sep 2014 15:16:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A+iR+UqQhp4v0dTHehuv1KNNugU=; b=YT+/P6
	03MaIHiI3796Ok68zuRKdPRqfPwrr0SvSDxVILwpmi7VvnQlpRPDNVuWgIS45EkN
	yFfhRpqbWivj3wyoKqeVjmLKvQ8Xf8tjhf/8lsdz/eeeOxS7z8cjGOqh+2KiLeJ4
	dq6p1WUlKRE4ICi4E3jo/VWvPoRSuT8HIC7Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TlXTU5qf9rZHWbXejQY3LbRgw6Te5eN/
	8nBS2lVK1tTww8PAFi7Z/QOe8rkoR4U+yGyYrf6NmeGYM2WFrb9da2d4BBHQ+Kbs
	UlA6yFvQi3Lv1fioYG5yM6ZgBuc5jIEZUEYwCfTZKwlbuRgOC0eHHwzQWdOOg3Tx
	OlbmSPuJRiU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F5C03A249;
	Mon, 15 Sep 2014 15:16:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D8D863A248;
	Mon, 15 Sep 2014 15:16:55 -0400 (EDT)
In-Reply-To: <1410680445-84593-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 14 Sep 2014 00:40:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB791E1C-3D0C-11E4-AEED-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257074>

David Aguilar <davvid@gmail.com> writes:

> Teach check-header.sh to ensure that the first included header in .c
> files is either git-compat-util.h, builtin.h, or cache.h.
>
> Ensure that common-cmds.h is only included by help.c.
>
> Move the logic into functions so that we can skip parts of the check.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This depends on my previous patch that adds check-header.sh.
> ...
> +check_headers () {
> +	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
> +	do
> +		check_header "$header"

Hmmmm, doesn't check_header run "$@" as a command?
