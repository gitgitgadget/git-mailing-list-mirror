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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B37C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BFD61946
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCUS0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCUS0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:26:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD28CC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 11:26:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so16666235edp.11
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5r4LX1hc6fuXwkXOekzWoVblTyu0ksnHBs/BKry0bQU=;
        b=UdzYDseDgSLjVqMzHkeFv+yoTnatom4ohsspbB/x0OmJL8ltIt6ao6kMwEnmKchpjY
         RxBrek4Tljp/I85XLUjS9tHmEApFG3xe48FZ6iNKiQLLbmGD22PDf3GCgy4LvoSO96BU
         CNg1teTL/1lZFWZwMU4qaNbSSs6aoX5VKBjK0HkpBiAAaRG99N3ni7rDGbD42InL0ear
         oMUnMpROUNUl9gl8CljPaaWBk/XIe4W6b7TXDLHkY5W4SYxFPVJAinOizNuhXQPcU22z
         NweckKrKvoy/qg+UclMkvNgxQ3tTAsGs9OHTB17Gp2u0ukXFQ1lwgMYzD1nM3EtfFIkJ
         yQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5r4LX1hc6fuXwkXOekzWoVblTyu0ksnHBs/BKry0bQU=;
        b=CS/d9fHf1DN02Rb/qJgzUUebGojAwdaUO48m/43Exk9mMSJEX5vkdgXVzynU747AKb
         TIv1lDB93vt7PAi/0LQdxif5u68dK7X5b7OjM0qM5aB3rRon1nhVycDDzf6YoBcGY1On
         XyhG8OPvAwaevu3PeJaUzYcL8XGvCpIK4kRIMbFiPDttgE9BYDpHRxGGhn1A33ac98Pc
         ukv2kL2F02yM6uR0CCuPKUj1K0cmlFvV2YPrG2AH1YjU8p4WP1RDuMwk2neICvFhApwG
         C131sRZr92OYQl8qBHgK9fVSf0MilNgJlKqWomjriOXOYk+ieVHYNvdmLLdbiWy0y9SV
         m4hg==
X-Gm-Message-State: AOAM530QgJ0srwK9/nqG0UbX5T6mQTG2M72l0lF7LT4/ZOt1kS0BM96D
        t27mEwy6RCQD3VQ3K6rt7CI=
X-Google-Smtp-Source: ABdhPJwOKLBHxStfBU7SFzh4kBa1azyBZIgF+inrfI3JHBt1C5vDOGcPJL9vZtv0smaCh1XiKAiATQ==
X-Received: by 2002:a05:6402:1342:: with SMTP id y2mr21892976edw.285.1616351170757;
        Sun, 21 Mar 2021 11:26:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n16sm7457593ejy.35.2021.03.21.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:26:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
 <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 19:26:08 +0100
