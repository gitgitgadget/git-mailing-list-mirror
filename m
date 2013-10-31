From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Thu, 31 Oct 2013 11:26:11 -0700
Message-ID: <xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwwk-0002wy-FR
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab3JaS0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:26:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430Ab3JaS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:26:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97E154EADE;
	Thu, 31 Oct 2013 14:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVsAJmu/F5D81qKNUZKX/PI/3A4=; b=puGQv2
	g/bA6kORjb67u/mFzAcry3In+jXKwYPBxwWZCxrThPWYXBxsazVZ46aS/APVIj+2
	sCOp+t5pdkspz4clCup3Qde+whrqkVOyZfxr1D7m7pqq5aR5ssOZLgpLnrnVU1rD
	CZeFiFJheIB/b/TrCbmQHn9lXjAy2c0jcijLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zu9wN/QdiXtP0s9ZQl/xMf76YAS0rRY6
	Wj1Qz8bKNTsGjd4WB5FWBJ/4VbHRhELbnTulchzFlyeomuVQbVwtxP/NNL0xCvEr
	2/fdqX+ygUyg8IJwSj1MghpEjthOe53Uhpjn8Fhsyd8NIMi9j3pbNxqFG6nkfuQJ
	KfS64clK+Xk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89ADE4EADD;
	Thu, 31 Oct 2013 14:26:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5D894EAD9;
	Thu, 31 Oct 2013 14:26:12 -0400 (EDT)
In-Reply-To: <1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:36:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBF5602E-4259-11E3-B60A-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237146>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +test_expect_success 'use refspec' '
> +	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
> +		grep "^commit " | sort | uniq > actual &&

It feels somewhat redundant that you have to twice say that you are
pushing your "master", once with --refspec and then the branch
name.  Is this the best we can do?

If the answer is "yes", I guess it is OK to leave the external
interface to fast-export of this patch as-is, but if we can do
better, then we'd be better off without redundancy.

There are quite a few shell script style violations in this test, by
the way.  You do not want the trailing " \" after a pipe (the shell,
when seeing a line that ends with "|", knows you haven't finished
giving it the pipeline).  Also we do not put extra space between a
redirection operator and the target filename.



> +	echo "commit refs/heads/foobar" > expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
