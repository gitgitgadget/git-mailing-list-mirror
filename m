From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Fri, 14 May 2010 19:58:15 +0200
Message-ID: <201005141958.16469.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005141253.46956.jnareb@gmail.com> <20100514153636.GB17443@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Fri May 14 19:58:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCz9b-0003oo-72
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 19:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758473Ab0ENR61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 13:58:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52006 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab0ENR60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 13:58:26 -0400
Received: by fxm6 with SMTP id 6so1773032fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=622+6opE4oRKIOu4KtKHKF6/Nn6QBylsRcjxosHxC0I=;
        b=ZYe7DKUmKDe8gn2Qs0ZwEzMzPUkfIS6DiBGc6SQx9KbZcrIWrdSt2886ehKhZLsYN+
         BWrhBoltJVLEqHjgFbJ4KUPHE/nUrUIxFVcpyL358tJY/HdSXhrhoBM/NW+P4HIyvttk
         gFGoD8Vu6clmKGKPQuE3BO7pkihzJ2PWSs/X8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VHPkx1mc6hoHQU+UFJgMRa+mrf4ChyJfxMMdWBOV+aTZ90Iwt2RLUBsqH7W1VU9U6x
         71DqGwfdQ9oe4guwTdsGR+ZA8/fQmbnApuedwUNmnW9El/tMoGM7T61hoKHmkZXzN2tI
         K1DoIGzYKY71K66jISLfDY585FduvcVlC9v6k=
Received: by 10.223.29.135 with SMTP id q7mr2052866fac.30.1273859904201;
        Fri, 14 May 2010 10:58:24 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id 13sm11889116fad.7.2010.05.14.10.58.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 10:58:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100514153636.GB17443@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147104>

On Fri, 14 May 2010, Peter Vereshagin wrote:
> 2010/05/14 12:53:42 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

>> legitimate uses of 'goto' that make the program simpler to understand,
>> and not harder,... among those is handling exceptions.
> 
> so did you change the exception-related exit()s on your patch to the
> "last" ?

Yes, die_error(), which had "exit" that got replaced by non-local "goto"
is exception-related subroutine.


>> The problem is that "do <file>;" is similar to "eval `cat <file>`;"
>> (except that it's more efficient and concise), it that it silences
>> parsing errors.  From `perldoc -f do`:
>> 
>>   If "do" cannot read the file, it returns undef and sets $! to the error.
>>   If "do" can read the file but cannot compile it, it returns undef and sets
>>   an error message in $@.   If the file is successfully compiled, "do"
>>   returns the value of the last expression evaluated.
>> 
>>> And yes, since it's about development but not production use, die is just fine
>>> in the inclusion code like this:
>>> 
>>> eval( 'use Module;' ); die $@ if $@;
>> 
>> Wrong!
> 
> The problem was you can't see the reason of the inclusion-via-do()
> parsing failure.

You don't see the parsing failure because "do <file>;" functions like
"eval", which traps exceptions.  You will see consequences of parsing
failure (like not defined subroutine).

> But you may see it with "use warnings;" right?

"use warnings;" pragma doesn't help, because of the 'trapping
exceptions' part.  That is why "require <file>" is recommended over 
"do <file>".

>>> as always, require() can do the trick, not to mention usual 
>>> 
>>> use Module;
>>> 
>>> This all will cause die() when it's necessary as only the application developer
>>> knows how strict is the dependence on the Module. In some cases, application
>>> can work without some Module but it's just better with it.
>> 
>> First, both "use Module;" and "require Module;" (and "require '<file>';")
>> do automatic error checking and raise an exception if there is problem.
> 
> for web applications, half of exceptions or more are generated when the user
> isn't the develioper.
> Notifications() via the logs are just enough and more than it: should be the
> prefered way of exceptions' notifications in a production.
> Why worry about return code then?

Checking $@ after "do <file>" would cover the situation where there were
parsing errors, but wouldn't cover situation where file was not found,
or there was error in executing code (but parsing was O.K.).
 
>> Second, "use Module <LIST>;" is equivalent to
>>   BEGIN { require Module; import Module <LIST>; }
>> and therefore it doesn't make sense to use it for conditional inclusion.
> 
> eval() is used there.

It's the fact that "use Module" uses BEGIN block that is incompatibile
with *conditional* using it from eval.

>>>> PSGI is interface, Plack is reference implementation.  You can run PSGI
>>>> app on any supported web server; this includes running PSGI apps on
>>>> FastCGI.
>>> 
>>> Existing problem FCGI::Spawn for is not the PSGI applications to be run as a
>>> FastCGI, but the bunch of existing CGI.pm applications (even gitorious) need
>>> to be more effective with the widest-spread protocol FastCGI. Best without any
>>> patching of the application, deployed the same simple way as with apache's cgi
>>> implementation.
>> 
>> Gitorious is in Ruby, therefore is not a CGI.pm application, as it is
>> not even in Perl.
> 
> It was Girocco you mentioned earlier

Girocco is shell scripts, not Perl either, see
http://repo.or.cz/w/girocco.git/tree

>> By using Plack::App::CGIBin you can load CGI scripts from a directory
>> and convert them into a <persistent> PSGI application.  You can use
> 
> Such a conversion is more than a compilation? Does it mean converted CGI app
> should be stored before to become a persistent application?

This convertion is 
a.) compiling CGI file into subroutine (taking care of things like DATA
    filehandle) using CGI::Compile
b.) converting between CGI interface and PSGI interface, using
    CGI::Emulate::PSGI


CGI::Compile manpage includes this example:

         use CGI::Emulate::PSGI;
         use CGI::Compile;

         my $cgi_script = "/path/to/foo.cgi";
         my $sub = CGI::Compile->compile($cgi_script);
         my $app = CGI::Emulate::PSGI->handler($sub);

         # $app is a PSGI application

>> Plack::App::WrapCGI to convert single CGI script into PSGI application.
>> You can use Plack::Buuilder's domain specific language to join (map)
>> together a bunch of PSGI applications (in different paths) in a single
>> app (via Plack::App::URLMap).
> 
> And can the same process of that application server run for the several
> applications depending on the FastCGI request?

Yes, it can.  Depending on request it would run appropriate
CGI-converted-to-PSGI application.

I am not sure how Plack::App::CGIBin works internally; it migh cimpile
all CGI applications upfront; but it might not.
 
>> You can then run PSGI application (for example the PSGI app which loads
>> CGI apps via Plack::App::CGIBin) on any supported web server, which
>> includes FCGI (FastCGI).

-- 
Jakub Narebski
Poland
