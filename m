From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Mon, 02 May 2011 10:37:52 -0700
Message-ID: <7vd3k1ngun.fsf@alter.siamese.dyndns.org>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com> <4DBEE672.5070707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 02 19:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGx4a-000863-DP
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab1EBRiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 13:38:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1EBRiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 13:38:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EB3F5685;
	Mon,  2 May 2011 13:40:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SHW6yAGPZ8hZ
	MKQC1TjLgBeboGA=; b=uBLm6qHDPG7CQSUc1qvzuUwvD9mbzqDwpzbkRDlmVa2q
	fJ2UYLhsez7Qi09YxwZgkMdWl+nwTgrkg7ZDh6QWX7djYcPMpAcHuTddbRDlU16R
	F3BplLQEFzhfsJ0774Qcv0aenO8vmlgb/PdYwr8rqh+PeMRbUzy0+jeXiCY22qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kkCrGQ
	5xzlfMpnnhv5wOcdLscDpJ6QZsWk1ZCtre/K00NRHFIekwOon/BQsqidcifKTrwS
	81jKMdPefKnXZs7i+iUl1UkyZhlSKId9NcPx2hZH6haaOF+7AnuCf/v4G7foSO57
	TteLoOdIDNhIO20ZCdDM0aAvn9cCsHw/HQ4j8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F9FA5684;
	Mon,  2 May 2011 13:40:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AAAEB5680; Mon,  2 May 2011
 13:39:57 -0400 (EDT)
In-Reply-To: <4DBEE672.5070707@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 02 May 2011 19:14:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37904E82-74E3-11E0-B3EC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172605>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> +	test_commit initial input "foo bar baz
=2E..
>> +	git grep --color -e foo --or \( -e bar --and --not -e baz \) |
=2E..
> The current code highlights the given search terms ("atoms").

Hmm, I was probably not paying attention to "coloring the parts that
matched" topic at all, but wouldn't it be easier and more efficient to
paint only "foo" without painting "bar baz"?  We know the first term "f=
oo"
matches, and the rest \(...\) that is --or'ed does not have to even be
evaluated, no?
