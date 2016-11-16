Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3072021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbcKPAFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:05:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752742AbcKPAFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:05:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F30D44FC0B;
        Tue, 15 Nov 2016 19:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nAK3YVIkwXyyWKlsJky9Jdtq9mM=; b=PIRLpR
        U/kq7uJh21//mlx80rqILTUeON04U46QNCAfFuyf/EQwhPDSpMM6TsEZKjOl7D7L
        XcNHeDiaL9Hd18tlg8JYXRtV7UYFfCboX9uA0yog82NOFpZpwOTvH5g4J+JmvrJ7
        wpXmCJ5hhG9Os5BlVL9xQqQz0/QOTvTYr6cBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YAOChWaj0i57u3GolZcDYtiijJCLpTle
        hRDN8s6cC3TaLFpea4h9gWkDKxlIKLwELe/bh9R719FDbu715/lENjh2xBdnhlUU
        j4BDjElLYEHOpHQc80sj7GAUJLu8iCTefaBDMKj4UbGk86E8lhlVpGPmMh52Fh5M
        NviRwceLQLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA2804FC0A;
        Tue, 15 Nov 2016 19:05:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F94D4FC09;
        Tue, 15 Nov 2016 19:05:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     =?utf-8?Q?Rapha=C3=ABl?= Gertz <mageia@rapsys.eu>,
        git@vger.kernel.org
Subject: Re: gitweb html validation
References: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu>
        <20161115182632.GA17539@gmail.com>
Date:   Tue, 15 Nov 2016 16:05:34 -0800
In-Reply-To: <20161115182632.GA17539@gmail.com> (Ralf Thielow's message of
        "Tue, 15 Nov 2016 19:26:32 +0100")
Message-ID: <xmqqy40ks301.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6680D5E2-AB90-11E6-AF4A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Only block level elements are
> allowed to be inside form tags, according to
> https://www.w3.org/2010/04/xhtml10-strict.html#elem_form
> ...
> I think it's better to just move the <form>-Tag outside of the
> surrounding div?
> Something like this perhaps, I didn't test it myself yet.

That sounds like a sensible update to me (no, I do not run gitweb
myself).  Is this the only <form> we have in the UI, or is it the
only one that is problematic?

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7cf68f07b..33d7c154f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5531,8 +5531,8 @@ sub git_project_search_form {
>  		$limit = " in '$project_filter/'";
>  	}
>  
> -	print "<div class=\"projsearch\">\n";
>  	print $cgi->start_form(-method => 'get', -action => $my_uri) .
> +	      "<div class=\"projsearch\">\n" .
>  	      $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
>  	print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
>  		if (defined $project_filter);
> @@ -5544,11 +5544,11 @@ sub git_project_search_form {
>  	                     -checked => $search_use_regexp) .
>  	      "</span>\n" .
>  	      $cgi->submit(-name => 'btnS', -value => 'Search') .
> -	      $cgi->end_form() . "\n" .
>  	      $cgi->a({-href => href(project => undef, searchtext => undef,
>  	                             project_filter => $project_filter)},
>  	              esc_html("List all projects$limit")) . "<br />\n";
> -	print "</div>\n";
> +	print "</div>\n" .
> +	      $cgi->end_form() . "\n";
>  }
>  
>  # entry for given @keys needs filling if at least one of keys in list
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 321260103..507740b6a 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -539,7 +539,7 @@ div.projsearch {
>  	margin: 20px 0px;
>  }
>  
> -div.projsearch form {
> +form div.projsearch {
>  	margin-bottom: 2px;
>  }
>  
