From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] t5520: test work tree fast-forward when fetch updates head
Date: Thu, 07 May 2015 10:12:59 -0700
Message-ID: <xmqqoalwqpk4.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPMF-0000QF-9G
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbEGRNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:13:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751593AbbEGRNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:13:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F05034E9B4;
	Thu,  7 May 2015 13:13:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m3smOni1+MmJaOtrVejQmS/j+cg=; b=N7dOyf
	kIo4sqxl/lYt+pl3l9JqGcg4/TiUU0mf0ECk7VaT89y3DoiLK8VN7pRMuwf1sakq
	7H9Z4bGbfT7gT9pKPff3z6AZzTlQAL4o6MOnPs48uGfCam6E+wluP9HnSEPzW7+o
	R+FospXyhtgDbxzjNNDBmKglhGfqaoyX18CM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6q4PJ9BJ5rIsjrka5KK8GkuSaZuRrqh
	gW6X4PgniAnLG+beDbJbYaGrHJeDWuYoFGST0dDL3fapiF1485Fm0GDMhS4cgndO
	fgPv6XzQP8ALOu/VmbDE5h2ezPxbX1ZbLrXqrnH703+CisnOYLSE+3iL5vPyFsUZ
	SqzIAEtPDF4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E87174E9B2;
	Thu,  7 May 2015 13:13:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 441034E9B0;
	Thu,  7 May 2015 13:13:01 -0400 (EDT)
In-Reply-To: <1430988248-18285-4-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 7 May 2015 16:43:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50C66062-F4DC-11E4-B663-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268554>

Paul Tan <pyokagan@gmail.com> writes:

> +test_expect_success 'fast-forward fails with conflicting work tree' '
> +	git checkout -b third master^ &&
> +	test_when_finished "git checkout -f copy && git branch -D third" &&
> +	echo file >expected &&
> +	test_cmp expected file &&
> +	echo conflict >file &&
> +	test_must_fail git pull . second:third 2>out &&
> +	test_i18ngrep "Cannot fast-forward your working tree" out &&
> +	test `cat file` = conflict

At this point, HEAD would match either master^ (as initially checked
out) or second (as fetch fast-forwarded), but I cannot read what this
test is expecting to happen.  

Should the HEAD move or stay?

> +'
> +
>  test_expect_success '--rebase' '
>  	git branch to-rebase &&
>  	echo modified again > file &&
