From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] stash: handle specifying stashes with spaces
Date: Thu, 09 Jan 2014 10:42:18 -0800
Message-ID: <xmqq1u0hatf9.fsf@gitster.dls.corp.google.com>
References: <1389082935-16159-1-git-send-email-oystwa@gmail.com>
	<xmqq7gabeiqo.fsf@gitster.dls.corp.google.com>
	<87ob3nphc5.fsf@thomasrast.ch>
	<xmqqiotvbf4g.fsf@gitster.dls.corp.google.com>
	<loom.20140108T003945-67@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 19:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1KYk-0005wq-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 19:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbaAISmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jan 2014 13:42:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaAISmW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 13:42:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F7C461AE7;
	Thu,  9 Jan 2014 13:42:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yC6bj4eHYbmT
	B9fPaBHyhTqhevc=; b=H9M6z9tnXKvx8YKBSkrL1+tF1dDC8WoPPjI8KcVnQxR4
	1I6yRafY//kc9pkuEzpmCV2Y6s++mFrBQWN/NmqpVGFS1aAZAixTQ04/LAf1zgCl
	bBSbornimC++JURav41XAan7rdI5/QD2LluhgekCz/s4UwLmV8g/eFHCf7ct/lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kuFpMf
	NZcame8N8QiCol4AtJxpF2fs+sQ+wW5s3UsuKqPrB0k6cyQFRGB8ufOzW9nkSO1D
	wHZSlcAwMBBg91RUZiqcM+noSxhsXnklQIQgBKcHk4+bmMrjpb4NYbGrVBLDcv5f
	GFme6TaVzlONXY2hscOb7SSH/yxr7SKysrqSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C61361AE6;
	Thu,  9 Jan 2014 13:42:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B964561AE4;
	Thu,  9 Jan 2014 13:42:20 -0500 (EST)
In-Reply-To: <loom.20140108T003945-67@post.gmane.org> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
	message of "Wed, 8 Jan 2014 00:03:54 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5BD8DBA-795D-11E3-8990-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240264>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> But it's seems the spaces trigger some other way of interpreting the
> selector. In my git.git, git rev-parse HEAD{0} gives me the same resu=
lt
> as HEAD@{ 0 } but HEAD@{1} and HEAD@{ 1 } are different.

The integer to specify the nth reflog entry (or nth prior checkout)
are never spelled with any SP stuffing. HEAD@{1} is the prior state,
HEAD@{-1} is the previous branch; HEAD@{ 1 } nor HEAD@{ -1 } do not
mean these things.

Any string inside @{...} that is _not_ a valid nth reflog entry
specifier is interpreted as a human-readable timestamp via the
approxidate logic (and used only when it makes sense).  " 1" happens
to mean "the first day of the month".
