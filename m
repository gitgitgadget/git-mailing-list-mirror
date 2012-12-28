From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: grep author/committer using mailmap
Date: Fri, 28 Dec 2012 10:43:30 -0800
Message-ID: <7va9syj9v1.fsf@alter.siamese.dyndns.org>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
 <1356622318-19523-1-git-send-email-apelisse@gmail.com>
 <7v1uebmizx.fsf@alter.siamese.dyndns.org>
 <7vwqw3l49z.fsf@alter.siamese.dyndns.org>
 <CALWbr2y63L0-ykdUNGqUOb0LhG=vpXGRcb1KkvssEZmKFJEGeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 19:44:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToeuU-0008F7-S1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 19:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab2L1Snh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 13:43:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab2L1Snf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 13:43:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13E17A470;
	Fri, 28 Dec 2012 13:43:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=APP6pTT6ONHmkU1eFU3V+wJbVxY=; b=FCGYhV
	bvtS+eUDDMaSRO2rjImWlZeWNvGBiT4MO/nbgtIhUlrI/RPDXf1itKtrsMaRxb4t
	YyhIbLP0jjlng0qysMfiWVBA9lVa8TxtqvVRAWjV9Sk3mxCqGzUz40YfJJdsm2hk
	pLXx8y5nTPpdxudp+puAhdWPUJbgpyCbxNpmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PaVA0lkMbI1wb9+6HKJ1qZlGGsPIy3oG
	m3bWUcssCuCru9pHddLmXqMpKHawz3XEpxyzQ5rCxkw1/KCoB7JnWTg0L3kL0OWb
	aetJDRZFBLtYzUeF+amcF+x9RNzBWa4XhFiCAktx2vTDsyRyorUQ81V2n88ghV7K
	dYDWRlD0GZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 006E7A46F;
	Fri, 28 Dec 2012 13:43:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EB67A46B; Fri, 28 Dec 2012
 13:43:32 -0500 (EST)
In-Reply-To: <CALWbr2y63L0-ykdUNGqUOb0LhG=vpXGRcb1KkvssEZmKFJEGeQ@mail.gmail.com> (Antoine
 Pelisse's message of "Fri, 28 Dec 2012 19:00:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ABCEF30-511E-11E2-A4B3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212249>

Antoine Pelisse <apelisse@gmail.com> writes:

> Actually, gprof seems to be unhappy about the number of call to
> strbuf_grow() in map_user() (25% of the time spent in map_user() is
> spent in strbuf_grow()).
>
> That probably comes from the repeated call to strbuf_addch() when
> lowering the email address.

This is about your rewritten implementation that hasn't escaped to
the general public but sitting in 'next', right?

Two things that immediately come to mind are:

 - initialization of lowermail can use strbuf_init() instead;
 - downcasing can be done in place, i.e. "lowermail.buf[i] = ...".
