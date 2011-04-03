From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sparse: Fix errors and silence warnings
Date: Sun, 03 Apr 2011 01:17:46 -0700
Message-ID: <7vaag7g34l.fsf@alter.siamese.dyndns.org>
References: <1301814414-11368-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 10:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6IVl-0004wv-IS
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 10:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab1DCIR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 04:17:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1DCIRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 04:17:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 421CD2DE2;
	Sun,  3 Apr 2011 04:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vDkpvOxWyA451820xlWHDr/YLuo=; b=MKw5JY
	Pl8o/ZpIAygbdxCnc9rUSxFvQh70qXjIfFQGZifa7SpfJIRSkckOWoXFxF8RltsX
	GcI85sl3rhslhC1pvMDkBU6T1Yx5b4/7HUPai36fznISfQ+UanvaeIysS/TZgIgy
	qux8+ZiBtQTCJxd3JCJKB0gjrRbWLJ/whTgcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UvXbUqc3chRLR7IdpF7SDTQp0jU/ypcI
	+XuMJaxPmoCiJYYD0z5FXXTr/r66bmu/CxugEgMSvpoWb3OLkuRlRXs0mmVm1n7X
	V2lBMC3/cYQXFNSUIgmMJiZc9Cn3pJZQ8or0jHmuXgBNRktnxzuLnfJEvMrmP3/F
	UZBiuEbAIX4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FA652DE1;
	Sun,  3 Apr 2011 04:19:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42FD02DE0; Sun,  3 Apr 2011
 04:19:39 -0400 (EDT)
In-Reply-To: <1301814414-11368-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Sun, 3 Apr 2011 00:06:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 202A3098-5DCB-11E0-93F0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170684>

Stephen Boyd <bebarino@gmail.com> writes:

>  * load_file() returns a void pointer but is using 0 for the return
>    value
>
>  * builtin/receive-pack.c forgot to include builtin.h
>
>  * packet_trace_prefix can be marked static
>
>  * ll_merge takes a pointer for its last argument, not an int
>
>  * crc32 expects a pointer as the second argument but Z_NULL is defined
>    to be 0 (see 38f4d13 sparse fix: Using plain integer as NULL pointer,
>    2006-11-18 for more info)

I think these were originally coded this way to match the way the upstream
zlib.h from which we use the function expects us to.  But I tend to agree
that we should ignore Z_NULL and use NULL throughout the system.

The patch looked fine.  Thanks.
