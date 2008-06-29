From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 30 Jun 2008 01:39:13 +0200
Message-ID: <48681D21.1040302@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <1214488126-6783-1-git-send-email-LeWiemann@gmail.com> <200806300047.12224.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 01:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD6Vt-0006RO-Kc
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 01:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYF2XjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 19:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYF2XjU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 19:39:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:31752 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbYF2XjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 19:39:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so648068fgg.17
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=73jilc/vQWdhA79cAntCAfjA82Hys+q99DA2YCJqg4o=;
        b=URcTJXVKQW9HhInIXA03ftzL7a1PLT/48pjfj+2Xpcb0Pt/lPlTSRkvhSaHaAef06j
         ZjyE28sCBMII8sdVyBSXBaX8sBfio+ZDCgdrdXmq7SlKm341IBf2qcKj0M1Awl3Xew/w
         QXegXiESDcDi0D94UGFuV+D5LC4ZE0xtmYZho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=JWmPXIAok1oullS9VDJWK2SWsh0b//ZcCltMRm0OW+GJqke/X2mOwoDgiHPJiBvqay
         1uUYmnyoX4H8X4XC22EDoMXwEjlMSFprDMXmnGFx6SbthZA4Uvr5AUJNrpC9LHQZXTSu
         R4Qw9FXlTZdLxXwdLHUDza/SX97eJSuDASrt8=
Received: by 10.86.33.19 with SMTP id g19mr2251270fgg.67.1214782757351;
        Sun, 29 Jun 2008 16:39:17 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.203.119])
        by mx.google.com with ESMTPS id d4sm7762601fga.8.2008.06.29.16.39.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 16:39:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806300047.12224.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86848>

Jakub Narebski wrote:
> On Thu, 26 June 2008, Lea Wiemann wrote:
>> It also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)
> 
> Wouldn't it be better to use "(each if present)"?
> I am not a native English speaker, though.

Me neither, but I prefer "if present, each" off the top of my head...

>> - Add simple page caching (reduces execution time without --long-tests
>>   by 25%).  That's *really* helpful when you have to run those tests
>>   on a regular basis. ;)
> 
> What do you need caching for?  You check if page was already accessed
> when spidering...

This is actually about the short tests (I don't think it gains much for
spidering, percentage-wise).  The test suite uses some repetitive set-up
code (like get_summary && follow_link 'tree' && ...), so the second and
third times these pages are loaded we can save some time.

> replace $mech->page_links_ok [with] finding all the links [...], 
> then filtering out links which you have checked already, then checking
> selected links using $mech->links_ok

That's basically what it does right now. :)

>> +package OurMechanize;
>> +use base qw( Test::WWW::Mechanize::CGI );
> 
> Why this package is not named WWW::Mechanize::CGI::Cached, I wonder?
> Is it because of corrected cgi_application method?

Yeah, basically. :)  Plus, it's not to be confused with a proper
implementation of a TWM::CGI::Cached package.  (For instance, it uses
the URL rather than the complete request as cache key.  Hence it ignores
headers like Referer; but that's great for the Gitweb tests since TWM
apparently sets the Referer, but Gitweb doesn't check it, so there's no
need to refetch a page because the Referer has changed.)

> By the way, if you want to add a comment to mentioned WM::CGI ticket [...]

Thanks; done.

>> - Follow redirects rather than failing.
> 
> Nice. Where it is?

test_page doesn't use $mech->get_ok anymore, but rather calls $mech->get
and checks that the status is [23][0-9][0-9].  If it's 3xx, it also
follows the redirect.

> I begin to wonder if
> splitting this test into smaller part wouldn't be a good idea...

It's not yet painful (or long-running) enough for me to care. :)  I'm
fine with a 500-lines test module.

>> +# Diff formattting problem.
> 
> (One 't' too many:

Fixed.

>> +			follow_link( { url_abs_regex => qr/a=blob_plain/ },
>> +				     'linked file name');  # bang
>  
> I'll try to investigate; I guess this uses wrong name or wrong hash
> for preimage.

Thanks!

>> - Do not test correctness of line number fragments (#l[0-9]+); they're
>>   broken too often right now.
> 
> What do you mean by broken?

This is only visible with --long-tests -- there are links to line
numbers that don't exist (IOW the fragment doesn't exist in a name or id
attribute on the target page).  I've even seen links to #l0.  Bug fixes
welcome. ;-)

(There are also some other [mostly minor] issues marked with "TODO:" in
the test code; I didn't want to swamp the list with half a dozen bug
reports though, apart from time constraints on my end.)

> Good work!

Thanks! :-)  I'll send v9 in (hopefully) 2-3 days, together with the
first working version of the caching code.

-- Lea
