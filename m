From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Retry on all A/AAAA records
Date: Mon, 18 Apr 2011 21:22:08 -0700
Message-ID: <7v39le7tvz.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.01.1104161312590.11706@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Apr 19 06:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC2SG-000061-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 06:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab1DSEWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 00:22:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab1DSEWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 00:22:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76D6451D5;
	Tue, 19 Apr 2011 00:24:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nxrqfbdFwB2je+a9+cvry41ih4w=; b=V1CgpE
	FR5o2gWBj/+6vLQaVTY8cBUUyOCtCAfu/xTQKSQws5g8OXGAd8s/Y2HkQGW+pLie
	g2PXoV8f0+mZ3cgP0DptIVc6dumsl+WB9LrqT/CJTtc3wWBlhqlXS5cIkJsjaYjX
	fnguzbaUy8PjYA2wY1qjvDpZ9PKj4645vlulM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1cEJRQpPu94RdZZ3rhW1bMnDA5sPqGq
	mQom+Ujq+PFEMLb/MIaeBriMQQ6rA2MSUQfaJ37/vbRzFDiRG9fdhReBkxSoD8Bb
	XirNmzUfZU5jq0ErEUtHVsex0XsbZS1pkyM7Nrrgl0BgSjiAB1GcJ8skjJJQ42Aq
	RUtMMmwnbO0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52C6D51D4;
	Tue, 19 Apr 2011 00:24:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7314A51D3; Tue, 19 Apr 2011
 00:24:10 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.01.1104161312590.11706@obet.zrqbmnf.qr> (Jan
 Engelhardt's message of "Sat, 16 Apr 2011 13:14:27 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E15BBFCA-6A3C-11E0-8BF5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171772>

Jan Engelhardt <jengelh@medozas.de> writes:

> Just now, some git server that is in the DNS rotation seems to have an 
> issue,
> $ telnet git.eu.kernel.org git
> Trying 199.6.1.166...
> Connected to git.eu.kernel.org.
> Escape character is '^]'.
> Connection closed by foreign host.
>
> I thought it would be nice if git-fetch would retry the operation on 
> the other DNS records that were returned if the connection breaks.

I think people who wrote git_tcp_connect_sock() in connect.c apparently
thought so, too.  It uses either gethostbyname() or getaddrinfo() and
iterate over the list of addresses returned from these functions.
