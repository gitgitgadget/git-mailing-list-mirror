Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30611C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094122073E
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BJWGc1GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgEDRMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:12:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51650 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgEDRMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 13:12:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89D7BDA852;
        Mon,  4 May 2020 13:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M1bik5XQdHCKg6xVewsGSMqX+W0=; b=BJWGc1
        GBY8XqTR+epgBw2xPqvLdivWx3P9tn4yuCb9bcIpRtDkMIxEClKZew3p2Tn7Ofve
        zgngOpFeg3FlVGTBosPU9jEIeSsqfmlrNOSkNnQjmNNcTzb41F+CY23m5csGlHid
        v4hzP7x0DJHmr2zdvbQ913qk4etXA3px6iIY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BqICVSKXp2s0LGwJozD2ve6Uw6EXxsBw
        jOY0Yu/dat1xvcxCWH4w5fL6QQk6PXHpUYC2jOeqj55o2ntpkSd0rHFi/POojktX
        yWm/aN+4gRDcEeeG0WcJphJR/X33df+y+uniOFh7BC6vVnsK2+HvneJtGDA0BHTg
        BaJ6mOL2KTg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 815A6DA851;
        Mon,  4 May 2020 13:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B9836DA84F;
        Mon,  4 May 2020 13:12:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/6] vcxproj: adjust for the reftable changes
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
        <d05b9b9a2e0a49b1bacf0dafb99d36cd213181dc.1588599086.git.gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 10:12:48 -0700
In-Reply-To: <d05b9b9a2e0a49b1bacf0dafb99d36cd213181dc.1588599086.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 04 May 2020
        13:31:26 +0000")
Message-ID: <xmqqbln3hbe7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B5E195E-8E2A-11EA-ADEF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This allows Git to be compiled via Visual Studio again after integrating
> the `hn/reftable` branch.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname                           |  2 +-
>  contrib/buildsystems/Generators/Vcxproj.pm | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e009383..8a01a0da3f1 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -700,7 +700,7 @@ vcxproj:
>  	# Make .vcxproj files and add them
>  	unset QUIET_GEN QUIET_BUILT_IN; \
>  	perl contrib/buildsystems/generate -g Vcxproj
> -	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
> +	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
>  
>  	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
>  	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
> diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
> index 5c666f9ac03..33a08d31652 100644
> --- a/contrib/buildsystems/Generators/Vcxproj.pm
> +++ b/contrib/buildsystems/Generators/Vcxproj.pm
> @@ -77,7 +77,7 @@ sub createProject {
>      my $libs_release = "\n    ";
>      my $libs_debug = "\n    ";
>      if (!$static_library) {
> -      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
> +      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
>        $libs_debug = $libs_release;
>        $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
>        $libs_debug =~ s/libcurl\.lib/libcurl-d\.lib/g;
> @@ -231,6 +231,7 @@ sub createProject {
>  EOM
>      if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
>        my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
> +      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
>        my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
>  
>        print F << "EOM";
> @@ -240,6 +241,14 @@ sub createProject {
>        <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
>      </ProjectReference>
>  EOM
> +      if (!($name =~ /xdiff|libreftable/)) {

Wow.  That is messy.  I find it somewhat funny that this is not just
libreftable, i.e. "don't include/refer to libreftable in itself",
but as long as it works, I won't complain ;-)

Thanks for helping the tip of 'pu' moving forward.

> +        print F << "EOM";
> +    <ProjectReference Include="$cdup\\reftable\\libreftable\\libreftable.vcxproj">
> +      <Project>$uuid_libreftable</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +EOM
> +      }
>        if (!($name =~ 'xdiff')) {
>          print F << "EOM";
>      <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
