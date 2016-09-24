Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045AB1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965431AbcIXWe0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:34:26 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56588 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965409AbcIXWeY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Sep 2016 18:34:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E163203FE;
        Sat, 24 Sep 2016 18:34:24 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Sat, 24 Sep 2016 18:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=D3VlM0TMmacMA6FhLlIDjS1adt8=; b=bN9EQN
        EOS8knT/V9n45xRtkVsBudVRybv49LMTpjQRVO0JMtyQoFq9j8Uc9EO0t9HUkm6t
        HfnagNH4FDVmVFYQWDcsk/qqphOiOwEtlYwKxtbSr0zH998eo21eG6UZDcFqiIGR
        UoyxPKnXZFhY3zwYo2rkxkeO5LaUqxSD/L5bY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=D3VlM0TMmacMA6F
        hLlIDjS1adt8=; b=PiEUdNDgEAuQwPz7Kv5yfT5Lr14MP8boBJc3YkIR1Z2xM1A
        LKHHZq2ln7ld1+2ujeBNiAElzg+eW6/Ms5R4Gy4yMBBxplrFkmaXVS+2x7JA9oLC
        HnbuB4HWfFsUZL3nNKcxQWkLgjsnO8YxS7CRh8qktVorbHd8WEDAYXiR0pYU=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id CE61A2E184; Sat, 24 Sep 2016 18:34:23 -0400 (EDT)
Message-Id: <1474756463.3745393.735971833.7FD5B5C9@webmail.messagingengine.com>
X-Sasl-Enc: zxGvQ9gGTsx3jIATt08/rYby7ALFciryyCDTeBWruT+V 1474756463
From:   Ian Kelling <ian@iankelling.org>
To:     =?utf-8?Q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3ce3fca2
Subject: Re: [PATCH v3 2/2] gitweb: use highlight's shebang detection
Date:   Sat, 24 Sep 2016 15:34:23 -0700
In-Reply-To: <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
 <20160923090846.3086-1-ian@iankelling.org>
 <20160923090846.3086-2-ian@iankelling.org>
 <2a4c3efb-2145-b699-c980-3079f165a6e1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016, at 03:15 PM, Jakub Nar=C4=99bski wrote:
> W dniu 23.09.2016 o 11:08, Ian Kelling napisa=C5=82:
>
> > The "highlight" binary can, in some cases, determine the language type
> > by the means of file contents, for example the shebang in the first line
> > for some scripting languages.  Make use of this autodetection for files
> > which syntax is not known by gitweb.  In that case, pass the blob
> > contents to "highlight --force"; the parameter is needed to make it
> > always generate HTML output (which includes HTML-escaping).
>
> Right.
>
> >
> > Although we now run highlight on files which do not end up highlighted,
> > performance is virtually unaffected because when we call highlight, we
> > also call sanitize() instead of esc_html(), which is significantly
> > slower.
>
> This paragraph is a bit unclear, for example it is not obvious what
> "..., which is significantly slower" refers to: sanitize() or esc_html().
>
> I think it would be better to write:
>
>   Although we now run highlight on files which do not end up highlighted,
>   performance is virtually unaffected because when we call highlight, it
>   is used for escaping HTML.  In the case that highlight is used, gitweb
>   calls sanitize() instead of esc_html(), and the latter is significantly
>   slower (it does more, being roughly a superset of sanitize()).

Agree. Done in v4.

>
> >        After curling blob view of unhighlighted large and small text
> > files of perl code and license text 100 times each on a local
> > Apache/2.4.23 (Debian) instance, it's logs indicate +-1% difference in
> > request time for all file types.
>
> Also, "curling" is not the word I would like to see. I would say:
>
>   Simple benchmark comparing performance of 'blob' view of files without
>   syntax highlighting in gitweb before and after this change indicates
>   =C2=B11% difference in request time for all file types.  Benchmark was
>   performed on local instance on Debian, using Apache/2.4.23 web server
>   and CGI/PSGI/FCGI/mod_perl.
>
>       ^^^^^^^^^^^^^^^^^^^^^^--- select one
>
> Or something like that; I'm not sure how detailed this should be.
> But it is nice to have such benchmark in the commit message.


Sounds  good. Used it in v4.

