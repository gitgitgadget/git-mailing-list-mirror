From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitweb: Add test t9500 for gitweb (as standalone script)
Date: Sun, 17 Jun 2007 17:39:53 +0200
Message-ID: <20070617153953.GW955MdfPADPa@greensroom.kotnet.org>
References: <11795339604115-git-send-email-jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 17:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzwrA-0001iD-4A
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 17:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXFQPj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbXFQPj7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 11:39:59 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:39432 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbXFQPj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 11:39:58 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJS005O7E6IGR@smtp13.wxs.nl> for git@vger.kernel.org; Sun,
 17 Jun 2007 17:39:57 +0200 (CEST)
Received: (qmail 4187 invoked by uid 500); Sun, 17 Jun 2007 15:39:53 +0000
In-reply-to: <11795339604115-git-send-email-jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50354>

On Sat, May 19, 2007 at 02:19:20AM +0200, Jakub Narebski wrote:
> This test runs gitweb (git web interface) as CGI script from
> commandline, and checks that it would not write any errors
> or warnings to log.

Could you please skip this test if the version of perl is too old?

In particular, I get
[Sun Jun 17 17:28:11 2007] gitweb.perl: Too many arguments for Encode::decode_utf8 at ../../gitweb/gitweb.perl line 618, near "Encode::FB_CROAK)"
[Sun Jun 17 17:28:11 2007] gitweb.perl: Execution of ../../gitweb/gitweb.perl aborted due to compilation errors.

My Encode.pm has

----
sub decode_utf8($)
{
    my ($str) = @_;
    return undef unless utf8::decode($str);
    return $str;
}
----

Curiously, it also has

----
=item $string = decode_utf8($octets [, CHECK]);
 
equivalent to C<$string = decode("utf8", $octets [, CHECK])>.
The sequence of octets represented by
$octets is decoded from UTF-8 into a sequence of logical
characters. Not all sequences of octets form valid UTF-8 encodings, so
it is possible for this call to fail.  For CHECK, see
L</"Handling Malformed Data">.
----


In any case, I don't feel like upgrading perl just for gitweb
on this machine.

bash-3.00$ perl -V
Summary of my perl5 (revision 5.0 version 8 subversion 0) configuration:
  Platform:
    osname=linux, osvers=2.4.18, archname=i686-linux-thread-multi
    uname='linux greensroom 2.4.18 #2 smp fri jul 19 13:03:13 cest 2002 i686 unknown '
    config_args='-Doptimize=-g -Dprefix=/usr -Dusedevel -Dusethreads -Duseithreads -Duseshrplib -Dinstallusrbinperl -des'
    hint=recommended, useposix=true, d_sigaction=define
    usethreads=define use5005threads=undef useithreads=define usemultiplicity=define
    useperlio=define d_sfio=undef uselargefiles=define usesocks=undef
    use64bitint=undef use64bitall=undef uselongdouble=undef
    usemymalloc=n, bincompat5005=undef
  Compiler:
    cc='cc', ccflags ='-D_REENTRANT -D_GNU_SOURCE -DDEBUGGING -fno-strict-aliasing -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64',
    optimize='-g',
    cppflags='-D_REENTRANT -D_GNU_SOURCE -DDEBUGGING -fno-strict-aliasing -I/usr/local/include'
    ccversion='', gccversion='2.95.3 20010315 (SuSE)', gccosandvers=''
    intsize=4, longsize=4, ptrsize=4, doublesize=8, byteorder=1234
    d_longlong=define, longlongsize=8, d_longdbl=define, longdblsize=12
    ivtype='long', ivsize=4, nvtype='double', nvsize=8, Off_t='off_t', lseeksize=8
    alignbytes=4, prototype=define
  Linker and Libraries:
    ld='cc', ldflags =' -L/usr/local/lib'
    libpth=/usr/local/lib /lib /usr/lib
    libs=-lnsl -lndbm -lgdbm -ldb -ldl -lm -lpthread -lc -lcrypt -lutil
    perllibs=-lnsl -ldl -lm -lpthread -lc -lcrypt -lutil
    libc=, so=so, useshrplib=true, libperl=libperl.so
    gnulibc_version='2.2.5'
  Dynamic Linking:
    dlsrc=dl_dlopen.xs, dlext=so, d_dlsymun=undef, ccdlflags='-rdynamic -Wl,-rpath,/usr/lib/perl5/5.8.0/i686-linux-thread-multi/CORE'
    cccdlflags='-fpic', lddlflags='-shared -L/usr/local/lib'


Characteristics of this binary (from libperl): 
  Compile-time options: DEBUGGING MULTIPLICITY USE_ITHREADS USE_LARGE_FILES PERL_IMPLICIT_CONTEXT
  Built under linux
  Compiled at Jul 19 2002 18:11:28
  @INC:
    /usr/lib/perl5/5.8.0/i686-linux-thread-multi
    /usr/lib/perl5/5.8.0
    /usr/lib/perl5/site_perl/5.8.0/i686-linux-thread-multi
    /usr/lib/perl5/site_perl/5.8.0
    /usr/lib/perl5/site_perl
    .

skimo
