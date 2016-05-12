From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 22/94] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Thu, 12 May 2016 14:21:35 -0700
Message-ID: <xmqqeg97c6qo.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-23-chriscool@tuxfamily.org>
	<xmqqoa8bdpym.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD1VYW6+T_oTHJbemUhi8MPrMseaObWgoy0Xou=VCoKt-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 23:21:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0y3E-0008B0-NU
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcELVVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:21:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751990AbcELVVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:21:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C0A071B869;
	Thu, 12 May 2016 17:21:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LXSyFyOO/xfmrC7ndRs4uwMTEg0=; b=gr3Xrl
	2nr4xEyxfHYZnFRt1So35Aqydu0BJMaczAOtuVcB5+L5yVw8OZ+TlYUXzPMhsvnv
	l+c5EpwNj3YqZRFaYGawYK3W4vY+BaPtuHIWGQ0O/GSsHaw+/UGcCSTEfVzMre7A
	ougG17XWJZ82wvEyJ3OMH60lp5Cps8rLufJUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OIyLwquve53CeawOLfq+q5WxCUgYZExg
	XDC8I30F9FXlYtHz0mxsL1LMuW3ON65RF/y2yI5IwyoX8AMgTgXs7LTjeNN7kXwH
	JuYofwM8A3wjFHlJgXpXIKTID3fd9jx/m7FVMVU237XJsikfGQ0dV0hKkvRjm3pE
	DJP4Xotzm3M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F3E11B868;
	Thu, 12 May 2016 17:21:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC73B1B867;
	Thu, 12 May 2016 17:21:37 -0400 (EDT)
In-Reply-To: <CAP8UFD1VYW6+T_oTHJbemUhi8MPrMseaObWgoy0Xou=VCoKt-A@mail.gmail.com>
	(Christian Couder's message of "Thu, 12 May 2016 22:26:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 83052714-1887-11E6-A417-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294481>

Christian Couder <christian.couder@gmail.com> writes:

> Ok, I will try to group knobs like that, but the comments tend to
> break the groups.

By keeping the comment on a single field short, and reserve comment
occupying its own line(s) to comment on group, you can do

	/* These control what gets looked at and modified */
        int	apply;	/* this is not a dry-run */
        int	check_index; /* preimage must match the indexed version */
        int	cached; /* apply to the index only */

	/* These control cosmetic aspect of the output */
        int	diffstat; /* show diffstat */
        int	numstat; /* numerical stat */
        int	summary; /* report creation, deletion, etc. */
