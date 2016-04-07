From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 07 Apr 2016 11:32:39 -0700
Message-ID: <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
References: <5706A489.7070101@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoEjW-00041Z-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221AbcDGScn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:32:43 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756577AbcDGScm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 14:32:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 080E550DDA;
	Thu,  7 Apr 2016 14:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90fXpX4bxS0m9vqgiw15V0XtcaY=; b=qelyLh
	mu1aKukuZM2COhxTC5Bm8IbX4GdGt2hzb8kyWx64CwK++AB8q/78vteba00xyoqD
	9vyH6n8WC9qWCDpfFbtsCdezN657ZXAM4nlv5xQaS3MuBIlyIULWpk+B5n8J+Z1i
	U9lhrPfRONdLPfBZB6MTBqrrQDoek1T/1j+fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMX68ZBquQJiWfNVKbuZCE66OK3YRMMJ
	5IiQGUIwIqI10S+2AiYxz2C0qqatiTBLJbTgp9LVEdHHI9i1BMBwUELEnHeJopPd
	O70gUhaat8Y8yFYhforfJj8HEsKotBOtsuEZbYiVU+kqOslW3Zpsf7ML9Fxouf5n
	aAILk9/tGD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F377650DD7;
	Thu,  7 Apr 2016 14:32:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 702BC50DD6;
	Thu,  7 Apr 2016 14:32:40 -0400 (EDT)
In-Reply-To: <5706A489.7070101@jupiterrise.com> (Tom G. Christensen's message
	of "Thu, 7 Apr 2016 20:18:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C2C7D0C-FCEF-11E5-8F05-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290944>

"Tom G. Christensen" <tgc@jupiterrise.com> writes:

> The reason for the crash is simple, a null value was passed to the 's'
> format for the *printf family of functions.
> ...
> Passing a null value to the 's' format is explicitly documented as
> giving undefined results on Solaris, even on Solaris 11(2).

Do you mean

	*printf("...%.*s...", ..., 0, NULL, ...)

i.e. you saw a NULL passed only when we use %.*s with width=0?
