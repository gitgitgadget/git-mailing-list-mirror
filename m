From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 04 Sep 2012 11:47:17 -0700
Message-ID: <7vobllaami.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
 <7vpq64f935.fsf@alter.siamese.dyndns.org>
 <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
 <7v1uijexor.fsf@alter.siamese.dyndns.org>
 <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de>
 <7vzk55bu8s.fsf@alter.siamese.dyndns.org>
 <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de>
 <7vwr09abim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:47:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8y9n-000384-TE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab2IDSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:47:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494Ab2IDSrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:47:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F1D980C;
	Tue,  4 Sep 2012 14:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UaVfrNlca2000bD3R9Br1lC9Rdw=; b=VyNZN8
	dH+DT1uTAUxwvcijvWt65TW89NPpd7Q5X6W30DeGzBL4X7GNKJ5gOSECpEDLizRj
	JQpbyR6oIYm9phcJIJJNkHAwa6WaB7sO88HwB4gx+mcmkG2GTBAghPMHLO52q2c4
	zd0ZUQxqkFA4xWbenkqxPYOEePe8/1ZbZBxQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RxgiqsDhBzAD7LNVffA/Zuei5kL/7WaL
	D2V24brLdWRA9v+IrhwCsHMem6sNsE/9Bx2wjWeTG9ns2cuCyBX1v43dN7CqTQiP
	Ts8PmGuZ4Hw1OGlDk0Rqrm8/jBDd3xGYxpVOTay7HQTtBqhV4zAjOGKmVntdRQ3p
	IB03TaxzxNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09B4980B;
	Tue,  4 Sep 2012 14:47:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED43A980A; Tue,  4 Sep 2012
 14:47:18 -0400 (EDT)
In-Reply-To: <7vwr09abim.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 04 Sep 2012 11:28:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F43FAC8E-F6C0-11E1-989F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204763>

Junio C Hamano <gitster@pobox.com> writes:

> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>
>>> Only with the observation of "clone", I cannot tell if your timer is
>>> working.  You can try repacking the test repository you created by
>>> your earlier "git clone" with "git repack -a -d -f" and see what
>>> happens.
>>
>> It does update the counter too.
>
> Yeah, that was not a very good way to diagnose it.
>
> You see the progress from pack-objects (which is the underlying
> machinery "git repack" uses) only because it knows how many objects
> it is going to pack, and it updates the progress meter for every
> per-cent progress it makes, without any help from the timer
> interrupt.

I think the "Counting objects: $number" phase is purely driven by
the timer, as there is no way to say "we are done X per-cent so
far".

Doesn't your repack show "Counting objects: " with a number once,
pause forever and then show "Counting objects: $number, done."?
