From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Wed, 30 Oct 2013 10:39:22 -0700
Message-ID: <xmqq1u32d5f9.fsf@gitster.dls.corp.google.com>
References: <xmqqiowhdqx8.fsf@gitster.dls.corp.google.com>
	<1382996580-19031-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, j6t@kdbg.org, git@vger.kernel.org,
	avarab@gmail.com
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZjx-0006mc-B8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab3J3Rj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:39:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab3J3RjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:39:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A780C4DF1E;
	Wed, 30 Oct 2013 13:39:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bHFvtr8zIJUYEs4l47FtGVFg0wU=; b=O3u5Qg
	qlnk9omjIclKb4sZFy68g6H+yTTOFg9WClUn8UQvyH/Dl7vdlEszlwOkrffKnJYF
	MmQWLVgMtpfrgTnXOOD1uDclM5fFltoZHN88h+fde9qk4M2aL9THekOwZeTAGyr2
	WWufj4uBAunrJP3upiu9ysHC0Uyrf5zKgOcCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=psH7L8lyGWmUM2Ks1oR7rdr2aCKwqTuz
	rgu08RpvzjzbcGTDO3dDZizs+oG7YOBv/J9H5WF/gc2/fK2+3LmSQUloD8bFXBoc
	T8KPBd/F4IV+jyLpp56QwWQkBS//6fh83eK2orrzeG/7gZBQ051YkPfuXOfS1Ofg
	CcoPEOEBHSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D6C4DF1D;
	Wed, 30 Oct 2013 13:39:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0E204DF1B;
	Wed, 30 Oct 2013 13:39:23 -0400 (EDT)
In-Reply-To: <1382996580-19031-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Mon, 28 Oct 2013 21:43:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 374785E6-418A-11E3-ACC4-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237046>

Ben Walton <bdwalton@gmail.com> writes:

> Solaris' tr (both /usr/bin/ and /usr/xpg4/bin) uses the System V
> semantics for tr whereby string1's length is truncated to the length
> of string2 if string2 is shorter. The BSD semantics, as used by GNU tr
> see string2 padded to the length of string1 using the final character
> in string2. POSIX explicitly doesn't specify the correct behavior
> here, making both equally valid.
>
> This difference means that Solaris' native tr implementations produce
> different results for tr ":\t\n" "\0" than GNU tr. This breaks a few
> tests in t0008-ignores.sh.
>
> Possible fixes for this are to make string2 be "\0\0\0" or "[\0*]".
>
> Instead, use perl to perform these transliterations which means we
> don't need to worry about the difference at all. Since we're replacing
> tr with perl, we also use perl to replace the sed invocations used to
> transform the files.
>
> Replace four identical transforms with a function named
> broken_c_unquote. Replace the other two identical transforms with a
> fuction named broken_c_unquote_verbose.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>
> ...Forgot to quote PERL_PATH in the previous iteration.

Thanks; will requeue.
