From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Sun, 16 May 2010 14:15:28 +0400
Organization: '
Message-ID: <20100516101528.GA5761@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005141958.16469.jnareb@gmail.com> <20100515100615.GA3564@screwed.box> <201005151558.12191.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 12:15:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODasy-0002bF-V2
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0EPKPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 06:15:48 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:65184 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab0EPKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 06:15:47 -0400
Received: from localhost (xvm-0-245.ghst.net [92.243.0.245])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 984D15A81;
	Sun, 16 May 2010 14:04:11 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005151558.12191.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147181>

Be sure to wear flowers on your hat, Jakub!
2010/05/15 15:58:11 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
===
JN> >       eval "use Image::Magick;";
JN> >       if ($@){
JN> > ===
JN> > 
JN> > are those lemmings wrong?
JN> 
JN> No they are not.

so that code is just right, and this:
===
eval( 'use Module;' ); die $@ if $@;
===

is 'Wrong!'. And what is the difference?

JN> would work as expected, I think that 'use' in conditional 'eval BLOCK' would
JN> not.

I think so too as I did never meant about eval BLOCK;

JN>   if (<condition>) {
JN>       eval { use Image::Magick; }
JN>       ...
JN>   }
JN> 
JN> So if you want to use 'eval BLOCK' form, you need to use 'require' and not
JN> 'use':
JN> 
JN>   if (<condition>) {
JN>       eval { require Image::Magick; import Image::Magick; }
JN>       ...
JN>   }
JN> 
JN> 
JN> Second, if you are not interested in error condition, and only whether
JN> require'ing some module failed or not, then instead of
JN> 
JN>   eval { require Net::SSLeay };
JN>   no_SSL_warning($URL) if $@;
JN> 
JN> you can use the 'eval { <sth>; 1 };' idiom, i.e.
JN> 
JN>   eval { require Net::SSLeay; 1; }
JN>       or no_SSL_warning($URL);

'eval BLOCK' versus 'eval EXPR' it's just better, but not a tabu. 'eval EXPR'
with $@ checking causes no any errors on the same runtime with the code to be
executed later.
For most cases the modules are used, the read/parsing error can be the only
error possible as no run-time code happens out there but only the symbols
declaration.
Therefore checking $@ is just fine.

JN> When I added checking for $@ in the form of 'die $@ if $@', the error that
JN> Perl shown was the syntax error in the foo() subroutine in $file file.

and this is where the $@ was sufficient, too.

JN> I don't know if it would be complete replacement for FCGI::Spawn, but from
JN> your description of it, using Plack::App::CGIBin middleware (+ plackup +
JN> Plack::Handler::FCGI wrapper) could be a valid alternative to it..

There are some more features those are on by default in FCGI::Spawn if they are
to be replaced, not sure if I will find them inside that framework.

JN> P.S. About Girocco: instead of writing it as set of separate CGI scripts, it
JN> could have been instead written as single app, loading its modules ('use
JN> lib' would help).

... and sharing them with gitweb, right. ;-)

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
