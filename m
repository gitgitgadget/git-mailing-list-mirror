From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request - telling git bisect to skip, from inside a
 commit
Date: Mon, 28 Mar 2011 09:51:40 -0700
Message-ID: <7vipv31943.fsf@alter.siamese.dyndns.org>
References: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
 <20110328163153.GA18774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Cromie <jim.cromie@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:52:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Ffn-0007p8-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab1C1Qv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:51:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab1C1Qvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:51:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CB41428A;
	Mon, 28 Mar 2011 12:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=snHxzoRYt8GJKajMy9z52WZicCQ=; b=UF1Ken
	LWPJrPIVuDuiCCpV47CQ5Fr7Yz1zmZrUNhd/3ds0LVxhjwr7cojtA17lOAHzV3VO
	0yn0C6jF7zyTMdnJ9eFoHEEqWdamcWh3wXR/y8XwFZfRtFqov0U/G6KBbEY2Ddly
	oipQH/TVHErSKZAVE415S1BLiFEsV8IdXpQOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCVUah4/JVuBKUKCumaSN3gTnPaHw242
	TaBt1Mz9p43LvcSGu0dyLF1qjqJeHYbW3q5JIgbskkeCeqgEoe4mPd+vqHVt4a8c
	bRd2QILKbg72sS9UPiXzh3V8SDnf4wMsPDDA2USuP7ogFEMK/XI8Id9ZEw6caWNc
	zpQFz/WxmPw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 653F4427D;
	Mon, 28 Mar 2011 12:53:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A78F4271; Mon, 28 Mar 2011
 12:53:29 -0400 (EDT)
In-Reply-To: <20110328163153.GA18774@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 28 Mar 2011 12:31:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA90B4FC-595B-11E0-91CB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170156>

Jeff King <peff@peff.net> writes:

> That could work, though I would spell it as a pseudo-header:
>
>   Bisect: Skip
>
> at the end of each commit.

I think that is a saner approach, and further say it would be much saner
to make that token something like

    Broken: does not build

A commit may or may not build, a build product may work in some areas just
fine and may have known bugs in some other areas, depending on what kind
of breakage you are interested in.  You might even be looking for a change
that fixed a bug for cherry picking.  In short, "Bisect: Skip" is too
broad a brush, and does not convey enough information.

And then teach the script you give to "bisect run" to grep for that
"^Broken: " pattern to answer with exit 125 (cannot test), and you are
done.
