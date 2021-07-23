Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38EC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7748C60F38
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhGWS4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:56:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:56:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E26B913A5C8;
        Fri, 23 Jul 2021 15:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cgb2GcIgaNc/
        vNATo2ZhhAazs4O65IL3Dki01xz9toQ=; b=x4XShxmoOUUIBpzNKmFUNm3PLMR8
        4DmCOBri0QQ0VWMJ3X+j0QA6C9mtpdkRSZSsNVgF53z0iM2g8aCXSX9FBjuEz7Vg
        1vsHA99fz+fto1A61mSflh4lhBRUZ5tB81TJHRrYkTKD7UoOppqxxJufCHu63/t8
        dT66+XdDV+JMpwc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB3FB13A5C6;
        Fri, 23 Jul 2021 15:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E70F13A5B9;
        Fri, 23 Jul 2021 15:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Santos <hello@brighterdan.com>
Cc:     git@vger.kernel.org
Subject: Re: Git show only showing ASCII chars problem
References: <924b70af-1e55-0944-0f45-ab28cff1e98d@brighterdan.com>
Date:   Fri, 23 Jul 2021 12:37:00 -0700
In-Reply-To: <924b70af-1e55-0944-0f45-ab28cff1e98d@brighterdan.com> (Daniel
        Santos's message of "Fri, 23 Jul 2021 18:20:34 +0100")
Message-ID: <xmqqfsw4n7oj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A70F88E-EBED-11EB-BDE8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Santos <hello@brighterdan.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue=
)
> git show

Thanks for a report, but sorry, it is *not* "steps to reproduce your
issue", as people who do not have the commit you have trouble with
checked out would not see your issue reproduced by typing "git
show".  Something like this:

    $ mkdir newdir; cd newdir; git init
    $ echo '=C3=A7 =C3=A3 =C3=B5' >file; git add file
    $ git commit -m "add file with non-ascii contents"
    $ git show

may be detailed enough for people to try reproducing what I see
(i.e. creation of a single-line file is shown with its non-ascii
contents).

By the way, if the problem is that your pathnames in the patch are
protected from corruption by quoting, perhaps

    $ git config --global core.quotepath false

may be what you are looking for.  I couldn't tell from your report
if that is the case, though.

Thanks.

