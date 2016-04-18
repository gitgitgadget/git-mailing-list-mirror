From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 15:24:13 -0700
Message-ID: <xmqq7ffu4ktu.fsf@gitster.mtv.corp.google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<CA+P7+xrisA0qqQ01GoSUdNm+O85NN9H7arovzqDD2e5GUv2GAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:24:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asHal-0002x5-4L
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcDRWYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 18:24:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752019AbcDRWYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 18:24:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA92115BF3;
	Mon, 18 Apr 2016 18:24:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BYHjeg+Rh23qYVvkufcKuyi+AdE=; b=fAYjns
	qP6MuW2ppZFQcwQIIMjIrHFpIk36oNQ4v0X8TZaAZU/I3W7xmXGWyvmlSNOsjR/S
	rgh9EMYa6KTsJRgLHS9g9xm6EjvaTiIvb1mHxpQ8d7ySmwlvQKqguT6kQIRBY3aE
	+KGGObHP7hYXGzDzX+09+cPfKm6tdHZ15YR0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9go22B20H6LR3G/69AIO2EoCXjUrEUg
	Dh76OMNaXypZaXap2mIEKBPx8mg8V4BclSZtkmf3SaovnIN3MTxExjItJpVeLhUN
	Rw1I50zP0HdklezHkOGlYoXN6kaTZkj3FtM16DkRv/+yeRqFO4qmJUzHUFb9ac4p
	epUX9C3uVnw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C12FD15BF2;
	Mon, 18 Apr 2016 18:24:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C2C615BF1;
	Mon, 18 Apr 2016 18:24:15 -0400 (EDT)
In-Reply-To: <CA+P7+xrisA0qqQ01GoSUdNm+O85NN9H7arovzqDD2e5GUv2GAw@mail.gmail.com>
	(Jacob Keller's message of "Mon, 18 Apr 2016 15:04:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 489DAFBE-05B4-11E6-9CB9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291833>

Jacob Keller <jacob.keller@gmail.com> writes:

> Thanks Stephan and Junio, this looks pretty good. I think before it's
> merged we'd probably want to implement some sort of attributes which
> allows per-path configuration, incase it needs to be configured at
> all.

My take on it is that we'd want to make sure that the shift with
blank line heuristics is "good enough", i.e. there is no need for
end-user configuration or attributes, and then remove the tentative
option, configuration and its documentation, before this is merged.

If we really want to add knobs to handle different kind of payloads
in vastly different way, the right place to do so is to add a set of
bits "use this and that heuristics" to userdiff driver, I would say,
but in the compaction codepath it does not seem to be enough room to
have that many knobs to be tweaked in the first place to me.

> I've got it applied to my local git, and I'm going to try to run a
> diff between enabled vs disabled on a large section of the Linux
> kernel history and a few other projects to see if I spot anything odd.

Thanks.
