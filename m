From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] Add test to describe expectation of blame --reverse with branched history
Date: Tue, 27 Oct 2015 10:57:48 -0700
Message-ID: <xmqqk2q8chyb.fsf@gitster.mtv.corp.google.com>
References: <1445837217-4252-1-git-send-email-max@max630.net>
	<1445837217-4252-3-git-send-email-max@max630.net>
	<xmqqeggijga3.fsf@gitster.mtv.corp.google.com>
	<20151027044049.GA18120@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8VR-0005RG-SX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 18:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbbJ0R5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 13:57:53 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754673AbbJ0R5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 13:57:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56DEA26BF8;
	Tue, 27 Oct 2015 13:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GC2Uay3z+B2rkC9SboovEBm1R8w=; b=bzfyjo
	vNcj5T3ikBLj+FbAkfw4Xk3ChcB+qQ1Oj9A7fIgli8Z2rMNbiu9dYRysU67QAJiC
	rWkND10qiQeP7/O+zED2PDarIxFJUXI8mDdg8k5UuJcFSTer4J/EIAJ7FBW2Rew+
	MgX+fNpPNWOKaAVX2zmXR0m/ysWFrK/yzwTro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2V3R8EIo3/w2f33wONdYt0Pdo8h06TM
	vms1HedzsmVzaVof/03HtLzHDfcUQU/qT5akTiDiXMn5dNe4XcnymKCroFjWmND8
	DpedGOpqZSM4j7F+qypmXMKfE60brsuf8215TTyRTybyrFmAbR17NnUx+Ssgouo6
	/1liUdr4jkQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A18526BF7;
	Tue, 27 Oct 2015 13:57:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B677A26BF3;
	Tue, 27 Oct 2015 13:57:49 -0400 (EDT)
In-Reply-To: <20151027044049.GA18120@wheezy.local> (Max Kirillov's message of
	"Tue, 27 Oct 2015 06:40:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CAE0CDA-7CD4-11E5-B4ED-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280273>

Max Kirillov <max@max630.net> writes:

>> The explanation of the first paragraph needs to be rewritten to make
>> it understandable, but I am not sure what relevance it has with this
>> change.
> ...
> So the history looks rather like (the interesting line is removed
> in B1, line removal is practically more interesting case because
> edits can be found with normal forward blame):
>
>
>  a0--a1-----*a2-*a3-a4...-*a100
>  |\         /   /         /
>  | b0-B1..bN   /         /
>  |\           /         /
>  | c0..   ..cN         /
>  \                    /
>   z0..            ..zN
>
> ...where many of the c-z branches started before a1 and
> contain the older version of line. And, what I usually need
> is the change b0->B1, because I expect to find there the
> person who did it and explanation why that was done.
>
> Now the git blame --reverse a0..a100 may return me zN, and in
> practice it often does return some quite late commit wN
> which was merged to some a90.

That covers a lot of what I meant by "rewritten to make it
understandable".  Instead of picking any of the random cN thru zN,
you are forcing to find a2, because at the initial phase of the
search, you are interested in granularity at the topic level.  And
the --first-parent combined with --reverse is exactly that, and it
is a good thing to support it.
