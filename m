From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 15:20:19 -0700
Message-ID: <xmqqa9jhof6k.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKFFU-0004rO-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab3ILWUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:20:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223Ab3ILWUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BEB241967;
	Thu, 12 Sep 2013 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TC2lC4yUscW9kveep78dZYJTWbc=; b=JUZ73E
	qqFMQbuhnX+VlLtbtUvRPG0cYlVh/Lb8aELiaShno0qWKkQRN5WF5iLLAyQtMVgg
	+fSIjeGMEV0KUgqjmXl8au1bQblwbB+Q2T7iSr/5CFYxlYW1tHn4BzZBLzlQul5G
	QhMfORlptsigNlj9gmp10Pe1HKfg937K3ab3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3mU1Hygajv6vaKe+x0t1Jld/SOVtMbs
	gLnSoTqWb5c26K8DgrPwxPtwfFyIfSGsJgdFJb8LLzhRQZ6RgK3Gn9coqDbjIXas
	en3TENPwlNW4fkswCZyUv/VOzM3wXLFndWpNFMTXE1k8J4jdJQX+57MG0rpkfnnW
	lOP6l0F2U2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA6D41965;
	Thu, 12 Sep 2013 22:20:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3EF94195C;
	Thu, 12 Sep 2013 22:20:21 +0000 (UTC)
In-Reply-To: <xmqqioy5oiif.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Sep 2013 14:08:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8387A1E0-1BF9-11E3-A561-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234706>

Junio C Hamano <gitster@pobox.com> writes:

> Eugene Sajine <euguess@gmail.com> writes:
>
>> So are you really sure that it is a non-starter to have
>> --before-service/--after-service options for access-hook?
>
> Given the definition of "--access-hook" in "git help daemon":
>
>     --access-hook=<path>::
>             Every time a client connects, first run an external command
>             specified by the <path> ... The external command can decide
>             to decline the service by exiting with a non-zero status (or
>             to allow it by exiting with a zero status)....
>
> There is *NO* way in anywhere --after-service makes any sense (and
> by definition --before-service is redundant).
>
> What you _could_ propose is to define a *new* hook that is run when
> the spawned service has returned, with the same information that is
> fed to the access hook (possibly with its exit status).

Scratch that "exit status" part, as I do not think it is useful.

To a receive-pack and a send-pack that is talking to it, if a push
results in a failure, it is a failure.  Likewise for upload-pack and
fetch-pack for a transfer in the reverse direction.

And the way that failure is communicated from the receive-pack to
the end-user via the send-pack is for the receive-pack to send a
protocol message that tells the send-pack about the failure, and the
send-pack showing the error message and signalling the failure with
its exit status.  Likewise for upload-pack and fetch-pack (hence
"fetch", which is conceptually a thin wrapper around it).

Between the deamon and the receive-pack (or the fetch-pack) process,
however, such a failed push (or fetch) is still a success.  "I
correctly diagnosed and successfully sent a rejection notice to the
other end" is signalled by receive-pack to the daemon by exiting
with success (i.e. 0) exit status.

So even if we feed the exit status of the service process to the
hook script specified by the --post-service-hook, it does not tell
the script if the service "succeeded" in that sense.
