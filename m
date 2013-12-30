From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 13:05:25 -0800
Message-ID: <xmqqfvpaqcbu.fsf@gitster.dls.corp.google.com>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
	<20131224063726.19560.61859.chriscool@tuxfamily.org>
	<xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
	<20131230202042.GJ27213@leaf>
	<xmqqk3emqd7a.fsf@gitster.dls.corp.google.com>
	<20131230205234.GU27213@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 22:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxk1m-00067s-29
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 22:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab3L3VFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 16:05:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169Ab3L3VF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 16:05:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16305FC07;
	Mon, 30 Dec 2013 16:05:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T32SyBMW8Fq5MlF3XzlegWYKY7o=; b=N+lnlc
	v3LnyQro5CdfJL9+NQM+7l8Eo5NlV7oUEBe1r9bJadEe57AY7ROLdnMD7Vog4i9w
	ZIpX0N6Pw7ZZBCtVHDuaBzzXP+9b7ghE9rANP5VqRP9eHQwTBTyWXFU+Sv//o+Rw
	Ou8rQJyzFKTb0dyErVRuEBvP2Te3Uhi6wP004=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=syuEWJONp8XGxPQsw1DtsKpDiZCBDs4i
	T6Cj7YfHn4B2h7pABmbk5JJiZdCTy2mZwhArOETxms4XlN/5h6qOgmgOCAfJbE4E
	qpx68bY2wlqN9lQj+L1l8sAPVE5F5N2ZjvzcHoi8rk3iPOL3DsdIhcW4XYaF99un
	T/dY0J3AGn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A14F55FC06;
	Mon, 30 Dec 2013 16:05:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8D7C5FC05;
	Mon, 30 Dec 2013 16:05:26 -0500 (EST)
In-Reply-To: <20131230205234.GU27213@leaf> (Josh Triplett's message of "Mon,
	30 Dec 2013 12:52:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B631F98-7196-11E3-A290-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239826>

Josh Triplett <josh@joshtriplett.org> writes:

>>  - The "everybody will have a single SP at the end" may or may not
>>    last forever;
>
> Trivially fixed if that ever changes, but given the nature of all of
> these, that seems unlikely.

Why?  Because we encourage to write tests that are expected to find
breakages, some of these test vector lines may have to show a broken
line that lacks SP after label + colon.

>>  - With your scheme, if you already had _one_ trailing SPs in the
>>    input, it would be hard to spot in the source;
>
> Git makes them quite difficult to miss. :)

That is irrelevant, isn't it?

This is about protecting the source in the editor, before you run
"git show --whitespace=trailing-space", "git diff --check", etc.
