From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change throughput display units with fast links
Date: Wed, 14 Oct 2009 02:13:08 -0700
Message-ID: <7viqeifie3.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0910132256280.20122@xanadu.home>
 <4AD578BD.7080201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 11:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzwT-0004qZ-5w
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbZJNJOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755621AbZJNJOA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:14:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbZJNJN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:13:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C0C37711B;
	Wed, 14 Oct 2009 05:13:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=brRsUnezrifN01J4G/dSEWgIfDc=; b=oOC5Ro
	I/7ZKK2F7MxyDre9oMo4FWfuj/HQrFZHv6R1VTUnlRkQ9CtN6sdhBt6N8maXG1XD
	TYZTl40HPfMxFGS69XiwFgLDU1MrxPVIgVuzYx28cwPKoHRngsiWFSQQTpxdSFZ/
	elgH87mJXqzRHF2JRNbHWK89DQ+K+bVLN023Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cp58FjEgcQ4VgF3poc+Y3i8AtCrx8IFX
	YjAidRs92MpGMZaUfiObIN/MqvEBShNdJ4OWyyLFckUEpRoTr4VrOuqQ0AQ2MNv4
	L5zCx2TcG4xiKAnFnRqE3/vHuts0pArfwVi9YyVAy/dLVUVPrxawpM2NEFZ9uQGN
	AURM10qzxc8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0385777116;
	Wed, 14 Oct 2009 05:13:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C744C7710F; Wed, 14 Oct 2009
 05:13:09 -0400 (EDT)
In-Reply-To: <4AD578BD.7080201@viscovery.net> (Johannes Sixt's message of
 "Wed\, 14 Oct 2009 09\:07\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD34FDF2-B8A1-11DE-A132-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130269>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Nicolas Pitre schrieb:
>> +	if (rate > 1 << 10) {
>> +		int x = rate + 5;  /* for rounding */
>> +		snprintf(tp->display + sizeof(tp->display) - l, l,
>> +			 " | %u.%2.2u MiB/s",
>
> Shouldn't the fractional part be "%02.2u" (leading zeros instead of blanks)?
>
>> +			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
>> +	} else if (rate)
>>  		snprintf(tp->display + sizeof(tp->display) - l, l,
>>  			 " | %u KiB/s", rate);
>>  }
>
> -- Hannes

Judging from the surrounding existing code, I do not think so.

    $ cat <<\EOF >j.c
    #include <stdio.h>

    int main(int ac, char **av)
    {
            printf("%u.%2.2u\n", 4, 5);
            return 0;
    }
    EOF
    $ gcc -o j j.c && ./j
    4.05
