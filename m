From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 13:37:39 -0700
Message-ID: <7vhag3v59o.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwefc-0004RV-5r
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3GIUhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:37:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab3GIUhv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:37:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4052F798;
	Tue,  9 Jul 2013 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lKR0NjAI4X3nYLx3sP4GvLU/9Uo=; b=adA28T
	bAJDeSO7vFRnLFYjutMkA7ase+Mwf4+oIfNOM2an+Joz6b9wceSivxB2OGWyYi8T
	eI2C9MxnhZCrscj3+f24rvVYy355cW0OezW38tXyoYREXgWlRadf8WmgOOnJYhOI
	aLh2HV2OVkMHBc6SV2j6bc3CwKFaAHne3jFXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dU2wcg4xIzD3M1FeCAri8OUBS3CbdOvB
	xmdVPKIQZOHbOZ6WszRJR13uN2TqHBieX/FlBGGhks28EBrk4qb4pP+rrqPUeiex
	5RnJfQkMFtZYU/Rc++DsFjT0c8LPyNv4e06bEEZ7LHuw8MLA8nkeMO8dulA25Dqh
	YCkAgEnlY6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1470F2F797;
	Tue,  9 Jul 2013 20:37:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B66F2F794;
	Tue,  9 Jul 2013 20:37:50 +0000 (UTC)
In-Reply-To: <51DC7199.2050302@kdbg.org> (Johannes Sixt's message of "Tue, 09
	Jul 2013 22:24:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C24596C-E8D7-11E2-A219-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230003>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.07.2013 21:53, schrieb Junio C Hamano:
>> +--lockref::
>> +--lockref=<refname>::
>> +--lockref=<refname>:<expect>::
>> ...
>> +This is meant to make `--force` safer to use.
>
> This is a contradiction. "--force" means "I mean it, dude", and not "I
> mean it sometimes". It would make sense if this sentence were "This is
> meant to make `+refspec` safer to use."

No, this *IS* making --force safer by letting you to say in addition
to --force alone which is blind, add --lockref to defeat it.

I do not see any good reason to change the samentics of "+refspec"
for something like this.  "+refspec" and "--force refspec" have
meant the same thing forever.  If --lockref adds safety to +refspec,
the same safety should apply to "--force refspec".

> Do you intend to require users to opt in to safety by saying --lockref
> until the end of time?

For normal users this is *NOT* necessary.  I do not know where
people are getting the idea of making it default.

Rewinding a branch, needing to --force, is an exceptional case.

> Which makes it actually usable only for scripts
> and aliases. How do you override when the safety triggers, e.g., in an
> alias that uses --force --lockref?

The original request for this feature did come from script writers,
who want to spin

	until
                git fetch &&
                ... magic integrate of the ongoing work ... &&
                git push --lockref
	do
        	: spin
	done
