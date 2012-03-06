From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 10:43:25 -0800
Message-ID: <7veht5tvsi.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <1330903437-31386-2-git-send-email-greened@obbligato.org>
 <87aa3vzdoc.fsf@thomas.inf.ethz.ch> <nngy5re29zn.fsf@transit.us.cray.com>
 <878vje86cy.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David A. Greene" <dag@cray.com>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:43:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zMM-0003dy-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab2CFSn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:43:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210Ab2CFSn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:43:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C70953BF;
	Tue,  6 Mar 2012 13:43:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4mYMyXz4iPUT1Uq080+nw8dFC68=; b=JFoDBC
	TcJxUf/mIDKkNhcA8axUJkJnCVQMkT+CYBB0gMDNFg9dhtXkD5uNM0KYe1MQJ8+2
	Vng9col6cX/pTkSIwY3GCIezVJuY2cvMaxikz0THBg8069IjPpCo6+W7/TCdXD1e
	Tbby+Ej1al9J/mTo2feUFpyTOP7A43mU/TYlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sc1JADQ8G+hMWXrbdvwPC4ZhVzkItpCQ
	9JIo0gWkPqnhS5r3fJy7vESgMHEVVIlTD8TPFOjXLj8M6DT5EYtqGGQvfNGNX8lO
	fZa5TyPJkm7d1fQlxydtzJ3qW0ya69pdi6ZqnALZrJhiAG9ARbnpxbA4fTAdWK7q
	ss9ajmAaaS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73CA453BE;
	Tue,  6 Mar 2012 13:43:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D09A553BD; Tue,  6 Mar 2012
 13:43:26 -0500 (EST)
In-Reply-To: <878vje86cy.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 09:46:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42B76CB0-67BC-11E1-8FC4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192373>

Thomas Rast <trast@inf.ethz.ch> writes:

> Don't we, right now, get stuff as follows:
>
>   item                   path
>   --------------------------------------------
>   test-lib.sh            $TEST_DIRECTORY
>   git                    $GIT_BUILD_DIR/bin-wrappers
>   valgrind.sh            $TEST_DIRECTORY/valgrind
>   git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin
>
> You are saying this must change to an entirely new path
>
>   valgrind.sh            $GIT_VALGRIND_TOOLS
>   git (with --valgrind)  $GIT_VALGRIND_TOOLS/bin
>
> but what's wrong with simply
>
>   valgrind.sh            $GIT_BUILD_DIR/t/valgrind
>   git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin
>
> In the common case of t/, these just map to what we had before.  In the
> out-of-tree case, we'd create valgrind/bin in the test directory for the
> *temporary* stuff, and still look for the wrapping valgrind.sh in the
> git tree.

Sounds sane.  Simple is good.

No matter what happens to this particular patch, could we have the
above table (the final version of it, that is) in t/README or
something, please?

Thanks.
