From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix problem causing erroneous project list
Date: Fri, 07 Jun 2013 14:59:36 -0700
Message-ID: <7vd2rxshtj.fsf@alter.siamese.dyndns.org>
References: <20130605043524.GA2453@compy.Home>
	<7vd2s01i6f.fsf@alter.siamese.dyndns.org>
	<CANQwDwfiuNSk+woFheqfi527rfutZ2YYH1h3tjuWh0ziwmU+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles McGarvey <chazmcgarvey@brokenzipper.com>,
	git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 23:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4hD-000577-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab3FGV7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:59:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab3FGV7j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 17:59:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE9F326F74;
	Fri,  7 Jun 2013 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=304sAwk0mzJT
	f7Nx5NaREtMYIaE=; b=nuDfi8f0FQbk3lY5t35bBAig0bBb9J5c78ktSg3O4DCj
	y+cQfr/lKDpXPf9UJM3GKBpThcISBJbr4L0Nt9G5SumwYpQkYfoAIFmxSrnEiP6L
	0d3dWQU0DxhyNdT1oBUu6DxMBuRYyeld1mwVVgEP5gzKQ5lQpkHTrHWNFJZIh7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cWMzK3
	R9tGkr0xdVdraOOoXsVCrLihw79OgXIyBe2O4plB3nalMsukyXxsjldOcRx4e/o8
	3uv/Le/slARku44FvMKE/Fwns1A7XQ79QvQ8wm7Ljta4ZYzLmIu2Z3Z8exq5GfBB
	fAUs3P1eBlyqwjJQK+n9cdbf7YMF9cs0mXtGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B36BE26F73;
	Fri,  7 Jun 2013 21:59:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33AA626F6F;
	Fri,  7 Jun 2013 21:59:38 +0000 (UTC)
In-Reply-To: <CANQwDwfiuNSk+woFheqfi527rfutZ2YYH1h3tjuWh0ziwmU+uQ@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 7 Jun 2013 22:39:45
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C2F206C-CFBD-11E2-86A9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226744>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>>> Instead, clear $search_regexp before dispatching each request.
>>>
>>> Signed-off-by: Charles McGarvey <chazmcgarvey@brokenzipper.com>
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks (the ack was a few hours too late and the commit is already
in 'next', so I won't be able to rewind it though).

>> By the way, I looked at how $search_regexp is used in the code:
>
> How $search_regexp is used does not matter. What was intended
> (but was not implemented) is for $search_regexp to matter and to
> be used only if $searchtext is defined.  $searchtext is reset on each
> request, so $search_regexp should be also reset... like in Charles's
> patch.

Oh, we are in total agreement about that.  That is why the part is
marked with "By the way"---it is an orthogonal issue (which turned
out to be a non-issue).

>>  x git_search_files and git_search_grep_body assume that
>>    $search_regexp can be interpolated in m//, which is not very
>>    nice.  They want an empty string.
>
> But both git_search_files() and git_search_grep_body() are run from
> git_search(), which "dies" (returns HTTP 400 "Text field is empty" er=
ror)
> if $searchtext is not defined; if $searchtext is defined then $search=
_regexp
> is string and is never undef.

Thanks; that is what I missed.

>> So as an independent fix, the two subs may want to be fixed if we
>> want to be undef clean.  Or am I missing something?
