From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 23 Jun 2008 19:57:11 +0200
Message-ID: <485FE3F7.4040102@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <1214183688-8544-1-git-send-email-LeWiemann@gmail.com> <200806231531.13082.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqIr-000555-6B
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYFWR5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYFWR5K
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:57:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:11575 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbYFWR5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:57:08 -0400
Received: by wx-out-0506.google.com with SMTP id h29so772761wxd.4
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=31RiVqRjLpeEeLJBysxAI+3ZryJbBEv5DFaijoGFhwg=;
        b=KdUc17TI1DLuEtPf5GNIgp8kgCNKytYNJTIbVXBS0NpnZRQacLgDXkzLkWQfqKG2sa
         MOHIDLinwBJSxEtYK8UdWSNjJcDIYwyU+BUuShd29rFhIvoz/4Fd2r5ko+He3T+36n0L
         he/EdzSpeVXu+Kq5RwiwB18zVUNRsfAN81LVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=dPTgDStBWk53YQcdinOJpiN4ZyF3H1Te2Wu56W03/8UDaCgOu35rjpPVk6uW4RPYIu
         dGlmtdEAyRTDDPzwIRqmSqjqEJpITdcI/S+oe6MUXHBdRLySGwchU36wfLiTxUB1iNkL
         3TCwibfQwkN3UmMFkgQDgAjQD0qbJLYxH4KZk=
Received: by 10.100.58.19 with SMTP id g19mr13789863ana.41.1214243827311;
        Mon, 23 Jun 2008 10:57:07 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.198.167])
        by mx.google.com with ESMTPS id c9sm12005686ana.9.2008.06.23.10.57.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 10:57:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806231531.13082.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85895>

[Open issue about PERL_PATH at the bottom!]

Jakub Narebski wrote:
> Lea Wiemann wrote:
> 
>> +# We don't count properly when skipping, so no_plan is necessary.
>> +use Test::More qw(no_plan);
> 
> I'd rather either skip this comment all together, or change it [...]

I'll just remove it.  Anybody trying to add a test count will give up 
within 30 seconds. ;-)

>> +our $long_tests = $ENV{GIT_TEST_LONG};
> 
> Here also it could be "my $long_tests";

This one is to make "local $long_tests = 0" work -- it wouldn't work 
with a 'my' declaration.

>> +chomp(my @heads = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/heads`);
> 
> Wouldn't be easier to use '--format=%(refname)' in git-for-each-ref

*checks*  No, since I want to strip the leading refs/heads/ anyway (in 
order to test the page text, which mentions heads and tags without the 
directory prefix) -- hence the 'split' wouldn't go away with 
--format=%(refname).

>> +chomp(my @files = map { (split("\t", $_))[1] } `git-ls-tree HEAD`);
> 
> Wouldn't it be easier to use "git ls-tree --names-only HEAD"?

Yup ('--name-only' though).  Wonder why I didn't use it -- fixed.

>> +# Thus subroutine was copied (and modified to work with blanks in the
>> +# application path) from WWW::Mechanize::CGI 0.3, which is licensed
>> +# 'under the same terms as perl itself' and thus GPL compatible.

That's a tyop: s/Thus/This/ (fixed).  It refers to the following "my 
$cgi = sub".  Does the comment make sense now?

>> +my $cgi = sub {
>> +	# Use exec, not the shell, to support blanks in the path.
> 
> blanks = embedded whitespace?  path = path to gitweb?

Yup.  Improved comment, and simplified system call:

-	# Use exec, not the shell, to support blanks in the path.
-	my $status = system { $ENV{GITPERL} } $ENV{GITPERL}, $gitweb;
+	# Use exec, not the shell, to support embedded whitespace in
+	# the path to gitweb.cgi.
+	my $status = system $ENV{GITPERL}, $gitweb;

>> +		# WebService::Validator::Feed::W3C would be nice to
>> +		# use, but it doesn't support direct input (as opposed
>> +		# to URIs) long enough for our feeds.
> 
> Could you tell us here what are the limitations?  Are those limits
> of W3C SOAP interface for web validation, or the CPAN package mentioned?

No idea.  I tried it and it told me that the URL was too long -- I 
suspect it's the W3C server that rejected it.  I wouldn't spend more 
effort trying to get online validation to work; it's probably easier to 
just occasionally validate manually. ;)  XML well-formedness tests 
should catch most occasional breakages just fine.

>> +	# Broken link in Atom/RSS view -- cannot spider:
>> +	# http://mid.gmane.org/485EB333.5070108@gmail.com
>> +	local $long_tests = 0;
>> +	test_page('?p=.git;a=atom', 'Atom feed');
> 
> This I think should be written using Test::More equivalent of
> test_expect_failure in t/test-lib.sh, namely TODO block,

Right -- here's my new version (which still fails if the feeds die or 
are not well-formed XML -- I'll want that when I change gitweb):

# RSS/Atom/OPML view
# Simply retrieve and verify well-formedness, but don't spider.
$mech->get_ok('?p=.git;a=atom', 'Atom feed') and _verify_page;
$mech->get_ok('?p=.git;a=rss', 'RSS feed') and _verify_page;
TODO: {
	# Now spider -- but there are broken links.
	# http://mid.gmane.org/485EB333.5070108@gmail.com
	local $TODO = "fix broken links in Atom/RSS feeds";
	test_page('?p=.git;a=atom', 'Atom feed');
	test_page('?p=.git;a=rss', 'RSS feed');
}
test_page('?a=opml', 'OPML outline');

>> [in t/test-lib.sh:]
>> +GITPERL=${GITPERL:-perl}
>> +export GITPERL
>> [The idea is to easily run the test suite with different perl versions.]
> 
> How it is different from PERL_PATH?

Right, I didn't think of that.  PERL_PATH isn't available in the tests 
though, it's only used internally by the Makefile to generate (among 
other things) gitweb.cgi.  This means that while we can control under 
which Perl version gitweb.cgi runs, we cannot control under which Perl 
version the test suite runs (at least without $PATH trickery).  Does 
this bother us?

If yes, I'd suggest we keep GITPERL but rename it to GIT_TEST_PERL, 
because that's what it's about.  If not, I'll rip it out and simply call 
'perl' in the test shell script, whatever version it may be.

-- Lea
