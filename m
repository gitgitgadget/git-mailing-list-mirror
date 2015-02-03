From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] apply: do not read from beyond a symbolic link
Date: Tue, 03 Feb 2015 12:31:58 -0800
Message-ID: <xmqqiofirb29.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-4-git-send-email-gitster@pobox.com>
	<CAGZ79kbE2frDRgXkS0zGvufR1GP15wjgf9t49U87jPT83aTF0w@mail.gmail.com>
	<xmqq1tm6ss4z.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYkT_1cKgn8_JseHovnXoeO1Hi5FFPE9k7T6qDXLVY_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:32:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIk8n-0003if-K0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 21:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966639AbbBCUcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 15:32:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966353AbbBCUcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 15:32:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0DF34CA4;
	Tue,  3 Feb 2015 15:32:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6e/+pK9mL4zeS7uAOlAfSYZ5Ks=; b=FVcnYW
	39kQKwjYE1CRcN2RPODuq8TyeMdcpK0z4aQywFdiJ6xqOmczaMJgZ6F0D+RH4CYb
	yQ4g25Dz90w+HN6FH49TIW25WHAj5IHw1Z78dXMCmmJvQYsTQwwQeVIwysKENopq
	o8qQl1hkcT+vUGGssPTnOwQNFAZIianbwT+qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/WbkdbLLN6DLvOxqcBmWW8GjiEjfKZb
	RRxQiw6H/NghFC+pZCDodeKAdwsSsrQ6ejQFHE0HIx528sjocv+/+TV0KJG+Gpd7
	YpOVNfDsLKPwmB+4mBdmINYx5CFc7ZoQPXM3Uf2oBz87IuMZyiaqFK5/7xgpNxV/
	NUXok9SgsZQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0447D34CA3;
	Tue,  3 Feb 2015 15:32:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 696C134CA2;
	Tue,  3 Feb 2015 15:31:59 -0500 (EST)
In-Reply-To: <CAGZ79kYkT_1cKgn8_JseHovnXoeO1Hi5FFPE9k7T6qDXLVY_FA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 Feb 2015 11:44:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B409982A-ABE3-11E4-8176-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263331>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 3, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Mon, Feb 2, 2015 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +       test_must_fail git apply --index patch
>>>> +
>>>> +'
>>>
>>> Is the empty line between the last test_must_fail and the closing `'`
>>> intentional?
>>
>> I think I just mimicked the previous existing one, but I can go with
>> the version without.
>
> It was really a honest question. I've seen and written and sent
> tests without such an ending empty line and it seemed to be ok.

It was a honest answer, too.

I see existing new-style tests [*1*] that have and/or lack the empty
line at the end of the command, and I do not have particular
preference either way.  Having these variations did not bother me
too much, at least until now.  We might want to make them consistent,
and the time to be careful is when we add new tests, so it was very
valid for you to bring it up against this patch.  But I do not know
if we as the Git developer community have preference either way, and
I myself don't either, so...


[Footnote]

*1* The really ancient style we want to clean-up goes like

        cmd for setup > expect
        
        test_expect_success \
                'title of the test' \
                'command && more command &&
                 yet more command > actual &&
                 test_cmp expect actual'

        cmd for cleanup

    and we want them to read more like

        test_expect_success 'title of the test' '
                test_when_finished "cmd for cleanup" &&
                cmd for setup >expect &&
                command &&
                more command &&
                yet more command >actual &&
                test_cmp expect actual
        '
