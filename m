From: Daniel Quinlan <danq@brtt.com>
Subject: Re: help with git usage
Date: Wed, 7 May 2008 16:41:27 -0600
Message-ID: <200805072242.m47Mg1o0015578@rs40.luxsci.com>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com> <alpine.LNX.1.00.0804291354070.19665@iabervon.org> <m3tzhjokox.fsf@localhost.localdomain>
Content-Type: multipart/mixed; boundary=Apple-Mail-45--35346685
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtsOJ-000695-Vc
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360AbYEGWor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbYEGWoq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:44:46 -0400
Received: from rs40.luxsci.com ([65.61.166.82]:43488 "EHLO rs40.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934077AbYEGWoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:44:37 -0400
Received: from rs40.luxsci.com (localhost [127.0.0.1])
	by rs40.luxsci.com (8.13.1/8.13.7) with ESMTP id m47MgYDf016033;
	Wed, 7 May 2008 17:42:34 -0500
Received: (from root@localhost)
	by rs40.luxsci.com (8.13.1/8.13.7/Submit) id m47Mg1o0015578;
	Wed, 7 May 2008 22:42:01 GMT
Received: (from danq@brtt.com) by Lux Scientiae SMTP Processor; Wed, 07 May 2008 22:42:01 +0000
In-Reply-To: <m3tzhjokox.fsf@localhost.localdomain>
X-Comment: Lux Scientiae SMTP Processor Message ID - 1210200121-8308113.50503414
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81490>


--Apple-Mail-45--35346685
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Thanks for your earlier responses, they were very helpful.

On Apr 30, 2008, at 1:39 AM, Jakub Narebski wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> On Tue, 29 Apr 2008, Daniel Quinlan wrote:
>>
>>> I've been trying to use git for awhile now, (and I've read a lot
>>> of documentation, though maybe my comprehension has not been high
>>> enough) but there are several operations which I can't figure out:
>
> Many of answers to your questions can be found on GitFaq,
> http://git.or.cz/gitwiki/GitFaq

I should have read this earlier.  I don't really understand the
details, but I get the idea:  make the central repository bare.

>

>>> 3) Similarly, I can't use the little context diffs I can see in
>>> git-gui -- I need to see side by side comparisons; I've become
>>> accustomed to tkdiff.  It seems like git mergetool knows how to do
>>> that in some restricted circumstances, but I want to do it outside
>>> the context of a merge.
>>
>> This I don't know, but you can get particular files from particular
>> commits output with "git show <commit>:<path>", and you can likely  
>> wire
>> something up.
>
> From the various graphical comparison tools, Meld has supposedly Git
> support (http://meld.sourceforge.net/).  Supposedly only because I
> have not tested this; see
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-00fbd1ac45fe93dac4653cad3639b3df73d8657e
>

I found no mention of git on the meld man page or in the meld mailing  
list.

Here's a (perhaps naive) perl script which uses "git show" and wraps  
around
the original tkdiff.  Other cvs users might find it useful, though it  
can surely
be improved.


--Apple-Mail-45--35346685
Content-Disposition: attachment;
	filename=gtkdiff
Content-Type: application/octet-stream;
	x-unix-mode=0755;
	name="gtkdiff"
Content-Transfer-Encoding: 7bit

: # use perl
eval 'exec perl -S $0 "$@"'
if 0;

use strict ;

require "getopts.pl" ;
our($opt_r) ;
if ( ! &Getopts('r:nv') || @ARGV != 1 ) { 
    my $pgm = $0 ; 
    $pgm =~ s".*/"" ;
    die ( "Usage: $pgm [-r commit] filename\n" ) ; 
}


my $filename = shift ; 
if ( ! -f $filename ) { 
    die ( "$filename not found\n" ) ;
}

chomp(my $prefix = `git-rev-parse --show-prefix`) ;
$opt_r = "HEAD" if ! defined $opt_r ;
my $name = $filename ; 
$name =~ s".*/"" ;
my $tmpfile = "/tmp/$name" ;
system ("git show '$opt_r:$prefix$filename' > $tmpfile" ) ; 
system ( "tkdiff $tmpfile $filename" ) ;
unlink "$tmpfile" ;
 

--Apple-Mail-45--35346685
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit





I'm looking for a way to embed some identifying information about  
version
into compiled programs.  I hasten to add that I am not looking to  
expand RCS-like
tags.  Unlike CVS/RCS, git provides a single value that characterizes  
the whole
distribution, at least if everything is committed.  So, something like  
"git log | head -1 | awk '{print $2}'"
probably provides a value which I can embed into executables and  
libraries, tying
them to a particular source configuration.  I'm just curious if  
there's a better approach
to getting the commit hash.

-- danq



--Apple-Mail-45--35346685--
