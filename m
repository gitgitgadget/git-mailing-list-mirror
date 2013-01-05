From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid
 overwrites
Date: Fri, 04 Jan 2013 20:32:10 -0800
Message-ID: <7vobh4qmgl.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <7vsj6gqvhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 05:32:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrLQy-0000Zy-GD
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 05:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab3AEEcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 23:32:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944Ab3AEEcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 23:32:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1EB3A3D5;
	Fri,  4 Jan 2013 23:32:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QP2UhVxaMkz3K8iW9OYJ1A08j8Y=; b=Qi1Mbe
	oEtoEeT8OLdTYdJ9VD6OGV8i/QEWOGzS5r2vtO29AWenC8ofF2JW3OOxBFkseUFA
	/VT4P74dLlWwTsHEBXkz2oFWVzLBH4ESuRaHZjAbIaNfg1AoNiWQX+swi4Z9zrM+
	0osvnjOLXuME0v9YWrBEKqLkkxWINfxGY+PVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lbs8wkyHJOLGQRCQpElSW+AorkvHCW6t
	f9xmdvcUD7NzTQVJA112K4agLlQcC1eGihJBf/MMJ2MtNk3Dnil51kuGgHNoKGMb
	dVLuHUYqbMN0DCjnC6ObDE4xc5EZL06CykTjLDRyn1FnWUT+xhnDfuRbQ3diAPDF
	Tn9dgnYPQks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D454FA3D4;
	Fri,  4 Jan 2013 23:32:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51963A3D3; Fri,  4 Jan 2013
 23:32:12 -0500 (EST)
In-Reply-To: <7vsj6gqvhc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 Jan 2013 17:17:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFEB4654-56F0-11E2-91EB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212661>

Junio C Hamano <gitster@pobox.com> writes:

> ...  So even if the standard allowed the
> returned value to be volatile across calls to getenv(3),...
> ...
> In fact,
>
>     http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html
>
> says that only ...

Apparently I wasn't even reading what I was quoting carefully
enough.  The above does include getenv() as one of the functions
that are allowed to invalidate earlier return values.

Sorry about that.  I'll go back to bed (I am a bit under the weather
and OOO today).  The conclusion in my original message is still
valid.

> Having said that, we do have codepaths to update a handful of
> environment variables ourselves (GIT_DIR is among them), so I think
> your patch is a good safety measure in general.