>
> Anyway I think that adding yet another configuration toggle for selecting
> whether to use "highlight" syntax autodetection or not would be just an
> unnecessary complication.
>
> Note that the performance loss might be quite higher on MS Windows, with
> its higher cost of fork.  But then they probably do not configure
> server-side highligher anyway.
>
> >
> > Document the feature and improve syntax highlight documentation, add
> > test to ensure gitweb doesn't crash when language detection is used.
>
> Good.
>
> >
> > Signed-off-by: Ian Kelling <ian@iankelling.org>
> > ---
> >  Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
> >  gitweb/gitweb.perl                     | 10 +++++-----
> >  t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
> >  3 files changed, 27 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
> > index a79e350..e632089 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -246,13 +246,20 @@ $highlight_bin::
>
> We should probably say what does it mean to be "highlight"[1] compatible,
> but it is outside of scope for this patch, and I think also out of scope
> of this series.
>
> >  	Note that 'highlight' feature must be set for gitweb to actually
> >  	use syntax highlighting.
> >  +
> > -*NOTE*: if you want to add support for new file type (supported by
> > -"highlight" but not used by gitweb), you need to modify `%highlight_ex=
t`
> > -or `%highlight_basename`, depending on whether you detect type of file
> > -based on extension (for example "sh") or on its basename (for example
> > -"Makefile").  The keys of these hashes are extension and basename,
> > -respectively, and value for given key is name of syntax to be passed v=
ia
> > -`--syntax <syntax>` to highlighter.
> > +*NOTE*: for a file to be highlighted, its syntax type must be detected
> > +and that syntax must be supported by "highlight".  The default syntax
> > +detection is minimal, and there are many supported syntax types with no
> > +detection by default.  There are three options for adding syntax
> > +detection.  The first and second priority are `%highlight_basename` and
> > +`%highlight_ext`, which detect based on basename (the full filename, f=
or
> > +example "Makefile") and extension (for example "sh").  The keys of the=
se
> > +hashes are the basename and extension, respectively, and the value for=
 a
> > +given key is the name of the syntax to be passed via `--syntax <syntax=
>`
> > +to "highlight".  The last priority is the "highlight" configuration of
> > +`Shebang` regular expressions to detect the language based on the first
> > +line in the file, (for example, matching the line "#!/bin/bash").  See
> > +the highlight documentation and the default config at
> > +/etc/highlight/filetypes.conf for more details.
>
> All right. I guess /etc/highlight/filetypes.conf is the standard
> location?

I think so. I checked packages from homebrew, fedora, suse, debian to
confirm.

>
> >  +
> >  For example if repositories you are hosting use "phtml" extension for
> >  PHP files, and you want to have correct syntax-highlighting for those
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 6cb4280..44094f4 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3931,15 +3931,16 @@ sub guess_file_syntax {
> >  # or return original FD if no highlighting
> >  sub run_highlighter {
> >  	my ($fd, $highlight, $syntax) =3D @_;
> > -	return $fd unless ($highlight && defined $syntax);
> > +	return $fd unless ($highlight);
> >
> >  	close $fd;
> > +	my $syntax_arg =3D (defined $syntax) ? "--syntax $syntax" : "--force";
> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >  	          quote_command($^X, '-CO', '-MEncode=3Ddecode,FB_DEFAULT', '=
-pse',
> >  	            '$_ =3D decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);=
',
> >  	            '--', "-fe=3D$fallback_encoding")." | ".
> >  	          quote_command($highlight_bin).
> > -	          " --replace-tabs=3D8 --fragment --syntax $syntax |"
> > +	          " --replace-tabs=3D8 --fragment $syntax_arg |"
> >  		or die_error(500, "Couldn't open file or run syntax highlighter");
> >  	return $fd;
> >  }
>
> All right, nice and understandable.
>
> > @@ -7063,8 +7064,7 @@ sub git_blob {
> >
> >  	my $highlight =3D gitweb_check_feature('highlight');
> >  	my $syntax =3D guess_file_syntax($highlight, $file_name);
> > -	$fd =3D run_highlighter($fd, $highlight, $syntax)
> > -		if $syntax;
> > +	$fd =3D run_highlighter($fd, $highlight, $syntax);
> >
> >  	git_header_html(undef, $expires);
> >  	my $formats_nav =3D '';
>
> Good, run unconditionally.
>
> > @@ -7117,7 +7117,7 @@ sub git_blob {
> >  			$line =3D untabify($line);
> >  			printf qq!<div class=3D"pre"><a id=3D"l%i" href=3D"%s#l%i" class=3D=
"linenr">%4i</a> %s</div>\n!,
> >  			       $nr, esc_attr(href(-replay =3D> 1)), $nr, $nr,
> > -			       $syntax ? sanitize($line) : esc_html($line, -nbsp=3D>1);
> > +			       $highlight ? sanitize($line) : esc_html($line, -nbsp=3D>1);
> >  		}
>
> Good, use highlighter if possible, not only if syntax is known
> and highlighter is turned on.
>
> Nice and easy to understand after earlier change.
>
> >  	}
> >  	close $fd
> > diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
> > index e94b2f1..6d06ed9 100755
> > --- a/t/t9500-gitweb-standalone-no-errors.sh
> > +++ b/t/t9500-gitweb-standalone-no-errors.sh
> > @@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
> >  	 git commit -m "Add test.sh" &&
> >  	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest.sh"'
> >
> > +test_expect_success HIGHLIGHT \
> > +	'syntax highlighting (highlighter language autodetection)' \
> > +	'git config gitweb.highlight yes &&
> > +	 echo "#!/usr/bin/perl" > test &&
> > +	 git add test &&
> > +	 git commit -m "Add test" &&
> > +	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest"'
>
> Nice.
>
> > +
> >  # --------------------------------------------------------------------=
--
> >  # forks of projects
> >
> >
>

Thanks for great  suggestions.
