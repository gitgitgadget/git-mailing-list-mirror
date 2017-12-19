Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05721F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdLSWTu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:19:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60926 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751820AbdLSWTs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:19:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD455B08F6;
        Tue, 19 Dec 2017 17:19:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SkH7RG3/ZkB6Na529/DQq8U5Gc=; b=Fr2iWP
        co6OBzrpnaknPw3vLxj8wQjr8Y0XkSw7Bt3Xh0wb0L8yWb/q0Cks/1pDbZqBWaF4
        +hePD+XQX/2Mxm9CD+dhKKA7/3TL5K6+Iw+Br3EP7TrnK+cUsH7m/dk1xDHVhC9x
        AzkYu41/TiBipfDfztvwevYyY1dFnLTjNYQW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RzreUDk9W4uJAI+GHt6npjacwxGnHV6/
        J3vxqarRILEh4uFoRUQQftiEmhnRXtsPQUQBzaG6DG/bCHtoSDW9aWc3Fwaayini
        uvTwT+4R+I6JSqSfDsri7uIAKiHZaPew2Tj8W4p44j2yU63NnMQMdXPKD2O9O2yM
        isOYUWx58Yg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D424CB08F5;
        Tue, 19 Dec 2017 17:19:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50DA1B08F4;
        Tue, 19 Dec 2017 17:19:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     arurke@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with differing path/name?
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
        <20171219180230.254881-1-sbeller@google.com>
Date:   Tue, 19 Dec 2017 14:19:46 -0800
In-Reply-To: <20171219180230.254881-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 19 Dec 2017 10:02:30 -0800")
Message-ID: <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8F3B3D0-E50A-11E7-BEB7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I tried reproducing the issue (based on the `next` branch, not 2.15,
> but I do not recall any changes in the submodule area lately), and
> could not come up with a reproduction recipe,...

I do not offhand recall anything; the closest I can think of is the
three-patch series <20171016135623.GA12756@book.hvoigt.net> that
taught the on-demand recursive fetch to pay attention to the location
in the superproject tree a submodule is bound to.

    4b4acedd61 submodule: simplify decision tree whether to or not to fetch
    c68f837576 implement fetching of moved submodules
    01ce12252c fetch: add test to make sure we stay backwards compatible

But IIRC, "submodule update" uses a separate codepath?
