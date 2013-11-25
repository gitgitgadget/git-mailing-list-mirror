From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 12:33:29 -0800
Message-ID: <xmqqiovgxluu.fsf@gitster.dls.corp.google.com>
References: <878uwc2r7c.fsf@thomasrast.ch>
	<89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
	<20131125201200.GN4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2qh-0007N0-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab3KYUdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:33:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665Ab3KYUde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:33:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8001C53465;
	Mon, 25 Nov 2013 15:33:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s0M+B85gl12tNaFCsIPsJQAmZAs=; b=GKQWQh
	J1N40+66P8t0IeFodAl0skXP1RlKLBqzvcwPq30k+mp8Mw7t4KGAf5Jo0tpHyJRJ
	xyRt8fYOjqmULx1x+iwDZ8Qi1ZmsUejXUbWN66Sd6AWfdHT2UJ2TNlwaoLhL02GB
	IyPg9WDc31p4yHAFre+a4tE0QBkxUx4U+CVVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FCPwU6Wqcn4518aJDjytGNSgnPAk+GqF
	UxQuOQ9+a6nKgUE/j3J8xUBED5h7nl2i+fjr7mwn3CDsUnzaEtxVE1mB4vpiewmr
	YBxLx5r9fuzIvySis1d9WqiwaqlB0k1tEH9ZfvMh9wKsxBnl4JH2EPfy9ogbYLSm
	Wu5sUi/e1X0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68AA753464;
	Mon, 25 Nov 2013 15:33:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ED2153463;
	Mon, 25 Nov 2013 15:33:32 -0500 (EST)
In-Reply-To: <20131125201200.GN4212@google.com> (Jonathan Nieder's message of
	"Mon, 25 Nov 2013 12:12:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9D459AC-5610-11E3-AB07-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238343>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> This shuts up compiler warnings about unused functions.
>
> If that is the only goal, I think it would be cleaner to use
>
> 	#define MAYBE_UNUSED __attribute__((__unused__))
>
> 	static MAYBE_UNUSED void init_ ...
>
> like was done in the vcs-svn/ directory until cba3546 (drop obj_pool,
> 2010-12-13) et al.
>
> I haven't thought carefully about whether encouraging inlining here
> (or encouraging the reader to think of these functions as inline) is a
> good or bad change.
>
> [...]
>> @@ -98,4 +98,16 @@ struct slabname {							\
>>  									\
>>  static int stat_ ##slabname## realloc
>>  
>> +/*
>> + * Note that this seemingly redundant second declaration is required
>> + * to allow a terminating semicolon, which makes instantiations look
>> + * like function declarations.  I.e., the expansion of
>
> Micronit: this reads more clearly without the "Note that".  That is,
> the comment can get the reader's attention more easily by going right
> into what it is about to say without asking for the reader's
> attention:
>
> 	/*
> 	 * This seemingly redundant second declaration is required to ...

Hmm, both of these are good points.

Thanks.
