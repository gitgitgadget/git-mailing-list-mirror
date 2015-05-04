From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Improve git-pull test coverage
Date: Mon, 04 May 2015 10:35:55 -0700
Message-ID: <xmqqlhh4tfd0.fsf@gitster.dls.corp.google.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<vpqoam0sqp5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 04 19:36:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKHr-0001IZ-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbEDRgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:36:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751870AbbEDRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:36:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B74AF4C32F;
	Mon,  4 May 2015 13:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/3JHCB9PSAMhsgOeyfaI8IfL2s=; b=Pl6G3T
	DYHWWS6tTNTyO7HFQ4urklCCw91br0XW67dFqFgIOX/xzt/eSbF7c6+DRv2i2Ddi
	iaPBc5Ar4xiZdJa+yAyctp1j3/YYepYsAdl2sFb20SU5ooNuwrUH5Cwn2bCkrBor
	dLOuuNVSTJOVeA0hnx1kKhMEQWLiD0sEXPFXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ip9ITHdFyHzf2fno6TZJFtxIcYjt66OQ
	+695LdCuJbI0eYTcDAuKI75GnHPTnYO8PWc4Ua+H10++rjOqOC25KT6xbyB/6Ogp
	GdDx6dROWR67Y54B2plK1kkCHiBc/ZflMfpp1YDNNv5nUz+IbP3pRfA8ym3WKqDi
	L2TzGheAfnQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF9484C32E;
	Mon,  4 May 2015 13:35:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F8EF4C32B;
	Mon,  4 May 2015 13:35:57 -0400 (EDT)
In-Reply-To: <vpqoam0sqp5.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	04 May 2015 10:16:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05984100-F284-11E4-AD01-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268333>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
>> Paul Tan (7):
>>   t5520: test pulling multiple branches into an empty repository
>>   t5520: implement tests for no merge candidates cases
>>   t5520: test for failure if index has unresolved entries
>>   t5520: test work tree fast-forward when fetch updates head
>>   t5520: test --rebase with multiple branches
>>   t5520: test --rebase failure on unborn branch with index
>>   t5521: test --dry-run does not make any changes
>
> I did a semi-thourough review of the whole series, it looks good to me.

Thanks. I did the same, and it looked OK.

One test was duplicated with jc/merge series and caused a textual
conflict, but that was nothing major.

I didn't like the grepping of error messages alone as a way to
diagnose the failure, though.  When we expect the pull to fail
without touching anything in the working tree, I'd prefer to see
that tested explicitly (e.g. "if pull mistakenly tried to go ahead
and touch this file that would be involved in the merge, its
contents would change---let's make sure that does not happen by
making sure the contents before and after are the same" kind of
thing).
