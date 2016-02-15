From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 15 Feb 2016 14:18:18 -0800
Message-ID: <xmqqegcdpqhh.fsf@gitster.mtv.corp.google.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
	<1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 23:18:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRTN-0004yE-CG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbcBOWSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:18:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752463AbcBOWSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:18:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 703F24588A;
	Mon, 15 Feb 2016 17:18:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ttdv9L257AN5q7av+M2zkULXTOE=; b=BBs9fw
	SVtKYrnokao0zZbHLv2dlZmTC7fqbEzBRNTqnRu9efrv2c6YCd0eEJikOiyCtpUk
	eHqW79dyKQ2UJjUPSKAAATrwaK8Ldzrp0lwoBxT11qhI+BEaj6i/rZu12vQUTH9E
	dGEjQhyK9IBM1Z17iYo5WeLuPe85YDwmXeoG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EdVK5Yq1sopipvX6wJY6KfGBkPILpcjt
	ldfaeSiJ2QS2qouC+i9/3LDgvRCQr9IrEWmEh3lAWQ/b7df0+4wr4QzE6ImbZqll
	UPmkIxcw/vp8anDdqkz0MY2S+kYzE3HyeQpJVY1IbZ396X/e69Z2rcAgbM7nUb73
	lagUmvA99sU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66E3245889;
	Mon, 15 Feb 2016 17:18:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D080745888;
	Mon, 15 Feb 2016 17:18:19 -0500 (EST)
In-Reply-To: <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 15 Feb 2016 11:17:46
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 04D7E032-D432-11E5-BA6E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286277>

larsxschneider@gmail.com writes:

> +test_expect_success 'set up custom config file' '
> +	CUSTOM_CONFIG_FILE=$(printf "file\twith\ttabs.conf") &&
> +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> +		[user]
> +			custom = true
> +	EOF
> +'
> +
> +test_expect_success '--show-origin escape special file name characters' '
> +	cat >expect <<-\EOF &&
> +		file:"file\twith\ttabs.conf"	user.custom=true
> +	EOF
> +	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
> +	test_cmp expect output
> +'

Do we really need to use a file with such a name?

An existing test t3300 tells me that a test that uses a path with a
tab needs to be skipped on FAT/NTFS.  If your goal is to make sure
dquote is exercised, can't we just do with a path with a SP in it or
something?

Thanks.
