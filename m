From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 23 Jun 2008 15:31:12 +0200
Message-ID: <200806231531.13082.jnareb@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <1214183688-8544-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 15:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAmA6-0001I6-9D
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 15:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbYFWNbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYFWNbZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 09:31:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:59820 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbYFWNbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 09:31:24 -0400
Received: by ug-out-1314.google.com with SMTP id h2so520034ugf.16
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nrx4qmb7WwdT7N9V53P6Aq6SJl5ZAUIq6bXOVbRMGgk=;
        b=XV4oYzjJ58NRchWtmWOltz217BRYazuvqIYC20lxfcwEefRpKFf4FxxKWQbn1+53Q1
         PgeXyZ6T/O4dh/t34T9cJ7x0pzqi+meYHvSrjPwRD4nBLQZv4da4kWctcDHg3DvIQ/Fe
         lM7z08F7yhgOM88OL6SHUFS3D9UDUAEIBQpbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=phIghWiXPfjcyW1mUVh3LhqhKiCVE16vCDjebLyGXls5IUTZw7NcrUFvyxQ4KGptNy
         i4O05M0J4AJAms5fEt01U7j9mm3G44ylG7VS51fMy0+FSey6GpusrD7VD1MWKejQDBvS
         ibfagMN6hQLb/pe7i671pnj/lXPt+qTy9Ei9g=
Received: by 10.66.221.6 with SMTP id t6mr2160078ugg.55.1214227882505;
        Mon, 23 Jun 2008 06:31:22 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.247.21])
        by mx.google.com with ESMTPS id 32sm29955452ugf.42.2008.06.23.06.31.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 06:31:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1214183688-8544-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85863>

Lea Wiemann wrote:

> +# We don't count properly when skipping, so no_plan is necessary.
> +use Test::More qw(no_plan);

I'd rather either skip this comment all together, or change it to
read something like that (I don't have good solution):

+# Counting tests upfront is difficult, as number of tests depends
+# on existence of several Perl modules, and is next to impossible
+# when spidering gitweb output (for --long-test).  Additionally,
+# having number of tests planned stated at beginning is not necessary,
+# as this test is to be run from git test suite, and not to be
+# processed further by TAP (Test Anything Protocol) Perl modules.

See http://www.perlfoundation.org/perl5/index.cgi?testing for
explanation why (and when) 'plan' is useful:

  TAP output usually starts with a plan line:
  
     1..9
  
  which specifies how many tests are to follow. The above example
  specifies 9 tests.
  
  This line is optional, but recommended. Should a test suite die
  part-way through, the plan allows the testing framework to recognise
  this situation, rather than assuming that all tests were completed.

> +our $long_tests = $ENV{GIT_TEST_LONG};

Here also it could be "my $long_tests"; but I am not a Perl hacker,
and do not know which is preferred.

> +eval { require Archive::Tar; };
> +my $archive_tar_installed = !$@
> +    or diag('Archive::Tar is not installed; no tests for valid snapshots');

> +chomp(my @heads = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/heads`);
> +chomp(my @tags = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/tags`);

Wouldn't be easier to use '--format=%(refname)' in git-for-each-ref
invocation?  Besides, gitweb now uses in link _full_ refname, i.e.
"refs/heads/<name>" and "refs/tags/<name>" to avoid branch / tag
ambiguity (when there are both branch and head with the same name).

> +# files and directories in HEAD root:
> +chomp(my @files = map { (split("\t", $_))[1] } `git-ls-tree HEAD`);

Wouldn't it be easier to use "git ls-tree --names-only HEAD"?

> +sub rev_parse (...)
> +sub get_type (...)

Nice.

> +my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
> +
> +# Thus subroutine was copied (and modified to work with blanks in the
> +# application path) from WWW::Mechanize::CGI 0.3, which is licensed
> +# 'under the same terms as perl itself' and thus GPL compatible.

Errr... I think that without my comment you removed it is hard to
understand what this comment talks about.  "Thus ..." without any
preceding sentence?

> +my $cgi = sub {
> +	# Use exec, not the shell, to support blanks in the path.

blanks = embedded whitespace?
path = path to gitweb?

> +	my $status = system { $ENV{GITPERL} } $ENV{GITPERL}, $gitweb;
> +	my $value  = $status >> 8;
> +
> +	croak( qq/Failed to execute application '$gitweb'. Reason: '$!'/ )
> +	    if ( $status == -1 );
> +	croak( qq/Application '$gitweb' exited with value: $value/ )
> +	    if ( $value > 0 );
> +};
> +
> +my $mech = new Test::WWW::Mechanize::CGI;
> +$mech->cgi($cgi);

Looks good.  Thanks.

> +		# WebService::Validator::Feed::W3C would be nice to
> +		# use, but it doesn't support direct input (as opposed
> +		# to URIs) long enough for our feeds.

Could you tell us here what are the limitations?  Are those limits
of W3C SOAP interface for web validation, or the CPAN package mentioned?

> +	return 1

Style: "return 1;"

> +# RSS/Atom/OPML view.  Simply retrieve and check.
> +{
> +	# Broken link in Atom/RSS view -- cannot spider:
> +	# http://mid.gmane.org/485EB333.5070108@gmail.com
> +	local $long_tests = 0;
> +	test_page('?p=.git;a=atom', 'Atom feed');
> +	test_page('?p=.git;a=rss', 'RSS feed');
> +}
> +test_page('?a=opml', 'OPML outline');

This I think should be written using Test::More equivalent of
test_expect_failure in t/test-lib.sh, namely TODO block, either
as 

  TODO: {
    local $TODO = "why";

    ...normal testing code...
  }

or if it causes problem with t9503-gitweb-Mechanize.sh failing, perhaps
as

  TODO: {
    todo_skip "why", <n> if <condition>;

    ...normal testing code...
  }


(And similarly for other pages).

> +# Blob view

I like those comments.


> diff --git a/t/test-lib.sh b/t/test-lib.sh
[...]
> +GITPERL=${GITPERL:-perl}
> +export GITPERL

How it is different from PERL_PATH?

-- 
Jakub Narebski
ShadeHawk on #git
Thorn, Poland
