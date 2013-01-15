From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Mon, 14 Jan 2013 18:45:19 -0800
Message-ID: <7va9sb6u68.fsf@alter.siamese.dyndns.org>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1301150055520.32206@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mar?= =?utf-8?Q?t=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 03:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuwX1-0001TY-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 03:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab3AOCpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 21:45:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab3AOCpW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 21:45:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B81A9CF09;
	Mon, 14 Jan 2013 21:45:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJ0LA8vhC6z4QlGyLqqM4xr2U38=; b=gKvFWY
	m0d9QzUYMYGD0aeEj885UiHYT9io7ZDQ8EIXJrsIl67JtR2HQ5XLgS6CpMEm35Wk
	igx8F6wCpbbnZzTebxDLdiO3MBViP0GKlL2C6uJXVg4sJkH1MCM+mE0xojedKf86
	3N+aiYHraMHrNPRr3PGuXX+tVAaJK1I7snw6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i8BIl4hY1LoUmdSKjVekjweOT5fSphg7
	L+e3U7aUss8hTi194l9UqqTfy+klyeQd0Kiv7X9l48N6e6b+ROIkgqksdEHyX5S4
	1EWd0MYYspsVZ8DLoKCf3pm8en1uFga9cmfjuZvDdobNaZEln6zIh3X8j11Wb2Y3
	8hel06jkbRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3E2CF08;
	Mon, 14 Jan 2013 21:45:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2878ECF05; Mon, 14 Jan 2013
 21:45:21 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1301150055520.32206@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Tue, 15 Jan 2013 00:56:24 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AB23F0A-5EBD-11E2-A5F7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213567>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 14 Jan 2013, Junio C Hamano wrote:
>
>> It appears that memcmp() uses the usual "one word at a time"
>> comparison and triggers valgrind in a callback of bsearch() used in
>> the refname search.  I can easily trigger problems in any script
>> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
>> without this suppression.
>
> I have no way to replicate that issue, but I take your word for it. With
> that in mind, here is my ACK.

Thanks.
