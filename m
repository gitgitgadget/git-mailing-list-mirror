From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 08:28:13 -0800
Message-ID: <7vmwwr4kiq.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRBE-0000TD-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab3ABQ2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:28:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab3ABQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:28:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC50FB282;
	Wed,  2 Jan 2013 11:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObefBjB3OKqDXiRvCZONWF88TMQ=; b=R+/WKM
	P7yzkVfQ7MfTi2rStmQrHkNISnntlOQMP98rVj9NMbIeyHDhIxTHZGAtLZf019H4
	QTzLjVwb7lTtGIXFxJj68QVaED7xVOdsGLkqL3GLzuu5vYBV+Hm6L87CKNdda2+5
	2wueuMQ21bts6A4Muq8DVXzlgVJ3F0khwWsK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H/wsK04W6hNZxkgVzstMceectORr7H0V
	t20gqw2StPazN+e6l4WhPVhD8ItFjxun/BzdzOi6K/3ySKmGKpyc+0Q39LouEyuK
	g91DBGTyb2Zo66jlx2LX1Ay9CN8Idr1Yz97tTrYFAm0Zj6CAj2Skmr5M1sJuYcFp
	Ew4Pswny44c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E079B281;
	Wed,  2 Jan 2013 11:28:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AC78B27F; Wed,  2 Jan 2013
 11:28:14 -0500 (EST)
In-Reply-To: <20130102094635.GD9328@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Jan 2013 04:46:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 687369F6-54F9-11E2-BB26-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212518>

Jeff King <peff@peff.net> writes:

> So taking all of that, a more idiomatic perl script would look something
> like:
>
>   my $exit_code;
>   sub err {
>     my $msg = shift;
>     print "$ARGV:$.: error: $msg: $_\n";
>     $exit_code = 1;
>   }
>
>   while (<>) {
>     chomp;
>     if (/^\s*sed\s+-i/) {
>       err('sed -i is not portable');
>     }
>     # ...and so on
>
>     # this resets our $. for each file
>     close ARGV if eof;
>   }
>   exit $exit_code;
>
> I'd personally probably write the conditions like:
>
>   /^\s*sed\s+-i/ and err('sed -i is not portable');
>
> to make the structure of the program (i.e., a list of conditions to
> complain about) clear, but I know not everybody agrees with such a terse
> style.

Thanks for a nicely-done review.
