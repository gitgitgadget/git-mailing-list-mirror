From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Tue, 11 May 2010 16:09:24 +0400
Organization: '
Message-ID: <20100511120924.GC5220@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005101729.07334.jnareb@gmail.com> <20100511062415.GA5220@screwed.box> <201005111258.53388.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 14:09:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBoHO-0000jB-RI
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 14:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0EKMJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 08:09:36 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:51501 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab0EKMJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 08:09:35 -0400
Received: from localhost (gpftor6.privacyfoundation.de [62.212.67.209])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 2C3455A83;
	Tue, 11 May 2010 15:57:57 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005111258.53388.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146887>

I know St. Peter won't call your name, Jakub!
2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> > > I have added my guess of in which subroutine this code is above.
JN> 
JN> [...]
JN> > > >         git_footer_html();
JN> > > > -       exit;
JN> > > > +#              exit;
JN> > > >  }
JN> > > 
JN> > > Err... and gitweb works correctly with this change?  This 'exit' was
JN> > > required for die_error to function like 'die' in that it finishes
JN> > > serving request, and should not continue subroutine it was called
JN> > > from.
JN> > 
JN> > Does at least on 'non-existent diff' page:
JN> > 
JN> > http://gitweb.vereshagin.org/fcgiproxy/commitdiff/abcd
JN> 
JN> Hmmm... strange that it works.

just break it (c) ;-)
There are many other cases for this function to use, I just don't care. It's
all yet readonly after all ;-)

JN>  
JN> > > I have changed this 'exit' to non-local goto to toplevel.  It could be
JN> > > done instead by redefining 'exit' subroutine, like shown below, but I
JN> > > feel that would be hacky if you can change gitweb code (it is not
JN> > > black box you should not touch).
JN> > 
JN> > Right, one shouldn't ever redefine perl built-in functions. I did only because
JN> > of no other way to 'get things working'
JN> 
JN> Why not?  For example CGI::Carp redefines 'die' to log errors.

Ouch, sorry, I meant last() or something like that.
I just believe any non-system application development for end-user being a
non-developer doesn't need to redefine perl built-in functions. Just a sane
bone tone for common functioning in a sandbox.
For example, I remember the Linux kernel  ( or Glibc? ) was criticised much of
being possible to override the str*cmp() inside. Because most of the existing
commerceware were protected from copying by password, e. g. serial number, etc.
sometimes by authors. So criticants supposed it's impossible to 'protect' their
software this way. And thus Linux was 'bad'. ;-)
Nowadays we have all of those possible actions ( trying to investigate and
substitute the password hash in the str*cmp() called by user-space software )
classified by Crime Code and aoplied apparently widely. Kind of confessional
debates between those who suppose the potentially dangerous thing should be
restricted because it can be used as harm and those who use it regularly
without any idea to use it in any different dangerous way. Last time I saw them
on bbc about islam - 'hey, your islam spells to cut thievs' arms' - 'hey islam
of no danger, it's just very powerful and you shouldn't use it in dangerous
way'.
This will last for ages, anyway. You may find them even in "Just For Fun",
where the 'pubs' restricted topics' persist. Even there. 
So one who use CORE:: namespace in their sources should always know it can be
grepped and considered as dangerous, especially if those are 3rd+ party
sources, not approved by any reasonable authority, and there are lots of such a
software off the shelves to choose. And most of them doesn't use to override
perl built-in functions. ;-)

JN> 
JN>   BEGIN { 
JN>     require Carp; 
JN>     *CORE::GLOBAL::die = \&CGI::Carp::die;
JN>   }
JN> 
JN> Sub::Uplevel and Test::Exception redefines 'caller' (perhaps locally).
JN> CGI::Compile redefines 'exit':
JN> 
JN>   our $USE_REAL_EXIT;
JN>   BEGIN {
JN>       $USE_REAL_EXIT = 1;
JN>       *CORE::GLOBAL::exit = sub (;$) {
JN>           my $exit_code = shift;
JN> 
JN>           CORE::exit(defined $exit_code ? $exit_code : 0) if $USE_REAL_EXIT;
JN> 
JN>           die [ "EXIT\n", $exit_code || 0 ]
JN>       };
JN>   }
JN> 
JN> 
JN> > > This is quite nice idea to replace 'exit' by subroutine that does
JN> > > non-local jump to outside of application, at the end of request loop.
JN> > > Such "monkey patching" is the only solution if you can't or shouldn't
JN> > > modify application code (like FCGI::Spawn being generic solution).
JN> > 
JN> > Yes, this is quick-n-dirty to apply for those monkeys who are just busy to care
JN> > about re-writing CGI apps.
JN> 
JN> Errr... "monkey patching" is the name of technique of extending and
JN> modifying runtime code in dynamic languages, see
JN> 
JN>   http://en.wikipedia.org/wiki/Monkey_patch

