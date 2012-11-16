From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] sequencer.c: refrain from adding duplicate s-o-b
 lines
Date: Thu, 15 Nov 2012 18:03:52 -0800
Message-ID: <7v4nkq8fsn.fsf@alter.siamese.dyndns.org>
References: <1352943474-15573-5-git-send-email-drafnel@gmail.com>
 <1353021875-7552-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 03:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZBHt-0000ns-9L
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 03:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab2KPCDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 21:03:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2KPCDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 21:03:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C90039FC7;
	Thu, 15 Nov 2012 21:03:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVidW0+i+w0Uv5r45YpyUw1jjJA=; b=kVSIJ3
	+W8S7pZJUkqeZW95tfgtjR9Bfd07EF6rfhXe5xh2uoVSb9/SkmVA2OJyfAIhJQ1Q
	04Kgy3ncYA9KtqXimOVsyqs2LEokcrEh+WyrDTxScw8cv1OPAC4irIWiXuYyiY3i
	OYe9yoxxFWINs+A0VtpAEdMxasFv6MPs5GpeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BnGHQVm90RjeFTTyM79DhY/YxGq2WMXw
	bvcAjbzssgw/GAQZz+gRuku6C7ojkt0vytipospICLopnToi8lAzd5HtP6N5L6Gq
	MbPKxvZ1z9CuCeymbwnioqZVHC/Jb7xvvYmFtL0GCNIGEU4j+WXVtBcF3IUqfHJV
	g8igYDCB+P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67749FC5;
	Thu, 15 Nov 2012 21:03:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 281009FBE; Thu, 15 Nov 2012
 21:03:54 -0500 (EST)
In-Reply-To: <1353021875-7552-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Thu, 15 Nov 2012 15:24:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF8AFC30-2F91-11E2-B020-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209858>

Brandon Casey <drafnel@gmail.com> writes:

> Detect whether the s-o-b already exists in the commit footer and refrain
> from adding a duplicate.

If you are trying to forbid

	git cherry-pick -s $other

from adding s-o-b: A when $other ends with these two existing s-o-b:

	s-o-b: A
	s-o-b: B

then I think that is a wrong thing to do.  

In such a case, the resulting commit should gain another s-o-b from
A to record the provenance as a chain of events.  A originally wrote
the patch, B forwarded it (possibly with his own tweaks), and then A
picked it up and recorded the result to the history, possibly with a
final tweak or two.
