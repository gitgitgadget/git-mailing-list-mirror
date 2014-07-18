From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 4/4] test-config: add tests for the config_set API
Date: Fri, 18 Jul 2014 10:01:57 -0700
Message-ID: <xmqqzjg6mwhm.fsf@gitster.dls.corp.google.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
	<1405675142-20300-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8BY6-0005O4-6G
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbaGRRCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 13:02:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51294 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965879AbaGRRCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 13:02:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 409FE27FE6;
	Fri, 18 Jul 2014 13:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQQP9wqNtGZCJ4SzMSTCqT3b0UE=; b=r51Zvw
	9OQPDW5dVB5Dvlvky/oThZ9uJ7ELUMpjCgqMApShv5sYVCh2BMwHRgQQEBJ18HFt
	u2TVBzwqESsIw2FTbNu8Zn7hkRNgTtdGAhVGogKUeGCrLPoIBZ+DO7naw/6zxdWZ
	/0l/frtcAe6gZTa4PZMZ/aGKUL3IH734jaOPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=asUi9FMLuSS14JHZvLCiPftiktqIN4zM
	NTGViS3vewdrHnRNKooiTRbKYTq/T3yw3PvoANVLPQ/ds2Fmn8InMQEJOAJ6dAXc
	tRs7AOvkURDmXeqmHGvUxYY/Xg6p17q1qiV7+Gj7+9uBnoMxcWVcUgcHRqq0YS/H
	hrwL9u7APMs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33E9027FE4;
	Fri, 18 Jul 2014 13:02:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5EBD627FCB;
	Fri, 18 Jul 2014 13:01:59 -0400 (EDT)
In-Reply-To: <1405675142-20300-5-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 18 Jul 2014 02:19:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3B365264-0E9D-11E4-BB53-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253827>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'proper error on non-existant files' '
> +	echo "Error (-1) reading configuration file non-existant-file." >expect &&

s/tant/tent/ perhaps?
cf. http://en.wiktionary.org/wiki/non-existant

> +test_expect_success 'proper error on non-accessible files' '
> +	chmod -r .git/config &&
> +	test_when_finished "chmod +r .git/config" &&
> +	echo "Error (-1) reading configuration file .git/config." >expect &&
> +	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
> +	test_cmp expect actual
> +'

Doesn't this one need some prerequisite?
