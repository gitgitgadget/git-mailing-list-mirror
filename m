From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Fri, 08 Apr 2016 09:52:46 -0700
Message-ID: <xmqq4mbcxctd.fsf@gitster.mtv.corp.google.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
	<CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 18:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZeT-00074n-BI
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbcDHQwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:52:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752071AbcDHQwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:52:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 479FA5157D;
	Fri,  8 Apr 2016 12:52:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rjq6vMUKCK7tlRkE6ry8UO6VMoA=; b=Yqa9Eh
	jSpQdB5dze/Y6akuraCzJW9zX3ugE2VmOHFUZVpC3nSMxpo1FNbshKBbq+LQgc2Y
	Z0MEQfCPO0/Ck+9HfKFRFYRqcy/v+qwG6XhXV9Cz0fFTirynvEKJbOPz6CewYU/z
	70ufrzhgKNqxaLt3vdTb5+atILvhlUqAuXj7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sx+QoVwHZPcCeDvvyI6kQDcH7gtyQS1u
	mWgxebKShuFqv/UfYfA7Qq7sfrsDbOOcIUW3GP8u0ipd4cCU8iuWTNOyfWA06OfJ
	XRvGqP/ksE3B2G4NI4iLJN1K1+h5jV3o3IPRcPqjBfGn6YdsYrhXG8fXHoA08WOP
	GstYd1g5NQk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E1E05157C;
	Fri,  8 Apr 2016 12:52:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B43235157B;
	Fri,  8 Apr 2016 12:52:47 -0400 (EDT)
In-Reply-To: <CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 3 Apr 2016 17:30:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52A567AC-FDAA-11E5-9C2C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291044>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>> and not boolean and thus it is more appropriate to print it as integer
>> to avoid confusion.
>
> I can buy this line of reasoning, however, it would be even easier to
> sell the change if you cited an existing client (a git command) which
> actually respects multiple quiet levels. Are there any?

This is the only one I found in Documentation/

    -q::
    --quiet::
            Make 'git svn' less verbose. Specify a second time to make it
            even less verbose.

It probably is not a good idea to use OPT__QUIET() and try to do
multiple classes of quietness in the longer term anyway.

New work should be done to improve OPT_VERBOSITY() that already can
do "even more verbose" and "even more quiet" with a single variable;
currently there is no way to ask "has any verbosity ever been given
from the command line?", and we may want to support that.
