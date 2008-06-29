From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 30 Jun 2008 00:47:11 +0200
Message-ID: <200806300047.12224.jnareb@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <1214488126-6783-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5gr-0005Hj-Em
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYF2WrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 18:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYF2WrR
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:47:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:14215 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbYF2WrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 18:47:15 -0400
Received: by ug-out-1314.google.com with SMTP id h2so172458ugf.16
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LWgOnxYybndbBPlKuec0APhIbb82WY3WxElPGS/sdbk=;
        b=g/1b1+RdVjL/hZayLyq6X+BmuVAw5Ds04R3DTiS3s6b+/pqi9E4HR/slCMF8ga5jG3
         q+1sSxSFols+8s/N93UMaHZSyBvn9CJ7wRdjvsmw9y1P9ad05ZdrfRrvOzF4OVVyqB4C
         ttRoJ/2BsOMV9L3h7Uyq0loyDR3Bil9dRovnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=B7ibkoH06Y7Fs0Yt1/hf+yP5GpSnhwRKqJs3oGe9xwmrZknO+3L4W8tMwsMXZQqoXN
         kU7rp2zwEJaFNa7KMlwwU2YsEE+zQ5r26g2oeCja8XC7yO/DlOJnxLiHk8ISE3O9e/Xy
         VG/KuTP8b3LxeOkHjNEieVHSvWlqIuM58w/aw=
Received: by 10.66.255.20 with SMTP id c20mr3368823ugi.87.1214779633327;
        Sun, 29 Jun 2008 15:47:13 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.210])
        by mx.google.com with ESMTPS id 34sm1142154ugh.76.2008.06.29.15.47.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 15:47:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1214488126-6783-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86844>

On Thu, 26 June 2008, Lea Wiemann wrote:

> This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
> also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)

Wouldn't it be better to use "(each if present)"?

I am not a native English speaker, though.

[...]
> Changes since v7:
> 
> - In Makefile, dump $PERL_PATH to GIT-BUILD-OPTIONS (which gets
>   source'd by test-lib.sh), and use it in t9710-perl-git-repo.sh.

Good idea.

> - .git/description in the test repository no longer depends on $0
>   (this would e.g. cause 'cd t; make' to fail).

> +cat >.git/description <<EOF
> +gitweb test repository
> +EOF

I'd rather use more descriptive name, so when you look it up in gitweb
to manually (visually?) checks its output you would know of which test
is it.  Something like "gitweb Mechanize test repository", or "test
repository for gitweb's Mechanize test".

> - Add test_link subroutine and use it everywhere in place of
>   ok(find_link...) so that links whose presence get tested get checked
>   and spidered in --long-tests mode.

Nice.

> - Add simple page caching (reduces execution time without --long-tests
>   by 25%).  That's *really* helpful when you have to run those tests
>   on a regular basis. ;)

What do you need caching for?  You check if page was already accessed
when spidering...

If it is about checking links, alternate solution would be to replace
simple $mech->page_links_ok( [ $desc ] ) by finding all the links
either using $mech->followable_links() or $mech->find_all_links( ... ),
or just $mech->links, then filtering out links which you have checked
already, then checking selected links using $mech->links_ok( $links [, $desc ] )

>   (WWW::Mechanize::Cached won't work with
>   TWM::CGI, so we have to implement it ourselves; but it's easier
>   anyway.)

> +package OurMechanize;
> +
> +use base qw( Test::WWW::Mechanize::CGI );

Why this package is not named WWW::Mechanize::CGI::Cached, I wonder?
Is it because of corrected cgi_application method?

> +
> +my %page_cache;
> +# Cache requests.
> +sub _make_request {
> +	my ($self, $request) = (shift, shift);
> +
> +	my $response;
> +	unless ($response = Storable::thaw($page_cache{$request->uri})) {
> +		$response = $self->SUPER::_make_request($request, @_);
> +		$page_cache{$request->uri} = Storable::freeze($response);
> +	}
> +	return $response;
> +}
> +
> +# Fix whitespace problem.
> +sub cgi_application {
> +	my ($self, $application) = @_;
> +
> +	# This subroutine was copied (and modified) from
> +	# WWW::Mechanize::CGI 0.3, which is licensed 'under the same
> +	# terms as perl itself' and thus GPL compatible.
> +	my $cgi = sub {
> +		# Use exec, not the shell, to support embedded
> +		# whitespace in the path to $application.
> +		# http://rt.cpan.org/Ticket/Display.html?id=36654
> +		my $status = system $application $application;
> +		my $value  = $status >> 8;
> +
> +		croak( qq/Failed to execute application '$application'. Reason: '$!'/ )
> +		    if ( $status == -1 );
> +		croak( qq/Application '$application' exited with value: $value/ )
> +		    if ( $value > 0 );
> +	};
> +
> +	$self->cgi($cgi);
> +}
> +

By the way, if you want to add a comment to mentioned WM::CGI ticket
http://rt.cpan.org/Ticket/Display.html?id=36654 you have to either
register, or send comment via mail with the following info

>From "Bugs in WWW-Mechanize-CGI via RT" <bug-WWW-Mechanize-CGI@rt.cpan.org>:
|
| Please include the string:
|
|         [rt.cpan.org #36654]
|
| in the subject line of all future correspondence about this issue. To do so, 
| you may reply to this message.

> - Follow redirects rather than failing.

Nice. Where it is?
 
> - Test subdirectories in tree view.
> - Test error handling for non-existent hashes or hashes of wrong type.
> - Test commitdiff_plain view.
> - Expand test for history view.
> - Test tag objects (not just symbolic tags) in tag list.

More tests are always nice to have, although I begin to wonder if
splitting this test into smaller part wouldn't be a good idea...

> - Test a specific bug (under "diff formatting", marked TODO).

> +# Diff formattting problem.

(One 't' too many: should be "Diff formatting problem")

> +if (get_summary &&
> +    follow_link( { text_regex => qr/renamed/ }, 'commit with rename') &&
> +    follow_link( { text => 'commitdiff' }, 'commitdiff')) {
> +	TODO: {
> +		local $TODO = "bad a/* link in diff";
> +		if (follow_link( { text_regex => qr!^a/! },
> +				 'a/* link (probably wrong)')) {
> +			# The page we land on here is broken already.
> +			follow_link( { url_abs_regex => qr/a=blob_plain/ },
> +				     'linked file name');  # bang
> +		}
> +	}
> +}
 
I'll try to investigate; I guess this uses wrong name or wrong hash
for preimage.

> - Do not test correctness of line number fragments (#l[0-9]+); they're
>   broken too often right now.

What do you mean by broken?

> - Probably some more minor improvements I've forgotten about. :)

For example

> +die "this must be run by calling the t/t*.sh shell script(s)\n"
> +    if Cwd->cwd !~ /trash directory$/;

 
Good work!

-- 
Jakub Narebski
Poland
