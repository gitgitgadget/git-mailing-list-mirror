From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Refactor skipping DOS drive prefixes
Date: Fri, 08 Jan 2016 14:07:00 -0800
Message-ID: <xmqq8u3z20aj.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
	<CAPig+cRRaMbEGibYnQBTfGFQT6fybNU8e6ZAkX11V-TLAo9AfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHfBe-0007H2-VM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 23:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbcAHWHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 17:07:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279AbcAHWHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 17:07:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78C363AC8A;
	Fri,  8 Jan 2016 17:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B+Fmqof8ZfYRVlTF3FERi6mLZho=; b=Gpy43E
	ydVigNYzAVI+tPSEqgBgQLPeqNc4JrFENxYvNG5r3fO7m8xM9+f6UUhEK7m5ess8
	a1oKmlHhwMPbe3GZuCUePawS0LtKNYR/Lg0OGKN8kXRjhkRkuIbf7Kv54aQL30OO
	XP4XeSdgBWqCh0qSNp/Ms0VpOCshLz0fAWGyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iW9LutOXRc1DihK/T6e1lQtURIPah5O8
	c8nSqGKq5yDcWZ6MrKu5Ls/LxH7BK5jp2fUmtUOff/iYBA6khkOITlwPFhRQjkcW
	Slso+GKBI6/GNLa2og6W1IZX4x68zYtvL4oQ/vCtU5Bdq6isDyZwfGPLe+0+0L6B
	PI/u6VbLH34=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E3F73AC89;
	Fri,  8 Jan 2016 17:07:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C17703AC88;
	Fri,  8 Jan 2016 17:07:02 -0500 (EST)
In-Reply-To: <CAPig+cRRaMbEGibYnQBTfGFQT6fybNU8e6ZAkX11V-TLAo9AfA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 8 Jan 2016 16:51:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 258B4E6E-B654-11E5-AE48-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283584>

Eric Sunshine <sunshine@sunshineco.com> writes:

> With this change, code such as:
>
>     for (i = has_dos_drive_prefix(src); i > 0; i--)
>         ...
>
> in path.c reads a bit oddly. Renaming the function might help. For instance:
>
>     for (i = dos_drive_prefix_len(src); i > 0; i--)
>         ...

Renaming may be unnecessary churn, but I do not think we mind an
additional synonym, e.g.

    #define has_dos_drive_prefix(x) dos_drive_prefix_len(x)

if some people prefer.
