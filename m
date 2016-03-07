From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: make 'git clone -c remote.origin.fetch=<refspec>' work
Date: Mon, 07 Mar 2016 12:01:04 -0800
Message-ID: <xmqqh9gioy67.fsf@gitster.mtv.corp.google.com>
References: <1457313062-10073-1-git-send-email-szeder@ira.uka.de>
	<xmqqfuw3rrwb.fsf@gitster.mtv.corp.google.com>
	<20160307161931.Horde.TcdEVtHKgSMvScCDUKLclVq@webmail.informatik.kit.edu>
	<20160307153304.GA23010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 21:01:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad1L7-0007KO-4R
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 21:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbcCGUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 15:01:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753061AbcCGUBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 15:01:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C49A4491D3;
	Mon,  7 Mar 2016 15:01:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiyRDLg7bZGJHBIJ1M/LWAKWr8k=; b=lUoi5Z
	dN+k33bViXzR17MtpJQK0sgrcwAkRKibnJTIchDfUJ4tAnLitKHB+QIHwlSA15rG
	BLvCJoy6CelSGNR0DV4RAed1cjHuKDgi+NsL+lI4BtqREGT0cvuccSM3vnMo8KwG
	61RUMFlGnALIDoF1qv7oK+f7sUROiZ0Y/dzQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvxvmFtA+Ywg2DUoCiYejuo4V6s3qvC3
	jplxiqQLaQn7MMac+iWLGISI9njjiIHJIfhvnseVpxbiguylwYCkC+qsA5AnmGDI
	aYuJgMi6jpvB2+jtmNFCwIvPxUV8s00CuLW9rOSzi7boe5HJ/VBqysODonZU6e8x
	fLuc8kIHQMk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC60B491D2;
	Mon,  7 Mar 2016 15:01:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39827491D1;
	Mon,  7 Mar 2016 15:01:05 -0500 (EST)
In-Reply-To: <20160307153304.GA23010@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Mar 2016 10:33:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5342DDD0-E49F-11E5-A49D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288396>

Jeff King <peff@peff.net> writes:

> IMHO, we should stick to the conceptual model that "git clone" is:
>
>   git init
>   git config ... ;# set up remote, etc
>   git fetch
>   git checkout ;# obviously not for --bare
>
> The implementation has to diverge from that to do certain optimizations,
> but absent any good reason not to, I think we should aim for behaving
> "as if" those commands were run.

Yup, I 100% agree that we should aim for matching that mental model.
