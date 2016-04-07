From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Thu, 07 Apr 2016 10:34:51 -0700
Message-ID: <xmqq1t6h1fwk.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-3-git-send-email-mst@redhat.com>
	<xmqqmvp51hhm.fsf@gitster.mtv.corp.google.com>
	<20160407201853-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:35:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDpn-0000Yy-3A
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757130AbcDGRez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:34:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751706AbcDGRey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:34:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71A3C52D0B;
	Thu,  7 Apr 2016 13:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7lvbzjwD8P2D569OMlH6M4+QWKk=; b=Dcxlpn
	xN0FbNKR9oSbDYKxlGkQ615Y177+FHd1EYP6TjKmLiWwmsnSZhqWM9RbOWsgYjTK
	+f3R1Ma6QBXzxCgYwHfbqS9x4+b4JsmaFxpBrXejlMWWCV79RDZg0ckUf1njHTWJ
	onVDw/kbh6o6RDUkqncOdv3F2HVy6z+sYelvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o0oBPUb7gQ17tDZSMf46rd7hw/zUhTCj
	hFMnsrSc0BhDndq0qBdKeZ0ixypOH4l7IPdLjOjtLIIgh2jJJx2QVlQm0q4paBY2
	bCXBw7rXeBUWAilaJuJIn+ki/8qDyaqzM+wLne/ohAriRvVqwn2/Qi9sxMXZbxG+
	naZsKbtBvUc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69C0C52D08;
	Thu,  7 Apr 2016 13:34:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1CF052D05;
	Thu,  7 Apr 2016 13:34:52 -0400 (EDT)
In-Reply-To: <20160407201853-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 20:21:49 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 093F5028-FCE7-11E5-B79B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290937>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> No - but then I will need to re-run mailinfo to parse the result,
> will I not?

By the way, I suspect (if Christian did his implementation right
when he did interpret-trailers) all these points may become moot.

I haven't re-reviewed what is in interpret-trailers, but the vision
has been that its internal workings should be callable directly into
instead of running it via run_commands() interface passing the data
via on-disk file.  In the codepath you touch in 3/4 and 4/4, you
already have not just mi.log_message but msg that has the whole
payload to create a commit object out of already, so shouldn't it be
just the matter of passing <msg.buf, msg.len> to some API function
that was prepared to implement interpret-trailers?
