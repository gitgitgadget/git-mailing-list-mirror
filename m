From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 16:27:19 -0700
Message-ID: <xmqqppsdmxig.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
	<xmqqa9jhof6k.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYY6Q=zZ62mY6uGi6O7KaOO8NhUEH0YUgcQE3NBvHQEpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 01:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKGIM-00023z-7r
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 01:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737Ab3ILX1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 19:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab3ILX1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 19:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 456FF415A6;
	Thu, 12 Sep 2013 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvWjm9ChAZYl4BMzDrtbb8HrJOE=; b=rSE2Ej
	9lYuhXW4nMbIriy9dFtf23wuPpD3Vq1aT9piqYsF+/GgyTEa0TfkXiizXpuJyMc1
	39SekCr2uWpE9+5FlONNOYwDWTDVwdeDnLSoyPPJkEem2s3nLmzL/CH7pPxyne2X
	70ib8mXAfl+Njqa0bdXR8DjqFbApYkf3L2G5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVtqRDwPvG6fU0zCSUex864jq9bla903
	Tk8cEfRpQZUrPIv9tZBwXfOBR14QwJj4KCO1cR+zvC22qjEZ7ClBxlgUGLHRjEin
	hNM7US9s+inTdJt3wojwETStAg4fkVvCNTu1Lt0SELxkDu7KUqEzSK/dx1PbY8rK
	kHzRpJTaRr8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B55A415A5;
	Thu, 12 Sep 2013 23:27:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1839415A1;
	Thu, 12 Sep 2013 23:27:23 +0000 (UTC)
In-Reply-To: <CAPZPVFYY6Q=zZ62mY6uGi6O7KaOO8NhUEH0YUgcQE3NBvHQEpg@mail.gmail.com>
	(Eugene Sajine's message of "Thu, 12 Sep 2013 19:17:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E0B4B93A-1C02-11E3-93DF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234714>

Eugene Sajine <euguess@gmail.com> writes:

>> So even if we feed the exit status of the service process to the
>> hook script specified by the --post-service-hook, it does not tell
>> the script if the service "succeeded" in that sense.
>
> I see what you're saying.
> In my particular use case I can work around that service status
> because even if it failed it will just trigger Jenkins to poll and in
> case of failure to transfer data there will be no new changes for
> Jenkins to work with. If we would want the --post-service-hook to know
> that data transfer succeeded or failed, then may be there should be
> some difference between "service status" and "service process status"?
> In this case the existing logic works with "service process status"
> while the --post-service-hook is fed with the "service status" (or
> name it "data transfer status")
>
> Do i make any sense?

Almost; you missed that there is no channel to pass "data transfer
status" from the service back to the daemon.
