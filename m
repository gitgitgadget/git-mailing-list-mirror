From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/5] connect.c: connect to a remote service with some flags
Date: Sat, 28 Feb 2015 19:22:54 -0800
Message-ID: <xmqqmw3xh04x.fsf@gitster.dls.corp.google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<1425085318-30537-1-git-send-email-sbeller@google.com>
	<1425085318-30537-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 04:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRuTD-0000Tn-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 04:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbbCADW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 22:22:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753018AbbCADW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 22:22:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B21443C759;
	Sat, 28 Feb 2015 22:22:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SC+KCCNE9sPIu5NtDav/WX4z0Qc=; b=GxjTcU
	5MPsTvHJ0etKKUO30rrRbre/f2RXStbazs3OjChRzcKaCF1sZzbifa0zH1zN6BBG
	bGzXqkRN5G0FnLr6E6KSx546VOnMOkooMYeLnthnrQexq8nXDiMwQ1GYIwThX1xX
	aZwhyBlgH+AKG6jSkrUYXcqzKo9HmOZwky28g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybNy3rEZryP8LrfV56b46Q9z6W/1/dlz
	U5eO4nX7JJct5tdYhIvqs+rW4qCA1dVQ+318zz8Qk0+VYF7njtqJgAPU7dhY+bIs
	g4ASAOMJ5+LQP78TgYFso14RwPYRXdx4r9rgq4ZCWUp3mGJntFpD1IfCdNj1h4hI
	Zb0phazpnSc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA9513C758;
	Sat, 28 Feb 2015 22:22:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BA783C757;
	Sat, 28 Feb 2015 22:22:56 -0500 (EST)
In-Reply-To: <1425085318-30537-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 27 Feb 2015 17:01:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40EEC4EE-BFC2-11E4-85EC-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264546>

Stefan Beller <sbeller@google.com> writes:

> If this is over git protocol, the flags is appended as the next
> parameter after host=. If it's ssh, a new argument is appended to the
> command line.
>
> None of the callers use this now though.

Replace "some flags" with something more meaningful, so that the
reader can imagine what purpose this change is meant to serve.

I unfortunately cannot offer a good suggestion by guessing what it
is at this point, as none of the callers use this at this step in
the series.

> +		if (!service_flags)
> +			packet_write(fd[1], "%s %s%chost=%s%c",
> +				     prog, path, 0, target_host, 0);
> +		else
> +			packet_write(fd[1], "%s %s%chost=%s%c%s%c",
> +				     prog, path, 0, target_host, 0,
> +				     service_flags, 0);

Is this meant to be consumed by daemon.c:parse_host_arg()?  Doesn't
it detect extra cruft after "host=<hostname>\0" and die with an
"Invalid request"?
