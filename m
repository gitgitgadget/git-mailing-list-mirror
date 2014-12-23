From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 09:07:30 -0800
Message-ID: <xmqqegrq47n1.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:07:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Svp-0003zi-P1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbaLWRHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:07:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751369AbaLWRHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:07:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C178928367;
	Tue, 23 Dec 2014 12:07:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nb3kgJuITY4eeHiPl6DmyiwLo/Y=; b=sHP9tW
	xPdjqvPuqG4npjVr6GoQDnLSM6kv6DaT5qj/0z9RXDRq8HKlpvSsp2AtjoD6l1fL
	u1x3M/6dpEehb7np1aZnCE3rKjna7fohL/yKx1E4JQpna3T9AA/tdhBYVOcATc1q
	HgmExu4zc/MVjRLheJCG8trhfcFCPgOGLgp3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HuJLC/JhqaqT9k+iXdTwWd1H+Kq4tR6C
	wN3TXoBrgHnSexc3yIFkSZemGSzo/3AE3bzrihx4Iqs8+2MXEQfoGIhQUiu7qrWK
	jlQK4hnhHHZvIG6KFjYQ4LdRuVIBrQ6N5Po3+P5L0PzGE45BGjbD995xacQGNx1+
	7mcBSiieIA0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7ECF28366;
	Tue, 23 Dec 2014 12:07:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F5BF28365;
	Tue, 23 Dec 2014 12:07:32 -0500 (EST)
In-Reply-To: <xmqqmw6e499u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Dec 2014 08:32:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2EE21D40-8AC6-11E4-981F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261742>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that it would be much better if the configuration
> variables were organized the other way around, e.g.
>
> 	$ git config fsck.warn missingTagger,someOtherKindOfError

By the way, I think I like this organization is much better than the
other way around, i.e. "fsck.missingTagger=warn", as we do not want
the namespace under fsck.* for variables that control the behaviour
of fsck that are *NOT* kinds of questionable conditions fsck can
find.
