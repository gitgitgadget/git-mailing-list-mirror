From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Opinions] Integrated tickets
Date: Tue, 11 Nov 2014 09:17:59 -0800
Message-ID: <xmqqioil7j20.fsf@gitster.dls.corp.google.com>
References: <20141105124429.GF15384@paksenarrion.iveqy.com>
	<xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>
	<54620522.4060600@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoF5k-000314-UK
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 18:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbaKKRSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 12:18:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967AbaKKRSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 12:18:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC2911C0D6;
	Tue, 11 Nov 2014 12:18:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0PAqhORPJ3V3z9LRQdY+hRyc2jU=; b=kXYBkA
	WbSS4Gw2w18D7SC8BVSwZiJlkKU4pavC6dNI712TXnFjP8ZwjrfQKUJgjOsq7hne
	mfygmK8cUCqM8Ta9pS2Mms+EWsuhLS2atJaZaRiqOWhbuGnHk4UZNhUR1Nx0A4f0
	+6Rqj6WxZYmK6I+ZOFlc8XjhqQ/UEFFnGjARs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c8pa9af8TuQmnsI6aw/4P9Lin/hdRvdM
	a5L503b+jytcyYBI3Cu4hITlymllim8upbLuTZjb2iGbN+F3D7HNdnTIaHcxaOT7
	kUZwwp6gkM8s6kIC2UaKB/xFgBHNyXL5I7mseVMf74COnlVu4gTQ9K3mS09HVwJJ
	4P+MvvUbNBQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F8731C0D4;
	Tue, 11 Nov 2014 12:18:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D39B81C0D3;
	Tue, 11 Nov 2014 12:18:00 -0500 (EST)
In-Reply-To: <54620522.4060600@ira.uka.de> (Holger Hellmuth's message of "Tue,
	11 Nov 2014 13:46:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B03BAAD0-69C6-11E4-A69A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> Am 06.11.2014 um 19:45 schrieb Junio C Hamano:
>> This is a tangent, but I personally do not think "ticket" meshes
>> very well with "commit".  If you already know which commit was
>> problematic, why are you annotating it with a ticket before
>> reverting it first?
>
> I would expect a ticket to be annotating the commit or version tag
> where the bug was found, which usually isn't the commit where the bug
> was introduced.

You could arrange your "tickets" in such a way, but in general, the
way you organize your data should match how the data is expected to
commonly be accessed.

If somebody finds a bug when the version he happened to be using was
v1.8.5-9-g144d846, do you mean to attach that ticket to that exact
commit?  Or do you use v1.8.5^0 (i.e. the closest tagged version)
after making sure that it is not a commit between these two that
introduced it as a new bug?

Either way, I do not see how such an arrangement is the most
convenient way to organize the tickets and ask questions such as
"what are the known, untriaged, or unresolved issues in v1.8.5?",
"what are the issues that didn't exist in v1.7.0 but appear in
v1.8.5?", "what are the outstanding issues around refs handling that
are the highest priority?", etc.  With your arrangement of data, any
of the common questions I think of asking would require a linear
scan of a commit range, followed by an enumeration and parsing of
all the notes attached to the commits to answer.

So I would have to say that your expectation makes even less sense
than annotating an exact buggy commit with a note saying what is
broken by it.
