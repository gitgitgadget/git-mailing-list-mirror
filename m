From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 12:56:51 -0700
Message-ID: <xmqqbnvt3zp8.fsf@gitster.dls.corp.google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcgoP-0005FH-IA
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbaDVT45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:56:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755954AbaDVT4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:56:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2ED7F505;
	Tue, 22 Apr 2014 15:56:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ABaMc6fXV1STfql3TLE5ZbwYGgA=; b=Gd3UJoN7/YSbMl6jx5kg
	K7PiEWGciGhNrWyGAD5FU2PXQCHAZ8gthCmGg4ymDIlTrD2oyan7eoVIt/Ty5HZ6
	IvnzzEOki4RQMDwkbCwI1DytfbJ+7xevVu8NH60dc6w9SfbZgQEYCeH4pIabwZ2q
	ps6mCWOrDQeasie+vUI691M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BM057IJlw1iU2KSeqrRuM74/mJZE0BljyWY11OcSveTnbd
	wqJuIgNgrtE6+pwCfy0VL/fZKkok6vXIN6YEkIExtcyCvsM2ugWktvoIAa7p64Af
	FZmnY3ef09xDZ6URAeExBPZJGvqPnU9btjSLnqpZCwF4sOvTfI9XUBGsNhEV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E717F503;
	Tue, 22 Apr 2014 15:56:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9A897F4F8;
	Tue, 22 Apr 2014 15:56:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FC6FB64-CA58-11E3-9D3A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246780>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Alternatively this change can be made in git-svn.perl:
> |diff --git a/git-svn.perl b/git-svn.perl
> |index 7349ffea..284f458a 100755
> |--- a/git-svn.perl
> |+++ b/git-svn.perl
> |@@ -149,7 +149,7 @@ my ($_trunk, @_tags, @_branches, $_stdlayout);
>   my %icv;
>   my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
>                     'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
> -                  'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
> +                  'branches|b=s@' => \@_branches, 'prefix:s' => \$_prefix,
>                     'stdlayout|s' => \$_stdlayout,
>                     'minimize-url|m!' => \$Git::SVN::_minimize_url,
>                    'no-metadata' => sub { $icv{noMetadata} = 1 },
>
> Which makes the argument to --prefix optional (in which case it is set  
> to "").

We do want to learn what prefix the user wants to use when they
start their command line with "git svn --prefix".  Stopping the
command line right there and expecting it to default to whatever
built-in prefix is simply strange; the user could have omitted that
"--prefix" that lacks the argument.  If the user did want us to use
the default by passing an empty string as its argument, both forms,
i.e. "--prefix ''" and "--prefix=''", ought to be usable, but if
older Getopt::Long() does not allow the latter form, at least the
former is the right way for the user to tell us that.

So I think your fix (workaround for a bug in older Getopt::Long) in
the patch is the right one.  Johan may want to help me by pointing
out if I am missing something.

Thanks.


> I'm not really sure what the best thing to do here is.  I thought the  
> documentation talked somewhere about using --prefix="" (or just --prefix=)
> to get the old behavior, but now I can't find that.  In that  
> case I think probably just changing the tests to use --prefix ""  
> instead of --prefix="" should take care of it especially since the log  
> message for fe191fca (which actually changes the default) talks about  
> using --prefix "" and not --prefix="".  I have attached a patch below  
> (against master) to make that change to the two affected subtests of t9117.
>
> --Kyle
>
> ---- >8 ----
> Subject: [PATCH] t9117: use --prefix "" instead of --prefix=""
>
> Versions of Perl's Getopt::Long module before 2.37 do not contain
> this fix that first appeared in Getopt::Long version 2.37:
>
> * Bugfix: With gnu_compat, --foo= will no longer trigger "Option
>   requires an argument" but return the empty string.
>
> Instead of using --prefix="" use --prefix "" when testing an
> explictly empty prefix string in order to work with older versions
> of Perl's Getopt::Long module.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  t/t9117-git-svn-init-clone.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
> index dfed76fe..a66f43c6 100755
> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -101,18 +101,18 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
>  	rm -f warning
>  	'
>  
> -test_expect_success 'init with -s/-T/-b/-t and --prefix="" still works' '
> +test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
>  	test ! -d project &&
> -	git svn init -s "$svnrepo"/project project --prefix="" 2>warning &&
> +	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
>  	test_must_fail grep -q prefix warning &&
>  	test_svn_configured_prefix "" &&
>  	rm -rf project &&
>  	rm -f warning
>  	'
>  
> -test_expect_success 'clone with -s/-T/-b/-t and --prefix="" still works' '
> +test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
>  	test ! -d project &&
> -	git svn clone -s "$svnrepo"/project --prefix="" 2>warning &&
> +	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
>  	test_must_fail grep -q prefix warning &&
>  	test_svn_configured_prefix "" &&
>  	rm -rf project &&
