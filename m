Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB4C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 01:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D51161920
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 01:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCUAnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUAnC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:43:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52FC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:43:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z1so15134903edb.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NTh0zXRNv6K7wLxxmT5xUWkSsq6PsWETDAAinlK9eOg=;
        b=vNpBtCSLGhXvgSctxCwzZJgH+GvPCHGwsrNC6JbOSfROD7Hm14xKmhFECZUBsgtF9Q
         caK1xRab6vdzfV1vCuANODkSe4Ub4Xq4bLfxtev0plLtbygw3u73pZofq7hmhVRtnY3W
         YCyIkqr+OCslKmcv16TnoOXgmE+VFLM8bjeTjrSQRJwtQS2fIIxT53XGkoTWm/JQxD1z
         tGEwepvOSo7XC3pQOkRNer1qEaJMAdTC6m5SiUesM+8jMvnrMEw3lEU7NKDZYevtPfjV
         1Sicy/B1ohLWPye7osEq5Sya3FtI7+j8Ymw8c+b99fbertlIcdrBVqxOQmpvfl605SWN
         ANxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NTh0zXRNv6K7wLxxmT5xUWkSsq6PsWETDAAinlK9eOg=;
        b=delx72lbIgYL/huwk3tUXK/obuhV+y6PVIing1U+w5VMOAmeeYM701jiEHtQ3085/z
         xIAYtHzrN8WVVveO+IY3JRiIaJW6at5OQqyIS1MGpnAtNH26xnKxbNlui9xAGU3qieHA
         V0YYwQC6pAjMRKJ8+7XeUScr78xCNQ0qksKOrd+x+hxnyNPrT927aIpm6Bxws6B9Y13X
         XNh0VgIKIe+tghOwkH7/VkHWjZBvROBZWn54VEUIfa9xHNGlirt0Luypo9YzM5kTmP2z
         Gz1JxspOUty9gtcZFGl5RrymzmubOAQIhxXBh55B21CndQlJpTV1ntUnZ4QPrTSMTvXp
         nxfw==
X-Gm-Message-State: AOAM530gsbv+Jp6XDORMPW73Yqa9iGN5Ok/z/tw6P+DQ2+f1ELJRphBc
        V/9TdMWcVQeLfWpKnYcXmivoGKpfv4jhKA==
X-Google-Smtp-Source: ABdhPJxiD0LSt3NDpIRhjohVw/K9d1l3WtlcVqBonAHRFyWXHyQO76JC4D8p+S0lzrs97CcAsCh3nw==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr17887227edc.302.1616287380437;
        Sat, 20 Mar 2021 17:43:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i11sm6144542ejc.101.2021.03.20.17.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:42:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 01:42:58 +0100
Message-ID: <8735wpz699.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 21 2021, Georgios Kontaxis via GitGitGadget wrote:

> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>
> Gitweb extracts content from the Git log and makes it accessible
> over HTTP. As a result, e-mail addresses found in commits are
> exposed to web crawlers. This may result in unsolicited messages.
> This is a feature for redacting e-mail addresses from the generated
> HTML content.
>
> This feature does not prevent someone from downloading the
> unredacted commit log and extracting information from it.
> It aims to hinder the low-effort bulk collection of e-mail
> addresses by web crawlers.

So web crawlers that aren't going to obey robots.txt?

I'm not opposed to this feature, but a glance at gitweb's documentation
seems to show that we don't discuss how to set robots.txt up for it at
all.

Perhaps having that in the docs or otherwise in the default setup would
get us most of the win of this feature?

> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
> ---

Odd:

>     gitweb: Redacted e-mail addresses feature.
>     
>     Gitweb extracts content from the Git log and makes it accessible over
>     HTTP. As a result, e-mail addresses found in commits are exposed to web
>     crawlers. This may result in unsolicited messages. This is a feature for
>     redacting e-mail addresses from the generated HTML content.
>     
>     This feature does not prevent someone from downloading the unredacted
>     commit log and extracting information from it. It aims to hinder the
>     low-effort bulk collection of e-mail addresses by web crawlers.
>     
>     Signed-off-by: Georgios Kontaxis geko1702+commits@99rst.org

