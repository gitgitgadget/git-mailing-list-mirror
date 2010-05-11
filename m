From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Tue, 11 May 2010 10:24:15 +0400
Organization: '
Message-ID: <20100511062415.GA5220@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005092018.54580.jnareb@gmail.com> <20100510071340.GA3382@screwed.box> <201005101729.07334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 08:24:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBitf-0003kL-69
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab0EKGYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 02:24:42 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:58208 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491Ab0EKGYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 02:24:40 -0400
Received: from localhost (tor-exit.aof.su [216.224.124.124])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id B18F95A81;
	Tue, 11 May 2010 10:12:59 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005101729.07334.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146871>

I know St. Peter won't call your name, Jakub!
2010/05/10 17:29:03 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> On Mon, 10 May 2010, Peter Vereshagin wrote:
JN> > 2010/05/09 20:18:52 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> > 
JN> > Great! I was just about to ask on caching, etc. What a complex history on all
JN> > of that, will be on those tracks after some of my whiles. ;-)
JN> 
JN> You can find current state of my take on gitweb output caching (based
JN> on / inspired by work by John 'Warthog9' Hawley) in my repository on
JN> repo.or.cz, in the 'gitweb/cache-kernel-pu' branch:
JN> 
JN>   http://repo.or.cz/w/git/jnareb-git.git  gitweb/cache-kernel-pu
JN>  
JN> You can find progress reports (and what current show-stoppers are) in
JN> git mailing list archives.

I will.

JN> Note that http://repo.or.cz does its own gitweb caching, IIRC by
JN> caching Perl data, and only for 'projects_list' page (the most costly
JN> one).
JN> 
JN> There was also "Gitweb caching" projects in GSoC 2008 by Lea Wiemann,
JN> which IIUC cached output of git commands. This project was, I think,
JN> completed but didn't get merged into git.
JN> 
JN> > JN> What are required changes to gitweb to use FCGI::Spawn to run gitweb as
JN> > JN> a FastCGI script?  Alternatively, how the wrapper script for gitweb 
JN> > JN> (gitweb.fcgi) to be run as FastCGI should look like to use FCGI::Spawn?
JN> > 
JN> > By far it's only an exit() of the what I use (1.6.0.6):
JN> 
JN> Why so old git?  Current version is git version 1.7.1

Update or die sounds too consumerical to me ;-)

JN> 
JN> > 
JN> > --- /usr/local/share/examples/git/gitweb/gitweb.cgi     2010-02-25 13:49:30.068287112 +0300
JN> > +++ www/gitweb.cgi                                      2010-03-13 14:28:45.326244103 +0300
JN> 
JN> Hrmph.  Why not use "git diff --no-index <file1> <file2>" here?
JN> 
JN> The Perl-aware equivalent of '-p' option of GNU diff, i.e. showing in
JN> which function we are in hunk headers, would help here.

It's obvious that I just made a more simple thing about this patch: grep exit
gitweb.cgi. Meat and potatoes ;-)

JN> 
JN> > @@ -933,7 +933,7 @@
JN> >         die_error(400, "Project needed");
JN> >  }
JN> >  $actions{$action}->();
JN> > -exit;
JN> > +#      exit;
JN> 
JN> This 'exit' was here just in case there were some forgotten code below
JN> this line outside subroutines (that should not be run).  It can be
JN> safely removed.
JN> 
JN> >  
JN> >  ## ======================================================================
JN> >  ## action links
JN> > @@ -3371,7 +3371,7 @@ sub die_error {
JN> 
JN> I have added my guess of in which subroutine this code is above.

Right.

JN> 
JN> >  </div>
JN> >  EOF
JN> >         git_footer_html();
JN> > -       exit;
JN> > +#              exit;
JN> >  }
JN> 
JN> Err... and gitweb works correctly with this change?  This 'exit' was
JN> required for die_error to function like 'die' in that it finishes
JN> serving request, and should not continue subroutine it was called
JN> from.

Does at least on 'non-existent diff' page:

http://gitweb.vereshagin.org/fcgiproxy/commitdiff/abcd

JN> I have changed this 'exit' to non-local goto to toplevel.  It could be
JN> done instead by redefining 'exit' subroutine, like shown below, but I
JN> feel that would be hacky if you can change gitweb code (it is not
JN> black box you should not touch).

Right, one shouldn't ever redefine perl built-in functions. I did only because
of no other way to 'get things working'

JN> 
JN> >  
JN> >  ## ----------------------------------------------------------------------
JN> > 
JN> > but it's probably even not necessary with -e parameter:
JN> > http://search.cpan.org/~veresc/FCGI-Spawn-0.16.1/fcgi_spawn#Command_line_options
JN> > which is definitely required for bugzilla, the worst boy in that sandbox. The
JN> > parameter does just this: 
JN> > ===
JN> > my $cref = sub {
JN> >   if ('FCGI::ProcManager' eq scalar caller) {
JN> >     CORE::exit @_;
JN> >   } else {
JN> >     no warnings;
JN> >     last CALLED_OUT;
JN> >   }
JN> > };
JN> > *CORE::GLOBAL::exit = $cref;
JN> > *CORE::GLOBAL::exit;
JN> > ===
JN> 
JN> This is quite nice idea to replace 'exit' by subroutine that does
JN> non-local jump to outside of application, at the end of request loop.
JN> Such "monkey patching" is the only solution if you can't or shouldn't
JN> modify application code (like FCGI::Spawn being generic solution).

