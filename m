From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/18] Introduce fsck options
Date: Wed, 10 Dec 2014 07:33:43 -0800
Message-ID: <xmqqk31zjz8o.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<56e9445d6e8a746356146bc565512f53bf8a0c8d.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 16:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyjGx-0004Vk-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 16:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbaLJPds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 10:33:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757962AbaLJPdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 10:33:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63FF323409;
	Wed, 10 Dec 2014 10:33:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ClY23cHLNLsHiQE/uJi8s6fwhNg=; b=j35jDS
	xgzXebWdl53fL1K6blw6fP6jana4wCrAl47ou5BnASeWecgHSwFdEf2LiXir487S
	Ksf/CmL3VV81sHQQlRMyUq/ADSqcGevbdMmssyCwLco0FIY2OYNSQLPl88dEk2kW
	NdkZKEb2pok7Gn66jdLnuL39dywzSuVq8WV6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HximrsZ0aVE5OkA7r90C8P9wMP7xjomZ
	CCowmRikwY+VO+5Th7nxWAlyzmr3MvL7RHqrCufJlGtgpFmSfFFDP6NBFcZGejOO
	uDugF8FlF3G16cL8ODinh9ZwhwMRo+vDV4TaT2Nr6zhecQcdMGkc70Xv96MLW0YL
	S9JgvT10x+E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BBD723408;
	Wed, 10 Dec 2014 10:33:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBD1A23407;
	Wed, 10 Dec 2014 10:33:44 -0500 (EST)
In-Reply-To: <56e9445d6e8a746356146bc565512f53bf8a0c8d.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:14:04 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED4461D4-8081-11E4-AE01-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261216>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

THis is not limited to this step, but

> Subject: Re: [PATCH 01/18] Introduce fsck options

please make it easier to cluster and spot the series in the eventual
shortlog by giving a common prefix to the patches, e.g.

	fsck: introduce fsck_options struct

> +static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
> +static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;

Is it a good idea to allow walker to be strict but obj verifier to
be not (or vice versa)?  I am wondering why this is not a single
struct with two callback function pointers.

> +struct fsck_options {
> +	fsck_walk_func walk;
> +	fsck_error error_func;
> +	int strict:1;

A signed 1-bit-wide bitfield can hold its sign-bit and nothing else,
no?

    unsigned strict:1;
