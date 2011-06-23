From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] small-alloc: add allocator for small objects
Date: Thu, 23 Jun 2011 10:17:30 -0700
Message-ID: <7vpqm431sl.fsf@alter.siamese.dyndns.org>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
 <1308728011-14136-3-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnXL-00078j-Vi
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667Ab1FWRRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 13:17:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab1FWRRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 13:17:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A45D5F3E;
	Thu, 23 Jun 2011 13:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zF1zi3Jz7fJtRxVCZY1ZScNQhvI=; b=l1OydU
	fdf+NYVARl/U8i6Wxc7300h59I0M2y+WQ9KaENFqBJ4qffuS0Qj08HykXchJycYj
	0ZoeYLx/zSqvEInW4toML2LhhSjk9CosXB5vWgCTJUAHydjdpLWr2ktdMnCUQQ/M
	DVOoZRqEUuwOOzRAAuzjXwxvIqj/3OX+KMCcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMK2Ov22mQX1kIrvKbRc+1axiXWOEBWm
	yO+gp2SakKlZnq+GCG4q6JP96z106J13r/jO9cEm9E7F1rqkCoTwOD9tuud6ihjI
	OQL36nlUeOX0DdpV55FwfdamWbrXTTqCQdJXvMiLMf3arnG5tEQAgysmlFoisjvY
	p89Nyu2zHYU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20A965F3D;
	Thu, 23 Jun 2011 13:19:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C5C45F3B; Thu, 23 Jun 2011
 13:19:43 -0400 (EDT)
In-Reply-To: <1308728011-14136-3-git-send-email-davidbarr@google.com> (David
 Barr's message of "Wed, 22 Jun 2011 00:33:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC5DC80A-9DBC-11E0-A2AC-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176283>

David Barr <davidbarr@google.com> writes:

> This allocator assigns an integer handle to each allocation which can be
> used to retrieve the pointer to the start of the allocation and its
> length.

One more thing to add to yesterday's review. I think you would need to
include a "method" that initializes a mem_pool object, and possibly
another to destroy an existing one, freeing the resources (unless the API
is meant to replace something like obj_hash in object.c).

It was quite difficult to judge how good this API is as it took
imagination on the reviewer's part on how a typical caller would look
like.
