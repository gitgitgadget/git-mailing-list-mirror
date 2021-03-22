Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE90C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AD061992
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhCVSdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:33:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63004 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCVScw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:32:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21069123BE3;
        Mon, 22 Mar 2021 14:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r/6XFVlDOSf5fxqWeOBdFeFyOTk=; b=aU0tls
        KzbFeGVfU2/ivTVjKqmZazPpq7uRTrvtUGoGzceO6Oof+oKuiI4bUo5LewLBkIDm
        wxaaSZPDmwP7Fz+FQwO3b2rdowYu/pOqaSYpprCywmc02PqTXhnn2LORcv0FakhJ
        2uat4wta+eQSC0aHH2tzEoQri1fIJZCvfiR7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FoD1c5elvn8hEzTOh/idxZTY4wuQy88P
        ftsvhctsMYDOpxy/suYhXKe0aQg75XaPUOmHv/HZ+9mEB818E9uxUpZ932O/XLMz
        M5EejHVXn27JkngcwGtZ6DhON/jXJLcnixjIEjq9hoqjxupj7ksvXdtHSQWE/cqy
        6W6x6c4g4Wk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A642123BE2;
        Mon, 22 Mar 2021 14:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6374E123BE1;
        Mon, 22 Mar 2021 14:32:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v4] gitweb: redacted e-mail addresses feature.
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 11:32:46 -0700
In-Reply-To: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com> (Georgios
        Kontaxis via GitGitGadget's message of "Mon, 22 Mar 2021 06:57:46
        +0000")
Message-ID: <xmqqlfaf6nu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00989756-8B3D-11EB-A396-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
writes:

[note to other reviewers. input from those who are more familiar
with gitweb and Perl is very much appreciated on this patch].

> From: Georgios Kontaxis <geko1702+commits@99rst.org>
>
> Gitweb extracts content from the Git log and makes it accessible
> over HTTP. As a result, e-mail addresses found in commits are
> exposed to web crawlers and they may not respect robots.txt.
> This may result in unsolicited messages.

"... are exposed to web crawlers, which spammers may use." would be
sufficient as a problem description.

After giving a problem description, it is customery to describe the
solution as if you are ordering the codebase to "be like so", so
instead of this ...

> This is a feature for redacting e-mail addresses
> from the generated HTML, etc. content.
    
... we may say something like

    Introduce an 'email-privacy' feature, which defaults to false,
    that redacts e-mail addresses that appear as author/committer
    info and in log messages from the generated HTML content.

> This feature does not prevent someone from downloading the
> unredacted commit log, e.g., by cloning the repository, and
> extracting information from it.
> It aims to hinder the low-effort bulk collection of e-mail
> addresses by web crawlers.

And this is a good thing to add.  Overall, nicely written.

> Signed-off-by: Georgios Kontaxis <geko1702+commits@99rst.org>
> ---
>     gitweb: redacted e-mail addresses feature.
>     
>     Gitweb extracts content from the Git log and makes it accessible over
>     HTTP. As a result, e-mail addresses found in commits are exposed to web
>     crawlers and they may not respect robots.txt. This may result in
>     unsolicited messages. This is a feature for redacting e-mail addresses
>     from the generated HTML, etc. content.
>     
>     This feature does not prevent someone from downloading the unredacted
>     commit log, e.g., by cloning the repository, and extracting information
>     from it. It aims to hinder the low-effort bulk collection of e-mail
>     addresses by web crawlers.

You do not need to repeat the above, which is in the log message above.

>     Changes since v1:
>     
>      * Turned off the feature by default.
>      * Removed duplicate code.
>      * Added note about Gitweb consumers receiving redacted logs.
>     
>     Changes since v2:
>     
>      * The feature can be set on a per-project basis. ('override' => 1)
>     
>     Changes since v3:
>     
>      * Renamed feature to "email-privacy" and improved documentation.
>      * Removed UI elements for git-format-patch since it won't be redacted.
>      * Simplified calls to the address redaction logic.
>      * Mail::Address is now used to reduce false-positive redactions.

Having these under the --- line like this is very helpful.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0959a782eccb..6630c76d92fd 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -21,6 +21,7 @@
>  use File::Basename qw(basename);
>  use Time::HiRes qw(gettimeofday tv_interval);
>  use Digest::MD5 qw(md5_hex);
> +use Git::LoadCPAN::Mail::Address;

I'll defer to others who are more familiar with gitweb and Perl
ecosystem if this is warranted, but I have a feeling that importing
and using Mail::Address->parse() only because we want to see if a
given "<string>" is an address is a bit overkill and it might be
sufficient to do something as crude as m/^<[^@>]+@[a-z0-9-.]+>$/i

> +	# Redact e-mail addresses.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'email-privacy'}{'default'} = [1];
> +	'email-privacy' => {
> +		'sub' => sub { feature_bool('email-privacy', @_) },
> +		'override' => 1,
> +		'default' => [0]},
>  );
>  
>  sub gitweb_get_feature {
> @@ -3449,6 +3459,32 @@ sub parse_date {
>  	return %date;
>  }
>  
> +sub is_mailaddr {
> +	my @addrs = Mail::Address->parse(shift);
> +	if (!@addrs || !$addrs[0]->host || !$addrs[0]->user) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +sub hide_mailaddrs_if_private {
> +	my $line = shift;
> +	return $line unless gitweb_check_feature('email-privacy');
> +	while ($line =~ m/(<[^>]+>)/g) {
> +		my $match = $1;
> +		if (!is_mailaddr($match)) {
> +			next;
> +		}
> +		my $offset = pos $line;
> +		my $head = substr $line, 0, $offset - length($match);
> +		my $redaction = "<redacted>";
> +		my $tail = substr $line, $offset;
> +		$line = $head . $redaction . $tail;
> +		pos $line = length($head) + length($redaction);

Hmmmm, Perl suggestions from others?  It looks quite strange to see
that s/// operator is not used and replacement is done manually with
byte position in a Perl script.

>  sub parse_tag {
>  	my $tag_id = shift;
>  	my %tag;
> @@ -3465,7 +3501,7 @@ sub parse_tag {
>  		} elsif ($line =~ m/^tag (.+)$/) {
>  			$tag{'name'} = $1;
>  		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
> -			$tag{'author'} = $1;
> +			$tag{'author'} = hide_mailaddrs_if_private($1);
>  			$tag{'author_epoch'} = $2;
>  			$tag{'author_tz'} = $3;
>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {

This (and the others that follow the same pattern) looks sensible.

> @@ -7489,7 +7526,8 @@ sub git_log_generic {
>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>  	}
>  	my $patch_max = gitweb_get_feature('patches');
> -	if ($patch_max && !defined $file_name) {
> +	if ($patch_max && !defined $file_name &&
> +		!gitweb_check_feature('email-privacy')) {
>  		if ($patch_max < 0 || @commitlist <= $patch_max) {
>  			$paging_nav .= " &sdot; " .
>  				$cgi->a({-href => href(action=>"patches", -replay=>1)},
> @@ -7550,7 +7588,8 @@ sub git_commit {
>  			} @$parents ) .
>  			')';
>  	}
> -	if (gitweb_check_feature('patches') && @$parents <= 1) {
> +	if (gitweb_check_feature('patches') && @$parents <= 1 &&
> +		!gitweb_check_feature('email-privacy')) {
>  		$formats_nav .= " | " .
>  			$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  				"patch");
> @@ -7863,7 +7902,8 @@ sub git_commitdiff {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>  			        "raw");
> -		if ($patch_max && @{$co{'parents'}} <= 1) {
> +		if ($patch_max && @{$co{'parents'}} <= 1 &&
> +			!gitweb_check_feature('email-privacy')) {
>  			$formats_nav .= " | " .
>  				$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  					"patch");

I wouldn't have expected to see the above three hunks in the
"patch" codepath.  Rather, I was hoping that you'd do something
like this at startup when you find out that the privacy feature
is enabled:

	$feature{'patches'}{'default'} = [0]
		if gitweb_get_feature('email-privacy');

so that nothing related to the 'patches' has to be modified.
That way, even if there were fourth place that can leak an e-mail
address in the 'patch' codepath that above three hunks in this patch
missed, crawlers won't be able to get at it, no?

> diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
> index 1f32ca66ea51..77fc1298d4c6 100644
> --- a/t/lib-gitweb.sh
> +++ b/t/lib-gitweb.sh
> @@ -67,6 +67,9 @@ gitweb_run () {
>  	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
>  	export GITWEB_CONFIG
>  
> +	PERL5LIB="$GIT_BUILD_DIR/perl:$GIT_BUILD_DIR/perl/FromCPAN"
> +	export PERL5LIB
> +

Why is this change suddenly become necessary?  This addition is only
about tests---do we need to do something similar in the runtime
environment when the updated gitweb that requires Mail::Address gets
deployed, or is that covered already somewhere else?

Thanks.
