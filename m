From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] incorrect search result returned when using git log with a
 future date parameter
Date: Wed, 30 Jan 2013 14:22:01 -0800
Message-ID: <7v7gmujoqe.fsf@alter.siamese.dyndns.org>
References: <51090466.9070105@casparzhang.com>
 <7vsj5ijvei.fsf@alter.siamese.dyndns.org> <20130130221544.GA15680@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caspar Zhang <caspar@casparzhang.com>, git@vger.kernel.org,
	Gris Ge <fge@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 23:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0g32-0001EI-Ex
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 23:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab3A3WWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 17:22:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab3A3WWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 17:22:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93821C17E;
	Wed, 30 Jan 2013 17:22:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wDSEvzjZpw94zn2YfSNCH7Hj1/0=; b=TCXQP7
	YmYRul7PISqoTMdkysR12xceAf0pueXZnaALhnl1ZPPAIDfSst57YSdUN9Esbalp
	TPjwvQj1wSnxaWNiEqMInglfCM8ReDrCmnudC6v7jOGzifeMnnXHv5Jf8elsy99P
	sEgVYc7zKHvQQoCZcXKL1F9QQT59SoMK+RyQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wKD+t5PSPRaf3LuwRdQvm1rpWUMQrcNt
	SYy+dcyWyxwPoyIEO/prTLnL0a75lZC1gVV905TRE3ayqoj95HbB8mHromKrXhpv
	W6Rzn+3vpRR5uv11ermuqxxf0Fd/9FfnJw6f4m94NLQ8T1H6WDmVI3F2gda8Y3SU
	epZxBfiWkbs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8754AC17D;
	Wed, 30 Jan 2013 17:22:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09BF3C17B; Wed, 30 Jan 2013
 17:22:02 -0500 (EST)
In-Reply-To: <20130130221544.GA15680@google.com> (Jonathan Nieder's message
 of "Wed, 30 Jan 2013 14:15:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78E61F48-6B2B-11E2-91E6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215077>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> When it is fed 2013-02-12, it is ambiguous and "approxidate" can and
>> should use whatever heuristics (including rejection of future) to
>> guess what the user wanted, but 2013-02-13 cannot be interpreted in
>> any other way, so we should parse it as such.
>
> FWIW, if you said 02/12/2013, I'd agree, but I've never seen someone
> using 2013-02-12 to mean December 2.
>
> So that suggests another possible tweak on top. :)

I think in the original context that triggered the "be more friendly
to Europeans" discussion long time ago, some correlations between
the delimiting characters (i.e. 'xxxx-xx-xx' vs 'xxxx.xx.xx' vs
'xxxx/xx/xx') and month-day ordering convention.  I do not recall if
we actually added that as a signal when disambiguating, though.
