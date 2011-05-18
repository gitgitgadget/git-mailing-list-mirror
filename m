From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 21:22:18 -0700
Message-ID: <7vmxikeiyt.fsf@alter.siamese.dyndns.org>
References: <1305681991-11699-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 06:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMYHH-000080-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 06:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab1EREW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 00:22:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1EREWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 00:22:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26CC95EA4;
	Wed, 18 May 2011 00:24:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r9G7LFuCJ/O5HlpTb+sb368nObs=; b=Z4svW6
	hlM3ivrDo3VMWLso+yYDDt+Bp+gppbtyOLV8XsVdzag7xx/lealbw7DPiu2pTZzW
	kYxNUUNUARdL3aAEpuSZpZPZAbPQL09AW4MMfD1oPxbU0J3dXemAZsjoTQXbRLEZ
	hC6LgwNcwWKnJhjIvWsEgSrKkDvO14jZxbvqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kHE8VqcYeIriGyxVOZ5UbrgYf/Y4HCWE
	ciCK9vz2NzpdmCHO0HTXb1kvSrOe3UmVrnNcsPeRT438hzCBW2NZRmfyUgWI/Mup
	w0YKp6g1gVdbjHOyDg2//Zxo4aR/3GdtBSzh9DpRcSHizoLTarny/A996cSb9fuq
	TExN+58c0lc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 044285EA3;
	Wed, 18 May 2011 00:24:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 159C65EA0; Wed, 18 May 2011
 00:24:25 -0400 (EDT)
In-Reply-To: <1305681991-11699-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 17 May 2011 21:26:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8AE07A0-8106-11E0-9E79-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173841>

Jay Soffian <jaysoffian@gmail.com> writes:

> +test_expect_success 'log.abbrev-commit configuration' '
> +	test_when_finished "git config --unset log.abbrevCommit" &&
> +
> +	git log >expect.full &&
> +	git log --abbrev-commit >expect.abbrev &&
> +	git log --pretty=raw >expect.raw &&
> +	git log -g --abbrev-commit --pretty=oneline >expect.reflog &&
> +	git whatchanged --abbrev-commit >expect.whatchanged &&
> +
> +	git config log.abbrevCommit true &&
> +
> +	git log --no-abbrev-commit >actual.full &&
> +	test_cmp expect.full actual.full &&
> +
> +	git log >actual.abbrev &&
> +	test_cmp expect.abbrev actual.abbrev &&
> +
> +	git log --pretty=raw >actual.raw &&
> +	test_cmp expect.raw actual.raw &&
> +
> +	git reflog >actual.reflog &&
> +	test_cmp expect.reflog actual.reflog
> +
> +	git whatchanged >actual.whatchanged &&
> +	test_cmp expect.whatchanged actual.whatchanged
> +'

I can see you are testing all the commands in the "log" family for cases
where the new configuration _should_ take effect, but I cannot see the
same throughness for the negative case where the configuration should not
kick in. Is "log" the only one that you make sure --no-abbrev-commit
defeats the configuration? Please always test both sides of the coin.

Other than that, the patch looked fine from my cursory look.

Thanks.
