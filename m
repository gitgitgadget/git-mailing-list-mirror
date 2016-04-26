From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Tue, 26 Apr 2016 09:22:44 -0700
Message-ID: <xmqqeg9sibl7.fsf@gitster.mtv.corp.google.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
	<xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604260851390.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5lF-0002Lf-BP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbcDZQWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:22:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752257AbcDZQWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:22:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 280161499C;
	Tue, 26 Apr 2016 12:22:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OPjaxASyUVinHoh4AkKzsGG26C0=; b=ZfbCAZ
	rOtKhUl4g4Q9efwHomHi98WmyCvCRQAzC6Sca5pXcM/W1cNZa8M8/cWDhuWs+z1A
	XlBEk6J1bV1Ee4chbF3f1+E6IAn7y57sceyDZ7Fvwh2msKeCAt2hg7ytOFK46+NO
	loZoy3TblFoneXVnu3SFbz8VpIFbs05yD+cXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6hbKFyUYsjq4S5yWwpG9xb/JHy7VJB2
	Owq8UEsV2boIdikzyuJnyUzPEJzSYIavMspwkI0mVxyPtM9ekMmtFV9uJjL8j0ba
	G7OWGE0I4e255B6ieUtaCdyXvomB5q83XHIc/Lz4TrtowZkfBFvKBKbVijfODv3Q
	p7X8y6Ym2Fg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2052B1499A;
	Tue, 26 Apr 2016 12:22:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AC3814997;
	Tue, 26 Apr 2016 12:22:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604260851390.2896@virtualbox> (Johannes
	Schindelin's message of "Tue, 26 Apr 2016 17:33:33 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C807340-0BCB-11E6-8A63-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292610>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Testing the headers? I dunno, do we have tests for that already? I thought
> we did not: it requires an HTTP server (so that the headers are actually
> sent) that we can force to check the header...
>
> So I see we have some tests that use Apache, and one that uses our own
> http-backend. But is there already anything that logs HTTP requests? I did
> not think so, please correct me if I am wrong.

I suspect that no codepath in the current system has cared about
what http headers are sent; auth stuff might have but even then I
would imagine that a test for auth would observe the end result
(i.e. it would ask "did the server accept or reject us?") not the
mechanism (i.e. it would not ask "did we correctly send an
Authorization header?").

So I wouldn't be surprised if this topic is the first one that cares
exactly what headers are sent out (eh, rather, "we told Git to send
this and that header, do they appear at the server end?"), in which
case it is very likely that we do not have any existing test that
can be imitated for that purpose X-<.

In other words, the answer to "Do we already have a test so that I
can mimick it instead of thinking of a way to test this?" would
probably be "No".

Do we care about this feature deeply enough to devise a mechanism
to prevent it from getting broken by careless others in the future?
