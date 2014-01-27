From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Mon, 27 Jan 2014 08:02:31 -0800
Message-ID: <xmqqlhy1pg4o.fsf@gitster.dls.corp.google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
	<xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
	<7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
	<xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
	<20140115215024.GM18964@google.com>
	<xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
	<CALkWK0ky2KCJuo==XRiNu+eb2+hHpgv+FAyZTd85=TYQxgSCbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 17:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7oe0-0008Ie-Av
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 17:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbaA0QCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 11:02:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbaA0QCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 11:02:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ACBF67AE2;
	Mon, 27 Jan 2014 11:02:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kMRSj9Zhl4BJ0PvgAPDCAXB/VTs=; b=O6pHfG
	lSHbGLRrq23xUlCMHhGU4V7oicmHhyf9NWPHbCMEjFOshmXfz1gYMPPHWGIOowYT
	qCd5KtJZnCAoKtWxHDOj7c55ZwQ546DMTtL2ZzWVdgmu6+1wJqzfE6LaHrtdYBfv
	HylKNL0oYYgTAllYkM61lTCVOOiobV1giQ0Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sFiKIhBQn4iyBXvm62AuBdeRJkr2YvHu
	KzhdqYgEU4xLziJ1KAm/QkfD+T/0sVN7gKGja1IyZ7MQFK62S+SM/bUDrECD6iiB
	Aq2hCuyjwOZOoPpHELOjv9iJELnNhuhSmnyMu0HfhETzVz+4OMBv74mzexD9Mbr7
	37pPgG9SFKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A8DB67AE1;
	Mon, 27 Jan 2014 11:02:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56DB467AE0;
	Mon, 27 Jan 2014 11:02:34 -0500 (EST)
In-Reply-To: <CALkWK0ky2KCJuo==XRiNu+eb2+hHpgv+FAyZTd85=TYQxgSCbQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 26 Jan 2014 12:17:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F3C260A-876C-11E3-A246-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241143>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> This change could introduce a regression for people on a platform
>> whose certificate directory is /etc/ssl/certs but its IO::Socket:SSL
>> somehow fails to use it as SSL_ca_path without being told.
>
> I can confirm that my git-send-email doesn't regress to the
> pre-35035bbf state; my certificate directory is /etc/ssl/certs. I'm
> somewhat surprised that IO::Socket::SSL picks the right file/
> directory on every platform without being told explicitly. This change
> definitely looks like the right fix.

Thanks.
