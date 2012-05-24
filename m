From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 11:29:52 -0700
Message-ID: <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
References: <20120524061000.GA14035@sigill.intra.peff.net>
 <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcnT-0008PK-35
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934100Ab2EXS35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 14:29:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933804Ab2EXS34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 14:29:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81003716C;
	Thu, 24 May 2012 14:29:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a6Q1e3qQOUkHwOU90w949/2Ho4c=; b=VxpGSb
	TPKdYGnfELcjMumOt2yBJVuI2XH13s7PAiz8FkfvUDMHuFfNZBCizQJGhlh9h+iC
	Qwcqy2f2VsnySI33NuTyLTxD6bVU/da2NQ9xrQRKp9RfoD5hSyjL+tP/HFAvLSp/
	mF2JunvIrnh8RkkHBdEtyybVowD1bgV775By4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fBa96sbRpYpMSqpMleQrAT4DUP+0LLhR
	W2Ef1jN28K1CnHSDQdwU/lUzT6qZVHmX887m2dcI+sEIEVVYWMYThLXJ8ABQs/Dk
	mez4EQxa4Waupw+ChGUDd1fHRXTGDzSAl0VzRGsldd50PqgNuQZimw1C6HBHPQVU
	2aHumYG/OSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F8D716A;
	Thu, 24 May 2012 14:29:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B4B27168; Thu, 24 May 2012
 14:29:54 -0400 (EDT)
In-Reply-To: <1337839944-4651-1-git-send-email-apenwarr@gmail.com> (Avery
 Pennarun's message of "Thu, 24 May 2012 02:12:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7579A6EA-A5CE-11E1-BF7D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198403>

Avery Pennarun <apenwarr@gmail.com> writes:

> It would probably be better to have progress.c check isatty(2) all the time,
> but that wouldn't allow things like 'git push --progress' to force progress
> reporting to on, so I won't try to solve the general case right now.

Before that "It would probably be better" comment to give your opinion,
you need to describe what problem you wanted to solve in the first place.
I'll lift it from your original version of the patch:

    If stderr isn't a tty, we shouldn't be printing incremental progress
    messages.  In particular, this affected 'git checkout -f . >&logfile'
    unless you provided -q.  And git-new-workdir has no way to provide -q.

I do not seem to find a sane justification for

	git $cmd --progress 2>output

use case and I do not immediately see how that "output" file can be
useful.  But we've allowed it for a long time, so probably this version is
safer.  Besides, it is more explicit.

Thanks.
