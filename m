From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 20:12:59 -0700
Message-ID: <7vr71eorlw.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
	<7vr71f5kzs.fsf@assigned-by-dhcp.cox.net>
	<7vu06bymtr.fsf@assigned-by-dhcp.cox.net>
	<20060624111657.GR21864@pasky.or.cz>
	<7vac82wytw.fsf@assigned-by-dhcp.cox.net>
	<20060624130234.GT21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 05:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuL3a-0007Iv-KM
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWFYDND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWFYDND
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:13:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6649 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751361AbWFYDNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 23:13:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625031300.PABU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 23:13:00 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22582>

ePetr Baudis <pasky@suse.cz> writes:

>> Is there a way from the environment to override this behaviour,
>> so that we can run the tests properly?  I think PERL5LIB and
>> PERLLIB are defeated by having -I there (that's why I said I
>> liked what Fredrik did with his Python script, which appends the
>> final installed location to the search path).  I think unshift
>> into @INC by hand (i.e. without even using use lib "$path")
>> would do what we want, but I feel that is a bit too ugly just 
>> for the testing X-<.
>
> PERL5LIB and use lib at the same time works for me. Anyway, with the
> second patch I've sent things should work well even if you don't have
> Git.pm installed anywhere yet.

Sorry, I am not sure it "works for me" -- which one take
precedence for this?

	$ head -n 2 script.perl
        #!/usr/bin/perl -w -I /path/a
        use lib "/path/b";
        $ ./script.perl ;# invocation #1
        $ PERL5LIB=/path/c ./script.perl ;# invocation #2

Precedence between the in-script -I and "use lib" are
irrelevant, but unless PERL5LIB takes precedence and the
invocation #2 takes Git.pm from /path/c my previous patch 
to make sure test uses freshly built one does not work.

>> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
>> index 54e8b20..92c140d 100644
>> --- a/perl/Makefile.PL
>> +++ b/perl/Makefile.PL
>> @@ -3,7 +3,7 @@ use ExtUtils::MakeMaker;
>>  sub MY::postamble {
>>  	return <<'MAKE_FRAG';
>>  instlibdir:
>> -	@echo $(INSTALLSITELIB)
>> +	@echo $(INSTALLSITEARCH)
>>  
>>  MAKE_FRAG
>>  }
>
> Oh, yes; that line came from the time when we had no .xs yet. It is not
> visible here since both arch-specific and non-arch-specific libraries
> get installed to ~/lib.

OK.  Thanks.
