From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Sun, 29 Jun 2014 23:40:22 -0700
Message-ID: <xmqqmwcuzyqx.fsf@gitster.dls.corp.google.com>
References: <20140525051254.5329.66539.chriscool@tuxfamily.org>
	<20140525053223.5329.28002.chriscool@tuxfamily.org>
	<xmqqegzdd7cm.fsf@gitster.dls.corp.google.com>
	<20140629.113731.1129545703421115235.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1VGV-00059g-JB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbaF3Gkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:40:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59544 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaF3Gkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:40:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C3991D57D;
	Mon, 30 Jun 2014 02:40:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f85xZPtIer1q0l7PbrUlYdUGuk0=; b=GGM6Li
	na8lPEBbjcppbhJlGxpXDJbHleVO9t8n9p9992+1QZ6t8HHHV08azroPLwM2OE/n
	3U8u64V+5JF8rfcv89flB5lTzuU6vHeZXYirrQhHS819pPwtVQ4wdA789WsY7u40
	efYETvQHylmQERXd1DGw0PiqcwnbgJMqpb2bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B8jpYmX3plBFZ/CSfd534DCe+GESmtEE
	wgert1bZFI2lNWqh1TN9UV8HDXW2OH7px2MUOEzjL5kM9fVXy4y18EHE7G50Mwc1
	oeqOcjX8hkCDJzOrfHUYMjLPpyY1I9e9p0twqzT8tpwJ8carN9wf+ByQ6GQeHKGn
	7TiPJBfCFQg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEA7F1D57C;
	Mon, 30 Jun 2014 02:40:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92FB81D572;
	Mon, 30 Jun 2014 02:40:15 -0400 (EDT)
In-Reply-To: <20140629.113731.1129545703421115235.chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 29 Jun 2014 11:37:31 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65068A80-0021-11E4-AC8A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252656>

Christian Couder <chriscool@tuxfamily.org> writes:

>> While I agree with Michael on the other thread that we should limit
>> the syntax and start with ':' only, if you really want to allow
>> random syntax like "Bug #12345" and "Acked-by= Peff", for which you
>> have demonstrations in the tests in the other patch, the above rule
>> should be updated to also allow prefix matches to possible set of
>> keys defined by the user, so that an existing line that is produced
>> by your tool, e.g. "Acked-by= Peff", can be picked up as matching
>> with some token having a key "Acked-by= ".  Otherwise, the input
>> side of your tool is inconsistent with the output side of your own
>> tool, and that will make the flexiblity of the output side useless.
>
> I don't think that the flexibility of the output side would be
> useless.

Flexibility is useful, only if you can control it.

> We already emit stuff like:
>
> (cherry picked from commit f72baf07969242882128aff4c95ec8059e7fd054)
>
> and we don't care about any input side when we do that.

That is something you may want to _fix_, not take as an excuse to
make things worse, no?
