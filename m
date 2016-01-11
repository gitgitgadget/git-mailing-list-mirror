From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 11:44:52 -0800
Message-ID: <xmqqio2zx5mz.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
	<xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
	<20160111192844.GD10612@hank>
	<xmqqmvsbx62d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:45:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiOn-0006ht-CS
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbcAKTo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:44:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758791AbcAKToz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:44:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E59843A577;
	Mon, 11 Jan 2016 14:44:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=viN8kpqicFRRopenXGKeSccyVao=; b=sqneDY
	d9FmGoPq33XH0ulJQT2xHTqjCZPId+mfcFmSxqCv1zSQfkUFyc0pQypi0gL1sJD6
	AE0bmW1ZOz3ekmX78kYDGGc47Cu266zHYisXL1wDrw0R+DzlgC0roRPP9XOKJFMi
	ovXnd8+TWL6mh754zDHQPPTopZWCjc3zVgRh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ck4uYNwTjLC+XSoDa2FqEKuwogyWlFDL
	DOfDyhLH7X92e2OAPwQO80LRCiqALFcbmI+6QHLIOZyD8WyC57rxQQdTC/FiUqRi
	CYnJPUmXP9FBMy2SaleO+47F2Kmow4C5/8aH8NKakOeK/dlG+tryEBh+b6suvu4C
	pA/DtK7B8hA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC1E83A576;
	Mon, 11 Jan 2016 14:44:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 537043A574;
	Mon, 11 Jan 2016 14:44:54 -0500 (EST)
In-Reply-To: <xmqqmvsbx62d.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jan 2016 11:35:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C96E22EC-B89B-11E5-BF9F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283711>

Junio C Hamano <gitster@pobox.com> writes:

> I however fail to see why that necessitates to change use_index to
> no_index, making the code harder to follow by introducing double
> negation.

Oh, perhaps your thinking is that there are multiple ways that
use_index can become 0 (i.e. it could come from the config, could
come from an explicit --no-index, or it could come from the new
default behaviour), and the error messages deep in the callchain
(long after option parsing is done) want to react to these
differences.

To that I am somewhat sympathetic, but then use_index can become 1
(rather, no_index can become 0) in multiple ways (i.e. it can be
because the user is just using the command as designed for its
primary use case, or the user explicitly said --no-no-index), so I
am not sure.

In either case, I do not have a strong objection.  Avoiding double
negation is merely a moderately strong general preference.