To have this duplication of the patch here below "---", some GGG feature
gone awry?

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>
>  Documentation/gitweb.conf.txt | 12 ++++++++++++
>  gitweb/gitweb.perl            | 36 ++++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index 7963a79ba98b..10653d8670a8 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -896,6 +896,18 @@ same as of the snippet above:
>  It is an error to specify a ref that does not pass "git check-ref-format"
>  scrutiny. Duplicated values are filtered.
>  
> +email_privacy::
> +    Redact e-mail addresses from the generated HTML, etc. content.
> +    This hides e-mail addresses found in the commit log from web crawlers.
> +    Enabled by default.
> ++
> +It is highly recommended to keep this feature enabled unless web crawlers
> +are hindered in some other way. You can disable this feature as shown below:
> ++
> +---------------------------------------------------------------------------
> +$feature{'email_privacy'}{'default'} = [0];
> +---------------------------------------------------------------------------

I think there's plenty of gitweb users that are going to be relying on
the current behavior, so doesn't it make more sense for this to be
opt-in rather than opt-out?

>  
>  EXAMPLES
>  --------
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0959a782eccb..9d21c2583e18 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -569,6 +569,15 @@ sub evaluate_uri {
>  		'sub' => \&feature_extra_branch_refs,
>  		'override' => 0,
>  		'default' => []},
> +
> +    # Redact e-mail addresses.
> +
> +    # To disable system wide have in $GITWEB_CONFIG
> +    # $feature{'email_privacy'}{'default'} = [0];
> +	'email_privacy' => {
> +		'sub' => sub { feature_bool('email_privacy', @_) },
> +		'override' => 0,
> +		'default' => [1]},
>  );
> [...]
>  sub gitweb_get_feature {
> @@ -3471,6 +3480,10 @@ sub parse_tag {
>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$tag{'author_name'}  = $1;
>  				$tag{'author_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$tag{'author_email'} = "private";
> +					$tag{'author'} =~ s/<([^>]+)>/<private>/;
> +				}
>  			} else {
>  				$tag{'author_name'} = $tag{'author'};
>  			}
> @@ -3519,6 +3532,10 @@ sub parse_commit_text {
>  			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$co{'author_name'}  = $1;
>  				$co{'author_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$co{'author_email'} = "private";
> +					$co{'author'} =~ s/<([^>]+)>/<private>/;
> +				}
>  			} else {
>  				$co{'author_name'} = $co{'author'};
>  			}
> @@ -3529,6 +3546,10 @@ sub parse_commit_text {
>  			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$co{'committer_name'}  = $1;
>  				$co{'committer_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$co{'committer_email'} = "private";
> +					$co{'committer'} =~ s/<([^>]+)>/<private>/;
> +				}
>  			} else {
>  				$co{'committer_name'} = $co{'committer'};
>  			}
> @@ -3568,9 +3589,13 @@ sub parse_commit_text {
>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>  	}
> -	# remove added spaces
> +	# remove added spaces, redact e-mail addresses if applicable.
>  	foreach my $line (@commit_lines) {
>  		$line =~ s/^    //;
> +		if (gitweb_check_feature('email_privacy') &&
> +			$line =~ m/^([^<]+) <([^>]*)>/) {
> +			$line =~ s/<([^>]+)>/<private>/;
> +		}
>  	}
>  	$co{'comment'} = \@commit_lines;

All of these hunks (and the below) should use some new function that
does this feature check + sanitizing instead of copy/pasting mostly the
same code N times. e.g.:
    
    sub maybe_hide_email {
        my $email = shift;
        return $email unless gitweb_check_feature('email_privacy');
        return hide_email($email);
    }

then:

    $tag{author_email} = maybe_hide_email($2);

Also it looks like this isn't a new issue, but does this need to
implement its own E-Mail parser? We ship with Mail::Address for
git-send-email, can gitweb (and the elided hide_email() function above)
use that too?


> @@ -8060,8 +8085,13 @@ sub git_commitdiff {
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
>  	} elsif ($format eq 'patch') {
> -		local $/ = undef;
> -		print <$fd>;
> +		while (my $line = <$fd>) {
> +			if (gitweb_check_feature('email_privacy') &&
> +				$line =~ m/^([^<]+) <([^>]*)>/) {
> +				$line =~ s/<([^>]+)>/<private>/;
> +			}
> +			print $line;
> +		}
>  		close $fd
>  			or print "Reading git-format-patch failed\n";

Is that "patch" output meant for "git am"? Won't this severely break
that use-case if so?
