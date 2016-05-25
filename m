From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Wed, 25 May 2016 09:23:01 -0700
Message-ID: <xmqqfut6150a.fsf@gitster.mtv.corp.google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1464130008.24478.134.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:23:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5baR-0004fQ-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbcEYQXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:23:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcEYQXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:23:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC9281DDF1;
	Wed, 25 May 2016 12:23:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rX6YJ/wJ1qoVUYPI7bquRI4C1TA=; b=bXBuNh
	uofot0CqUUpzust1DV9qOJYl53F2eaGhS5S/vnyzFilU4i2PuJlobaqFSFrV5E+j
	0XA7jB9/XM6ZVQWt6pqWNEg836Sg4fQS7C3CmmGsqL++eCgomwEXTL8STbYWrJEW
	30Z8qnfQUebuh2S9iDWiLfYVb/hu+S6EfBKLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+/YxeKzcEona59FLlA8w/LRL30hBpoM
	Ekl28C+BeW7TkrODbHmoBP4omp87miJkrwA0NIqlZhPOpFucNjAmTXIXaSS8WzLD
	U1s72RmWbO6rgEezXcokiqf6U7BOtxrO2JPuAbTy/egZhe4jTV1oDSnmzHRz79Be
	v5W3LeQPBmk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B55171DDF0;
	Wed, 25 May 2016 12:23:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 379971DDEF;
	Wed, 25 May 2016 12:23:03 -0400 (EDT)
In-Reply-To: <1464130008.24478.134.camel@twopensource.com> (David Turner's
	message of "Tue, 24 May 2016 18:46:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F468E136-2294-11E6-99A3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295578>

David Turner <dturner@twopensource.com> writes:

> I was looking at this again today, and noticed that it doesn't really
> address the HTTP case.
>
> The central problem is that protocol v2 goes like this:
> server: I have capabilities w,x,y, and z
> client: I want capabilities x and z.
>
> But HTTP goes like this:
> client: [request]
> server: [response]

I wonder if that can be solved by speculative request?

Let the connection initiator say "If you can do x and z, please do
so", and allow the responder to say either "OK, I can do x and z; by
the way the full capabilites I support are w, x, y and z", or
"Sorry, can't do that; I have capabilities w, x, and y".
