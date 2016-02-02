From: Junio C Hamano <gitster@pobox.com>
Subject: Re: parse_object does check_sha1_signature but not parse_object_buffer?
Date: Mon, 01 Feb 2016 19:10:04 -0800
Message-ID: <xmqq60y7u7sj.fsf@gitster.mtv.corp.google.com>
References: <20160202015701.GA30444@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 04:10:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQRMC-0002vJ-9f
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 04:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbcBBDKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 22:10:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751728AbcBBDKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 22:10:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0358441FDA;
	Mon,  1 Feb 2016 22:10:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opU+qB2cV2ODjnm8rTffnQKJ6TQ=; b=Im0V8K
	5bYEOPfI/ejouGBt5TGn+EEmgeo8UYcDZ9vp1GAxQx+890Oi5WcmfCkqxYyDgSHv
	qEq7NwHUwHH5RYX8SBoUw7N0g260Dfec4JTOks5WYlsQuKm3EAk8d5Ra+jYbOwT0
	FJkrGEXi6eDmaJxqP7YL/CK8Wu7H7oAApnWPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUGbC8n91UD0lGm1C0Oz9OCFrSAI11MX
	iyCX6HMJcpPK7RkaVEdw+8PtlQdw9nnPyMTMxs78DzZH9bAeu7YaZ8Js67a2BvEV
	gFfQovgeLn/ZaWphKsaKXh4SYIqfobF3y7dsm3rONftNirfxQS9AgTK1f9nZVuJ5
	Gm283Bx/ukg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF60C41FD9;
	Mon,  1 Feb 2016 22:10:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 635FB41FD7;
	Mon,  1 Feb 2016 22:10:05 -0500 (EST)
In-Reply-To: <20160202015701.GA30444@glandium.org> (Mike Hommey's message of
	"Tue, 2 Feb 2016 10:57:01 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75243D32-C95A-11E5-8361-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285234>

Mike Hommey <mh@glandium.org> writes:

> Shouldn't parse_object_buffer also do check_sha1_signature?

In general, it shouldn't; its callers are supposed to do it as
additional check when/if needed.  Callers like the one in fsck.c
does not want to die after seeing one bad one.  We want to report
and keep checking other things.
