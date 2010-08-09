From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib: user-friendly alternatives to test [!]
 [-d|-f]
Date: Mon, 09 Aug 2010 09:25:15 -0700
Message-ID: <7vvd7j7nys.fsf@alter.siamese.dyndns.org>
References: <vpqfwytnh0m.fsf@bauges.imag.fr>
 <1281027281-21055-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVAK-0000h8-HJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab0HIQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:25:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832Ab0HIQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D7A413F6;
	Mon,  9 Aug 2010 12:25:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9KZh7CTQ2a/iPJnhlvGn1OfrNQ=; b=tMwI4Z
	s+2y3X5iKV5iFCmZ6Pl8rzC9AluFWnoS6vwW8rsgTdxvvg50b1AmjQUyNevdpspY
	r2t3idERakpR+UQmqjXuELGX1xa7/7dNqw0hLhWZ3GA3Q951atO2f0MvqAr+T7iO
	lSE/h5VpIkrCYwe4rxWC5eXQxTo2OgvsSDVhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yS5Y1jQQCVIH8xuTPBs/aQsQbiLKrcUR
	NATV2sQnhDsbe9sb30SvnyvDNCa2vCbcnmOXyTX7MezLiukGhDG7wSHNuA9pctCe
	NQETDdvPn2bxx/7HR0zjQuISI9+vP5nVsFwM6zeXpQyG3OC5T1Bh+ZhofYK9Xymi
	kLpDQMiBDeo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67C2013F3;
	Mon,  9 Aug 2010 12:25:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B56B213F2; Mon,  9 Aug
 2010 12:25:16 -0400 (EDT)
In-Reply-To: <1281027281-21055-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu\,  5 Aug 2010 18\:54\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B379E40A-A3D2-11DF-A382-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152980>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +   test_file_must_not_exist <file> [<diagnosis>]
> +   test_dir_must_not_exist <dir> [<diagnosis>]

Should either of these pass?

    mkdir foo && test_file_must_not_exist foo
    rm -fr foo && >foo && test_dir_must_not_exist foo

I think in most of the test cases we want to write "must not exist" to
make sure what we are supposed to remove is gone, which would mean that
(1) we know what that thing is, and (2) we not only just do not want a
file "foo" when we say "file-must-not-exist foo", but we don't expect it
to be a directory either.

I'd say we would probably want three primitives instead of four:

    test_path_is_file        <path>
    test_path_is_directory   <path>
    test_path_is_missing     <path>

Thanks.
