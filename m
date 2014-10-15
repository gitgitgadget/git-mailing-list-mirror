From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools/meld: do not rely on the output of `meld --help`
Date: Wed, 15 Oct 2014 12:04:27 -0700
Message-ID: <xmqqoatdw3wk.fsf@gitster.dls.corp.google.com>
References: <1413361848-16923-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrey Novoseltsev <novoselt@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeTsB-0004cD-PE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 21:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaJOTEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 15:04:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbaJOTEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 15:04:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9385014806;
	Wed, 15 Oct 2014 15:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zRMX63kX1AriGFeqRGirs46f7q4=; b=kJEXeT
	NWN0U9OJgp2tkY2alyXcLbSpee7/lQiTEolY/nfFzlmZthdgq1hjfN9l3Nd/8RlR
	r85vXAnlnCb34/kZ12YgifBhnEoEACFnj0NKjBphMBP6O9jWas8VEl8BPYLCtBGs
	IpmPJKv2voDB+wvsFIUb4f4+4qGtO823PJwZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x7PEXDwS3wZl/x5dqFNKXc9S7mrGbTT2
	2xA8u/xKHM3goNJehaSo/WE/89UVZeGEGtCtKqMajoNNInvtylrV7Z4dUZRaC+Ac
	11RAZSLGMZh9ITyHme0C4VljlmCObGLJ61VjIdIHU/F3oNTqAVcLPOBqcTlvgZt0
	2bKd816hwuk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AEF614804;
	Wed, 15 Oct 2014 15:04:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA79214802;
	Wed, 15 Oct 2014 15:04:28 -0400 (EDT)
In-Reply-To: <1413361848-16923-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 15 Oct 2014 01:30:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16A939BA-549E-11E4-ADC2-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> We cannot rely on the output of `meld --help` when determining
> whether or not meld understands the --output option.
>
> Newer versions of meld print a generic help message that does not
> mention --output even though it is supported.

This obviously breaks those who have happily been using their
installed version of meld that understands and shows --output in the
help text.  Is that a minority that is rapidly diminishing?

I would understand it if the change were

 - a configuration tells us to use or not use --output; when it is
   set, then we do not try auto-detect by reading --help output

 - when that new configuration is not set, we keep the current code
   to read --help output, which may fail for recent meld but that is
   not a regression.

When versions of meld that support --output but do not mention it in
their --help text are overwhelming majority, we would want to flip
the fallback codepath from "read --help and decide" to "assume that
--output can be used", but I do not know if now is the time to do
so.
