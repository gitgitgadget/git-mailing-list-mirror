From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Sat, 15 May 2010 15:58:11 +0200
Message-ID: <201005151558.12191.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005141958.16469.jnareb@gmail.com> <20100515100615.GA3564@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sat May 15 15:59:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODHuF-0005Ut-3U
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 15:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0EON6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 09:58:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43237 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab0EON6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 09:58:21 -0400
Received: by fxm6 with SMTP id 6so2358774fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BoPKtM1IBT9yTSmUDYNs6ADR58/MPssCUlVzOdgwexA=;
        b=smPlR5Tr7HJ5XCN6VFap+v/PdS2bykLmpNrDWuufc0SwlU2xqoh2mSvl0ncIxF75H1
         ooxQZJiFBxeb67hBe8WJM8DsjlyRz1bwwNHLDz9d8eSOr/0Pp7UxQib+GNXSs1qy4e5I
         PR/HZJMLSE+AA2k5RXMCedcgLGfnix0oMECqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hUfcWpnznJsmxdeuQ2oCkoRdRYO5nE4WZGsnuimBNoV9JC95Yrcw8PZYzbarFicexh
         JSqjnVjNaNSpmW60vOx2laiOQupLdkMlGEiQoxRnbcXWv/2tCAfpujueGjh4hB/7tKO4
         GL8jhY2hxWelAdzm4xfUDkW6t5+Wb+DWOwtW0=
Received: by 10.223.26.206 with SMTP id f14mr3197179fac.96.1273931899558;
        Sat, 15 May 2010 06:58:19 -0700 (PDT)
Received: from [192.168.1.13] (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id z12sm15992781fah.21.2010.05.15.06.58.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 06:58:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100515100615.GA3564@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147151>

On Sat, 15 May 2010, Peter Vereshagin wrote:
> 2010/05/14 19:58:15 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
> >
> > You don't see the parsing failure because "do <file>;" functions like
> > "eval", which traps exceptions.  You will see consequences of parsing
> > failure (like not defined subroutine).
> > 
> > > But you may see it with "use warnings;" right?
> > 
> > "use warnings;" pragma doesn't help, because of the 'trapping
> > exceptions' part.  That is why "require <file>" is recommended over 
> > "do <file>".
> >
> > Checking $@ after "do <file>" would cover the situation where there were
> > parsing errors, but wouldn't cover situation where file was not found,
> > or there was error in executing code (but parsing was O.K.).
> 
> I just use it like many others, here are the examples of the code
> http://www.jmarshall.com/tools/cgiproxy/ nph-proxy.cgi:
> ===
>     if ($scheme eq 'https') {
>   eval { require Net::SSLeay } ;  # don't check during compilation
>   &no_SSL_warning($URL) if $@ ;
> ===
> http://webgui.org lib/WebGUI/HTML.pm:
> ===
>   } elsif ($type eq "thumb-if-form-thumb") {
>       eval "use Image::Magick;";
>       if ($@){
>         WebGUI::ErrorHandler::warn("Image::Magick not loaded: ".$@);
> ===
> 
> are those lemmings wrong?

No they are not.

But there are two things.  First, there is a difference between 'eval EXPR'
and 'eval BLOCK' form, in that 'eval EXPR' is parsed (at execution time) and
executed (and is slightly slower), while 'eval BLOCK' form is parsed only
once, at the time code surrounding eval is parsed (and is slightly faster).

This means that while 'use' in conditional 'eval EXPR' as below

  if (<condition>) {
      eval "use Image::Magick;"
      ...
  }

would work as expected, I think that 'use' in conditional 'eval BLOCK' would
not.

  if (<condition>) {
      eval { use Image::Magick; }
      ...
  }

So if you want to use 'eval BLOCK' form, you need to use 'require' and not
'use':

  if (<condition>) {
      eval { require Image::Magick; import Image::Magick; }
      ...
  }


Second, if you are not interested in error condition, and only whether
require'ing some module failed or not, then instead of

  eval { require Net::SSLeay };
  no_SSL_warning($URL) if $@;

you can use the 'eval { <sth>; 1 };' idiom, i.e.

  eval { require Net::SSLeay; 1; }
      or no_SSL_warning($URL);

[...]  

> Whatever, I almost forgot to ask you again about your mysterious 'The
> subroutine was defined, but there was a bug in parsing included file'.
> Does Perl parser has a bug (about 'bug in parsing')?  File was not
> included but the sub from it was successfully defined?  File was about to
> include inside a sub but Perl reported the 'sub undefined' instead of
> 'file has failed to be included by the sub'?  All of those seem just
> incredible to me ;-)

The situation looked like this.  The included file (via 'do') had a few
subroutines in it, looking roughly like this:

  use strict;
  use warnings;

  sub foo {
     # here was a syntax error
  }

  sub bar {
     # ...
  }

  1; # last statement in file

The main file used 'do $file;' and then tried to use 'bar' subroutine,
looking like this:

  use strict;
  use warnings;

  do $file;
  # no checking for $@

  ...

  bar();

And there Perl gives the following error:

  'Undefined subroutine &bar called'

This is caused by the fact that there was a syntax error before definition
of foo(), and Perl didn't make it to defining foo().

When I added checking for $@ in the form of 'die $@ if $@', the error that
Perl shown was the syntax error in the foo() subroutine in $file file.

[...]

> > This convertion is 
> > a.) compiling CGI file into subroutine (taking care of things like DATA
> >     filehandle) using CGI::Compile
> > b.) converting between CGI interface and PSGI interface, using
> >     CGI::Emulate::PSGI
> 
> Sounds to me like all of that can happen in-memory. Great!
> 
> > Yes, it can.  Depending on request it would run appropriate
> > CGI-converted-to-PSGI application.
> > I am not sure how Plack::App::CGIBin works internally; it migh cimpile
> > all CGI applications upfront; but it might not.
> 
> Will challenge.

I don't know if it would be complete replacement for FCGI::Spawn, but from
your description of it, using Plack::App::CGIBin middleware (+ plackup +
Plack::Handler::FCGI wrapper) could be a valid alternative to it..

P.S. About Girocco: instead of writing it as set of separate CGI scripts, it
could have been instead written as single app, loading its modules ('use
lib' would help).
-- 
Jakub Narebski
Poland
