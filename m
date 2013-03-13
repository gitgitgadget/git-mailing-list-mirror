From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t2200: check that "add -u" limits itself to
 subdirectory
Date: Wed, 13 Mar 2013 10:44:25 -0700
Message-ID: <7vli9r2o06.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041022.GA5378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpjS-0000oA-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151Ab3CMRo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:44:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933096Ab3CMRo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:44:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33AA7B072;
	Wed, 13 Mar 2013 13:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6nboEwaBCKiwKe01fHX9nOSJxY=; b=qWtvQg
	JPHGHZr8M6pO8E4lrYwZOh/OrY2VrjNoQc8447V7se9EeF9ZWoL+XJZxR+afWASW
	FoAkqLPtkhdclKxceVtOoi5w3gssinTb7cJueKBwDpXJE2DyObHUS7LX2zwqjU9A
	h1obvNUrss76Qipc/Io9uRXXbAstjQzFsdfPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umEtQ1o9b1ZFRFyBEpUOZmtURMhTLNw0
	+A2LatGAmmZwE+/eQq4014iAdQDV9jgUR/tn/A3fKtotcNLKlX/JkttVMOywJ8HQ
	WpgkSXMxjx9oosA8ZMt3iw31eYJvAWQpiAchdz4XQutSrsrPc47ecCUOcbO6GMmV
	amkDp4Ebjxc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274A8B071;
	Wed, 13 Mar 2013 13:44:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8881DB070; Wed, 13 Mar 2013
 13:44:26 -0400 (EDT)
In-Reply-To: <20130313041022.GA5378@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Mar 2013 00:10:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A633C284-8C05-11E2-ADC0-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218075>

Jeff King <peff@peff.net> writes:

> We didn't seem to be testing this transition at all. I think it's sane
> to do so now, and Junio's "now it is 2.0, let's switch" patch should
> update the test.

Yes, but I am not sure if this is testing the right thing.

> +# Note that this is scheduled to change in Git 2.0, when
> +# "git add -u" will become full-tree by default.
> +test_expect_success 'update did not touch files at root' '
> +	cat >expect <<-\EOF &&
> +	check
> +	top
> +	EOF
> +	git diff-files --name-only >actual &&
> +	test_cmp expect actual
> +'

The last "git add -u" we have beforet his block is this test piece:

 test_expect_success 'update from a subdirectory' '
        (
                cd dir1 &&
                echo more >sub2 &&
                git add -u sub2
        )
 '

That is not "git add -u" without pathspec, which is the only thing
we are transitioning at Git 2.0 boundary.
