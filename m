From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 24 Sep 2014 22:04:08 -0700
Message-ID: <xmqq1tr0cmuv.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
	<CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
	<xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 07:04:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX1E1-0007Gr-FA
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 07:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbaIYFEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 01:04:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54054 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbaIYFEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 01:04:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED3493DC60;
	Thu, 25 Sep 2014 01:04:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F+DLq0YZVs1pH2A5HjTpB7TQxwU=; b=x1EjRJ
	2ORLo3wLT+1iE26YnvPYYn72mmJuZ11Iu4ZmjlbNJY14BXhT/Y/eNEhtQNOnblAL
	D6jsnPcsR6TDjmZfE0ciLwGsh5JMBEQxtJjdsYO6UhleCMWvO62w32xHGIliQWE4
	a28H3ZEIX800+T7c1v6TDRsl3MyNUkTZJCMP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyQZQq5/nIpN04MepH8UrgZLoxBYpkJ7
	gNJR49n8/4GosmGzSwe+WbrVCq3yzUGJqkQoDspCK9aI6I8HRVEz57ZGRMDnj2ow
	QcH4F/x0TWY+MFu/+i6zQfcgPieqMcTTeaO0dc5f3Y8VkyuHOIPKvgQcod/PZwC/
	3ezpNnieCSI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E368D3DC5F;
	Thu, 25 Sep 2014 01:04:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F5973DC5E;
	Thu, 25 Sep 2014 01:04:09 -0400 (EDT)
In-Reply-To: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Sep 2014 10:15:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61FE4FB4-4471-11E4-AE02-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257470>

Junio C Hamano <gitster@pobox.com> writes:

> What would be more interesting is if the primitives you have,
> e.g. "replace", "append", etc. are sufficient to express his use
> case and similar ones.  For example, when working on multiple
> trailers (e.g. "am --trailer art" would muck with three kinds), how
> should "do this if exists at the end and do that otherwise" work?
> To an existing message ends with Michael's Signed-off-by:, if his
> "git am --trailer arts" is called to add these three and then a
> Signed-off-by: from him, should it add an extra S-o-b (because his
> existing S-o-b will no longer be the last one after adding Acked and
> others), or should it refrain from doing so?  Can you express both
> preferences?

By the way, the answer to this can be "no, but it does not matter.",
of course.  If you can only express the latter (i.e. the addition of
multiple trailers is done as an atomic event, what was the last
before addition of them will be treated during the whole time of
addition of all of them), that may be perfectly fine because the
former (i.e. the addition is done one by one) can easily be emulated
by calling the program multiple times, feeding the trailers one by
one.

> Another thing that got me wondered this morning while I was thinking
> about this topic was if "replace" is flexible enough.  We may want
> to have "if an entry exists (not necessarily at the end), remove it
> and then append a new one with this value at the end" to implement
> "Last-tested-by: me@my.domain", for example.
