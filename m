From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds without blocking
Date: Mon, 14 Dec 2015 17:40:47 -0800
Message-ID: <xmqqbn9sh4kg.fsf@gitster.mtv.corp.google.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
	<CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
	<xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
	<20151214235736.GA26133@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 02:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ebm-0001MN-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbbLOBku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:40:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753664AbbLOBkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 20:40:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D281D352DA;
	Mon, 14 Dec 2015 20:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qv29mSVytLfgrArg6xhICXgUJUQ=; b=CWXLre
	pihkPr9JyFsM8103vpAXvBJjQUMjt/u/TEDoLLqZOSk6ucE4rOZHIuVVaSNaMpcS
	nkd9qlsUa7vhyE8s9QNfIQKqOwKL1jsV02IfXP6c3h/u1JgoHZ6kwHx4w2KN0r3p
	RsIn2JfMOTttf80XTiN0lfxDyaNXUwK2SwXK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5FXlNi5gFTg7i6p1HpGh5YbWTIwDYem
	WVntrCNtwO9sECWtUUFQrhVo+aKbCrgmhx/s76KXUd6YP/WFneLBfMcgXTcwnSaK
	HMZ0ubanxi7ovUkn0laO94vPZfd3yMxvW8kZ6GDV2XkvIaHG6KWnWIJ9csJf2Kzo
	8qBl1P01FL4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C904C352D9;
	Mon, 14 Dec 2015 20:40:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42759352D7;
	Mon, 14 Dec 2015 20:40:48 -0500 (EST)
In-Reply-To: <20151214235736.GA26133@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Dec 2015 18:57:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDD7D3CA-A2CC-11E5-B2B6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282459>

Jeff King <peff@peff.net> writes:

> Are we trying to protect ourselves against somebody _else_ giving us a
> non-blocking descriptor? In that case we'll quietly spin and waste CPU.
> Which isn't great, but perhaps better than returning an error.

I think I said it earlier in a message upthread.

> Ahh, there is a difference if the file descriptor the caller feeds
> strbuf_read_once() happens to be marked as nonblock.  read_once()
> wants to return without doing the poll() in such a case.  Even
> though this series would not introduce any use of a nonblocking file
> descriptor, as a general API function, [4/8] must be prepared for
> such a future caller, hence [3/8] is needed.