Yes, this is quick-n-dirty to apply for those monkeys who are just busy to care
about re-writing CGI apps.

JN> > so this requires configuration 
JN> > ( $PREFIX/etc/fcgi_spawn/preload_nonprepared_01.pl, in my case ) for fcgi_spawn
JN> > daemon like this:
JN> > ===
JN> >   $spawn->{ callout } =  sub{ do shift;
JN> >   CALLED_OUT: 
JN> >   };
JN> > ===
JN> 
JN> Here
JN> 
JN>    $spawn->{'callout'} = sub {
JN>    	my $cgi_app = shift;
JN>    	do $cgi_app;
JN> 
JN>         # this is needed for sane error handling
JN>         die "Couldn't parse $cgi_app: $@" if $@;
JN> 
JN>    CALLED_OUT: 
JN>    };

in a forked application, die() is a PITA on any reasonable load. It makes the
CoW-shared memory to be copied into separate area and being marked as unusable
before the process is dead. This is the only case I saw load averages on the
servers valued as crazy ~700.
So just exit there, not die. By far, die can not be redefined the same way as I
propose for exit in FCGI::Spawn.

JN> 
JN> could be simply replaced by
JN> 
JN>   use CGI::Compile;
JN> 
JN>   # ...
JN> 
JN>   $spawn->{'callout'} = \&{CGI::Compile->compile}
JN> 
JN> or something like that.  See CGI::Compile manpage and CGI::Compile source:
JN> http://cpansearch.perl.org/src/MIYAGAWA/CGI-Compile-0.11/lib/CGI/Compile.pm
JN> 
JN> >
JN> > All of that is not needed without exit() in gitweb, now.
JN> 
JN> BTW I wonder what are the consequences for performance on replacing
JN> 'exit' by non-local jump.  It can degrade performance a bit for gitweb
JN> run as pure CGI (mod_cgi / mod_cgid), but should improve performance
JN> for mod_perl, at least if there are more connections... unless
JN> ModPerl::Registry does similar trick with exit().

I knew out about such a trick somewhere in modperlbook. For mod_perl, this
should be done in startup.pl

JN> > I didn't mean FCGI::PM is a problem by itself. The standalone gitweb daemon is
JN> > great thing for those who need such a choice. FCGI::Spawn is just for some
JN> > different task: to put several ( wish to say: any CGI app ) applications inside
JN> > the same fork()ed processes. It should be just obviously documented for a user
JN> > as a dependency for implementation of a gitweb fastcgi daemon. Although I'm not
JN> > sure if the FCGI::PM package should be a dependency for git package for any OS:
JN> > for those modules use()d in eval() my guess is: particular user's choice to be
JN> > offered.
JN> > 
JN> > So FCGI::PM usage I think makes a flavor taste for any daemon and thus should
JN> > be explicit. YMMV for those uninvolved in daemonizing, of course. ;-)
JN> 
JN> Hmmm... is FCGI::Spawn really needed, or can it be replaced by simple
JN> PSGI wrapper using either Plack::App::CGIBin, 
JN> 
JN>   use Plack::App::CGIBin;
JN>   use Plack::Builder;
JN> 
JN>   my $app = Plack::App::CGIBin->new(root => "/path/to/cgi-bin")->to_app;
JN>   builder {
JN>         mount "/cgi-bin" => $app;
JN>   };

You use the predefined paths here on initialization. FCGI::Spawn knows about
the CGI application's path at the right moment it takes the request.

JN> or Plack::App::WrapCGI plus Plack::App::URLMap, the last indirectly
JN> via Plack::Builder DSL:
JN> 
JN>   use Plack::Builder;
JN>   use Plack::App::WrapCGI;
JN> 
JN>   builder {
JN>         mount "/foo" =>
JN>                 Plack::App::WrapCGI->new(script => "foo.cgi")->to_app;
JN>         mount "/bar" =>
JN>                 Plack::App::WrapCGI->new(script => "bar.cgi")->to_app;
JN>   };

Sounds no more simple than simplicity of php deployment. That is whom the
FCGI::Spawn combats for.
Probably, 'the directories and scripts cache' should help to defer such an
initialization? like it is done about the DBI handles in Apache::DBI. You can
perform that init on a first request per fork, and keep it built for all of the
process lifetime for the requests coming next.

JN> > Is it probable that gitweb doesn't take any POSTs requests? The main trick
JN> > around FCGI::Spawn is the need to patch the CGI.pm but if that is the case...
JN> > I'd try to redefine the STDIN to /dev/null or zero so FCGI.Spawn.CGI.pm.patch
JN> > should be unnecessary for one who only wants to run the gitweb in FCGI::Spawn.
JN> > If switch to FCGI.pm will be way complicated to me.
JN> 
JN> Errr... excuse me, what you wanted to say in the paragraph above?

CGI::Fast use CGI.pm for POST input. With FCGI.pm I'll use CGI.pm for POST
input only on an application's demand in FCGI::Spawn.
In case of gitweb.cgi POST is not used. This makes the CGI.pm patch supplied
with FCGI::Spawn not needed.
But web user may send the POST request and FCGI::Spawn should feed a dummy
input for CGI.pm in the CGI script waiting for input from STDIN when request
method is POST.
Not sure if this feature is needed at all for FCGI::Spawn though.

JN> Gitweb doesn't use no POST requests: it is read-only web repository
JN> browser... well, except for the 'show_ctags' action.

Tag cloud? Is there an example of usable tag cloud on any public gitweb out
there?

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
