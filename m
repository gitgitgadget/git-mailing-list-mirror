From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 11:43:12 -0700
Message-ID: <xmqqd1ol3ku7.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbHW+qzQjoVu9gRYC0FBqpkq5bPPLU3=BdEFKeGc=U6sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 20:43:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2NUD-0004zJ-W2
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbcEPSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:43:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753561AbcEPSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EECA01CE03;
	Mon, 16 May 2016 14:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65EExlWljQCOq7cGqM0Zc0q4/TM=; b=o07C/f
	0AFkJ+v5rL0fjP2nwYjNnQ06zC/pdeOfrH+QPFM+EbiLvrOU3oe1kX+Axqs6Njku
	tnozmWN3Nczr+i7m7P4vC9lx7xLfKrea14tbvoy0phyVTu3qR61/NodlJaG+VOag
	fnRnlnZEYvhy2qfSImNRSgOuhs7wEBgvU+Z80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hw0FTUkfE+yp559ftB4CL4FgxJqcKlxg
	1pcA/NFEo3rLMZfmXWdWric938nGfwhxs8XcMuPK6PvmjMFrgWuHxErP4SFwXB7O
	d/6KS5re1KGwFnZhsCk6PDQmtSIZAKxWImlKuU8DoS9agKS+785lS5lM6yejKpix
	zyCJXBSSpYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E58D51CE02;
	Mon, 16 May 2016 14:43:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62EFB1CE01;
	Mon, 16 May 2016 14:43:14 -0400 (EDT)
In-Reply-To: <CAGZ79kbHW+qzQjoVu9gRYC0FBqpkq5bPPLU3=BdEFKeGc=U6sA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 10:55:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C2F373A-1B96-11E6-B6CC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294775>

Stefan Beller <sbeller@google.com> writes:

>> I am NOT suggesting to make this enhancement in the prototype to
>> allow us experiment with submodule selection use case, but this is
>> an obvious place to allow
>>
>>         :(label=A B):(label=C D)
>>
>> to mean ((A & B) | (C & D)) by making item->labels an array of set
>> of labels.
>
> This is what already works with the series. Or rather:
>
>     ":(label=A B)" ":(label=C D)"
>
> works as you would expect for (A&B) | (C&D).

That is "duplicationg path".  I was envisioning a single

	":(label=A B):(label=C D)tediously/long/path/because/java/"

a shorter and sweeter way to say your two pathspec variant, i.e.

	":(label=A B)tediously/long/path/because/java/" \
        ":(label=C D)tediously/long/path/because/java/"
