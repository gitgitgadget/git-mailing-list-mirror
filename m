From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Wed, 14 Jan 2015 09:31:06 -0800
Message-ID: <xmqqbnm1b76t.fsf@gitster.dls.corp.google.com>
References: <54B5579B.4080607@kdbg.org> <20150113214733.GA16582@peff.net>
	<54B59D24.7030508@kdbg.org> <20150113223849.GA3144@peff.net>
	<xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
	<20150114112659.GA23474@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRmm-0005E9-2J
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbbANRbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:31:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbbANRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:31:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6AF2B95B;
	Wed, 14 Jan 2015 12:31:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ed2MQyrCLDVIkm4cIsESlj2kPpA=; b=JiwQNE
	0rIystIjk0BQxww32+TDlPNbHlWmPGA4e+Jf0mnf03Q+E3QQu32tIiBXqDPW70Jg
	1hr7cDTFYLRLHLFrqIxqqMBF29jtakcDLE30oxRW7+ghksvTU/BLz08HbIOsVemb
	L0YLMGAYVvx74qQMf4YUbAJq5qGtMNusPDs6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qq/5hp+tDUGV2qbi6CDEHNhTTg/4BKal
	wn7TigoyUF1atQfPGdz7Zjme9Gpjrn1VDkaoTe5XEDfP86Vusy6C216fEGOO796M
	SsvfRd/9nPyeTwo/tv7xkxBUzy5KeLlg8bPxkSc2Gv5UZpa+8xmaX8Z76XXnaEYb
	6INJQJ3/pOE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73E872B95A;
	Wed, 14 Jan 2015 12:31:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EF3E2B959;
	Wed, 14 Jan 2015 12:31:07 -0500 (EST)
In-Reply-To: <20150114112659.GA23474@peff.net> (Jeff King's message of "Wed,
	14 Jan 2015 06:27:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F9C618E-9C13-11E4-BEEF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262395>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 13, 2015 at 03:40:10PM -0800, Junio C Hamano wrote:
>
>> >> -	test-genrandom seed2 2500000 >huge &&
>> >> +	printf "\0%2500000s" Y >huge &&
>> [...]
>> Are we depending on the binary-ness of these test files by the way?
>> The leading NUL \0 looked a bit strange to me.
>
> I don't think so. We do not want to do a text diff, because that would
> overflow our GIT_ALLOC_LIMIT. But the core.bigfilethreshold check is
> what will make them binary, not the actual content. So a gigantic text
> file is arguably a better test of the feature in question.

Perhaps.

The original used "dd seek" primarily so that we can logically have
large file without wasting diskspace, in addition to make sure that
the result would compress well.  The large printf will still waste
the diskspace, but disks are cheap enough to tolerate a hanful of
files of a few megabytes and you already made sure that the
compressibility is what matters more to the test latency, so I think
all is good.

Thanks.
