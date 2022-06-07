Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbiFGImy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiFGImu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:42:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2E1C90D
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:42:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so26507071ejx.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4KlWBY+ACQ08FPhuVF7MiSr/mjQXaTarXfiemh3QfD8=;
        b=H70Wzn7nZb3EoaUVfUTjc9vh8sslffnSFy6jDrJNYT9paPko5ACD3Wcbf5lNz5hELl
         chifnTyTTSljsTBvnbAWYo8rCNxxBm3YtrZ8J9YJwghCyBTJcI9t3/qaJBDK/LIyjHT8
         GnZWK8dsg+noNK2+DmmE4k3HTNKGZujZL3yWzXJc5EWLu45jyRkhcBdlnMOAIhDxqbSL
         FEmGH1EH9e/cgxBdpM2f7jvUMpy7YQ9aY9FmtDSCWRXL31nTERhmCbL6HwT2/2ogs9ea
         t/ilR2WDY1MpNrKpKbZ5wTJ1Ptq2ZjAloDfMvwWFYOr5AsYJk3xeBfGbO+pUvB22Sg0o
         SXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4KlWBY+ACQ08FPhuVF7MiSr/mjQXaTarXfiemh3QfD8=;
        b=YR3trmNl78odkA0NTsek7867HjXWYEOXg4U2FHIvJg8ieRdlC5yLK8m4xcpyXNx1bF
         1z8K7UXLHNhgVClpTO9Mqm8BSGCRuI7k8pdjGrZTBBcizCAWPwwiIp3MvVd6YnokxiXw
         J36PLur9yGH7zphLOyQT71CQld7O7bTxiO1YcjBm8xGe89cOGprW5ZopQzolSSJc/Fd8
         2yKpMmpx1wAIkDJVMoDbMXQQXZCttqbyxoqY0ovmeyEBzq6ys0FGGhy6yrfJMC7W6T1N
         OdqO7eKxCF4xwj3eONpuJGs4S9GzbmI63476Gn8EzfDPPfCkQi5Hcu7VREic/i39S9CR
         JWug==
X-Gm-Message-State: AOAM532C0t/yh7sX53gjMsWCm3fJ+gz84IHfbNF8kFUYGD5gwkm0RZiP
        L9YTan/60/Sx13XEV8xUd6BIvyCV4ok=
X-Google-Smtp-Source: ABdhPJxSmCynbF3heprds+eorA1WQlQiQWCtlMgBm/hhd8oWBaDHZ+UibuUHCMgmBxENJ+VmpkKuuQ==
X-Received: by 2002:a17:907:2d24:b0:711:d584:f118 with SMTP id gs36-20020a1709072d2400b00711d584f118mr6408897ejc.238.1654591368122;
        Tue, 07 Jun 2022 01:42:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm7269420ejb.80.2022.06.07.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:42:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyUnW-002NBY-WA;
        Tue, 07 Jun 2022 10:42:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsmonitor: query watchman with right valid json
Date:   Tue, 07 Jun 2022 10:40:10 +0200
References: <20220607075425.39510-1-sluongng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220607075425.39510-1-sluongng@gmail.com>
Message-ID: <220607.86ilpcvp89.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
>   failed to parse command from stdin: line 2, column 13, position 67: unexpected token near ','
>   Watchman: command returned no output.
>   Falling back to scanning...
>
> Hide the "since" field in json query when "last_update_token" is empty.
>
> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> ---
>  templates/hooks--fsmonitor-watchman.sample | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
> index 14ed0aa42d..b4ee86dfc4 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -79,6 +79,12 @@ sub watchman_query {
>  	or die "open2() failed: $!\n" .
>  	"Falling back to scanning...\n";
>  
> +	my $query = <<"	END";
> +		["query", "$git_work_tree", {
> +			"fields": ["name"],
> +			"expression": ["not", ["dirname", ".git"]]
> +		}]
> +	END

Wouldn't a more minimal & obvious patch here be....

>  	# In the query expression below we're asking for names of files that
>  	# changed since $last_update_token but not from the .git folder.
>  	#
> @@ -87,15 +93,14 @@ sub watchman_query {
>  	# output to file names only. Then we're using the "expression" term to
>  	# further constrain the results.
>  	if (substr($last_update_token, 0, 1) eq "c") {
> -		$last_update_token = "\"$last_update_token\"";

To just change this to be:

	# same as now:
	$last_update_token = "\"$last_update_token\"";
        $last_update_line = qq["since": $last_update_token,];

Of course having declared the new $last_update_line variable earlier, then:

> +		$query = <<"		END";
> +			["query", "$git_work_tree", {
> +				"since": "$last_update_token",
> +				"fields": ["name"],
> +				"expression": ["not", ["dirname", ".git"]]
> +			}]
> +		END
>  	}
> -	my $query = <<"	END";
> -		["query", "$git_work_tree", {
> -			"since": $last_update_token,

Just change this line to:

	$last_update_line

I.e. you don't need to duplicate the whole query just to omit/include a
single line in it, or am I missing something?

(This suggestion *would* include a redundant line, but I'm assuming
JSON/watchman deals with that just fine...).
