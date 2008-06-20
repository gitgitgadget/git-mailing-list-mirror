From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [WIP/PATCH v3] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Fri, 20 Jun 2008 15:49:44 +0200
Message-ID: <485BB578.3040605@gmail.com>
References: <1213487844-685-1-git-send-email-LeWiemann@gmail.com> <1213931911-15860-1-git-send-email-LeWiemann@gmail.com> <200806201408.05254.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9h0f-0005bm-29
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbYFTNtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbYFTNtk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:49:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:47984 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbYFTNtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:49:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so645990fgg.17
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=hExA5ppc9D2PmClNsE/pnqqQgZQQ6J/GvUT//IgT450=;
        b=klj3Du2zQhHQXM4iYL8yLK/GrYObRSdtz4u3ANKmfIq2/inh3PvIZ5HwKzHhCTHSq4
         /CaFXEpcH97a+aKXt9heWxg/Ck64oGX6A+VHHUV9hpKcexZyudVzqfKEXqIsomVx7lI/
         3r7L5P4fugipT4SozxBRwW2ybNxGjmBTDTcH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=LIfibW5q/jd2RN+n/jbMVCfkx9cBdheYgsAXnkQetZ3y0RwLevhOaxQxwnYrCea6EU
         AbToy5sIdm0asqJ+RHz508v9e11QNqkNmD6RmcOGf5xKnWfGB3RhfKXdoG8jR+RpaIyi
         FSB4kaWoebn+bghtqLeyBXglk11HoltvvLv3Y=
Received: by 10.78.138.14 with SMTP id l14mr1607135hud.65.1213969777787;
        Fri, 20 Jun 2008 06:49:37 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.240.210])
        by mx.google.com with ESMTPS id 3sm1358425hud.45.2008.06.20.06.49.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 06:49:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806201408.05254.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85646>

Jakub Narebski wrote:
> First, it is not XML validation[*1*], but check if XML is well-formed.
> Second, I think it would be better if adding XML checks (RSS, Atom,
> OPML) would be left as separate commit.

Sure; FWIW I'm generally in favor of having a large initial commit for 
new independent files (and since we don't need to worry about conflicts 
I'm not fervent about getting this into the next branch ASAP), but we 
can definitely add XML checking separately.

>> +# set up test repository
> 
> I have created this part as a copy of older t9500 gitweb test, thinking
> about what we might want to test, but the WIP of Mechanize based t9503
> doesn't have yet tests for those specific features.

I was thinking about that.  Right now the tests are so generic that you 
can replace the test repository with anything else as long as it has 
some commits (and later some tags, etc.).  That's kinda nice.

>> +# We don't count properly when skipping, so no_plan is necessary.
>> +use Test::More qw(no_plan);
> 
> Actually it is not that we cannot could properly when skipping, because
> there are two ways to have skipped tests and test count upfront,

We're skipping tests if a page-load fails to prevent a slew of failure, 
using constructs like if(test_page '?...') { ... inspect the page ...}. 
It's my impression that we shouldn't end up with a wrong test count even 
if one test fails; but then we'd have to replace those ifs with 
cumbersome skip blocks.

I'm generally not in favor of maintaining any test count plans; they're 
an unnecessary failure source, and I don't think they buy us much, if 
anything -- correct me if I'm missing something Perl-specific here.

> Why do you use shortened SHA1 identifier, instead of full SHA1?
> Links in gitweb use full SHA1.

That's for readability in the test output; links get checked anyway, 
don't they?  If you think we should be testing against full SHA1s, 
that's fine too.

> Errr, HEAD would be $revisions[0], $revisions[-1] would be $root.

Fixed, thanks.

> Another solution would be to copy relevant parts of cgi_application
> (without all the checks for example), and use $mech->cgi( sub { ... } );
> here (without the cgi_application bug).

ISTR that using cgi(sub ...) gives us problems with untrappable exits in 
gitweb.cgi (and possibly more things), right?  I'm fine with the 
workarounds we have in place, they don't seem brittle.

>> +our $baseurl = "http://localhost";
>> +our($params, $url, $pagedesc, $status);
> 
> I think we can use 'my' here;

They're used in subroutines, so I believe 'our' is correct here.

> Style: I would write "our (", with space [...]

>> +# if (test_page '?p=.git;a=summary', 'repository summary') {
> 
> Style: I would use function call form, i.e. "test_page(...)", not
> command-like (or script-like) form.

Both fixed, thanks.

> As to the rest of the test: I think as preliminary test it is a good
> thing to have.  We can think about what tests to add later (unless you
> rather have exhaustive test suite now...).

I'll be writing tests as I go and change parts of gitweb.  I won't be 
able to write exhaustive tests, but I at least want to make sure that 
the code I'm changing is covered somehow.

-- Lea
