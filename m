Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8845FC43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 15:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383131AbiFQPnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382840AbiFQPnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 11:43:14 -0400
Received: from pb-sasl-trial2.pobox.com (pb-sasl-trial2.pobox.com [64.147.108.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FA29CB4
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 08:43:13 -0700 (PDT)
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 745972E6D2;
        Fri, 17 Jun 2022 11:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6wEoQnEhy6q4obzTnTvxFh+NckI=; b=uoijTK
        TO2wUK1ktLhBl6/ZvyFHGJ/9509qYwvUAXqZ8TlgOkrfmjKkSBcFcPozhMz6PKFu
        myBugKMlSP+wuQqBe3WefQxEDQIsOmY1k9dEgDHBiJDU04gBZILjbUjdN5WdytSR
        6Bid2zegj6euQjP5CEHyFZ3lgdDynJ/8HFCWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XAuU7lQpgPZUkJIByGrqBixotveJSL94
        lDmNInmyypv9nLb0Qs7ix7VCI15rd9V+m6IsupOQgu5q5aVtKviYMQZIPxw2WdKY
        U9OLHff99ct7K6rtopcAWMnDCmTJhTnlVIKEK9EGwt+rPPPwFy35UWskDYeY0YAp
        zzC4g6WBmu4=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 3D5E72E6D1;
        Fri, 17 Jun 2022 11:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0675D135691;
        Fri, 17 Jun 2022 11:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?utf-8?Q?S=C3=A9b?= =?utf-8?Q?astien?= Helleu 
        <flashcode@flashtux.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Arusekk <arek_koz@o2.pl>, Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        insolor <insolor@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Ray Chen <oldsharp@gmail.com>,
        =?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Franklin Weng <franklin@goodhorse.idv.tw>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: fix mismatched camelCase config variables
References: <20220617100309.3224-1-worldhello.net@gmail.com>
Date:   Fri, 17 Jun 2022 08:43:06 -0700
In-Reply-To: <20220617100309.3224-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 17 Jun 2022 18:03:09 +0800")
Message-ID: <xmqqtu8jpa7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F74C4E8-EE54-11EC-B848-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Mismatched camelCases, choose the former:
>
>  * Documentation/config/fetch.txt: fetch.credentialsInUrl
>    remote.c:                       fetch.credentialsInURL

We renamed this with "fetch" -> "transfer", didn't we?

Everything else looks good, though.

Thanks.
