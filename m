From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] notes: add notes.merge option to select default strategy
Date: Wed, 05 Aug 2015 13:47:35 -0700
Message-ID: <xmqqegjh31js.fsf@gitster.dls.corp.google.com>
References: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
	<1438510226-1163-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:47:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5bD-0004UF-Az
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 22:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbHEUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 16:47:38 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36352 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbHEUri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 16:47:38 -0400
Received: by pacrr5 with SMTP id rr5so9405874pac.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+MUJcfgETZ+Axxuen6I9JRfzXT3N6ob9DGdO+dl9S7k=;
        b=HRw2b2YNqG7JQfbHs9D2+3jDcqaQlPpF6bu7ygbqxTDPsYnu6txk4cY49ib5Z9FhEy
         OUhMg5zpP+LeLEXrgLRe1DTNsxvmlALpGDlJXGACZ8T3WOFjC96a96SdekT8GvGM1iRg
         jZ5YASZ2WA3m34CfuNPZFcyVTDnjAnOjSiPeivVbaOQvTRfr7TIsKM3wCIArkkBT3K6n
         sQrmirEC3qtIb+Hl1FOYmDPtGMgaAeVxf1YSYA9tpsuNbC3JeP3VMKtCcQL4fTtru1t1
         CCZb9UXiU+kK9CcLh3uPF4XKlULoJlI0RGByrdVfWZSoizF10gzTwzsanvyNMU1JZc7b
         8csw==
X-Received: by 10.66.194.201 with SMTP id hy9mr23419009pac.140.1438807657654;
        Wed, 05 Aug 2015 13:47:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id nu6sm3885563pbb.64.2015.08.05.13.47.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 13:47:36 -0700 (PDT)
In-Reply-To: <1438510226-1163-4-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Sun, 2 Aug 2015 03:10:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275395>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-notes about a new configuration option "notes.merge" for
> selecting the default notes merge strategy. Document the option in
> config.txt and git-notes.txt
>
> Add tests for use of the configuration option. Include a test to ensure
> that --strategy correctly overrides the configured setting.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Cc: Johan Herland <johan@herland.net>
> Cc: Michael Haggerty <mhagger@alum.mit.edu>
> Cc: Eric Sunshine <sunshine@sunshineco.com>
> ---

Perhaps I am biased because we do not usually use Cc: around here,
but the above looks in a somewhat strange order.  Shouldn't your
sign-off be at the end?

> +static enum notes_merge_strategy merge_strategy;

OK.

> +static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *strategy)
> +{
> +	if (!strcmp(arg, "manual"))
> +		*strategy = NOTES_MERGE_RESOLVE_MANUAL;
> +	else if (!strcmp(arg, "ours"))
> +		*strategy = NOTES_MERGE_RESOLVE_OURS;
> +	else if (!strcmp(arg, "theirs"))
> +		*strategy = NOTES_MERGE_RESOLVE_THEIRS;
> +	else if (!strcmp(arg, "union"))
> +		*strategy = NOTES_MERGE_RESOLVE_UNION;
> +	else if (!strcmp(arg, "cat_sort_uniq"))
> +		*strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> +	else
> +		return -1;
> +
> +	return 0;
> +}

OK.

>  static int merge(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
> @@ -795,23 +815,13 @@ static int merge(int argc, const char **argv, const char *prefix)
>  	expand_notes_ref(&remote_ref);
>  	o.remote_ref = remote_ref.buf;
>  
> -	if (strategy) {
> -		if (!strcmp(strategy, "manual"))
> -			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> -		else if (!strcmp(strategy, "ours"))
> -			o.strategy = NOTES_MERGE_RESOLVE_OURS;
> -		else if (!strcmp(strategy, "theirs"))
> -			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> -		else if (!strcmp(strategy, "union"))
> -			o.strategy = NOTES_MERGE_RESOLVE_UNION;
> -		else if (!strcmp(strategy, "cat_sort_uniq"))
> -			o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> -		else {
> -			error("Unknown -s/--strategy: %s", strategy);
> -			usage_with_options(git_notes_merge_usage, options);
> -		}
> +	if (strategy && parse_notes_strategy(strategy, &merge_strategy)) {
> +		error("Unknown -s/--strategy: %s", strategy);
> +		usage_with_options(git_notes_merge_usage, options);
>  	}
>  
> +	o.strategy = merge_strategy;
> +

This may be a minor taste thing, but initializing "o.strategy" with
merge_strategy at the same place as "o.remote_ref" is initialized,
and then passing &o.merge_strategy to parse_notes_strategy(), may be
easier to follow.

Renaming the global "merge_strategy" to "configured_merge_strategy"
might make it even easier to follow.  If anybody uses the variable
instead of o.strategy after this point, it would be immediately
obvious that it is either a bug or it is deliberately using the
value from the configuration file, not command line.

Thanks.
