From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bundle vs git rev-list
Date: Fri, 05 Dec 2014 15:40:06 -0800
Message-ID: <xmqq4mt9oecp.fsf@gitster.dls.corp.google.com>
References: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
	<20141205231350.GB223328@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jesse Hopkins <jesse.hops@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:40:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx2Tx-0002pP-W9
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbaLEXkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:40:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753870AbaLEXkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:40:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35DEA2364C;
	Fri,  5 Dec 2014 18:40:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xcd2OfGzlKzgMRYgm5GS9YoBVGg=; b=GH+H92
	YvjutYiGDfqNo7chgooJelMqH8zI1k2wp9Lh6jUQcagshgW9wTOJ5nLH6+t6Gcfu
	QrbXh8iWOpottbSrlR/X7e2DVCAXWstMTcVAarubULkFk02yw+kCbCxXqDncLKS9
	XJe7RQ2xz9dommArkpi5VYVQHzFUnVoZvdtKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ga/9cB/qNTLxOC29aqxgZO+hWB0CEwml
	tR+7dAh/xuPyLh9AZbnlxTEvHr4DpYNOCY0HvdpmaylAaT9sBfGePXU2etWzyi6A
	oaPmxE/8tRguviAW1btzyLd7uH2jMTR71saDgunwvW///UyqFaObFBgBdwmHUUPS
	DHamE5ZW2ns=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CEA82364B;
	Fri,  5 Dec 2014 18:40:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC5C52364A;
	Fri,  5 Dec 2014 18:40:07 -0500 (EST)
In-Reply-To: <20141205231350.GB223328@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 5 Dec 2014 23:13:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B96A0FA-7CD8-11E4-B766-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260916>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Dec 05, 2014 at 03:36:18PM -0700, Jesse Hopkins wrote:
>> 1. Any thoughts on why a tag would be included by 'git bundle', when
>> 'git rev-list' with the same arguments returns empty?
>
> I think the answer to this is found in the git rev-list manpage:
>
>   List commits that are reachable by following the parent links from the
>   given commit(s), but exclude commits that are reachable from the
>   one(s) given with a ^ in front of them.
>
> The operative word here is "commits".  A bundle might include one or
> more tag objects, or unannotated tags, even though no new commits were
> available within the time frame.

Is this what a recent "git bundle create" change in 2.1.1 and 2.2
fixed?  The Release Notes to them seem to have this entry:

 * "git bundle create" with date-range specification were meant to
   exclude tags outside the range, but it did not work correctly.