What's about 'patching'? Mokeys I meant to be the OpenBSD ( or non-OpenBSD ) crowd ;-)
http://article.gmane.org/gmane.linux.kernel/706950

JN> Although I am not entirely sure if I correctly applied this name to
JN> described (used) techique.


'Replace methods/attributes/functions at runtime, e.g. to stub out a function
during testing;'

sounds like 'dynamic modules reloading' to me. Yes, that is about FCGI::Spawn,
its 'stats' disablable feature 

'Modify/extend behaviour of a third-party product without maintaining a private
copy of the source code; '

sounds like 'run any 3rd-party CGI app in FCGI::Spawn'

Yep, uncle Darwin cries out loud. ;-)

JN> 
JN> > > Here
JN> > > 
JN> > >    $spawn->{'callout'} = sub {
JN> > >    	my $cgi_app = shift;
JN> > >    	do $cgi_app;
JN> > > 
JN> > >     # this is needed for sane error handling
JN> > >     die "Couldn't parse $cgi_app: $@" if $@;
JN> > > 
JN> > >    CALLED_OUT: 
JN> > >    };
JN> > 
JN> > In a forked application, die() is a PITA on any reasonable load. It makes the
JN> > CoW-shared memory to be copied into separate area and being marked as unusable
JN> > before the process is dead. This is the only case I saw load averages on the
JN> > servers valued as crazy ~700.
JN> >
JN> > So just exit there, not die. 
JN> 
JN> Well, it might be 'exit' not 'die', but you really, really need to check
JN> if there were problems parsing file.  Otheriwse you can get error
JN> messages somewhere further on that doesn't absolutely make sense.  

php is very successful with this: it can put error messages to both STDOUT and
STDERR or separate log. FCGI::Spawn is the something about that because it's
the 'what the most people want' (c) Junio. ;-)
Anyway, if the file was not parsed, it did not change anything in perl's
compile-cache/variables and therefore it's quite safe for any othe application
on the same sandbox. Why should the fork die if some file gets unparsed? 

JN> I know this from painful experience of trying to find bug in a
JN> test... when the error was in parsing file in 'do $file;'.

I handle them just fine like in any other CGI program using
CGI::Carp:fatalsToBrowser. Are you about to 'make test' via the http? ;-)

[...]

JN>   builder {
JN>         $app;
JN>   }

that's the wow to try. I will after some of my whiles.

JN> or even without it ($app should be the last expression).
JN> Or did you mean here something like mod_rewrite, or
JN> Plack::Middleware::Rewrite?

No, nginx rewrites just fine, it's a matter of another application level I
believe.
The scoop is meat and potatoes: here is the cgi app, just do it over FastCGI.
There are no such a thing as a mandatory mounts and paths tweaks in php's
fastcgi. Hope PSGI has no them either.

JN> [...]  
JN> > > Gitweb doesn't use no POST requests: it is read-only web repository
JN> > > browser... well, except for the 'show_ctags' action.
JN> > Tag cloud? Is there an example of usable tag cloud on any public gitweb out
JN> > there?
JN> 
JN> Tag cloud are optional feature in stock gitweb, named 'ctag' in %feature
JN> hash.  It is disabled by default.  If I understand correctly POST is
JN> used here to populate which tags one wants to use... but perhaps GET
JN> request would be enough here (at the cost of less readable URL).
JN> 
JN> See http://repo.or.cz for example usage of this feature.

Ouch, it was the first for me to look for them. It's just not named like that
there ( and looked like linkspam ;-. Anyway. user registration .cgi is a part
of gitweb distribution? It contains POST form and it's not  preferable stuff to
omit for too many cases to consider such a gitweb-based web site to be 'mostly
read-only' for a user.
Or those .cgi's are nothing in common with gitweb?

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
