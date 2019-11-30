Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A38C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB102073C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FlmspWMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfK3RAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:00:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:00:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C03AB89C72;
        Sat, 30 Nov 2019 12:00:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PuViafyIOG2VOB52d+ahYSQWi4g=; b=FlmspW
        MZfjPTXDVrvfnc/0pLHGXOMoYghOwW0FDOUpl+EmUzlNEmFDpmPiViDZybPpfWou
        AJCAF5gd6oc5pi/53wGJqzVHUSjbgxGut3g6sjO8vGz/4fLTDanA1ja1NTLWf5IL
        Np3LTA1V9suSrvWi7ENnfbhCUhejMUzOLa13Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xNR1SmjzDmWk8H+Qo0Nx0zAcYjyDzsYi
        lRIR1wKX3RW1CwH+ww19BF40cymvoTRfNu0m2JYkxGnWU1dur9CQ4HUQ+9wgJhGM
        sDaeapmJTHviDSQxeSkqkbjUk4Nnqj/vz3kf/4sRfTJgAqcBQmQoY4L2Ku8REAQp
        tCOA/BSRNBA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7E1989C71;
        Sat, 30 Nov 2019 12:00:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7ACFA89C70;
        Sat, 30 Nov 2019 12:00:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 26/26] t7700: stop losing return codes of git commands
References: <cover.1574731022.git.liu.denton@gmail.com>
        <cover.1574884302.git.liu.denton@gmail.com>
        <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
        <20191130104812.GA18401@danh.dev>
        <CAPig+cQ38J_0wHLw0CuhSdWBBEP-RuAchgG014GPHiSp6QOpsQ@mail.gmail.com>
Date:   Sat, 30 Nov 2019 09:00:08 -0800
In-Reply-To: <CAPig+cQ38J_0wHLw0CuhSdWBBEP-RuAchgG014GPHiSp6QOpsQ@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 30 Nov 2019 06:31:04 -0500")
Message-ID: <xmqqv9r12tbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE5FC362-1392-11EA-8861-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Nov 30, 2019 at 5:48 AM Danh Doan <congdanhqx@gmail.com> wrote:
>> On 2019-11-27 11:54:04-0800, Denton Liu <liu.denton@gmail.com> wrote:
>> > +   ! grep "^$coid " packlist &&
>>
>> I think we want to use test_must_fail instead of !
>
> test_must_fail() is intended only for use with 'git' commands; "!"
> should be used otherwise. Quoting from t/README:
>
>     Don't use '! git cmd' when you want to make sure the git command
>     exits with failure in a controlled way by calling "die()".  Instead,
>     use 'test_must_fail git cmd'.  This will signal a failure if git
>     dies in an unexpected way (e.g. segfault).
>
>     On the other hand, don't use test_must_fail for running regular
>     platform commands; just use '! cmd'.  We are not in the business
>     of verifying that the world given to us sanely works.
>
> So, Denton's use of "!" here is correct.

I wonder we can make the framework a bit more self-documenting to
avoid having to waste time on discovering potential issues and
explaining why it is not an issue, like this exchange.

Some ideas:

 * Perhaps test_must_fail is not descriptive enough that it should
   apply only to git command invocation.  Would it make it more
   obvious to rename it to say git_must_fail?  That would also make
   it unnecessary to give this rather unfortunate comment in
   test-lib-functions.sh:

   # This is not among top-level (test_expect_success | test_expect_failure)
   # but is a prefix that can be used in the test script, like:
   #
   #	test_expect_success 'complain and die' '
   #           do something &&
   #           do something else &&
   #	    test_must_fail git checkout ../outerspace
   #	'
   #

 * If it is too much trouble to rename it, perhaps test_must_fail
   can be documented better up there?

   diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
   index b299ecc326..052d88c5da 100644
   --- a/t/test-lib-functions.sh
   +++ b/t/test-lib-functions.sh
   @@ -817,6 +817,13 @@ list_contains () {
    #     Multiple signals can be specified as a comma separated list.
    #     Currently recognized signal names are: sigpipe, success.
    #     (Don't use 'success', use 'test_might_fail' instead.)
   +#
   +# Do not use this to run anything but "git".  We are not in the business
   +# of vetting system supplied commands---IOW this is wrong:
   +#
   +#    test_must_fail grep pattern output
   +#
   +# Just use '!' instead.

    test_must_fail () {
           case "$1" in

 * Or perhaps we can detect its use on anything that is not "git"
   automatically?  This is merely to illustrate the idea (the
   exemption of "env" shown here is too broad for production use)

   diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
   index b299ecc326..7ab113cd50 100644
   --- a/t/test-lib-functions.sh
   +++ b/t/test-lib-functions.sh
   @@ -828,6 +828,10 @@ test_must_fail () {
                   _test_ok=
                   ;;
           esac
   +	case "$1" in
   +	git|test-tool|env) ;;
   +	*) echo >&7 "warning: test_must_fail $*???" ;;
   +	esac
           "$@" 2>&7
           exit_code=$?
           if test $exit_code -eq 0 && ! list_contains "$_test_ok" success

Hmm?
