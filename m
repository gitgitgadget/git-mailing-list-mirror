Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3598F20195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcGOR26 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:28:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbcGOR24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 13:28:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 730082C745;
	Fri, 15 Jul 2016 13:28:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dkkiYvDey+D9
	vLopXQt68STN+i4=; b=C7sMZDLaLEjT8snJW9dH//+5/Xl54k+n0crq8t0pEF0u
	xM1i0ljCLc2EHDwS2l/nrtU5iiLHXkdJteo7LVsrVKtL+9UKS2saEgdjnv1WydPY
	68fvgfbn/Aj9BFiog9Ajz1fVkup7H/r+Sxy1CywGxQIAGLpQvJBnMiw0d1mvMHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oi3wu8
	5EoXseLze6ZR/MhNOg29qFJTosqhvowtTOlN19R9Ms6A5P+qLJsHxh1uswr5JThY
	JNxaH8Svmp59TdgoIWEX0NTaSKovRHbXyaEAbwdmKL65YtioE2tUpEb+JujjCpb/
	tzahyfaFiMTidboycsIy7F1CcvfVoc0oBrEBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A29A2C744;
	Fri, 15 Jul 2016 13:28:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4A252C743;
	Fri, 15 Jul 2016 13:28:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andrew Keller <andrew@kellerfarm.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
	<xmqq1t2uomw3.fsf@gitster.mtv.corp.google.com>
	<B3E20AFF-7661-43A0-A715-F0B9F3CD58DC@kellerfarm.com>
Date:	Fri, 15 Jul 2016 10:28:52 -0700
In-Reply-To: <B3E20AFF-7661-43A0-A715-F0B9F3CD58DC@kellerfarm.com> (Andrew
	Keller's message of "Fri, 15 Jul 2016 13:20:28 -0400")
Message-ID: <xmqqshvan73f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9AE14AC8-4AB1-11E6-9149-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andrew Keller <andrew@kellerfarm.com> writes:

> On 15.07.2016, at 1:02 nachm., Junio C Hamano <gitster@pobox.com> wrote:
>
>> Expected outcome is an error saying "do not modify the index inside
>> pre-commit hook", and a rejection.  It was meant as a verification
>> mechansim (hence it can be bypassed with --no-verify), not as a way
>> to make changes that the user didn't tell "git commit" to make.
>
> Ah!  Good to know, then.  I’ll rewrite my hook to behave more correctly.

No problem.

>> It is just the implementation that dates back to the old days were
>> too trusting that all users would behave (with its own definition of
>> "behaving well", which may or may not match your expectation), did
>> not anticipate that people would try to muck with the contents being
>> commited in the hook, and did not implement such verification.

Earlier you said you are working on a patch series.  Since you have
already looked at the codepath already, perhaps you may want to try
a patch series to add the missing error-return instead, if you are
interested?

Thanks.
