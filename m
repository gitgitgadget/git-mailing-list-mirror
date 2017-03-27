Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C677E1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 17:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdC0Q7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 12:59:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751403AbdC0Q7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 12:59:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E833C7EE2C;
        Mon, 27 Mar 2017 12:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fOCyz0tPTo1b
        IZA0OucEWTTyY+w=; b=WBCyR0fC1nDe93No1N1Zdy2pqlQDZchW2+MNTzhzOjCv
        zDBq8l6tltHpRHSfYFVmmCG1TU8BGJssMBRfD3H/3WiTrsdH1np6+fq4KwcjQhWl
        to7umi1qlELXn1gPjbidkrjR8nlQuUzW+wZUqnnLd93ehFj6ccpOFbg3MyEur2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qy2Cg1
        3DKgw1FrO01+/6aaeJFPRTQDM3qebusuLYMMbtJ1+zM7e25VU+ucVVFUBHGehUaK
        Ex3rGgu6m062M08O9F8fD4z3zokObAm8jIw0Y5RvemWDm+zagamrxbzhVAPyFiYE
        VoQdxMjYUs93717Zxu1lSJD/W4+99YvqRaC3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E02FB7EE2B;
        Mon, 27 Mar 2017 12:59:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B56A7EE2A;
        Mon, 27 Mar 2017 12:59:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Romuald Brunet <romuald@chivil.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: allow atomic flag via configuration
References: <1490375874.745.227.camel@locke.gandi.net>
        <CACBZZX7HAg89htqPgkFd+ks-E7fcgAWfQ9n9qRj-YM88tj3t-A@mail.gmail.com>
Date:   Mon, 27 Mar 2017 09:59:31 -0700
In-Reply-To: <CACBZZX7HAg89htqPgkFd+ks-E7fcgAWfQ9n9qRj-YM88tj3t-A@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 27 Mar
 2017 11:33:05
        +0200")
Message-ID: <xmqq7f3a3bbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0349BEC-130E-11E7-A051-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Mar 24, 2017 at 6:17 PM, Romuald Brunet <romuald@chivil.com> wr=
ote:
>> +test_expect_success 'atomic option possible via git-config' '
>> +       # prepare the repo
>> +       mk_repo_pair &&
>> +       (
>> +               cd workbench &&
>> +               test_commit one &&
>> +               git checkout -b second master &&
>> +               test_commit two &&
>> +               git push --mirror up
>> +       ) &&
>> +       # a third party modifies the server side:
>> +       (
>> +               cd upstream &&
>> +               git checkout second &&
>> +               git tag test_tag second
>> +       ) &&
>> +       # see if we can now push both branches.
>> +       (
>> +               cd workbench &&
>> +               git config push.atomic true &&
>> +               git checkout master &&
>> +               test_commit three &&
>> +               git checkout second &&
>> +               test_commit four &&
>> +               git tag test_tag &&
>> +               test_must_fail git push --tags up master second
>> +       ) &&
>> +       test_refs master HEAD@{3} &&
>> +       test_refs second HEAD@{1}
>> +'
>> +
>
> Sent my earlier E-Mail too soon, so I missed this, there's no test
> here for what "git config push.atomic false" && "git push --atomic"
> does, is that atomic or not? I.e. what does "git -c push.atomic=3Dfalse
> push --atomic" do? Does the CLI option override the config as it
> should?

Good points.  Thanks for reading and reviewing the tests carefully.

