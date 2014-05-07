From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive.c: Fix case-changing merge.
Date: Wed, 07 May 2014 11:01:04 -0700
Message-ID: <xmqqd2fpbh9b.fsf@gitster.dls.corp.google.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
	<1399417144-24864-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 07 20:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi69c-0000d1-4t
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbaEGSBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:01:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55424 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbaEGSBK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:01:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF11A14E91;
	Wed,  7 May 2014 14:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gdad7zedwR3ANueC0e3hZg9FCDw=; b=Gzn1oc
	W//lXDve2nA7YkRG7DZIncsjIJIH6THT8r2u9O0CXSwrdPg/CyVkz+d1ZCAFMSJT
	PhAWqjDnJ7MnhEgNnMQxcaizu/CjzhOdDiM8F3T/OfG57wPY0JmKOXTSoU4ufSUy
	M+gBi8by139g2Ps8W7jqBeO0k7v71il7t2Rjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYksRn+wkO4C+fIclJsi4QCcltb1119b
	iSxGDXbDq9G5b6nEHhm/BvEWJcXgytj+vGxEdSwURVL26RwXZpdF+2MMr1ba+LXz
	VpofIlxsWGitSeAccgegQO2ktQ2RjCXhScE3PnB5KPYhADuBCXjgnFzU3QGxgJZd
	WJBIfU2I4nE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD96514E90;
	Wed,  7 May 2014 14:01:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F92C14E87;
	Wed,  7 May 2014 14:01:06 -0400 (EDT)
In-Reply-To: <1399417144-24864-1-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Tue, 6 May 2014 15:59:03
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F9272A8-D611-11E3-9A47-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248338>

dturner@twopensource.com writes:

> +if ! test_have_prereq CASE_INSENSITIVE_FS
> +then
> +	skip_all='skipping case insensitive tests - case sensitive file system'
> +	test_done
> +fi
> +
> +test_expect_success 'merge with case-changing rename' '
> +	test $(git config core.ignorecase) = true &&

This check seems a bit strange.  You already know you are on a case
insensitive filesystem, so I would understand that if you assume it
is set, or if you make sure it is set (if you are really paranoid).

But I'll let it pass, as it is not wrong per-se.  Just looked strange.

> +	> TestCase &&

Please have no SP between redirection operator and its target.

> +	test -e testcase

Please make it a habit to use "test -f" when you expect "the path
exists as a file", not merely "something exists there I do not care
if it is a file or a directory", for which "test -e" is perfectly
appropriate.

I'll fix up locally before queuing; no need to resend.

Thanks.
