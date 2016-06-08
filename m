From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 08 Jun 2016 09:56:11 -0700
Message-ID: <xmqqr3c7mxg4.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-2-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:56:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAgmG-00068E-RJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbcFHQ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:56:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754245AbcFHQ4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 12:56:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FD161F902;
	Wed,  8 Jun 2016 12:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GjYLunULFSQNJtfQ+mFRIAIlZMQ=; b=gS1A89
	ngR1bDz5vdbmfqQO6XSk8KU5hv5fAsmkKfVUHa4QjKFLc+kznVvRXTj5+aVmMHSA
	j3c/QwGAlk2ehKLDt77EW/T608wFu2FoAIEHCkd42+55jKlW1T4zje2JrPsU7yyh
	AO4jZc7aD3uw3trJnb9IIzX6En5ZEsdj02+B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pq8Kec5745ipfu3U55Kv0mMMJwrY/Wz/
	F/Kxt1dw1hIRA40kKZyrula+P/hbk7jPJ0TLoVy91YJv5Apa30acqmMASKy9lLhB
	fN1De96uj25+giLX/SEQsizY6yCvHqqUgA8+gNaWU7wRZi/bXBnAkOJJyWP9vMSv
	HGPBxWuk2dg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 666871F901;
	Wed,  8 Jun 2016 12:56:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1E6D1F900;
	Wed,  8 Jun 2016 12:56:12 -0400 (EDT)
In-Reply-To: <20160608130142.29879-2-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:01:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E824F8A0-2D99-11E6-9177-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296812>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> @@ -117,7 +124,7 @@ test_expect_success $PREREQ 'setup expect' '
>  '
>  
>  test_expect_success $PREREQ 'Verify commandline' '
> -	test_cmp expected commandline1
> +	test_cmp_noorder expected commandline1
>  '
>  
>  test_expect_success $PREREQ 'Send patches with --envelope-sender=auto' '

I think this comment applies to all the other hunk in this patch (I
didn't check very carefully though), but this is trying to see if
the command line arguments that drives send-email are like this (one
arg per line, enclosed in !! pairs for clarity):

	!patch@example.com!
	!-i!
	!nobody@example.com!
	!author@example.com!
	!one@example.com!
	!two@example.com!

when these addresses are given from the command line:

	git send-email \
        --envelope-sender="Patch Contributor <patch@example.com>" \
        --suppress-cc=sob \
        --from="Example <nobody@example.com>" \
        --to=nobody@example.com \
        --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors

that creates something like

$TRASH_DIRECTORY/fake.sendmail -f patch@example.com -i \
  nobody@example.com author@example.com one@example.com two@example.com

(all on a single line).

The earliest address patch@example.com and later addresses have
quite different meaning (the first one is meant to be the envelope
sender address, and does not name a recipient). While I think it is
a good idea to tell the test that the order of recipient addresses
given to the sendmail command (i.e. nobody, author, one and two)
does not matter by comparing sorted list of addresses, sorting the
whole argument list and comparing is making the test _too_ loose.
Don't you want to catch a potential bug that adds the envelope
sender address to the list of recipients by mistake, for example?
