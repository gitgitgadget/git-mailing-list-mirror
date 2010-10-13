From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] bisect: check for mandatory argument of 'bisect
 replay'
Date: Wed, 13 Oct 2010 10:58:47 -0700
Message-ID: <7viq16m0tk.fsf@alter.siamese.dyndns.org>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
 <1286747338-8521-3-git-send-email-szeder@ira.uka.de>
 <201010120435.11903.chriscool@tuxfamily.org>
 <201010120456.35411.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65bT-0004s0-91
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab0JMR66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:58:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab0JMR65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:58:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E2ADEA23;
	Wed, 13 Oct 2010 13:58:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ICJc3xzA8UtoDw57jmUVV0Fuf14=; b=xIq34A
	w6riynvuZJ3Rsg2pdbh/mejL3aett1egRa9inOreQaQMY5r54OSlV/PVUvUa3myt
	izPfCcmzhhu4diAikGy3jSRtcewrIF7bb/1wkxKVadfuZNaZYO7IROCdGacOwe81
	MHhuDmiZQqXuwDoQqtToZUpab654VJrGzg44c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tT4WaMWHAOzSJjZ0Wxb4eQiQqqNqLEEY
	hZXb53fDSaTq7WMkD/JKG0ItUXpEuo+5NGBQpgC89xIP1wVCFgYmOfQYgxF5GtfN
	urJqNZoaoay4g5bCJhV+hdd2v+WZySn5jpZuv3BrnjgUxIYkbXf4fdV7yIypX3D7
	yNbCONzv8qw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FCF2DEA22;
	Wed, 13 Oct 2010 13:58:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33FBCDEA20; Wed, 13 Oct
 2010 13:58:49 -0400 (EDT)
In-Reply-To: <201010120456.35411.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue\, 12 Oct 2010 04\:56\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A649BA6-D6F3-11DF-86A0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158956>

Christian Couder <chriscool@tuxfamily.org> writes:

>> >  bisect_replay () {
>> > 
>> > +	test "$#" -eq 1 || die "No logfile given"
>> > 
>> >  	test -r "$1" || die "cannot read $1 for replaying"
>> >  	bisect_reset
>> >  	while read git bisect command rev
>> 
>> While at it perhaps you could do something like:
>> 
>> bisect_replay () {
>> +	test "$#" -lt 1 || die "No logfile given"
>> +	test "$#" -gt 1 || die "Too many argument. Please give only one logfile."
>>  	test -r "$1" || die "cannot read $1 for replaying"
>>  	bisect_reset
>>  	while read git bisect command rev
>
> I mean:
>
> bisect_replay () {
> +	test "$#" -lt 1 && die "No logfile given"
> +	test "$#" -gt 1 && die "Too many argument. Please give only one logfile."
>  	test -r "$1" || die "cannot read $1 for replaying"
>  	bisect_reset
>  	while read git bisect command rev

That suggests that the original patch is buggy as well, in that it says
"No logfile given" when it gets two.

How about checking with 1 and saying "Give me only one logfile" and be
done with it?
