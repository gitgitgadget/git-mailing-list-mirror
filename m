From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-send-email: add --transfer-encoding option
Date: Tue, 25 Nov 2014 15:37:32 -0800
Message-ID: <xmqq7fyisvgj.fsf@gitster.dls.corp.google.com>
References: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
	<1416924027-29862-3-git-send-email-bonzini@gnu.org>
	<CAPig+cQ_jm1W3n7KqrRihuj7ie=wGTRMupyAnfLHXqFAAnhv4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paolo Bonzini <bonzini@gnu.org>, Git List <git@vger.kernel.org>,
	lersek@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 00:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtPfw-0007wD-UG
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 00:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaKYXhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 18:37:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751712AbaKYXhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 18:37:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1112E20E16;
	Tue, 25 Nov 2014 18:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V7O0LiYTkefb9rApKmjHE8KBbAI=; b=u/UTXq
	31iPaXIp570yBeHGbY5Yev6LDxunu9YoeiX2KJhbnN48hD83qZYEZ7uqhO27S7EX
	QXz/q5mZF1Rzm59KEyXBVUBhRhalpAs/WH4oQBhsgOgR4WXJkkbLUMIbNPFDhhlt
	KkyuqkTbB5EBb1Z+ursni533eSr64rvExtq5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/9vvpBBrTLJlHrK9jqo0otbeiyxNUWN
	dKGz5f1pJViwp55exQLzyQOwRtxaNB+gg792+d1L3+crEMO4YwGxilBXU4JeHufM
	OZWnRgsZPmrsozsSk3cPA0pB9UDujTEsgVRXwn9jlO0VwdmXDiX/C0ualZejsJdI
	xCTcrtNuDLU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 082C420E15;
	Tue, 25 Nov 2014 18:37:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8211120E14;
	Tue, 25 Nov 2014 18:37:33 -0500 (EST)
In-Reply-To: <CAPig+cQ_jm1W3n7KqrRihuj7ie=wGTRMupyAnfLHXqFAAnhv4Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 25 Nov 2014 15:44:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 079A9634-74FC-11E4-92AB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260252>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_success $PREREQ 'sendemail.transferencoding=7bit fails on 8bit data' '
>> +       clean_fake_sendmail &&
>> +       git config sendemail.transferEncoding 7bit &&
>
> test_config here and elsewhere perhaps?
> ...
>
>> +       test_must_fail git send-email \
>> +         --transfer-encoding=7bit \
>
> Redundant 7bit request.
>
>> +         --smtp-server="$(pwd)/fake.sendmail" \
>> +         email-using-8bit \
>> +         2>errors >out &&
>> +       grep "cannot send message as 7bit" errors &&
>> +       test -z "$(ls msgtxt*)"
>> +'
>> +
>> +test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEncoding' '
>> +       clean_fake_sendmail &&
>> +       git config sendemail.transferEncoding 8bit
>
> Broken &&-chain.

Thanks for a careful reading ;-).

The original before this patch is written in old 2005 style, which
makes it rather hard to read and add new tests to mimick the
existing tests.  Perhaps we would need to clean it up at some point,
probably after the dust settles after this series is done.
