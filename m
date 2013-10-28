From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 12:08:39 -0700
Message-ID: <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
	<1382951633-6456-1-git-send-email-bdwalton@gmail.com>
	<526EA7C8.2020607@kdbg.org> <20131028182718.GA4242@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VasBF-0005dK-5f
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3J1TIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:08:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J1TIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:08:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E38AB4EAA7;
	Mon, 28 Oct 2013 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aTegpQQRwr3KRTpWIe1VbUSj0o=; b=nVI5LC
	p6Z1p3Jwo+eZsAsy5eiUO8qp2oeY8szriZZu1HO35uNh6kcp43ih1sOrrNUXoRAw
	GQw4MQ7XFrJfFoBsuSohm4LC7hbRxRirjL0rbbhA6ZZ0P2rpkAuS8jw+fvAFT8YL
	fMrbIJjW+1AHUdHJvxYm+mU/B1+0Zso0EsYrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDnwFTu/UmnWjwGUX+wr7F1+BlPzVHnJ
	x4g24+oVKI1jbWhoGowhFVHtMiDi8aBE7ADsMPRTf12GUUS6mXpu+U2uHv9+cWNP
	0yYFfuFIw3DAIJ0bC9MLLQmwQvUdu+n+r0uivNrh9aOpL6xhznfpkwsjTy+MaYlJ
	jb9hmLSLpm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20404EAA5;
	Mon, 28 Oct 2013 19:08:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DB7E4EA9F;
	Mon, 28 Oct 2013 19:08:41 +0000 (UTC)
In-Reply-To: <20131028182718.GA4242@google.com> (Jonathan Nieder's message of
	"Mon, 28 Oct 2013 11:27:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B97CA28-4004-11E3-84CD-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236847>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>
>> In other tests, we check for prerequisite PERL, i.e., we are prepared
>> that perl is not available. Shouldn't we do that here, too?
>
> I think the tests assume there's a perl present even when the PERL
> prereq isn't present already.  E.g.:
>
> 	nul_to_q () {
> 		"$PERL_PATH" -pe 'y/\000/Q/'
> 	}
>
> So in practice the PERL prereq just means "NO_PERL wasn't set", or
> in other words, "commands that use perl work".  Maybe something
> like the following would help?
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git i/t/README w/t/README
> index 2167125..54cd064 100644
> --- i/t/README
> +++ w/t/README
> @@ -629,11 +629,20 @@ See the prereq argument to the test_* functions in the "Test harness
>  library" section above and the "test_have_prereq" function for how to
>  use these, and "test_set_prereq" for how to define your own.
>  
> - - PERL & PYTHON
> + - PYTHON
>  
> -   Git wasn't compiled with NO_PERL=YesPlease or
> -   NO_PYTHON=YesPlease. Wrap any tests that need Perl or Python in
> -   these.
> +   Git wasn't compiled with NO_PYTHON=YesPlease. Wrap any tests that
> +   need Python with this.
> +
> + - PERL
> +
> +   Git wasn't compiled with NO_PERL=YesPlease.
> +
> +   Even without the PERL prerequisite, tests can assume there is a
> +   usable perl interpreter at $PERL_PATH, though it need not be
> +   particularly modern.
> +
> +   Wrap tests for commands implemented in Perl with this.

Sounds like a sensible thing to address, but I first parsed it as

    Wrap (tests for (commands implemented in Perl)) with this.

while I think the readers are expected to parse it as

   Wrap ((tests for commands) implemented in Perl) with this.
