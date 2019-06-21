Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C485F1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 15:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFUPQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 11:16:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62087 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 11:16:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5EB616C6C6;
        Fri, 21 Jun 2019 11:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cn3D4YEATQ62
        qv7VVvXuyvKcZnA=; b=nOrv60UJT5PdPwv+XU2bkx2IOI0oGM0omHbFde3wrYQL
        WiiqNcli1qhIg0ItOjtVmZD4v6JXUckxldqvg9K6k7JKQV6zXl0rI+dcizqnVtbG
        IGtY8dSkqZotD9XzW63DjkipSBxgG8ZrRx+IIlKleaX9tm/eJdyjWw4xO/wz25Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bHtM84
        kHm3uzFYiSh1LFns+/h2IT5JJ5q+b3P2EXgG756ofzC/ZDd7mMDdAy+D5rmPAqwp
        nQfjD4e0juf4ns5PyWPmGszu9sWHWyFCiDkISKWw0LciH7IyTkO3Y+oP5Sd5qVSF
        QWdqZ+Ag0Qh07b+Wp+ELxBgYYkK2SLMaJG8Sk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EB3C16C6C5;
        Fri, 21 Jun 2019 11:16:08 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12EFD16C6C4;
        Fri, 21 Jun 2019 11:16:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     "Boettger\, Heiko" <Heiko.Boettger@karlstorz.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: specifying revision - how to enforce matching a tag/branch-name or revision only
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
        <87sgs3rhpo.fsf@kyleam.com>
Date:   Fri, 21 Jun 2019 08:16:06 -0700
In-Reply-To: <87sgs3rhpo.fsf@kyleam.com> (Kyle Meyer's message of "Thu, 20 Jun
        2019 18:54:11 -0400")
Message-ID: <xmqq8stvklzd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EAE1E62-9437-11E9-910B-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

>> git rev-parse "${BRANCH_NAME}"=C2=A0 || git rev-parse "refs/remotes/${=
UPSTREAM}/${BRANCH_NAME}"
>>
>> Unfortunately somebody used the branch name "add-gcc10" and `git rev-p=
arse` which didn't exist on one repository. However `git rev-parse`
>> also supports to parse the `git-describe` format which resulted in che=
ckout a commit starting with "cc10".
>
> Can't you prepend "refs/heads/" to BRANCH_NAME to disambiguate?

Yes, that is the kosher way for most commands. =20

It gets a bit tricky for "checkout <branch-or-committish>" that
changes its behaviour (a local branch is checked out and the next
commit extends it, other committishes like tags and remote-tracking
branch tips are checked out on a detached HEAD), and has special
rules for a "${BRANCH_NAME}" that is both the name of a local branch
and something else.

Hopefully (Duy Cc'ed) "git switch" would improve the situation.
