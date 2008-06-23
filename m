From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 24 Jun 2008 00:18:20 +0200
Message-ID: <200806240018.20820.jnareb@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <200806231531.13082.jnareb@gmail.com> <485FE3F7.4040102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuNf-0003BT-RP
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbYFWWS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYFWWS1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:18:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48767 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYFWWS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:18:26 -0400
Received: by ug-out-1314.google.com with SMTP id h2so615028ugf.16
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hsL/StOkLz+61dSaDPPaZmaGfHofHGA2GPXNpS9M1bg=;
        b=PerVUtsTLX20tj3b6RlE8DNakdjh0r9PuaGGkJACiHqKt2QeSh7pw6namjvnLVDlkA
         HTxnSmAmHtrqMXYvLc4zVfv98NZaAVLTRolozM31rSF4njQ23DpqHad1M3ox9WfFwiNu
         wdTKCkvmMvoHAl8ApTfICGRn/MCTTHMfoqoxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=O5ih4zJsNCDsnGRrLuSYrmxwqmrJgdgwQh6bZkCY5amotZnHCbm36UN8L3UZxDtGfo
         3DfRb9znzOk7HrTsWNai+uIN8S2PYV1FmBMb5iokvw1npV2o7XU7ZVTZCKIjM4nnmHEa
         Vx1XuF//PolKevGbgzxI9eoUYbg3LV9Pu3kFU=
Received: by 10.67.106.19 with SMTP id i19mr2635141ugm.81.1214259501856;
        Mon, 23 Jun 2008 15:18:21 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.249])
        by mx.google.com with ESMTPS id p34sm8356191ugc.27.2008.06.23.15.18.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 15:18:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <485FE3F7.4040102@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85944>

On Mon, 23 Jun 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann wrote:
>> 
>>> +# We don't count properly when skipping, so no_plan is necessary.
>>> +use Test::More qw(no_plan);
>> 
>> I'd rather either skip this comment all together, or change it [...]
> 
> I'll just remove it.  Anybody trying to add a test count will give up 
> within 30 seconds. ;-)

I just think that not having comment is better than have comment which
is not fully true, or five lines of explanations which could be
expanded further.

Simply: planning (coming with number of tests upfront) is hard, and for
this situation it doesn't give us anything.
 
>>> +our $long_tests = $ENV{GIT_TEST_LONG};
>> 
>> Here also it could be "my $long_tests";
> 
> This one is to make "local $long_tests = 0" work -- it wouldn't work 
> with a 'my' declaration.

Hmmmm...

Siednote: some time ago I though that I understood difference between
lexical scoping (my) and dynamical scoping (local)...
 
>>> +chomp(my @heads = map { (split('/', $_))[2] } 
>>> +	`git-for-each-ref --sort=-committerdate refs/heads`); 
>> 
>> Wouldn't be easier to use '--format=%(refname)' in git-for-each-ref
> 
> *checks*  No, since I want to strip the leading refs/heads/ anyway (in 
> order to test the page text, which mentions heads and tags without the 
> directory prefix) -- hence the 'split' wouldn't go away with 
> --format=%(refname).

Well, you could have replaced 'split' by s!^refs/!! ;-)))

>>> +# Thus subroutine was copied (and modified to work with blanks in the
>>> +# application path) from WWW::Mechanize::CGI 0.3, which is licensed
>>> +# 'under the same terms as perl itself' and thus GPL compatible.
> 
> That's a tyop: s/Thus/This/ (fixed).  It refers to the following "my 
> $cgi = sub".  Does the comment make sense now?

It makes sense now, thanks.

Although I guess it would be nice to have link to the ticket to the bug
(report) in WWW::Mechanize::CGI, so we could use cgi_application()
"again" if it gets fixed...

> +	my $status = system $ENV{GITPERL}, $gitweb;

...if not for the trick with explicitly calling Perl (GITPERL), to
allow testing different Perl versions with gitweb.
 
>>> +		# WebService::Validator::Feed::W3C would be nice to
>>> +		# use, but it doesn't support direct input (as opposed
>>> +		# to URIs) long enough for our feeds.
>> 
>> Could you tell us here what are the limitations?  Are those limits
>> of W3C SOAP interface for web validation, or the CPAN package mentioned?
> 
> No idea.  I tried it and it told me that the URL was too long -- I 
> suspect it's the W3C server that rejected it.  I wouldn't spend more 
> effort trying to get online validation to work; it's probably easier to 
> just occasionally validate manually. ;)  XML well-formedness tests 
> should catch most occasional breakages just fine.

Right.
 
Well, W3C feed validator provides SOAP interface we could use, using
POST of course and not GET (but it requires net connection), and also
standalone CLI validator (unfortunately in Python).

>>> +	# Broken link in Atom/RSS view -- cannot spider:
>>> +	# http://mid.gmane.org/485EB333.5070108@gmail.com
>>> +	local $long_tests = 0;
>>> +	test_page('?p=.git;a=atom', 'Atom feed');
>> 
>> This I think should be written using Test::More equivalent of
>> test_expect_failure in t/test-lib.sh, namely TODO block,
> 
> Right -- here's my new version (which still fails if the feeds die or 
> are not well-formed XML -- I'll want that when I change gitweb):
> 
> # RSS/Atom/OPML view
> # Simply retrieve and verify well-formedness, but don't spider.
> $mech->get_ok('?p=.git;a=atom', 'Atom feed') and _verify_page;
> $mech->get_ok('?p=.git;a=rss', 'RSS feed') and _verify_page;
> TODO: {
> 	# Now spider -- but there are broken links.
> 	# http://mid.gmane.org/485EB333.5070108@gmail.com
> 	local $TODO = "fix broken links in Atom/RSS feeds";
> 	test_page('?p=.git;a=atom', 'Atom feed');
> 	test_page('?p=.git;a=rss', 'RSS feed');
> }
> test_page('?a=opml', 'OPML outline');

Does it make t9503-gitweb.Mechanize.sh fail?
 
>>> [in t/test-lib.sh:]
>>> +GITPERL=${GITPERL:-perl}
>>> +export GITPERL
>>> [The idea is to easily run the test suite with different perl versions.]
>> 
>> How it is different from PERL_PATH?
> 
> Right, I didn't think of that.  PERL_PATH isn't available in the tests 
> though, it's only used internally by the Makefile to generate (among 
> other things) gitweb.cgi. [...]

That's what I was asking about.

-- 
Jakub Narebski
Poland
