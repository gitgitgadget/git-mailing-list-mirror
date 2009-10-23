From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 23:16:24 -0700
Message-ID: <7v4opqeitj.fsf@alter.siamese.dyndns.org>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
 <m3hbtrdu1r.fsf@localhost.localdomain>
 <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
 <4AE143BC.7040507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Howard Miller <howard@e-learndesign.co.uk>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1DSA-0004UQ-BR
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 08:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbZJWGQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 02:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZJWGQb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 02:16:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbZJWGQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 02:16:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B42F7638CD;
	Fri, 23 Oct 2009 02:16:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VuEcrPqhsqPlrenklk2kI0ocxRc=; b=LUe+qs
	2JGPKFr5/ZSpfjWeY6azXeYqm3dNs9RaXr+xoEwVWR5lZcTWSrNcJ8z/8x/EetYk
	zGYITTxnINujlojaBrloEebUTXKJY0JgrNsjrtM0RsMzLKzoWvb4HUlMYAwQ9KG+
	fQ6PhaadfoDIv/Ew4RFFVbzGcWmVg1SD2o17w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tnpr1DmrbxcccNWNEO/jsrgiZdvKPXyP
	6wrm8ew+ycWOFxLOvaOHyPcer7ZsZ6hxzgOYr3yLlNzdyu7fTyzSxQIP2d9MGR2u
	dRgWaAycS7X2DU7qAbJpYLl8s5KuMQBv3Yh+R4IUyei0HKRibd12KKtH0HnGxJCt
	JpYOPU6cdLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7535E638CA;
	Fri, 23 Oct 2009 02:16:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA36E638C9; Fri, 23 Oct
 2009 02:16:25 -0400 (EDT)
In-Reply-To: <4AE143BC.7040507@viscovery.net> (Johannes Sixt's message of
 "Fri\, 23 Oct 2009 07\:48\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9ABBAE9C-BF9B-11DE-B3C5-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131091>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The easiest way (IMHO) to achieve this is certainly:
>
>   # start a new branch at the tip of the series
>   $ git checkout -b all-in-one the-series
>
>   # squash 17 commits
>   $ git reset --soft HEAD~17
>   $ git commit
>
> Now you have a new branch 'all-in-one' that has the same contents as the
> original series 'the-series', but with only one commit:
>
>   $ git diff the-series..all-in-one  # must show no differences

I think --squash "*merge*" is conceptually simpler to explain *and*
has an added advantage that it helps preparing the consolidated log
message.

    # start from the last customer dump
    $ git checkout -b customer-update last-release
    # give the customer the greatness in the series, content-wise
    $ git merge --squash the-series
    $ git commit

This will start the "customer-update" branch starting from the
last dump you gave to the customer, merge in the changes made
in the series without history, and when you make a commit, you
will have access to all the individual log messages in the
series to look at as reference, so that you can cut and paste
from them to summarized message instead of typing everything anew.
