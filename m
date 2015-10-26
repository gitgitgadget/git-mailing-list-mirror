From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Mon, 26 Oct 2015 11:42:33 -0700
Message-ID: <xmqq4mhdii92.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
	<5627B496.7030102@ramsayjones.plus.com> <5627EFE4.1060106@kdbg.org>
	<alpine.DEB.1.00.1510261524000.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:42:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqmjA-0004eT-2W
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 19:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbbJZSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 14:42:36 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751724AbbJZSmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 14:42:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB73526671;
	Mon, 26 Oct 2015 14:42:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3fTVCi+tiqrnst+F9hUfg4X7aE=; b=wQsE4w
	SKsMA3pC6XOvYV6ENx3nTWiD0COwou5fFWMWoyIXM5x+3laaOBGxZ8iS3VcKjSHH
	BAUwzYFNVXFaHehhr4pMM2mjQkEwG6lpkbpEJ7N9nEvB8nAlSGbreQVty0y574y5
	cZTCGktzEhp79kQtVTcFLxODPakDELY3sj2UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gZOVS4YubGHmTItPVKxKATbfspmpfrVy
	A6GrKSf0V0KzLoF7J4vkeNNMfJG9mttAfjWhJBPSVExBbafLjRFnIYNRe7V+OROd
	S0RDc3FeFaI3T0D0vbh9tuc4fGal5qwt3Ejh4sig4YXaLjPr5+jOyYkanwTXMCe5
	V1lX4V2ahfM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1FCE26670;
	Mon, 26 Oct 2015 14:42:34 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 319F92666F;
	Mon, 26 Oct 2015 14:42:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1510261524000.31610@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 15:25:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5253A108-7C11-11E5-8B21-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280206>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > The corresponding times for me were:
>> >
>> >      (master)           (with the series)
>> >    real	0m9.760s      real	0m5.744s
>> >    user	0m0.531s      user	0m0.656s
>> >    sys	0m5.726s      sys	0m3.520s
>> >
>> > So, yes, a noticeable improvement! :)
>> 
>> Same here, on Windows built with the old msysgit environment:
>> 
>> (master)             (with the series)
>> real    0m3.147s      real    0m1.947s
>> user    0m0.016s      user    0m0.000s
>> sys     0m0.015s      sys     0m0.031s
>> 
>> Although I tested 'git am patches/*' where the patches/* are the result of
>> 'git-format-patch v2.6.1..github/jc/mailinfo-lib'.
>
> 2.548s vs 2.068s here.
>
> Ciao,
> Johannes

Thanks.  Let's start thinking about moving it forward.
