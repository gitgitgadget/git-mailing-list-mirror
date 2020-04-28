Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508FDC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF120730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BvjmsGd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD1XNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:13:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60593 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgD1XNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 19:13:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77D7F668EE;
        Tue, 28 Apr 2020 19:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eLRA0CiqJCxothKwnT/q+smLSPo=; b=BvjmsG
        d4WLhd62kJ0SYbYdVNxZ7aXp+9MA8Kayk7eORGPWcOq0p5RfmDH2R1d459AM+SJ5
        /YkrkysJIKsVtcMLu5bjtgEvS4XDzmrIQaHp4OtRQhAj6sUC0Cf/ScLKrT8Pt57k
        peK+CB37BBTV5xYMmOSDDuREnU6erc7qdc2Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KWOMKe1+pY77gavJOuATLuRjp0r+7X7l
        oMThyxi1qi/0tuvP56zPm2uA4yLljURupndyLcIIw1rtn2WxkNQPCfj5bI+vYS2W
        sWf9bCToFkD2TAXObiIaaBWKUeEK6gzcmKUCA6KHc3gjm/xCeEYK5nzJqRXu4o+a
        up34zCGiIT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E25D668ED;
        Tue, 28 Apr 2020 19:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D82C2668EC;
        Tue, 28 Apr 2020 19:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>` again
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
        <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet>
Date:   Tue, 28 Apr 2020 16:13:27 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sat, 25 Apr 2020 00:29:51 +0200
        (CEST)")
Message-ID: <xmqqr1w7yzjc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE37EC96-89A5-11EA-9D47-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 24 Apr 2020, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > @@ -53,7 +57,13 @@ static int credential_config_callback(const char *var, const char *value,
>> >  		char *url = xmemdupz(key, dot - key);
>> >  		int matched;
>> >
>> > -		credential_from_url(&want, url);
>> > +		if (credential_from_potentially_partial_url(&want, url) < 0) {
>> > +			warning(_("skipping credential lookup for key: %s"),
>> > +				var);
>> > +			credential_clear(&want);
>> > +			free(url);
>> > +			return 0;
>> > +		}
>> >  		matched = credential_match(&want, c);
>>
>> Unfortunately, the whole section of this code that is being patched
>> here goes away with 46fd7b39 (credential: allow wildcard patterns
>> when matching config, 2020-02-20), that delegates large part of the
>> logic to urlmatch.
>>
>> Dscho and Brian, how do we want to proceed?  As the conflicting
>> change has already been in 'next' for more than a month and a half,
>> we'd need this "partial URL" logic build to work well with it.
>
> I prepared a PR: https://github.com/gitgitgadget/git/pull/620. I do not
> necessarily feel 100% comfortable with that approach yet, but at least it
> lets the new test case of t0300 pass.

The -2.17 patch series (your [v3 3/3]) ends t0300 like so

    +	done &&
    +
    +	git -c credential.$partial.helper=yep \
    +		-c credential.with%0anewline.username=uh-oh \
    +		credential fill <stdin >stdout 2>stderr &&
    +	test_i18ngrep "skipping credential lookup for key" stderr
    +
    +'
    +
     test_done

while the other branch lacks the extra blank line just before the
single quote is closed.  I queued 850ef627 (SQUASH??? lose excess
blank line to match the other side of the eventual merge,
2020-04-24) on top so that the "-s ours" merge would be without
unnecessary evil-merge noise.  You probably would want to squash it
in.

Thanks.
