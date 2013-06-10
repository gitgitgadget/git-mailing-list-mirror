From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2]  rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 13:55:48 -0700
Message-ID: <7v4nd5fzxn.fsf@alter.siamese.dyndns.org>
References: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<7v8v2hkhqc.fsf@alter.siamese.dyndns.org>
	<vpqtxl5dfrf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um987-0008AQ-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab3FJUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 16:55:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab3FJUzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:55:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C44271A7;
	Mon, 10 Jun 2013 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uLaNBe/mrCW4RXQk+0LEVAPTGMw=; b=Z9q6kT
	2MhaahHEB9BdQY5R6loseUqrGKPTMf5BfIi4Fsx08GkcEIXoWmz0gtarw/TTtVse
	RmLiLPKiN2ecPK8QIbNlnez7OtCLFSSm0w6u8rwaUtYqsI0qyg1oRU0nQXGhclmH
	tqGo4nimhEZVnpbKfoOI8cLpiJ6Z0rmdhr8/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qwV1IBMJWH4K0yop1QH2HJkjNsXWognP
	yldg+tKrgsd7KEVdbuWusS2gqt+E56j42JCSAWZXZ2BuIKxIk/sCpddoeEgvl1oa
	2re3x0bTir3Z3J92DNqisr4/DQq4z/H0j1mUOAed81c0EyLhm4r/sAf16DF07n5b
	GW/dbqAgvOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A77E1271A6;
	Mon, 10 Jun 2013 20:55:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1180E271A4;
	Mon, 10 Jun 2013 20:55:49 +0000 (UTC)
In-Reply-To: <vpqtxl5dfrf.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	10 Jun 2013 19:42:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21AD02FE-D210-11E2-903D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227378>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +{
>>> +	if (files_list->nr) {
>>> +		struct strbuf err_msg = STRBUF_INIT;
>>> +		int i;
>>> +		strbuf_addstr(&err_msg, main_msg);
>>> +		for (i = 0; i < files_list->nr; i++)
>>> +			strbuf_addf(&err_msg,
>>> +				    "\n    %s",
>>
>> Is there an implication of having always 4 spaces here to l10n/i18n
>> here?  I am wondering if it should be _("\n    %s").
>
> I'd say this is just formatting and should be the same in every
> languages, but I'm far from an expert in the domain.

After looking at the patch again I do not think 4-SP matters.  I was
primarily worried if this was to align with some column of the first
line of output, e.g.

	error: lorem ipsum dolor sit amet, consectetur adipisicing
               elit, sed do eiusmod tempor incididunt ut labore et
               dolore magna aliqua.

but that is not what this 4-SP indent is about, so it is OK.

>>         test_expect_success 'rm files with different staged content' '
>>                 cat >expect <<\-EOF &&
>
> (that should be -\EOF, not \-EOF I think)

Sorry, my bad.  You are of course right.

>>  (2) by using a dash '-' before the end-of-here-text marker, you can
>>      align the body of here text with a leading tab (HT).
>
> This works because the list of files is aligned with spaces, but is
> seems a bit fragile to me to use this -EOF on a text which uses
> indentation. Anyway, I'm fine with both.

True.
