From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Tue, 03 May 2016 08:43:10 -0700
Message-ID: <xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
	<xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
	<6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:43:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcTr-00046N-PG
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 17:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbcECPnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 11:43:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755546AbcECPnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 11:43:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4157116E65;
	Tue,  3 May 2016 11:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GFg2li1oCwCPO5eE6fWeXCRYK1w=; b=F8+Fyq
	f3pvAycH0nYWgDK5hZW1xCoE1A0mwdKm4HcTI/vsJ8rR37R8jnsTZyP3/hRG7UOJ
	onphQCMwKz1avjUvouC90JtJ4a9NKXvXlvKDu1anDOpMf7nutHrK2F+o4b70IHcD
	IIZNbd9jFzicHPCQXq22+gxQBapJeAY81R+Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGmKmDEoPGx/EmdGxLMUuTYJf6vfLnzc
	Ira5EP2g4fGxln+VSFAMBfrAKldVXDG4nZSshq5caPvUmapPLnLDYt15viGYSOHt
	mF4/jN+421fwKvHtxZ+KTSHjM1/JVPGLPrmWePx26GnUZphhSQAbhFF2CtjKFKkP
	QRF9V8H/rIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37BE716E63;
	Tue,  3 May 2016 11:43:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B1C316E62;
	Tue,  3 May 2016 11:43:12 -0400 (EDT)
In-Reply-To: <6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com> (Lars
	Schneider's message of "Tue, 3 May 2016 10:12:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE6B10BE-1145-11E6-8761-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293404>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 02 May 2016, at 22:45, Junio C Hamano <gitster@pobox.com> wrote:
>
>> larsxschneider@gmail.com writes:
>> 
>>> +set -e
>>> +
>>> +LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
>>> +    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
>>> +    | sort -u \
>>> +)
>>> +
>>> +for LINK in $LINKS; do
>>> +    echo "Checking linkgit:$LINK..."
>>> +    test -s Documentation/$LINK.txt
>>> +done
>> 
>> Please separate the above link check out of this step and do so
>> separately after the move of test body to a separate script
>> settles.
>
> OK. I also wonder if the link check should rather go to the 
> "check-docs" Makefile target?

That sounds like a good direction.

Which in turn means that people on all platforms are welcome to run
it, which in turn means that the script must be even more portable,
with avoiding GNUism and bash-isms etc.
