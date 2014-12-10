From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/18] fsck: handle multiple authors in commits specially
Date: Wed, 10 Dec 2014 10:04:22 -0800
Message-ID: <xmqqk31zidp5.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<43faa41d4cc98d6c40a393ec590af73ec5c94246.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:04:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xylck-0006f7-6f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbaLJSE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:04:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932501AbaLJSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:04:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC792227D5;
	Wed, 10 Dec 2014 13:04:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mk0GGwxJ1uNivPkavotb/a8Yqyk=; b=r+x8m4
	c6FY1dDs+J5Dkvy/9G5TvgWJntz4TwiWKCR1HCBvLNjWnusTRZWiUNcGnDO0V0K6
	uFqf/HvAQNVG/vS4FbT8WaK7eK3GLPQbKUPddMaJf0rOVx5UNOSyvoRKenixSkzW
	5bmItG26SUmyWUukAIogeL8LbM6522FIyjVkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFhIAYoh4Z+GNl8cOfebisRTQTOSbngW
	d2VbOOVyl3/da8yecRcW1xyjhTngPFxt6yx7Bauk8NTpRuH3zif0FVKRAL+GMl+p
	xYi8DraHjnm/PIytKEg3hb5z51kadDGmx+yE0hSG1IUj5/kROI0RC0jv3Zz15C1e
	lAS53c+aQyo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A45BA227D4;
	Wed, 10 Dec 2014 13:04:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31147227D3;
	Wed, 10 Dec 2014 13:04:24 -0500 (EST)
In-Reply-To: <43faa41d4cc98d6c40a393ec590af73ec5c94246.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:00 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F930CEDC-8096-11E4-A5DA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261229>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This problem has been detected in the wild, and is the primary reason
> to introduce an option to demote certain fsck errors to warnings. Let's
> offer to ignore this particular problem specifically.
> ...
> +	while (skip_prefix(buffer, "author ", &buffer)) {
> +		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
> +		if (err)
> +			return err;

If we have an option to demote this to a warning, wouldn't we want
to do the same fsck_ident() on that secondary author line?

> +		/* require_end_of_header() ensured that there is a newline */
> +		buffer = strchr(buffer, '\n') + 1;
> +	}
>  	if (!skip_prefix(buffer, "committer ", &buffer))
>  		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
>  	err = fsck_ident(&buffer, &commit->object, options);
