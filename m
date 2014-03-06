From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 06 Mar 2014 11:00:08 -0800
Message-ID: <xmqqbnxjywxz.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<53183506.5080002@alum.mit.edu>
	<20140306155626.GB18519@sigill.intra.peff.net>
	<5318A537.4010400@alum.mit.edu>
	<20140306174803.GA30486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdWt-00042y-BX
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbaCFTAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:00:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbaCFTAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:00:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D97F71065;
	Thu,  6 Mar 2014 14:00:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z853SQ/8jckfm6MmSi+fKRMdeBU=; b=io7+LS
	01Hr1x9yRlS6A5FZifPfEaQj/mqCCr/w3TN/JOttFUgG03SSD1rj2SYWRp6mcghw
	jge42URoBL1HEcpsoIlMC8kfhuSYOygVtpyR5/nzHagte3VDGVXpnfShund1uPb0
	u2xODtw3fg5KXHuTIReMac9yy68J/+tToxLQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dT/tvrd9Y/NXGUsPw2n3R/aeUkeyPLN0
	VVuzO4HRXeWk4AyCqNS9uTFgzo5UTHX5vD2sjtdqjLXaheDng7lOr5H3401jFsio
	UDbdIkk/H9ykESeQBvHYXUcUUvBGUdLvpsTKicYRIgcyejOIjTVug3hw53uiy1TC
	jUMqyTXYk9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01C1F71061;
	Thu,  6 Mar 2014 14:00:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B5A47105C;
	Thu,  6 Mar 2014 14:00:11 -0500 (EST)
In-Reply-To: <20140306174803.GA30486@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 6 Mar 2014 12:48:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8AE455FE-A561-11E3-BE0F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243532>

Jeff King <peff@peff.net> writes:

> I also noticed that the diff engine does not play well with replacements
> of blobs. When we are diffing the trees, we see that the sha1 for path
> "foo" is the same on either side, and do not look further, even though
> feeding those sha1s to builtin_diff would fetch the replacements.

Sorry, I do not quite understand.

In "git diff A B -- path", if the object name recorded for A:path
and B:path are the same, but the replacement mechanism maps the
object name for that blob object to some other blob object, wouldn't
the result be empty because both sides replace to the same thing
anyway?
