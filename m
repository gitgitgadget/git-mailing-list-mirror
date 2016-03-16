From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Wed, 16 Mar 2016 10:24:44 -0700
Message-ID: <xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Your friend <pickfire@riseup.net>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:24:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFBl-0007bo-3C
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbcCPRYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 13:24:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932275AbcCPRYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 13:24:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 991A74B043;
	Wed, 16 Mar 2016 13:24:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AwdW3O3xOehU
	UlHZVTHYt1Bf7hw=; b=cWRXURMXJuw0EUXPbOEknXxEl6gRHaWpsNbW5ePs6nkL
	IPqcxEFGlc/RnODKOiNXBpPo15bK9Nuw9R7Q8FVU3wNpTEBdmcQ0oj1xxkeljwoB
	YaDN5F/UEws+NxIAxlCHrLxB3hmmhmB1jxqfoFSTG/v5lM3DvveBU3XHToi7TVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ThllD/
	vNeLJEiudySJN+9vlYNyTPdlwg3zkEzoY18OZ2HiwO78WtA1bqz9F5CJ5/9lQNO/
	S+gQ3ZnyZK5UJapMqfUJWwtTcWmuG25OHAtXpBJ6OzsFW0PBdv+Tx4yCRVMfKuvm
	WSUmyFYN8Iez3M9JQDP+AYT6GZ6EjaTAnyuc4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DDA64B042;
	Wed, 16 Mar 2016 13:24:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C6944B041;
	Wed, 16 Mar 2016 13:24:45 -0400 (EDT)
In-Reply-To: <CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Thu, 17 Mar 2016 00:40:59
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA8CA78A-EB9B-11E5-B03A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289000>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

>> Is it because the wish is to always use /tmp/git-$uid/ as a fallback
>> for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
>> is specific to the credential-cache and would look strange if we
>> used it for other "runtime" things)?
>
> Yes, I mean to use it as a general fallback for git.

If that is the case the code probably needs to be a bit more careful
before deciding to use /tmp/git-$uid/ directory (is it really $uid's?
can anybody else write to it to race with the real user? etc.)

> On the other hand, I think, falling back to $HOME/.git-credential-cac=
he/socket
> doesn't make any sense for back-compability cannot be ensured.

What do you mean by that?

Using ~/.git-credential-cache/credential-cache.sock would not help
at all for existing users, but ~/.git-credential-cache/socket would
interoperate well with users with existing versions of Git, no?

>> Just being curious, and wanting to see the reasoning behind the
>> design decision the patch series makes in the log message of one of
>> these patches.
