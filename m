From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Thu, 24 Mar 2016 23:28:23 -0700
Message-ID: <xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:28:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLEW-0002SR-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbcCYG21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:28:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751809AbcCYG21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:28:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98D46494E7;
	Fri, 25 Mar 2016 02:28:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N4J1JfJi8i43OsNN3dVIwnA7dYQ=; b=eOcDB7
	hDq4RGm3dq3ncsmZbKjxfeWpt8OBMimqiuoQy9YVvoHykfEt+VwKeZ65GYWv+dtS
	U+E3C8n/eOCYKZsPgJyOphwgQA7lb70kZia+SOZe9DApqP+mu+hACPqwWPm5LjyX
	OiCPmW85amC9o0Lj1tepV+mDNIlNNqyQhyXoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RrYEnCrJy2JESllDxDbpXiqB9xcxx33S
	8+F2g8vpa02t3k8kKODXafaoI0+979xiGs5f/qzMXi1TtL0n4/pWTI988Dk1OPXh
	ItNjWfeHNh2GED6QEN9U0IW6sJaaUPrqWB7yISZW5FayZs2ZfLb9I3JPCtOXIAKL
	hthLb9/MmrI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FDD8494E5;
	Fri, 25 Mar 2016 02:28:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E3EF494E3;
	Fri, 25 Mar 2016 02:28:24 -0400 (EDT)
In-Reply-To: <1458862468-12460-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 24 Mar 2016 16:34:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C75DB558-F252-11E5-A4D6-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289853>

Stefan Beller <sbeller@google.com> writes:

> The usual early machinery of Git is to change the directory to
> the top level of the working tree and pass the actual path inside
> the working tree as `prefix` to the command being run.
>
> This is the case both for commands written in C (where the
> prefix is passed into the command in a function parameter) as
> well as in git-submodule.sh where the setup code runs...
>
> Adhere to Gits standard of passing the relative path inside the
> working tree by passing it via -C.

While -C _also_ works, I do not think it is "standard" in any sense.
What made you think so?  -C is a way to tell Git to chdir there
before doing anything else, without even adjusting the command line
arguments that might be paths, and "chdir there to go to top" may
(or may not--I haven't thought things thru) have the same effect as
passing the prefix into functions, that is merely true as a side
effect, I would think.

So this change may not be wrong per-se, but if the lossage of prefix
is the final goal (as opposed to an approach to gain other benefits,
e.g. "now we do not have to use prefix, we can simplify these other
things"), I do not know if it is worth it.
