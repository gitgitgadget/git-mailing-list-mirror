From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 09:30:08 -0700
Message-ID: <7vmxii8xgv.fsf@alter.siamese.dyndns.org>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Gieschke <rafael@gieschke.de>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 18:30:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN67F-0005XG-BU
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 18:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209Ab1ESQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 12:30:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850Ab1ESQaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 12:30:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FE9C4EAC;
	Thu, 19 May 2011 12:32:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QNIZyuZkLpkxmUIRs1k4sQrAOl8=; b=rZgoAF
	u6M4EUWH9zsnhVfwLvcR48lmgVZG5TQdrLsERZcpCWqU9rqKekB5enxpZEGSQcAk
	xs3jaHFI5zZXV+WcekBRykIxeVO+m3wWNxnM99P7f9prvw9Q88xy+47FunKmXWHa
	D/ezuf+H5jK1l8dXu9ik953LMQsuMYa07yeGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMJ6WKc0ieMG+3ozt8glaJdZ0pEW2bbt
	bQMObWHmHkGafPd2kRaylSDZkSWsZYONZEdxLPU/aHG566xxwIz91wt3ijd17195
	TP+jLnup3VfdUtB0nVQerAfCfRyD6B83RqmyydvUBUQhl0lITxkF5/KJ9DjJgpMV
	oRVVgWdzVmI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DC714E9E;
	Thu, 19 May 2011 12:32:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A43634E98; Thu, 19 May 2011
 12:32:16 -0400 (EDT)
In-Reply-To: <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 19 May 2011 14:17:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91A79F6A-8235-11E0-8C06-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173966>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Do we really need two implementations? Wouldn't it be better to factor
> out the mingw-version to a separate source file, and then improve it?

Thanks for reminding.

> Windows doesn't have /dev/tty, but the logic in this version handles
> that by using stdin/stderr instead. The signal-stuff has a comment
> that indicates it might not even be correct. tcgetattr/tcsetattr isn't
> supported on Windows, but it's not needed if we use getch (as the
> version in compat/mingw.c does). POSIX/curses getch respects the
> echo-setting, while Windows getch never echo.

I forgot to check how generic/reusable mingw version would look. As you
said, it does feel a lot more attractive approach if it is trivial to add
the "noecho" bit to it, tweak the tty-ness and deal with signals.

I however suspect the result would end up on the borderline to be called
"trivial", rough guestimate being 3-4 times as large as the 14-line mingw
version. But it certainly feels that it is worth a try.
