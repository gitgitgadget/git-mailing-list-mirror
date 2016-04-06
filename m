From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Wed, 06 Apr 2016 10:42:42 -0700
Message-ID: <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
	<vpqlh4qbrnt.fsf@anie.imag.fr>
	<20160406201509-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:42:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anrTk-0005cW-A1
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcDFRmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 13:42:51 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbcDFRmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 13:42:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84F695374F;
	Wed,  6 Apr 2016 13:42:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5USowaF2gK7R4lfWduGkFz4eec=; b=uxvW/c
	09S7nPfSiLncibDFTgpcOUH1qHkCdeAl7jqthPx5/mJtcZl9w8DyflmMKOp2sHo1
	mYeuSfDfzlmejtISBgbmRd6l5uKrE1a5sNG5dddYNiO49IgpHOeh8/dtNofpbtRX
	BtrxYOzaQhfUGIBkPkDIaaXnlV+zNd/g0f4CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w2GauEuLR5xYE7EdQ1zRdtxcFP0DvrYP
	X9RL7yhp7wG4wLfoBv9CQ3yprljVqHXAjU2QERNwjV4HEyk73SyWNEu7oS3d+Uqx
	4OXLmTv8HtlePksa1DpmoEBhhqEaBscQwL7iKbgzahCQ6w6gI0J3mxir02LH/m5J
	1fUThSg1U9Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CA425374E;
	Wed,  6 Apr 2016 13:42:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 012CE5374D;
	Wed,  6 Apr 2016 13:42:43 -0400 (EDT)
In-Reply-To: <20160406201509-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 6 Apr 2016 20:16:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7BC0C4C-FC1E-11E5-AF7B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290858>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > I have this in .git/config
>> >
>> > [trailer "r"]
>> >         key = Reviewed-by
>> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> > [trailer "s"]
>> >         key = Signed-off-by
>> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>> >
>> > whenever I run git interpret-trailers -t r I see these lines added:
>> >
>> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> >
>> > Why is Reviewed-by repeated?  Bug or feature?
>> 
>> The first two lines are added unconditionally:
>> 
>> $ echo | git interpret-trailers 
>> 
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
>> 
>> The last line is added because you've asked for it with --trailer r.
>> 
>> I don't think it's currently possible to get the behavior you seem to
>> expect, ie. to define trailer tokens fully (key and value) in your
>> config file but use them only on request.
>> 
>> (BTW, I think you wanted a closing > at the end)
>
> Is this worth fixing? It doesn't look like a behaviour anyone
> would want...

CC'ing Christian who's done the "trailers" thing.

Personally, I do not think adding any configured trailers without
being asked is a sensible behaviour, but it is likely that people
already depend on it, as we seem to see "How do I configure to
always add this and that trailer?" from time to time.  I do not
think it is unreasonable to disable the "automatically add
everything that is configured" when the command line arguments ask
for some specific trailer, but I haven't thought deeply about it.

An additional (uninformed) observation is that the 'echo' looks like
an ugly workaround for the lack of "always use this string as the
value" configuration.  Perhaps next to trailer.<token>.command, we
would need trailer.<token>.value?
