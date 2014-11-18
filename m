From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Tue, 18 Nov 2014 09:08:32 -0800
Message-ID: <xmqqk32swi5r.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<xmqqtx1wwjtv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqmGh-0000Qz-0x
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbaKRRIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:08:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753677AbaKRRIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:08:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F82F1D6AC;
	Tue, 18 Nov 2014 12:08:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IWC2sn48Loz+2xeJvvz3Pc0Fb2g=; b=kQlH3d
	/W3KqL9I5CU5SbLv1/ciwUi37NHC4eXdF8GhbuMMRI+qlab/nePa4FX7qU8Hybj8
	oBoYdRK4N+h/ApnZwnokG7NZeQgRHRgt/JUD3lL0Ioz593NOe4oV/btPnAMHtGkB
	qMcT1FBFKRjSoWjYXIBKNnpXA/lpKwMApqa+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLzoHCLcIZAGK2XL7StFT6BMIllPvYV+
	i6UgGsGTWVYVTxY+bC/3ZYV52ME4e46K/9uleQoiBI2ETBqEThuwmS+3uc64DXW4
	w2cGt9m3ABRQ9Ts/uWlZiiaHCn/ynkyDrAHFHgOOkeW4RLIFD8fTFOhrqW5xfkr3
	HuJHLen/t5c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 749741D6A9;
	Tue, 18 Nov 2014 12:08:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 913C91D6A7;
	Tue, 18 Nov 2014 12:08:35 -0500 (EST)
In-Reply-To: <xmqqtx1wwjtv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Nov 2014 08:32:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 882D591A-6F45-11E4-9A4C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In short I am not a very big fan of passing around strbuf *err to
> low level helper API functions myself.
>
> But the approach does not make things much worse than it currently
> is, other than code churns to pass an extra pointer around.

Sorry I left the conclusion out of the message.

As it does not make things much worse, and does give slightly better
flexibility on error message emission to the callers, let's go with
the "strbuf *err" arpporach for now.

Until we hit a wall we cannot climb over, at which time we may need
to redo it, but let's first see how it goes.
