Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CDC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DAC206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+r1SfNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgHOV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgHOVwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED24C06135E
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:28:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so5190485pju.4
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tXWedCEFhAs0lhXi3+/RhnTdneoUxzV86vUgVGgXXRA=;
        b=n+r1SfNSP/D3qFJuP88i8iDWkqhzMAw+LelKMFo3QRYAnLT+HjSQoHpbkO5j/LYqOQ
         QKY8622lLRwmY5i2cIAst4FMAjR/l9zgjW0hfXadw1lXyhpO09Q/slaPXk7vhix4uuMu
         4Ny0i/MQxSKPcZQ2KkVAUbouepLh9eVvPZkcVWLwgjIM6bngeMWUIdFGsvj7L6xIRtuX
         lb2OsU2fKYDlOMFb1ueBlkblZFqp0J7ELSZdW5TjVleV96apypYMMmbwUDEnc8byLLCM
         qDcxQlErhomXsR17Mcc8jvU2WJPC8Yj2YI8sICns13zka0P0JhnGGKcCf7g4SSdxN16p
         N2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tXWedCEFhAs0lhXi3+/RhnTdneoUxzV86vUgVGgXXRA=;
        b=OWem4xxQ417gbsCRTUOsih6o4Gh7M471TeK+PeMnjEYzwMorH2s7H6RWPdPD3oIs7g
         p6+Hj+UlKP1ZW3sjerPaGyZ4KGSHfqxUbFeOtJmA5ysMB1vQliOV4m5lEUcT28Tq3Ql1
         u7DJAhFScEUZ3XWC0/Yjft8lvfmW67CdMkjYcXy2UtynIG13tZ0GbYn6SNMdKVw5lWVH
         BtOfklBDvn7rcA1CNxA+FztFmm/07PJdfG3e4uAFujfUzulgbqJhY4EGsCDflbXkllj9
         CXtDLqCUi8N2v/CoyxaicRZZM+ZuSgdBMBBYXZjYUOUbx10bfNgTp+5aQRCQ8B0JYD+b
         mX0Q==
X-Gm-Message-State: AOAM5333mm/ztarZOkVfjmG1HocT6h7lXed8/0jR16rcRZASgeFUD0ga
        yQjNq25u/gw+AhLo1Ysf7ug=
X-Google-Smtp-Source: ABdhPJyg5rfda5FB3UxE5a6mQonb5vITnumKqiMB6FOVenhAZBE99B4yYvQHgGc5kGKW4wVlX/BXXQ==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr2850606plq.283.1597458482657;
        Fri, 14 Aug 2020 19:28:02 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id bt10sm9387666pjb.39.2020.08.14.19.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 19:28:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 09:27:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's
 name
Message-ID: <20200815022759.GC12363@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597364493.git.congdanhqx@gmail.com>
 <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
 <20200814151815.GA29528@szeder.dev>
 <xmqqwo21xiuy.fsf@gitster.c.googlers.com>
 <xmqqy2mhvys6.fsf@gitster.c.googlers.com>
 <20200815002120.GQ8085@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815002120.GQ8085@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-15 00:21:20+0000, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2020-08-14 at 18:59:53, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Ouch.  These apparently come from
