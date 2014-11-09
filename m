From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 09 Nov 2014 09:32:30 -0800
Message-ID: <xmqq389se0up.fsf@gitster.dls.corp.google.com>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
	<20141108110958.GB20750@peff.net>
	<20141108123554.GA90057@melamine.cuivre.fr.eu.org>
	<20141108142753.GA28652@melamine.cuivre.fr.eu.org>
	<20141109095155.GB17369@peff.net>
	<20141109123934.GA50956@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWMi-0001U7-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbaKIRcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:32:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbaKIRcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:32:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F03DA1AB4F;
	Sun,  9 Nov 2014 12:32:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JB1+9SuJwkw/c0O8vzO1RoStGr4=; b=Hn4/CM
	PC0OJdBa3gRDlqHLd/7k86BJh7VQa+dqJwMIMjhNc9Kmgyf8qWph4UjX7gJ0p5Bu
	TDeHWKNqMS7TBBk1oxpT3Xc/WHkGNqEwS8xwMyQ5G9iSZrsyoMm3OexqIj60Jc8W
	riYxNoqGqCFxSKn3rsAQNHSZ+Mmc/XrlrsDYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPsBUtl1i8xaFxCqjbP3UgfWOnjuCh2+
	fAJYVKulnNtrLWyNNrUyZksxuCpMJra/j0+urtYWXe5qfe5EcKIIJSVsglBh14xY
	CVYJJcfQfbIDAeXgT4Qrb1BTh+m1SjhwtTbOunLJSvToyUYkiScW+7w11uvk6i2x
	gfbQnEZSkrk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7B301AB4C;
	Sun,  9 Nov 2014 12:32:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70E1D1AB4B;
	Sun,  9 Nov 2014 12:32:31 -0500 (EST)
In-Reply-To: <20141109123934.GA50956@melamine.cuivre.fr.eu.org> (Thomas
	Quinot's message of "Sun, 9 Nov 2014 13:39:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 624D457C-6836-11E4-A280-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Quinot <thomas@quinot.org> writes:

> Could also be GIT_SSH_SHELLCMD, to denote that this is a *shell*
> command...

Whatever.  I loathe the CMD abbreviation, though.  Why spell out
SHELL but not COMMAND?  I.e. GIT_SSH_[SHELL_]COMMAND

>> Parsing complications aside, you cannot even know in git which ssh is
>> going to be run until the shell code is executed. I think either we have
>> to leave the responsibility for munging "-p" into "-P" on the side of
>> the user's shell snippet
>
> That sounds like a reasonable approach, and leaves us with the simpler
> change (that splitting circuitry was admittely a bit awkward...)

It does not make sense to special case "plink" at the level of this
mechanism where the spawned command line does not even have to
invoke any "ssh" and its derivatives, so I fully agree that choosing
between -P and -p should be the responsibility of whoever is using
this mechanism.

Thanks.
