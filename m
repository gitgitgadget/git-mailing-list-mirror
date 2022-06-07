Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522CBCCA47C
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbiFGOsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343513AbiFGOr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 10:47:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973CA11C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 07:47:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y19so35685178ejq.6
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jQE1HfnL7LxHs5IR+BrFQwnDNVaYAFpuzeLo8BowocA=;
        b=GehOWGkwV2JjU1QD3iRFbp9PgG2QT5DGuHZJoRBc9zsafO02KwYbwbdSFYrjBQzTGm
         LGYN/PEwH0VWLZYhVaVWe2l8vx39GQHlwhyg9txXMlUjeqpDP9sqNcVZm1topzJgFIlJ
         3R3fqWyKsyA7iTWMY7KmMwSeuTtJcHppY7lI4EXwWlujnC9hvr4uF5qxFZo2EZGWCZJH
         DaSHUxjKIom0pa51is6i68MEl4S/0VhTkFff4TNbvWYb4pXG+pVNRvDEkLT1ClPznAa7
         beattkPWZez1+tK472i8d1gEAJkGLxV959TiWjuZuvaO55nn+Y12PHhVpGthtgFXAcar
         C5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jQE1HfnL7LxHs5IR+BrFQwnDNVaYAFpuzeLo8BowocA=;
        b=g+y8MnkluVZzOJGRGEg6iIfYoVIeRVDPRbciVoCqPuxaxJPrAZ10AudCEf7xhvp4E3
         X73qbbOrzkRGO6YsFgLP/W3Gw4StJavMl19JdJfR8Cx5DTIzwxSNdZMteVU0kG/P6ibF
         GaksXDyE1EQ7XhlcY5HjVg+vsISwI+ywcsV+Lc5HOpc2dRSd+SSGdfloitS96lSw9QDi
         zTe/91XT/NnvbYXFpMcGkcd/dnmElJj/w664/DhrkCQ7ycowQGaHmhz4NBFqWqX/G7TY
         K6JhNW8t9ZxV5jrDdpHRgoBdVc4jmv5dx9k4lcPdmC2NNeZ+4aTOKdGLUVMW0skVLhkl
         jn2g==
X-Gm-Message-State: AOAM5301QAEXYuscNdYhd6Z+UqY3p6DAZvI/DAdKzJN9/qEqV+LSpDkp
        SauUIm9SUE2gNcLTg95+TMHeBY77GoFwcw==
X-Google-Smtp-Source: ABdhPJz4pFAAWR0p3FA4A3tyNwH9X2OzVq67mCfo/GZlueBRrqv7zyi35y2l6dJnMSbmjyoUCNgIRg==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr25785050ejj.278.1654613276837;
        Tue, 07 Jun 2022 07:47:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fu16-20020a170907b01000b006fe8b3d8cb6sm7728636ejc.62.2022.06.07.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 07:47:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyaUr-002Yxl-Jl;
        Tue, 07 Jun 2022 16:47:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fsmonitor: query watchman with right valid json
Date:   Tue, 07 Jun 2022 16:39:58 +0200
References: <CAL3xRKev_KHvAFuviG7RxsxA_786K4QY5F08a8D23M9MLM81+g@mail.gmail.com>
 <20220607111419.15753-1-sluongng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220607111419.15753-1-sluongng@gmail.com>
Message-ID: <220607.867d5sv8bq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 07 2022, Son Luong Ngoc wrote:

> In rare circumstances where the current git index does not carry the
> last_update_token, the fsmonitor v2 hook will be invoked with an
> empty string which would caused the final rendered json to be invalid.
>
>   ["query", "/path/to/my/git/repository/", {
>           "since": ,
>           "fields": ["name"],
>           "expression": ["not", ["dirname", ".git"]]
>   }]
>
> Which will left user with the following error message
>
>   > git status
>   failed to parse command from stdin: line 2, column 13, position 67: une=
xpected token near ','
>   Watchman: command returned no output.
>   Falling back to scanning...
>
> Hide the "since" field in json query when "last_update_token" is empty.
>
> Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>

Thanks for the quick turnaround.

>  templates/hooks--fsmonitor-watchman.sample | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks=
--fsmonitor-watchman.sample
> index 14ed0aa42d..23e856f5de 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -86,12 +86,13 @@ sub watchman_query {
>  	# recency index to select candidate nodes and "fields" to limit the
>  	# output to file names only. Then we're using the "expression" term to
>  	# further constrain the results.
> +	my $last_update_line =3D "";
>  	if (substr($last_update_token, 0, 1) eq "c") {
>  		$last_update_token =3D "\"$last_update_token\"";
> +		$last_update_line =3D qq[\n"since": $last_update_token,];
>  	}

This LGTM, just a note...

>  	my $query =3D <<"	END";
> -		["query", "$git_work_tree", {
> -			"since": $last_update_token,
> +		["query", "$git_work_tree", {$last_update_line

...doesn't really need a re-roll, but doesn't this trade "we don't have
too many \n" for not indenting the query properly anymore?

I think skipping both is fine, but between the two I think having
indenting is better than having a redundant \n some of the time.

FWIW you could just add the variable on its own line, and then do this
instead:

	(my $query =3D <<"        END") =3D~ s/(?<=3D\n)\t*\n//s;=20

To post-hoc fix the extra \n in this case :)

But I think this is also fine as-is, thanks!
