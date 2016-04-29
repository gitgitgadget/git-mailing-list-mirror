From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 14:05:28 -0700
Message-ID: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
	<20160429121429.GB27952@sigill.intra.peff.net>
	<vpqeg9o7gh4.fsf@anie.imag.fr>
	<CAGZ79kbBCM0CdBoeWTx9kWBBN1f-kuibpUNh9FacOb2xxCDPcw@mail.gmail.com>
	<D3ACDA07-DBD4-44B5-8D0A-531F2EC3BD65@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	stefan.naewe@atlas-elektronik.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:05:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFbV-0005Ri-PV
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 23:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbcD2VFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 17:05:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752463AbcD2VFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 17:05:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09A2F17336;
	Fri, 29 Apr 2016 17:05:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nmmB12shc1gsH/YetQcA8HkDFi8=; b=wJJrtD
	2EjeiLMtgHh4avp1MZU+lx3Qh5mo4jbN9kj7Lc5u1LWqLhYrU8Op5DVqMr6fzuqO
	8MeOHliR8b0k9P1bz+zsl8C5dlwDvsj0G9HBEXiKxJhSUiXtXPYjaE1cHUbhUekk
	gCyXVHIAiCp8hxa+yDmQu7DAFHjJr9+8vTpQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIMo16BlNqOhnG0NnyY925Yq5nChTKdK
	ckkl8fJE5S7DhscXX+oE/cQ5XXqcedfV07iMeJ4Ih/atgdFzE+Kz9tO5O66fjEmR
	pYDBkb1beMJB5U0WEEXbocGjBCYFgaEdQ7GMo8MR3uZiHuNmTmU3GtlEKZVkTrQc
	qCgYVjHnM1U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0045317335;
	Fri, 29 Apr 2016 17:05:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 535CB17330;
	Fri, 29 Apr 2016 17:05:30 -0400 (EDT)
In-Reply-To: <D3ACDA07-DBD4-44B5-8D0A-531F2EC3BD65@gmail.com> (Lars
	Schneider's message of "Fri, 29 Apr 2016 22:44:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AFA1B18-0E4E-11E6-93E4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293056>

Lars Schneider <larsxschneider@gmail.com> writes:

>> This could be less of maintenance if we'd check with a "larger as" operator
>> such as
>> 
>>    test_file_count_more_than html 200
>> 
>> using an arbitrary slightly smaller number.
>
> Well, I was thinking about testing against something like 
> $(find . -type f -name "git*.txt" | wc -l) but it the end
> all of this is not really meaningful I think...

Either is too much, I would say--I have too much faith in the exit
status from "make doc", I guess.

What would _REALLY_ be nice is a check that lets us catch an error
like this deliberate breakage:

    diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
    index 4b0318e..a684f2d 100644
    --- a/Documentation/diff-options.txt
    +++ b/Documentation/diff-options.txt
    @@ -560,4 +560,4 @@ endif::git-format-patch[]
            Do not show any source or destination prefix.

     For more detailed explanation on these common options, see also
    -linkgit:gitdiffcore[7].
    +linkgit:gitdiffnore[7].

We just get a dangling link in the result without an error exit from
"make doc"; neither "test -s" nor "size is about what we expect"
would catch such a breakage, though.

Other things that might be of interest are

    make check-builtins
    make check-docs

but I am not sure if the latter built target is up to date (it has a
whiltelist that needs to stay current).  We rarely add new commands
these days, so it is easy to forget what these build targets try to
check, which makes them good candidates to be thrown into the set of
automated tests.
