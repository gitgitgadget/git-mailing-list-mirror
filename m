From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Mon, 18 Apr 2016 11:45:54 -0700
Message-ID: <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:46:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asEBO-0008CS-89
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbcDRSp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 14:45:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbcDRSp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 14:45:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7DDD13B6D;
	Mon, 18 Apr 2016 14:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zWxN7BCQwaxfxVSl2MSc+0/W/kA=; b=dx2dQv
	eOZ6xlbAahrZSqJdrJ2jY7Fsqe2c54cbPa7vKvLnrJ124zEGjGf0BGmtUFQPKmxw
	Bd8bA13NcJ9DxVZ9q0Ysf1wpu6brTHrVQlpEIXb/cqc7iBXUKACEn88Qis12NAir
	SzNQUE+7pkUzR2tfJTFyfQB28gFr2yi+IomsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBvpy7xRRU4zG2dUbat4Spxd5KSAURza
	SSfKkKYGVw30/23QCgLrzN9Y5uKRTKRmqOqHFv5EPJEFbsuZpU6H+t91LELjpmyD
	CPI5SfHR2ZGJ2Niad1VtOnEGGQmOF8oX0ViaFL+S+bA9/A8vGZZY6vOjehNH6Bl0
	9c+E7f+cLvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFB0213B6C;
	Mon, 18 Apr 2016 14:45:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42D1413B6B;
	Mon, 18 Apr 2016 14:45:55 -0400 (EDT)
In-Reply-To: <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 15 Apr 2016 15:19:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8768DCE-0595-11E6-A083-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291819>

David Turner <dturner@twopensource.com> writes:

> Add parameters for a list of refspecs to transport_get_remote_refs and
> get_refs_list.  These parameters are presently unused -- soon, we will
> use them to implement fetches which only learn about a subset of refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

What the code tries to do I am more than halfway happy.  It is
unfortunate that we cannot do this natively without upgrading the
protocol in a fundamental way, but this is a nice way to work it
around only for Git-over-HTTP transport without having to break the
protocol.
 
As a POC it is OK, but I am moderately unhappy with the use of
"refspec" here.

At the transport layer, we shouldn't care what the receiving end
intends to do with the objects that sits at the tip of the refs at
the other end, so sending "refspecs" down feels somewhat wrong for
this feature.  At one layer up in the next patch, you do use
"interesting refs" which makes it clear that only the left-hand-side
of a refspec, i.e. what they call it, matters, and I think that is a
much better phrasing of the concept (and the passed data should only
be the left-hand-side of refspecs).

Thanks.
