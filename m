From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] receive-pack.c: add protocol support to negotiate atomic-push
Date: Thu, 30 Oct 2014 12:59:14 -0700
Message-ID: <xmqqmw8duy5p.fsf@gitster.dls.corp.google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 20:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjvsQ-0005os-IU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 20:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759227AbaJ3T7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 15:59:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758072AbaJ3T7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 15:59:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A2D319663;
	Thu, 30 Oct 2014 15:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OXKR6d5nEF0YFlyfg1+yEU0koDY=; b=Iq36og
	gxO9mp/u2EthYLUHm3VMSf5MUxhQU3hG3Y15bfdToRX118O7MU0LTpgGSRlIevWn
	t6WhbxOclqLeBapsAmQBaVgK3X2NjePdtmIAjHLRDJatPls9TuZ6J2YqsS3bPkxE
	TWNHtnudyBGvWVT8IjtVbsvZnnTdPD8vwIV/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wVpjEeIBCDkLEEwCscn5yQTWsejUZ/kw
	H1x58dgCjoxEOcUxE5uxxrj/OPqQHhKuA49IPo6AvnptjlwVqQdt0BbFBlwKoNt8
	CgONmUlr/Wey1eXkm+TtHztjE29FcWqFpKAipQgUiUOqIS4MIKGu0CQZCgrTgbM8
	pPLy9LLL1f0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70A3019662;
	Thu, 30 Oct 2014 15:59:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBF2719661;
	Thu, 30 Oct 2014 15:59:15 -0400 (EDT)
In-Reply-To: <1413924400-15418-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 13:46:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A06D91C-606F-11E4-AB79-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> @@ -337,6 +341,8 @@ int send_pack(struct send_pack_args *args,
>  		strbuf_addstr(&cap_buf, " quiet");
>  	if (agent_supported)
>  		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
> +	if (atomic_push)
> +		strbuf_addstr(&cap_buf, " atomic-push");

This is just aesthetics, but please leave the agent at the end.
