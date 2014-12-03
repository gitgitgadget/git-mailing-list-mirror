From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked out elsewhere
Date: Wed, 03 Dec 2014 07:54:21 -0800
Message-ID: <xmqqegsgloeq.fsf@gitster.dls.corp.google.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
	<1417335899-27307-25-git-send-email-pclouds@gmail.com>
	<547B5170.6050206@gmail.com> <20141201103818.GA20429@lanh>
	<xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
	<547D487B.4040502@gmail.com>
	<CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com>
	<xmqq4mtem029.fsf@gitster.dls.corp.google.com>
	<CACsJy8DLd4biEHo+FWYLqc4HKezHfv1ymWSQ8kLHLTQv=YKc3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 16:54:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCGB-0003My-Nj
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 16:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaLCPyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 10:54:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbaLCPya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 10:54:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A4A6223C0;
	Wed,  3 Dec 2014 10:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOJQlyxjE40uFL8C4ZpQ9HNrmxE=; b=A52jBx
	A+DSI9NhjY8L0SamUe87V98BIXk5BibOv/nukbfoQJq6G9mfZsCsisDoWMVP1XZw
	4NAg8FxTDMpsSyWhBpjgugCcH/bSguA1hp209trrMT5xMxWZ0xZh6OAU8mP/C8XL
	j1M+XWSZyQk7aGanPFfyTPvELbp9CX6eK0Nsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYmrjvPOv1KtCe8HKV3gRS5GWK8UlO02
	QQrtPS7+aFpwgU8jcL3xNte1Sk1sS9ZiWzP51x3FdJgZIssUlaW9mdHGjIGvNZCq
	YJ09VCAvJb9vz+AKq+sxKI8ykf9kcpo8jdwqjPL3EVz/tufDXDcriIg9U6W/A6Hc
	ET1fadf2/WQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7100E223BE;
	Wed,  3 Dec 2014 10:54:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCDAF223BC;
	Wed,  3 Dec 2014 10:54:22 -0500 (EST)
In-Reply-To: <CACsJy8DLd4biEHo+FWYLqc4HKezHfv1ymWSQ8kLHLTQv=YKc3A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 3 Dec 2014 19:50:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A65CF27C-7B04-11E4-95B4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260653>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Dec 3, 2014 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I do like "read-only" ref concept where we can keep ref name
>>> (especially tags) in HEAD until the next commit. But it didn't go
>>> anywhere
>>
>> Remind me.  That sounds somewhat interesting.
>
> Couldn't find anything in my mail archive. But the idea is simple:
>
>  - we delay detaching HEAD until we need to update the associated ref
> at commit/reset time
>  - currently refs/tags/* are read-only. we generalize it to allow this
> 'read-only' attribute on some refs/heads/* as well. Because we can't
> really add attributes to refs, config var could be used.

It could be some annotation in HEAD instead, e.g.

    $ cat .git/HEAD
    ref: refs/heads/frotz
    options: read-only
    $ exit

and it may make more sense as this read-only-ness is closely tied to
the state of HEAD, i.e. whatever operation that manipulates the
HEAD, it needs to be very much aware of the read-only-ness, and it
is much less likely to go out of sync, compared to a solution where
you store this bit to anywhere else, e.g. config.
