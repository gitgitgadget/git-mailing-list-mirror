From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] builtin/interpret-trailers.c: allow -t
Date: Thu, 07 Apr 2016 10:56:34 -0700
Message-ID: <xmqqwpo9z4j1.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-2-git-send-email-mst@redhat.com>
	<xmqqr3eh1hq6.fsf@gitster.mtv.corp.google.com>
	<20160407202631-mutt-send-email-mst@redhat.com>
	<xmqq60vt1g4l.fsf@gitster.mtv.corp.google.com>
	<20160407205144-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:56:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoEAj-00066q-6j
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbcDGR4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:56:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932179AbcDGR4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:56:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F208503B6;
	Thu,  7 Apr 2016 13:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gu0p0qI28na/mTjXBXwtdjA7Jow=; b=vtpgJt
	8o77NgIp6SxelJ4ef7cKHWExvJ5F/j66hFAXftNJopcnr86HqJap3m3LDonlLCwa
	EUwelwVt2eNuXMcTNXNdJyDZAkhFm5D1nELchhJbxfe5CLVFiOSuskA9QdFmLBj1
	mJ1LAU8B7CQGOmufMXGZjhJAN3dTjOd5h3YDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fI0vqpf55AmYy9BULMOc+8KWYmx3EvL9
	m3ZyM7uLGnqjgrtOlEstpKdDGvWlHJ4A5Qhp8epcXNCOaJufk7OJHx0Ywvqn0ljy
	HGWghIbc5ikZp+Avg5YGFg5emqA7WjvKfT+1NAw6yBe8t7JrMscui+/VxFWL0ztr
	jwxdaNVWFyY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A3D3503B5;
	Thu,  7 Apr 2016 13:56:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCA50503B3;
	Thu,  7 Apr 2016 13:56:35 -0400 (EDT)
In-Reply-To: <20160407205144-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 7 Apr 2016 20:52:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11FF5EEE-FCEA-11E5-B22E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290941>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Aren't there other cases where a short option needs to be
> converted to a long one?

As I already said, making internal call to libified part (perhaps in
trailer.c) would make this part of conversation a moot point, but in
general you can find

	argv_push(&child.args, "cmd2");
	if (... some condition that involves variables parsed out ...
            ... by parse_options() of implementation of cmd1 ...)
		argv_push(&child.args, "--option-for-cmd2");
	...
        run_command(&child);

in implementation of cmd1 that calls out to cmd2.
