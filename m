From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Thu, 12 May 2016 13:43:18 -0700
Message-ID: <xmqq37pndn2x.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
X-From: git-owner@vger.kernel.org Thu May 12 22:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xSA-0000iC-V9
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcELUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:43:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751229AbcELUnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:43:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4312F1B2B5;
	Thu, 12 May 2016 16:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+MvqANhE21c0kqYsyhh0uJdBbA=; b=WPkpqe
	p8LcdPjIjfxx0WYHGE2oM3LUouC8sNrYX15NYxcXVKl4a/bx6Y7eel/j2lONDGZZ
	X/pumalyXbGqQGAyhCZXUfcSbLGrS5CGmIvBNNhW2PCGJKN6RFEEIXIqeVMPCvms
	TqcsXGc7use3GRbCGUVgFVlN53b/56i5vn9ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLq4fVntK5c7Hqbdv0l7WsXIi7SCGnYw
	4vyDrVrB+78TG5iwOoWeEEE8KbEr8sLnz+LU1X7Me1tQWu7Spc2rgn3XVhBAiNQy
	Mo9NalwpWbQOGPxJ6VTj41yVQb8muRrHLU/oJPKHGAsLusrJaPMUnejhqMP0e1ly
	gEQZG69/ygI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 393F21B2AE;
	Thu, 12 May 2016 16:43:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 999B01B2AD;
	Thu, 12 May 2016 16:43:20 -0400 (EDT)
In-Reply-To: <xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 May 2016 12:56:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29C718CE-1882-11E6-8AC9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294473>

Junio C Hamano <gitster@pobox.com> writes:

> Up to this point, the conversion looks quite sensible, even though I
> think the organization of fields in apply_state do not look logical.

I'd stop here for now, as everything before this step looks
uncontroversial.  Anybody whose tasked to move the global state for
these variables into a structure would reach the samestate after
applying these 48 patches, modulo minor differences in the way the
comments would say things, how the patches are split and how the
fields in apply_state() are organized.

One thing that is missing is a counterpart of init_apply_state().
In the early part of patches where it added only "const char *"
borrowed from the caller and fields of intregral type, the lack of
clear_apply_state() did not mattter, but with a few fields with
"string_list" type, anybody who want to make repeated call into the
apply machinery would want a way to release the resource the
structure holds.

Because 49/94 is a step to add an unfreeable resource, this is a
good place to stop and then add the clean_apply_state() before that
happens, I would think.  After that, I think both the contributor
and the reviewers would benefit if these early patches are merged
early without waiting for the review of the remainder.

Thanks.