> > >
> > > process_diffs () {
> > > ...
> > > }
> > >
> > > Hash-independence may be good, but it should not munge expected mode
> > > bits from 100644 to ffff44, which I think is a bug in the original
> > > introduced in 72f936b1 (t4013: make test hash independent,
> > > 2020-02-07).
> > >
> > > When we are adjusting the abbrev length of the index line, of course
> > > $_x07 would not be sufficient to match the abbreviated object name
> > > in full, so a79 vs 895 can be explained and is a bug in this patch
> > > that did not update the process_diffs helper.
> > >
> > > Another thing that I find somewhat problematic in the original
> > > (brian cc'ed) is that it does not special case all-zero object name
> > > specially.  By turning any and all instances of $_x40 to $ZERO_OID,
> > > we lose the distinction between a random-looking object name which
> > > got turned into $ZERO_OID by the processing, and an object name that
> > > was $ZERO_OID from the beginning, so we won't catch a possible
> > > future bug where new file's preimage object name is not $ZERO_OID
> > > (this is plausible when you try to show an intent-to-add entry; the
> > > diff between the index and the working tree would be "new file"
> > > patch, but the index entry records the object name for an empty
> > > blob, e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 instead of $ZERO_OID
> > > can easily be emitted by a mistaken implementation).
> 
> Yeah, it wasn't intended that we munge mode bits, and I definitely agree
> we'd be better off distinguishing between all-zero and non-zero OIDs.
> 
> As you might imagine, this is not my favorite test because have a large
> amount of diff formats, and even I think the giant list of sed
> expressions I wrote is hideous.  It is, however, reasonably
> comprehensive, which is pretty much the only nice thing that can be said
> about it.
> 
> > So here is what I came up with as a possible starting point.  The
> > idea is to grab hexadecimal strings at locations the original tried
> > to isolate with various contexts, and
> > 
> >  - if the input happens to be all zero, use '0', otherwise use 'f'
> > 
> >  - if the input is 40-bytes (i.e. unabbreviated object name in the
> >    SHA-1 world), repeat the character chosen in the first step as
> >    many times as there are chars in $ZERO_OID
> > 
> >  - otherwise, repeat the character chosen in the first step as many
> >    times as there are chars in the input.
> > 
> >  - regardless of all of the above, special case possible in-tree
> >    blob modes (100644, 100755 and 120000) and don't munge them.
> > 
> > I haven't tried it with the patch that started this discussion
> > thread, nor with SHA-256 build, though.
> 
> This seems like a sane approach.
> 
> > diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> > index 43267d6024..b33e60ab9d 100755
> > --- a/t/t4013-diff-various.sh
> > +++ b/t/t4013-diff-various.sh
> > @@ -130,27 +130,43 @@ test_expect_success setup '
> >  EOF
> >  
> >  process_diffs () {
> > -	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> > -	_x07="$_x05[0-9a-f][0-9a-f]" &&
> > -	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> > -	    -e "s/From $_x40 /From $ZERO_OID /" \
> > -	    -e "s/from $_x40)/from $ZERO_OID)/" \
> > -	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> > -	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> > -	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> > -	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> > -	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> > -	    -e "s/^$_x40 /$ZERO_OID /" \
> > -	    -e "s/^$_x40$/$ZERO_OID/" \
> > -	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
> > -	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
> > -	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
> > -	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
> > -	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
> > -	    -e "s/$_x07\.\.\./fffffff.../g" \
> > -	    -e "s/ $_x04\.\.\./ ffff.../g" \
> > -	    -e "s/ $_x04/ ffff/g" \
> > -	    "$1"
> > +	perl -e '
> > +		my $oid_length = length($ARGV[0]);
> > +		my $x40 = "[0-9a-f]{40}";
> > +		my $xab = "[0-9a-f]{4,16}";
> > +		my $orx = "[0-9a-f]" x $oid_length;
> > +
> > +		sub munge_oid {
> > +			my ($oid) = @_;
> > +			my $x;
> > +
> > +			if ($oid =~ /^(100644|100755|120000)$/) {
> > +				return $oid;
> > +			}
> > +
> > +			if ($oid =~ /^0*$/) {
> > +				$x = "0";
> > +			} else {
> > +				$x = "f";
> > +			}
> > +
> > +			if (length($oid) == 40) {
> > +				return $x x $oid_length;
> > +			} else {
> > +				return $x x length($oid);
> > +			}
> > +		}
> > +
> > +		while (<STDIN>) {
> > +			s/($orx)/munge_oid($1)/ge;
> > +			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
> > +			s/commit ($x40)($| \()/"commit " . munge_oid($1) . $2/ge;
> > +			s/($x40) /munge_oid($1) . " "/ge;
> > +			s/^($x40)($| )/munge_oid($1) . $2/e;
> > +			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
> > +			print;
> > +		}
> > +	' "$ZERO_OID" <"$1"
> >  }
> 
> This is much nicer, but I think we need the following on top of it
> because we have a couple of tricky cases the original didn't consider:
> 
> * Some of our 64-bit object IDs get processed twice, turning them into
>   88-character object IDs, which don't match.  We therefore need "\b".
> * The new unabbreviated index lines aren't accounted for, so I included
>   them by possibly matching "\.\.".
> * We have some lines that look like "commit $OID (from $OID)" that
>   aren't accounted for.  Because we now have an optional OID in
>   munge_oid, I had to account for that as well.
> 
> So this is what's on top:
> 
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index b5c7e1a63b..dfc87a0d19 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -140,6 +140,8 @@ process_diffs () {
>  			my ($oid) = @_;
>  			my $x;
>  
> +			return "" unless length $oid;
> +
>  			if ($oid =~ /^(100644|100755|120000)$/) {
>  				return $oid;
>  			}
> @@ -160,8 +162,8 @@ process_diffs () {
>  		while (<STDIN>) {
>  			s/($orx)/munge_oid($1)/ge;
>  			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
> -			s/commit ($x40)($| \()/"commit " . munge_oid($1) . $2/ge;
> -			s/($x40) /munge_oid($1) . " "/ge;
> +			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 . munge_oid($3)/ge;
> +			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
>  			s/^($x40)($| )/munge_oid($1) . $2/e;
>  			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
>  			print;
> 
> Or, a fresh original version:
> 
> -- %< --
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index e6eb4dd4c7..dfc87a0d19 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -130,27 +130,45 @@ test_expect_success setup '
>  EOF
>  
>  process_diffs () {
> -	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> -	_x07="$_x05[0-9a-f][0-9a-f]" &&
> -	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> -	    -e "s/From $_x40 /From $ZERO_OID /" \
> -	    -e "s/from $_x40)/from $ZERO_OID)/" \
> -	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> -	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> -	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> -	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> -	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> -	    -e "s/^$_x40 /$ZERO_OID /" \
> -	    -e "s/^$_x40$/$ZERO_OID/" \
> -	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
> -	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
> -	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
> -	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
> -	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
> -	    -e "s/$_x07\.\.\./fffffff.../g" \
> -	    -e "s/ $_x04\.\.\./ ffff.../g" \
> -	    -e "s/ $_x04/ ffff/g" \
> -	    "$1"
> +	perl -e '
> +		my $oid_length = length($ARGV[0]);
> +		my $x40 = "[0-9a-f]{40}";
> +		my $xab = "[0-9a-f]{4,16}";
> +		my $orx = "[0-9a-f]" x $oid_length;
> +
> +		sub munge_oid {
> +			my ($oid) = @_;
> +			my $x;
> +
> +			return "" unless length $oid;
> +
> +			if ($oid =~ /^(100644|100755|120000)$/) {
> +				return $oid;
> +			}
> +
> +			if ($oid =~ /^0*$/) {
> +				$x = "0";
> +			} else {
> +				$x = "f";
> +			}
> +
> +			if (length($oid) == 40) {
> +				return $x x $oid_length;
> +			} else {
> +				return $x x length($oid);
> +			}
> +		}
> +
> +		while (<STDIN>) {
> +			s/($orx)/munge_oid($1)/ge;
> +			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
> +			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 . munge_oid($3)/ge;
> +			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
> +			s/^($x40)($| )/munge_oid($1) . $2/e;
> +			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
> +			print;
> +		}
> +	' "$ZERO_OID" <"$1"
>  }
>  
>  V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
> -- %< --
> 
> Anyone is welcome to have my sign-off if they pick up any part of this
> patch.

This one seems to work with:

	make -j9 test GIT_TEST_DEFAULT_HASH=sha256

If noone step up and write this into a patch in some days,
I'll take this as first step in my series.

Also waiting some days so other people could come up with better idea,
sed's y seems to be able to work if we don't have the constraint
on all-0 oid.


-- 
Danh
