Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CFC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5978A206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiaW8ts3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDZARp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDZARp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 20:17:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149AC061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:17:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so6880638pfc.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ps2tSrmo1zBgtyhcHgDCyah75XMTIqCIMIHpxwaKH44=;
        b=uiaW8ts3X+gU+Gp3g5rzSpA30jn6jHiL4s2vZOLlkwnnKATuaqpWIzn/KB6fgc+J/7
         oG+4xkZGkqpFP2qSlkdcc5sX4jkevLNnmDgrlBZIuLxqgpJLES3BvTITXFQVqBABR5qX
         c/pASUUAfx7ZAZk6fSRTE1E4etPzvZwGA3W+UElPIwXyhrv3sxrtjKnhpcmhF/peaFEX
         afwpc6kJB1dhirCwMCbNvRtc4yTG2yXTrEKRRaElFHiaKjNUHHztm1Sb/+/6ld9KKu40
         nmOID6+AEeypvn4Bkn8GsvrVNBMMC6tpi0YI0q7MCXRj4xKt7RJSj36VWeqTyv9lgY3t
         OmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ps2tSrmo1zBgtyhcHgDCyah75XMTIqCIMIHpxwaKH44=;
        b=EZAK/Iy3+ekroG0P51wzy+J/m5cahtmJqeJeTcxsVOOxVre4mwjMwMW0cvbqHE47kH
         BfDWA4y0zluGN5tjlAuDGQ950iBqawySYeXxckHXDyPvGVHn7D2IX+ljO13yWyS9/mn9
         3ZlYX6bAXfGH5gof3tQKyELa03V3KbyrJydJJd5nK3oIceJsYFqHlgm5RWPFSrupqFJ7
         K0x+sbDkh+8V8CiEe0Id1zYip63thrtJEZEMZ8UXaScsdm1WJYLT0K/W1l3Bfqf/sc65
         WMGWGdS6RtWK0SaE7Vg3QWQEH21U22wEcQmFFzaRkpSSLi52TuteuwR2tGReAJ7XmXil
         477Q==
X-Gm-Message-State: AGi0PubYK9uIKmiiLtZBzvvBS5F8fJ8tndC4hKGJv6BqpVgD5kkIDnHv
        VlAl3VnFFkSr8XE1osav8WjBJdzB
X-Google-Smtp-Source: APiQypL9/+rzCGfplj62/xGVfLCmAxd5QRwQNHGtr3r14DOMFwW6ioyqT3/tzVrskwodJG+fGP68Jw==
X-Received: by 2002:a62:92:: with SMTP id 140mr16187613pfa.186.1587860264283;
        Sat, 25 Apr 2020 17:17:44 -0700 (PDT)
Received: from gmail.com (174.247.233.35.bc.googleusercontent.com. [35.233.247.174])
        by smtp.gmail.com with ESMTPSA id o11sm7743696pgd.58.2020.04.25.17.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 17:17:43 -0700 (PDT)
Date:   Sat, 25 Apr 2020 17:17:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Rapha=EBl?= Gertz via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?Rapha=EBl?= Gertz <git@rapsys.eu>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] commit:fix use of uninitialized value [...] in server log
Message-ID: <20200426001740.GB877@gmail.com>
References: <pull.767.git.git.1587847338677.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.767.git.git.1587847338677.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Jakub Narębski, gitweb expert; Giuseppe Bilotta, who contributed
 snapshot_format)
Raphaël Gertz wrote:

>     This is a simple fix that I did long ago that check carefully the index
>     before running tests on it.
>     
>     My goal is to avoid re-applying the patch on each distribution update.

Thanks for contributing.  That certainly seems like a good goal. :)

[...]
> Subject: commit:fix use of uninitialized value [...] in server log
>
> This change fix the message about uninitialized value when trying to
> access undefined hash indexes.
>
> The error message fixed:
> Use of uninitialized value $params{"action"} in string eq at gitweb.cgi
> line 1377

Some nitpicks about the commit message (see
Documentation/SubmittingPatches "Describe your changes well" for more on
this subject):

- the subject line should start with the subsystem being improved, a
  colon, and a space.  Here, that subsystem is gitweb.

- focus on describing what improvement the patch intends to make.  The
  description should be in the imperative mood, as though ordering the
  codebase to improve.

- try to cover what a person trying to understand whether to apply
  this patch would want to know beyond what is already in the patch
  itself.  What user-facing behavior change does the patch make?  How
  was the problem discovered?  What downsides are there, if any?

I think that would mean something like

	gitweb: check whether query params are defined before use

	In normal use, gitweb spams the web server error log:

	  Use of uninitialized value $params{"action"} in string eq at gitweb.cgi line 1377

	The 'action' parameter is optional so this is not warning about
	anything meaningful. Check whether the parameter is defined
	before using it to avoid the warning.

	Signed-off-by: ...

> Add myself as warning fix author.
> 
> Signed-off-by: Raphaël Gertz <git@rapsys.eu>
> ---
[...]
>  gitweb/README      | 3 +++
>  gitweb/gitweb.perl | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/README b/gitweb/README
> index 471dcfb691b..8964478a3fc 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -66,5 +66,8 @@ AUTHORS
>  Originally written by:
>    Kay Sievers <kay.sievers@vrfy.org>
>  
> +Perl warning fix:
> +  Raphaël Gertz <git@rapsys.eu>

Please don't.  A contributor list can be obtained using "git shortlog
-n -s -- gitweb".  A second changelog would fall out of sync with
that.

[...]
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1420,7 +1420,7 @@ sub href {
>  
>  		# since we destructively absorb parameters, we keep this
>  		# boolean that remembers if we're handling a snapshot
> -		my $is_snapshot = $params{'action'} eq 'snapshot';
> +		my $is_snapshot = defined $params{'action'} && $params{'action'} eq 'snapshot';

nit: long line

Other parameters like 'project' similarly use a defined check like
this, so it's consistent.  Good.

>  
>  		# Summary just uses the project path URL, any other action is
>  		# added to the URL
> 		if (defined $params{'action'}) {

optional: should we reuse this "if"?  That is, something like

		my $is_snapshot = 0;

		if (defined $params{'action'}) {
			$is_snapshot = $params{'action'} eq 'snapshot';
			$href .= ...

[...]
> @@ -6012,7 +6012,7 @@ sub git_history_body {
>  		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>  
> -		if ($ftype eq 'blob') {
> +		if (defined $ftype && $ftype eq 'blob') {

What is this part about?  The commit message doesn't describe it.

>  			print " | " .
>  			      $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
>  
> 

Thanks and hope that helps,
Jonathan
