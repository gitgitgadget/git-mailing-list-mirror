From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] Move PGP verification out of verify-tag
Date: Mon, 18 Apr 2016 13:15:24 -0700
Message-ID: <xmqqshyi4qsj.fsf@gitster.mtv.corp.google.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Mon Apr 18 22:15:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asFa7-0006yq-2S
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 22:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbcDRUPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 16:15:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751787AbcDRUP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 16:15:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCAB914BAB;
	Mon, 18 Apr 2016 16:15:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6hEHUqaXdV+YY2CYBYq0U0CiApo=; b=XAVjTG
	1kDxpnjW010p0EdejNe4FWK1SXhI3mIY+r7gfyuIyaYZGS7+hEE5no2LLL+gnjri
	E9SfcMui9gouFPuV3DXb+wZYmduEr8WEAhNSBGukNgR1SNAounn6NHswPleV2c22
	345wsMzMJ2LRy4UVHTTH6VSqQzCuBSST2JYts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tdjD8d2tf+kuLk+RlCf1mQjDXyn0R+PT
	wgxZg6fFyd1OqwoivG79VJSl6zVrDtz9W1TnOKugv+3pKWY7XHWrAYRi6+0kFzAg
	+xqlhiMMGpOYVGrzlxh8zggwvV7WHjrv48j2JBsKqISPTZAuqyGT0TKRloKfaEeu
	10rP1fW0XHo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C41D214BAA;
	Mon, 18 Apr 2016 16:15:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39F0114BA9;
	Mon, 18 Apr 2016 16:15:26 -0400 (EDT)
In-Reply-To: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Sun, 17 Apr 2016 18:26:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49CEBA66-05A2-11E6-94A2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291823>

santiago@nyu.edu writes:

>    I'm unsure about the 80-column
>    on 4/6, the ternary operator is rather long.

You can do something like this:

        type = sha1_object_info(sha1, NULL);
        if (type != OBJ_TAG)
                return error("%s: cannot verify a non-tag object of type %s.",
                             report_name ?
                             report_name :
                             find_unique_abbrev(sha1, DEFAULT_ABBREV),
                             typename(type));

        buf = read_sha1_file(sha1, &type, &size);
        if (!buf)
                return error("%s: unable to read file.",
                             report_name ?
                             report_name :
                             find_unique_abbrev(sha1, DEFAULT_ABBREV));

Thanks.
