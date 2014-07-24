From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 12:20:24 -0700
Message-ID: <xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>
	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAOZC-0007q0-UF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934078AbaGXTUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 15:20:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56124 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195AbaGXTUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 15:20:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4F802A0C0;
	Thu, 24 Jul 2014 15:20:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=435Ux7RaQiN3EBPFFKEttVPGYEo=; b=gY8KNv
	Cqo8lZ1EWIATSSKcB/D8MW8wf/z09XkEJjLUTiCLBVKrLY3zJR7MA+4wXS20bvjs
	ZfBnJgjH5cLWf15RvzJq925J4DfDXGzuAdHZpxoURxUV9Vm31jZCQ/i2InZcdSOo
	YMr6LqwaBJ7peT1W2humUsrSUq4bmak02Pghw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJFMGKgGd0llHSycry4K29w40F1yHMRR
	qK5GYaza/1zO6j63ESdJD8KAaFQHZUoHSVrBksyDdeLVWzdIqNMPEabXd3k3ZRFo
	1AFz1Am4Nib+HlO1G7W7TDJwCFga34/THSJXlXRqDgXpCugJXA4Qk1P05wHFpxKg
	1eiGoXjMZaM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA8352A0BD;
	Thu, 24 Jul 2014 15:20:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F7E62A09B;
	Thu, 24 Jul 2014 15:20:26 -0400 (EDT)
In-Reply-To: <vpqegxa386m.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	24 Jul 2014 20:47:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 90EE4062-1367-11E4-A4F1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254181>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> For core the only test failing was xfuncname vs funcname,
>
> Being a little pessimistic: there may be other cases where the hashtable
> magically gives the right order for existing tests, but that would fail
> for untested use-cases.
>
> But I can't think of any such case.
>
>> so the situation is not as bad as you think. One course of action
>> would be leave git_config() as it is, so that third party apps
>> may not be broken. Provide a function like git_config_cache(),
>> then rename all the git_config() calls in core to git_config_cache(),
>> fallback to git_config() where it is not applicable (for example,
>> git config -l).
>
> I think Junio's point about "git config -l" is correct: we should just
> keep git_config_raw there.

I have a slight preference of making git_config() do the right thing
and take advantage of caching behaviour, to be honest.  How much
extra effort is necessary in your code to carry a piece of
information, in addition to what lets you say "here are the values
associated with that key in the order we read from the files", in
order to be able to say "by the way, here is the order of key-value
pairs, if you want to show everything we read in the same order"?
If it would be excessive, using _raw() could be an easy way to punt,
but because we know it is easy to decide to punt, I'd like to see us
see if a real solution is feasible first before punting.

>> Also can you name any third party apps that use the git_config()
>> system on which I can test the patches.
>
> There are probably tons of. I can think of git-multimail.

This question does not really matter.

Among the various points, I actually think the last one you omitted
from your quote, closing door to one useful way to fix UI mistakes
in the future, is the most serious one.
