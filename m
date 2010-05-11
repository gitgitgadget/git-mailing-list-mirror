From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Tue, 11 May 2010 12:58:50 +0200
Message-ID: <201005111258.53388.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005101729.07334.jnareb@gmail.com> <20100511062415.GA5220@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue May 11 12:59:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBnBG-0005SC-Al
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 12:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab0EKK7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 06:59:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53898 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab0EKK7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 06:59:10 -0400
Received: by fxm19 with SMTP id 19so252701fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aJN8nYdLnM1NIpw2KmTznmAfpzGA1HsD+z5RqvmWh9I=;
        b=ThnDxDKRcDKfF/PWsim7Tj8+KgcQXsr5/U70WssoFdAyHqMVEnT85y8YnHESvU5uUB
         QrpiOnS9JJJFeRhrD348Ypktvt7CqM5bRAYywOahJmEdecv+oq3Q7Vd6LToCrtdGuOs9
         sqwZzo2jPyRF6GKAqGN0xXMTAl5VH0zf8ySBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iZEBFzqB31zpedizNQO07j30DDmbZjjgE4UXkq0c9uqG7WIa9Zfuw7a0ozRYJ4ZC2P
         +2jzmCoR34aVEaMmV1OjyjccVLrsN1GZoLrsnMsMlIYgKBSpZZXWzNW3Xtr8ka1xKMm3
         0smXBNY4UkMAV50YxYK57TQERA4yubL3aRLvM=
Received: by 10.223.16.142 with SMTP id o14mr6117704faa.11.1273575543318;
        Tue, 11 May 2010 03:59:03 -0700 (PDT)
Received: from [192.168.1.13] (abwc23.neoplus.adsl.tpnet.pl [83.8.226.23])
        by mx.google.com with ESMTPS id 2sm26118212faf.15.2010.05.11.03.59.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 03:59:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100511062415.GA5220@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146885>

On Tue, 11 May 2010, Peter Vereshagin <peter@vereshagin.org> wrote:
> 2010/05/10 17:29:03 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
> > On Mon, 10 May 2010, Peter Vereshagin wrote:

> > >  ## ======================================================================
> > >  ## action links
> > > @@ -3371,7 +3371,7 @@ sub die_error {
> > 
> > I have added my guess of in which subroutine this code is above.

[...]
> > >         git_footer_html();
> > > -       exit;
> > > +#              exit;
> > >  }
> > 
> > Err... and gitweb works correctly with this change?  This 'exit' was
> > required for die_error to function like 'die' in that it finishes
> > serving request, and should not continue subroutine it was called
> > from.
> 
> Does at least on 'non-existent diff' page:
> 
> http://gitweb.vereshagin.org/fcgiproxy/commitdiff/abcd

Hmmm... strange that it works.
 
> > I have changed this 'exit' to non-local goto to toplevel.  It could be
> > done instead by redefining 'exit' subroutine, like shown below, but I
> > feel that would be hacky if you can change gitweb code (it is not
> > black box you should not touch).
> 
> Right, one shouldn't ever redefine perl built-in functions. I did only because
> of no other way to 'get things working'

Why not?  For example CGI::Carp redefines 'die' to log errors.

  BEGIN { 
    require Carp; 
    *CORE::GLOBAL::die = \&CGI::Carp::die;
  }

Sub::Uplevel and Test::Exception redefines 'caller' (perhaps locally).
CGI::Compile redefines 'exit':

  our $USE_REAL_EXIT;
  BEGIN {
      $USE_REAL_EXIT = 1;
      *CORE::GLOBAL::exit = sub (;$) {
          my $exit_code = shift;

          CORE::exit(defined $exit_code ? $exit_code : 0) if $USE_REAL_EXIT;

          die [ "EXIT\n", $exit_code || 0 ]
      };
  }


> > This is quite nice idea to replace 'exit' by subroutine that does
> > non-local jump to outside of application, at the end of request loop.
> > Such "monkey patching" is the only solution if you can't or shouldn't
> > modify application code (like FCGI::Spawn being generic solution).
> 
> Yes, this is quick-n-dirty to apply for those monkeys who are just busy to care
> about re-writing CGI apps.

Errr... "monkey patching" is the name of technique of extending and
modifying runtime code in dynamic languages, see

  http://en.wikipedia.org/wiki/Monkey_patch
 
Although I am not entirely sure if I correctly applied this name to
described (used) techique.

> > Here
> > 
> >    $spawn->{'callout'} = sub {
> >    	my $cgi_app = shift;
> >    	do $cgi_app;
> > 
> >     # this is needed for sane error handling
> >     die "Couldn't parse $cgi_app: $@" if $@;
> > 
> >    CALLED_OUT: 
> >    };
> 
> In a forked application, die() is a PITA on any reasonable load. It makes the
> CoW-shared memory to be copied into separate area and being marked as unusable
> before the process is dead. This is the only case I saw load averages on the
> servers valued as crazy ~700.
>
> So just exit there, not die. 

Well, it might be 'exit' not 'die', but you really, really need to check
if there were problems parsing file.  Otheriwse you can get error
messages somewhere further on that doesn't absolutely make sense.  

I know this from painful experience of trying to find bug in a
test... when the error was in parsing file in 'do $file;'.

> By far, die can not be redefined the same way as I propose for exit in
> FCGI::Spawn.

It can't?  CGI::Carp redefines 'die'.
 
> > > [...] FCGI::Spawn is just for some different task: to put several
> > > (wish to say: any CGI app) applications inside the same fork()ed
> > > processes. [...]
> > 
> > Hmmm... is FCGI::Spawn really needed, or can it be replaced by simple
> > PSGI wrapper using either Plack::App::CGIBin, 
> > 
> >   use Plack::App::CGIBin;
> >   use Plack::Builder;
> > 
> >   my $app = Plack::App::CGIBin->new(root => "/path/to/cgi-bin")->to_app;
> >   builder {
> >         mount "/cgi-bin" => $app;
> >   };
> 
> You use the predefined paths here on initialization. FCGI::Spawn knows about
> the CGI application's path at the right moment it takes the request.

No, you need to provide only *root*, i.e. where Perl CGI applications
are, so that e.g. accessing 'http://0:5000/cgi-bin/foo/bar.cgi' would
run PSGI-ized (via CGI::Emulate::PSGI) '/path/to/cgi-bin/foo/bar.cgi'
application.

You don't need to mount it at "/cgi-bin", you can just

  builder {
        $app;
  }

or even without it ($app should be the last expression).


Or did you mean here something like mod_rewrite, or
Plack::Middleware::Rewrite?

[...]  
> > Gitweb doesn't use no POST requests: it is read-only web repository
> > browser... well, except for the 'show_ctags' action.
> 
> Tag cloud? Is there an example of usable tag cloud on any public gitweb out
> there?

Tag cloud are optional feature in stock gitweb, named 'ctag' in %feature
hash.  It is disabled by default.  If I understand correctly POST is
used here to populate which tags one wants to use... but perhaps GET
request would be enough here (at the cost of less readable URL).

See http://repo.or.cz for example usage of this feature.

-- 
Jakub Narebski
Poland