Message-ID: <87r1k8qs73.fsf@evledraar.gmail.com>
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
> exposed to web crawlers and they may not respect robots.txt.
> This may result in unsolicited messages.
> This is a feature for redacting e-mail addresses
> from the generated HTML, etc. content.
>
> This feature does not prevent someone from downloading the
> unredacted commit log, e.g., by cloning the repository, and
> extracting information from it.
> It aims to hinder the low-effort bulk collection of e-mail
> addresses by web crawlers.
>
> Changes since v1:
> - Turned off the feature by default.
> - Removed duplicate code.
> - Added note about Gitweb consumers receiving redacted logs.
>
> Changes since v2:
> - The feature can be set on a per-project basis. ('override' => 1)
>
> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
> ---
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
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-910%2Fkontaxis%2Fkontaxis%2Femail_privacy-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-910/kontaxis/kontaxis/email_privacy-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/910
>
> Range-diff vs v2:
>
>  1:  74af11ca8bf2 ! 1:  930cdefe7ee0 gitweb: redacted e-mail addresses feature.
>      @@ Commit message
>           - Removed duplicate code.
>           - Added note about Gitweb consumers receiving redacted logs.
>       
>      +    Changes since v2:
>      +    - The feature can be set on a per-project basis. ('override' => 1)
>      +
>           Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
>       
>        ## Documentation/gitweb.conf.txt ##
>      @@ gitweb/gitweb.perl: sub evaluate_uri {
>       +	# $feature{'email_privacy'}{'default'} = [1];
>       +	'email_privacy' => {
>       +		'sub' => sub { feature_bool('email_privacy', @_) },
>      -+		'override' => 0,
>      ++		'override' => 1,
>       +		'default' => [0]},
>        );
>        
>
>
>  Documentation/gitweb.conf.txt | 16 +++++++++++++
>  gitweb/gitweb.perl            | 42 ++++++++++++++++++++++++++++++++---
>  2 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
> index 7963a79ba98b..b7af3240177d 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -896,6 +896,22 @@ same as of the snippet above:
>  It is an error to specify a ref that does not pass "git check-ref-format"
>  scrutiny. Duplicated values are filtered.
>  
> +email_privacy::
> +    Redact e-mail addresses from the generated HTML, etc. content.
> +    This hides e-mail addresses found in the commit log from web crawlers.
> +    Disabled by default.
> ++
> +It is highly recommended to enable this feature unless web crawlers are
> +hindered in some other way. Note that crawlers intent on harvesting e-mail
> +addresses may disregard robots.txt. You can enable this feature like so:
> ++
> +---------------------------------------------------------------------------
> +$feature{'email_privacy'}{'default'} = [1];
> +---------------------------------------------------------------------------
> ++
> +Note that if Gitweb is not the final step in a workflow then subsequent
> +steps may misbehave because of the redacted information they receive.
> +
>  
>  EXAMPLES
>  --------
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0959a782eccb..174cc566d97d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -569,6 +569,15 @@ sub evaluate_uri {
>  		'sub' => \&feature_extra_branch_refs,
>  		'override' => 0,
>  		'default' => []},
> +
> +	# Redact e-mail addresses.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'email_privacy'}{'default'} = [1];
> +	'email_privacy' => {
> +		'sub' => sub { feature_bool('email_privacy', @_) },
> +		'override' => 1,
> +		'default' => [0]},
>  );
>  
>  sub gitweb_get_feature {
> @@ -3449,6 +3458,19 @@ sub parse_date {
>  	return %date;
>  }
>  
> [snip]

So in the v1 feedback I suggested:

BEGIN QUOTE
    sub maybe_hide_email {
        my $email = shift;
        return $email unless gitweb_check_feature('email_privacy');
        return hide_email($email);
    }

then:

    $tag{author_email} = maybe_hide_email($2);
END QUOTE

But:

>  sub parse_tag {
>  	my $tag_id = shift;
>  	my %tag;
> @@ -3471,6 +3493,10 @@ sub parse_tag {
>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$tag{'author_name'}  = $1;
>  				$tag{'author_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$tag{'author_email'} = "private";
> +					$tag{'author'} = hide_mailaddr($tag{'author'});
> +				}

This code seems quite awkward, we've already done the regex match, but
this code:

> [snip]
> +sub hide_mailaddr_if_private {
> +	my $line = shift;
> +	return $line unless (gitweb_check_feature('email_privacy') &&
> +						$line =~ m/^([^<]+) <([^>]*)>/);
> +	return hide_mailaddr($line)
> +}
> +
> +sub hide_mailaddr {
> +	my $mailaddr = shift;
> +	$mailaddr =~ s/<([^>]*)>/<private>/;
> +	return $mailaddr;
> +}

Is going to do it again incrementally, and then just act on a
search-replacement if we've got the feature enabled.

It seems much simpler to just turn your:

> +				if (gitweb_check_feature('email_privacy')) {
> +					$tag{'author_email'} = "private";
> +					$tag{'author'} = hide_mailaddr($tag{'author'});
> +				}

Into:

    $tag{'author'} = maybe_hide_mailaddr($tag{author}, \$tag{author_email});

Using:

    sub maybe_hide_email {
        my ($email, $ref) = shift;
        return $email unless gitweb_check_feature('email_privacy');
        $$ref = "private" if $ref;
        return hide_email($email);
    }

Which also works for the case where you don't have a "private" hash key
to assign to. But maybe it overcomplicates things...

>  			} else {
>  				$tag{'author_name'} = $tag{'author'};
>  			}
> @@ -3519,6 +3545,10 @@ sub parse_commit_text {
>  			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$co{'author_name'}  = $1;
>  				$co{'author_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$co{'author_email'} = "private";
> +					$co{'author'} = hide_mailaddr($co{'author'});
> +				}
>  			} else {
>  				$co{'author_name'} = $co{'author'};
>  			}
> @@ -3529,6 +3559,10 @@ sub parse_commit_text {
>  			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
>  				$co{'committer_name'}  = $1;
>  				$co{'committer_email'} = $2;
> +				if (gitweb_check_feature('email_privacy')) {
> +					$co{'committer_email'} = "private";
> +					$co{'committer'} = hide_mailaddr($co{'committer'});
> +				}
> [...]
>  			} else {
>  				$co{'committer_name'} = $co{'committer'};
>  			}
> @@ -3568,9 +3602,10 @@ sub parse_commit_text {
>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>  	}
> -	# remove added spaces
> +	# remove added spaces, redact e-mail addresses if applicable.
>  	foreach my $line (@commit_lines) {
>  		$line =~ s/^    //;
> +		$line = hide_mailaddr_if_private($line);
>  	}
>  	$co{'comment'} = \@commit_lines;
>  
> @@ -8060,8 +8095,9 @@ sub git_commitdiff {
>  		close $fd
>  			or print "Reading git-diff-tree failed\n";
>  	} elsif ($format eq 'patch') {
> -		local $/ = undef;
> -		print <$fd>;
> +		while (my $line = <$fd>) {
> +			print hide_mailaddr_if_private($line);
> +		}

Urm, have you tested this? How does a while loop over a <$fd> make sense
when $/ is undef, the readline() operator will always return just one
record, so having a while loop doesn't make sense.

I'm not sure of the input here, but given that if you're expecting to
replace all e-mail addresses on all lines with this function that's not
how it'll work, the s/// doesn't have a /g, so it'll stop at the first
replacement.

>  		close $fd
>  			or print "Reading git-format-patch failed\n";
>  	}
>
> base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f

