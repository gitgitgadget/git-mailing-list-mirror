From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 10:59:51 -0700
Message-ID: <7vy5m67694.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
 <1343232982-10540-5-git-send-email-rctay89@gmail.com>
 <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
 <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
 <20120726172630.GD13942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuSML-0005W1-QL
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2GZR7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:59:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab2GZR7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:59:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741D08EDC;
	Thu, 26 Jul 2012 13:59:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bB0SesA7hSFbCvLsOIsn7yA6qH4=; b=TSLUo/
	WIEUrDXjZYO4+pHNYa1un0EE0/S8DBsAHNlEercP8zdEelWkw7mhIDGwIBQJUPLQ
	QVBKxVtTb6H01nOeskekNNgpi2yDFZZMpGeeMq7sEK0UpDYpLPHlKoKU55/aYHtU
	Hocs0qTgBj0X4rdSZc1jWUMQrgX/MQLcNulOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uHBoriZY/VvWMf5yrRZ2uuroiQOt5MGQ
	3CulK+0byvPkxNJOGO3g5SxGv1fwZZ9l31rNG9S79KX8BzUiYHFjqXVV7gqsLsKN
	yapzF3vPvTp5HVeiZXXSqlPMTDw8DmzyHpqMjIwEOoY1TJUzQkW9cLFpr35UyrlY
	nxfuGxlFjK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61E078EDB;
	Thu, 26 Jul 2012 13:59:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6CDB8EDA; Thu, 26 Jul 2012
 13:59:52 -0400 (EDT)
In-Reply-To: <20120726172630.GD13942@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 13:26:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B33E7880-D74B-11E1-9996-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202288>

Jeff King <peff@peff.net> writes:

>   - isatty(0) check in cmd_revert to set opts.edit automatically. This
>     one should match merge's behavior.
> ...
> So I think the only one that could be improved is the one in cmd_revert.

Yeah, that matches the result of my grep.

Thanks for sanity checking.

> The credential code uses git_terminal_prompt, which actually opens
> /dev/tty directly. So it is probably sane to use for your new prompt,
> but it does not (and should not) rely on isatty.

I think using git_terminal_prompt() after doing a looser "does the
user sit at a terminal and is capable of answering interactive
prompt" check with isatty(2) is OK, as long as we know that all
implementations of git_terminal_prompt() never read from whatever
happens to be connected to the standard input.

The function falls back to getpass() on platforms without DEV_TTY,
and if getpass() on some platforms reads from the standard input,
that would be a disaster.  I wasn't sure about that part.
