Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D480FA3740
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiJUQx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiJUQxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793392852B5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:53:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w8so5828457edc.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbmaeui0qoARd8/5OLApyGD4iLYXDTXe6DDAVZzTf7w=;
        b=oYJjt5vG1Cj6OUA57l50sr+Pgw7OkTrdTnXVnnGn7uxSqz3O3KfbO/sC8w0DIIMZM4
         pRUARkAhXmFwkmFH3RxX0GNru455nOGu7rSW0BGdyF1eKEBCJ259zYVxj4WFMdpEgMQl
         ZZJBPHUf8mcki74AmTGm2MNkLC0k+VjMEAK/vASrJMUqMTj8qfDNxVZvrkHHU8jt4Nqu
         vnJLtFKsJx0c23rnrI0CyQcYkEjOPqPYja/dqObCV+/04zu6fYtJ4cKDwBDjLf6YTPrq
         doCiFH5afBguS/IgKb7N+slN/F69hzdcf/U98ujnyt5Kd7HRaCyvlmHXebGQLbhk+9Z6
         4QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbmaeui0qoARd8/5OLApyGD4iLYXDTXe6DDAVZzTf7w=;
        b=skUnCoNZVNKr1s7t11QkbjlZPSxIP2DKwVU899OI9ZBRx71MP1bJyeSBfk3FpHaZOB
         Ixw0T9AqAOiob3pWy5QQBr0K/muMdhY9gFHHeSzYqAm5DQlj9SXcnxLDHaVSPi2DtLJ9
         f5WtjND8WUSxADbnZFcraoAein5vPsj+cXFFFBhMmOjHc+Z1xsEvVAjcdVcbX6LYCAuo
         74llcK41OT/7DwVwCmwYI86vFnB2HOHrXIwA6OxTAjjeErk2NVZKWOwX5u2veD1wYEA/
         edxvr3CP4KhL0bUSfuUmDFS34KpCkph1ViXqnKxVBw8oCaQXG2qbERPLiErJxORMK2Q/
         ClKQ==
X-Gm-Message-State: ACrzQf1A77s5sgChy8M3DuW4wXbNCev767uZ9ZXNgRnbI1SdvgsYDMw5
        vKEBSTDfst07/35CHLDhyInJfJwLCoBz8g==
X-Google-Smtp-Source: AMsMyM4GKdRRR+Qixx/lgu++GMQKu6tqHeIssEOD5km/1dXLCb0Y+lHC/+ZOfEhex8yxN374kOD70Q==
X-Received: by 2002:a17:907:a429:b0:78d:b517:735 with SMTP id sg41-20020a170907a42900b0078db5170735mr16503020ejc.318.1666371207388;
        Fri, 21 Oct 2022 09:53:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b0073c80d008d5sm11628454ejb.122.2022.10.21.09.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olvGu-00767n-2b;
        Fri, 21 Oct 2022 18:53:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/build-docdep.perl: generate sorted output
Date:   Fri, 21 Oct 2022 18:52:26 +0200
References: <20221021102950.539148-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221021102950.539148-1-szeder.dev@gmail.com>
Message-ID: <221021.86ilkddsor.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, SZEDER G=C3=A1bor wrote:

> To make sure that our manpages are rebuilt when any of the included
> source files change and only the affected manpages are rebuilt,
> 'build-docdep.perl' scans our documentation source files for include
> directives, and outputs 'make' dependencies to be included by
> 'Documentation/Makefile'.  This script relies on Perl's hash data
> structures, and generates its output while iterating over them, and
> since hashes in Perl are very much unordered, the output varies
> greatly from run to run, both the order of targets and the order of
> dependencies of each target.
>
> This lack of ordering doesn't matter for 'make', because it cares
> neither about the order of targets in a Makefile nor about the order
> of a target's dependencies.  However, it does matter to developers
> looking into build issues potentially involving these generated
> dependencies, as it's rather hard to tell whether there are any
> relevant (i.e. not order-only) changes among the dependencies compared
> to the previous run.
>
> So let's make 'build-docdep.perl's output stable and ordered by
> sorting the keys of the hashes before iterating over them.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/build-docdep.perl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep=
.perl
> index ba4205e030..1b3ac8fdd9 100755
> --- a/Documentation/build-docdep.perl
> +++ b/Documentation/build-docdep.perl
> @@ -38,9 +38,10 @@
>      }
>  }
>=20=20
> -while (my ($text, $included) =3D each %include) {
> +foreach my $text (sort keys %include) {
> +    my $included =3D $include{$text};
>      if (! exists $included{$text} &&
>  	(my $base =3D $text) =3D~ s/\.txt$//) {
> -	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
> +	print "$base.html $base.xml : ", join(" ", sort keys %$included), "\n";
>      }
>  }

This looks good to me, FWIW I ran this ad-hoc test and it's the same,
i.e. we end up with the same order as the initial glob order on the FS:
=09
	diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.=
perl
	index ba4205e0302..6f6e6c62eb8 100755
	--- a/Documentation/build-docdep.perl
	+++ b/Documentation/build-docdep.perl
	@@ -1,9 +1,13 @@
	 #!/usr/bin/perl
	+use strict;
	+use warnings;
=09=20
	 my %include =3D ();
	 my %included =3D ();
=09=20
	-for my $text (<*.txt>) {
	+my @txt =3D <*.txt>;
	+
	+for my $text (@txt) {
	     open I, '<', $text || die "cannot read: $text";
	     while (<I>) {
	 	if (/^include::/) {
	@@ -38,9 +42,11 @@
	     }
	 }
=09=20
	-while (my ($text, $included) =3D each %include) {
	+
	+for my $text (grep { exists $include{$_} } @txt) {
	+    my $included =3D $include{$text};
	     if (! exists $included{$text} &&
	 	(my $base =3D $text) =3D~ s/\.txt$//) {
	-	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
	+	print "$base.html $base.xml : ", join(" ", sort keys %$included), "\n";
	     }
	 }
=09
