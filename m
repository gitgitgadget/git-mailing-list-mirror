From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 13:06:18 -0800
Message-ID: <xmqqbn8ey75h.fsf@gitster.mtv.corp.google.com>
References: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
	<xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
	<1453403398.16226.40.camel@twopensource.com>
	<xmqqpowuyall.fsf@gitster.mtv.corp.google.com>
	<1453409984.16226.46.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 22:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMR2-0005yz-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbcAUVGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:06:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752660AbcAUVGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 16:06:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E6D23CB37;
	Thu, 21 Jan 2016 16:06:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4C9KSqEcSYmutZpjDae0izUM+GU=; b=TWDaMN
	l+mqXsatMkwESz1TcQBd54KC6Nfmy0A630AR/KtjHSG9C59VTkKABfbpH9lMQi0n
	NewAlGLU9ODi4ApaiqXB2yyN8mmQKLXaX5/UIX6Y2B7VgpcQJguq+uBoZJDZz0is
	tOK/c9vjNtNkFEkkIRT9su74w2f1xpVvMGE7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3iacYUtre5RyZbdmkE5k+CtTEKHzHvT
	6voWi/iq4Y91pBzLVuC1YUBWq9nkzVNv4HG7F7MpoYUZgMDYA65LWAkCAX3cvhs5
	S16Ke981nTM3+35tdtIwumRs+Qqvjvt8Ls3a6IL3Pf8aR/1Zlv3tvNHbEK6dsJpj
	Vzexh7QIN5w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4612A3CB36;
	Thu, 21 Jan 2016 16:06:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD95A3CB35;
	Thu, 21 Jan 2016 16:06:19 -0500 (EST)
In-Reply-To: <1453409984.16226.46.camel@twopensource.com> (David Turner's
	message of "Thu, 21 Jan 2016 15:59:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D181E54C-C082-11E5-B245-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284527>

David Turner <dturner@twopensource.com> writes:

>> The first break is correct, but I am not sure about the "else if"
>> part.  Shouldn't it be doing something similar to the logic to "keep
>> looking" that talks about "t-i", "t" and "t/a" at the end of the
>> loop?
>
> Rather than doing more complicated logic, let's just do the first
> check; it seems about as fast for our repo, and I think will usually be
> so.  does that seem reasonable to you?

Very reasonable.  I was mostly afraid of leaving the loop
prematurely and giving a wrong answer to the caller.
