From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Filenames with single colon being treated as remote repository
Date: Mon, 22 Apr 2013 09:00:00 -0700
Message-ID: <7vobd6pncv.fsf@alter.siamese.dyndns.org>
References: <20130421045329.GB30538@WST420>
	<20130421060538.GB10429@elie.Belkin>
	<20130421124511.GA1933@sigill.intra.peff.net>
	<7vd2tnvk2x.fsf@alter.siamese.dyndns.org>
	<20130422153516.GB11886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org,
	fsckdaemon@gmail.com, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 18:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJA4-0005Lz-DC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab3DVQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 12:00:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab3DVQAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:00:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2C118BF2;
	Mon, 22 Apr 2013 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y5qPI5Z95sIRcZdTiLYYY/jj+bA=; b=J5/7M2
	P8qMbJbF8i2Tq3tvmuIzbqSOR2r0eZNWU6TlkJ1gl731Gtu9kDodXptnXP5NDXJQ
	/AmpbbjFKT0YMIShzOQHMNvOwM7cdEynZKGI2tnkbBUX6uZ7g6JZrP4WRnDbMr/8
	6+TMHFHYVQW3NwvFePL6T0qiApQg5ArjSR/bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JJZgCKWyuBUhV27ho+RJ/MqEowpFGbrM
	Brl9dhY8rEYb0pZE6MmIxBlureMzlWtW3GMhaJmuZ0qEAa0QbhWt53YIpM39KDVw
	CRW74SHgBN3ERiQ2VwBjUomueBBqsKVh/NZvy1hhT9YLASy9v3ZHF+E+cp29gLMM
	dG8NqoeKZUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BC218BED;
	Mon, 22 Apr 2013 16:00:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3538818BE6;
	Mon, 22 Apr 2013 16:00:02 +0000 (UTC)
In-Reply-To: <20130422153516.GB11886@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Apr 2013 11:35:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0EF1A78-AB65-11E2-A12B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222034>

Jeff King <peff@peff.net> writes:

> So I think one reasonable path would be:
>
>   1. Do not treat "host:path" as ssh if "host" has a slash, which should
>      not regress anybody. It does not allow unadorned relative paths
>      with colons, but it lets you use absolute paths or "./" to
>      disambiguate.
>
>   2. Teach git-clone to ask the transport code to parse the source repo
>      spec, and decide from that whether it is local or not. That would
>      harmonize the implementations and avoid errors when you _did_ mean
>      to use ssh, but "host:path" happens to exist in your filesystem. I
>      also would not be surprised if there are problems with
>      URL-encoding, but maybe clone handles that properly (I didn't
>      check).
>
> And the "host contains slash" rule is pretty easy to explain in the
> documentation, which is good.

Sounds like a good direction to take us.
