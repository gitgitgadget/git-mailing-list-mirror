From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] toposort: rename "lifo" field
Date: Thu, 06 Jun 2013 22:21:20 -0700
Message-ID: <7vy5amv6lr.fsf@alter.siamese.dyndns.org>
References: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
	<1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370581872-31580-2-git-send-email-gitster@pobox.com>
	<CAPig+cQnQv-Df52dptTDYfNFSzEUv_Db4rrddB2jQv9NhfLhbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Elliott Cable <me@ell.io>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 07:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukp7A-0007hE-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857Ab3FGFVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:21:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab3FGFVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:21:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5E9E21319;
	Fri,  7 Jun 2013 05:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vTnkVU19VuyoB8Br7azUlm46CZI=; b=TdmaLj
	leu8hl0CVPC4OXTwKxZtHwltCu4lssfPn1v0vTMorpN6sWvjMgxH0BNQasWtybCv
	Wx6GcYkWD731PO0BW8TOl0IBXYaJqeAIRYBman/K31iFPXiJ4XxKV6Yuqe2VFU3b
	VL4OQgjR44i1wuDeHJeRdDSm1QLX3C0zWTfTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjEkS3sfFRbeK5o8yE9ooD/A7VfI8V/w
	vroQxLFUkEPy7AdNA+RKRxWiQdRPpxVAw9Mq9TZ0vkNP8+I2v+mO53jACghy9Qbv
	E+ef2mF+fhrIg/NKjUyfZB2IO8TCqR0S6WZDX6AnOfHanjujoq0DqXXKclUY6s3Q
	ENGmEBZj1DY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC7DA21318;
	Fri,  7 Jun 2013 05:21:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D0D921315;
	Fri,  7 Jun 2013 05:21:22 +0000 (UTC)
In-Reply-To: <CAPig+cQnQv-Df52dptTDYfNFSzEUv_Db4rrddB2jQv9NhfLhbw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 7 Jun 2013 01:18:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17728CFE-CF32-11E2-8143-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226597>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 7, 2013 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The primary invariant of sort_in_topological_order() is to emit all
>> children before their parent is emitted.  When traversing a forked
>
> s/parent is/parents are/

Hmm, not quite.  The above refers to:

      B
     /
    A---C
     \
      D

where A is the parent, B, C and D are all its children.  We want to
emit all children (B, C and D) before their parent A _is_ emitted.
