From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 00:39:14 -0700
Message-ID: <7vaazl8acd.fsf@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
 <7v63a9n5i6.fsf@alter.siamese.dyndns.org> <4ADEA93E.7060907@viscovery.net>
 <7vzl7l8b1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0VnD-00025M-KY
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbZJUHj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbZJUHjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:39:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbZJUHjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:39:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B99661250;
	Wed, 21 Oct 2009 03:39:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bZPSiVU+Mtfeseyoy+RV7dYTxc0=; b=xYMjbL
	pBgzgz0rDAc0wZsLP9WItEtyYivEHlaeKm55J6A5l/LxILdLUBvaWHqpJk3I9y1x
	TVjN2IHl+9HIPs5AwHqLoD1plXrHQ4Xo7egEDNQq9eUYmyZ7L+NfLzpUD1ae7qcw
	aaL3PNw7clJ3kNpeTojeRuEmawkRmpNPC3cac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwYYUY8Wdn6BP/W5qv+21MziOiStft+B
	kL/Nv7PK6tnTRWoMQKmCVJNUWN5BsB8LWulb6ALFn2us4Szgo6neU9uAXlvkMIbK
	nCEAha7hCMJFevftFzTlto54AnoQFerQ6L4FWKELxvsSbvCDKER/jxjsSvSh6ePQ
	XjBCu/oCKqw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10EF661248;
	Wed, 21 Oct 2009 03:39:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9C5161246; Wed, 21 Oct
 2009 03:39:15 -0400 (EDT)
In-Reply-To: <7vzl7l8b1y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Oct 2009 00\:23\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9C6C14A-BE14-11DE-BE58-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130893>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Junio C Hamano schrieb:
>>> +		if (auto_gc) {
>>> +			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
>>> +			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>
>> Am I correct that this will produce progress output? If git-daemon runs
>> receive-pack, then this output will go to the syslog. Do we care?
>
> We do, and we don't want that.  Thanks for spotting.
>
> Would adding "--quiet" to the mix be enough?

Actually I don't know.  This originally came from "we _could_ add gc and
update-server-info to hundreds of post-receive hooks, but any repository
hosting site that holds many central repositories will exactly have the
same issue, so why not do this internally", so it may make sense to do
exactly the same thing as what we do to the output from hooks.  What do we
do to them now?  stdout-to-stderr?
