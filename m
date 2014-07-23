From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] add a test for semantic errors in config files
Date: Wed, 23 Jul 2014 15:11:05 -0700
Message-ID: <xmqq38drd8ue.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-4-git-send-email-tanayabh@gmail.com>
	<vpq38drvohr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4ko-0000F4-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 00:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737AbaGWWLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 18:11:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52527 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933651AbaGWWLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FC272BC05;
	Wed, 23 Jul 2014 18:11:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TJFrmFtxJhQ2bn5gWUdCz+7Cbcg=; b=ZNYNAw
	Mh1iIj3M4yz9/wCtRgFBridT+WvFoIpi3igEtQa0lJ06vLPEbF8hF0RCh/LQuuTu
	WLWhI9ZBPfRXtQ1wC8qm+j8r77HNY5oHeqEPajNgQ0GTPjN7VXWLXMXsVC8L4yns
	Ro7q6qT524zhpH7Ugl/7fdNByRz2/RoK85gHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVHylUyyd5nqoZdd54hJzO4NlSSqFS1v
	TPoIG6fTYzRAjs6z96UP1uXDcMV6/kc5yzrd8Z7VPHQHJd2v9Cmoa3vbKF2EsiY/
	UgLtTxbnvYGGufpeD78jiWEsf87vf2rxEJ+/4gb+vLJ1zBiL/iAskXpkKl647jXS
	omRUsVYv30g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1568D2BC04;
	Wed, 23 Jul 2014 18:11:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 763682BBFB;
	Wed, 23 Jul 2014 18:11:06 -0400 (EDT)
In-Reply-To: <vpq38drvohr.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	23 Jul 2014 21:55:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E350A06-12B6-11E4-B6DC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254133>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> +test_expect_success 'check line errors for malformed values' '
>> +	cp .git/config .git/config.old &&

Should this be "mv" not "cp"?  You will be overwriting the file from
scratch in the later part of this test.

>> +	test_when_finished "mv .git/config.old .git/config" &&
>> +	echo "[alias]\n br" >.git/config &&

Is the use of \n portable?

> Another option is to mark the test as test_expect_failure when you
> introduce it, and change it to test_expect_success when you fix it
> (probably not applicable here, but it's a trick I find elegant).

Yes, I agree that it is a good practice to document an existing
breakage in an early patch #1, and then make a fix and flip
expect-failure to expect-success in the patch #2.

Breaking the code and documenting the breakage by expecting a
failure in one patch, and then later fixing the breakage and
flipping the expectation in another patch, is a bit less nice,
though ;-)
