From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 56/94] apply: move 'struct apply_state' to apply.h
Date: Mon, 16 May 2016 09:03:22 -0700
Message-ID: <xmqqwpmu2do5.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-57-chriscool@tuxfamily.org>
	<CAPig+cS98guXbeRH6oW8n2tPAa3u=2MvSx1H5rixGKdGTrVJPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:03:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2KzT-0006pc-PU
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbcEPQD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:03:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752202AbcEPQD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:03:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D1341B817;
	Mon, 16 May 2016 12:03:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SrU3S2mKxcPBwYyX1+7WgRRD+Mc=; b=gBHox+
	szHCaySSSN/7y0iER0vgWse2mcGfWfiLGM/pxSbjM//WhOYBIfivrMO9XH4UEEJE
	jhB0qiyNTEaoE7vJLKL5bVbZYY1/tLaI8gxRrp1UlvM7Q3B814c+qKlv4+OwY05D
	xiQ4/JkhspItKQg2dB4X3pQ+aGHnm9BRqyALw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mVlLihTNUuo/fpz0JP82lAKr3DhImwuH
	80JdtXVcOzEbTu4wB47VqMouN8ZWNiBeGdhV/tsg6jyL67cehhPyF40E9XtUl4OR
	E6yyba0YVAU049u41ruzwc8TgoQihJAwwdkCLk9YAk5EK1kCARp3thtxo/iV6faY
	VoK6uGbfqGE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7380F1B816;
	Mon, 16 May 2016 12:03:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C82671B815;
	Mon, 16 May 2016 12:03:24 -0400 (EDT)
In-Reply-To: <CAPig+cS98guXbeRH6oW8n2tPAa3u=2MvSx1H5rixGKdGTrVJPg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 15 May 2016 23:10:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B859A584-1B7F-11E6-807A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294748>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To libify `git apply` functionality we must make 'struct apply_state'
>> usable outside "builtin/apply.c".
>
> Why is this patch plopped right in the middle of a bunch of other
> patches which are making functions return -1 rather than die()ing?
> Seems out of place.

Two possible places that would make more sense are (1) when it is
introduced very early in the series, or (2) when it absorbed all the
file-scope-static global states in the middle of the series.  I think
either is fine.

That would be a good place to end the first batch of the topic.
Then the second batch would be "turn die() into error status that is
propagated upwards".
