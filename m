Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23662023D
	for <e@80x24.org>; Thu,  2 Mar 2017 05:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdCBFpT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 00:45:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58641 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751128AbdCBFpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 00:45:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E5B87AD4D;
        Thu,  2 Mar 2017 00:43:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D4UwlK9BHdos4+4ErwGvuzU5+V4=; b=TeIBzQ
        K4B8V1Yk/qorTW9/7dSYI8l9Ab0Mxh1iiY/3sWx6K/WRVFIsYtcOJDajTu1vQ+08
        irOPJdgU0RMIGWMOwnbAH8Mbyv2ApkGQ1CxhWCAdiyw7o028FVsTiRMNH87dHfap
        9jUC36Xg6kObDRbrSuI8g9tYrjLMvZBNeR0VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hlgFwJAekmNX2bMzDMK6K+VHSuaSK+kt
        Y4Qv1nN2CTNYIjnCoYdtB7UUMl33thlmAXlHywqPFkqGYsGqAc0S2y/rk7rFG9B4
        TM6+81lyYfoXQWrMJzCcZ/zxS4yoQTJh2hA4Gd9iggqF0bGk944LQBXLNxZEGEW6
        rIo0mN57OT0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5803E7AD4C;
        Thu,  2 Mar 2017 00:43:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C98D87AD4B;
        Thu,  2 Mar 2017 00:43:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 01/10] submodule: decouple url and submodule existence
References: <20170223234728.164111-1-bmwill@google.com>
        <20170223234728.164111-2-bmwill@google.com>
        <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com>
        <20170301200230.GA30622@google.com>
Date:   Wed, 01 Mar 2017 21:43:52 -0800
In-Reply-To: <20170301200230.GA30622@google.com> (Brandon Williams's message
        of "Wed, 1 Mar 2017 12:02:30 -0800")
Message-ID: <xmqqwpc8cjxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38762DC2-FF0B-11E6-88A0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 02/24, Junio C Hamano wrote:
>
>> Also as a grouping measure, submodule.active that lists submodule
>> paths feels hard to use.  When switching between two branches in the
>> superproject that have the same submodule bound at two different
>> paths, who is responsible for updating submodule.active in
>> superproject's config?  If it were a list of submodule names, this
>> objection does not apply, though.
>
> I agree that if you are listing every submodule path by hand then this
> may not be the best approach and would be difficult to use.  The idea is
> that this would allow a user to set a general pathspec to identify a
> group of modules they are interested in.  Perhaps once attributes can be
> used in pathspecs a user could group submodules by setting a particular
> attribute and then submodule.active would have a value like
> ":(attr:foo)" to indicate I'm interested in all submodules with the
> "foo" attribute.

OK.  As .gitattributes is tracked just like .gitmodules in tree, the
project can adjust the path pattern that matches a renamed submodule
and gives it an attribute in .gitattributes in the same commit in
the superproject that moves the directory to which the submodule is
bound, just like it updates .gitmodules to adjust the name<->path
mapping.  So that plan solves my specific worry about using "path"
for grouping and not "name".

Thanks.
