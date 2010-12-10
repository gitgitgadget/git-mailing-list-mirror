From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 17/18] gitweb: Prepare for cached error pages & better error page handling
Date: Fri, 10 Dec 2010 21:33:31 +0100
Message-ID: <201012102133.31816.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3r5dqz9c5.fsf@localhost.localdomain> <4D01E5CC.6010301@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 21:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR9f6-0002jK-G4
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 21:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab0LJUdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 15:33:39 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:53875 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab0LJUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 15:33:37 -0500
Received: by fxm18 with SMTP id 18so4215734fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NJ/RjtO33j9gKgVgysFLyL1+hFk5Xbjp4nzfu9SFCEU=;
        b=DleV7q0XgDJfxCRkLq2AiWtQAb3ZSfaVkCJ99za8IYe1xW8djrnURWFiNdu+CQbfxz
         zXL+y4foV0oyfzlN5q4Nxpd2OzzUrTDFqZG6/4P1QlWJD3NC6ZFFUuqv4wE/FNH1TFH4
         3LBqLZq46M9XFT8mIRPoeG8j0WEJE7QCDy/jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Uj5tpGoxW+4P75RRgbyoqgFzTjyrCdKx9UWw+0myb/aSNKzbxxYvO32jL2LJJ6W+DP
         H0DeY2tyZuU+Oro2OpbNebwmWASIjLJ0YJuS2IaoIXs9fNnME3AkBj/Y+BE6UCPHBcvv
         QFun6BqzHUkZnRFHXeM65Ri30TfsUZV+C+Ltc=
Received: by 10.223.83.11 with SMTP id d11mr1440694fal.37.1292013215210;
        Fri, 10 Dec 2010 12:33:35 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id r24sm1048547fax.3.2010.12.10.12.33.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 12:33:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D01E5CC.6010301@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163439>

On Fri, 10 Dec 2010, J.H. wrote:

> > There is no problem with capturing output of die_error, nor there is a
> > problem with caching error pages (perhaps transiently in memory).
> > 
> > The problem is that subroutines calling die_error assum that it would
> > exit ending subroutine that is responsible for generating current
> > action; see "goto DONE_GITWEB" which should be "goto DONE_REQUEST",
> > and which was "exit 0" some time ago at the end of die_error().
> > 
> > With caching error pages you want die_error to exit $actions{$action}->(),
> > but not exit cache_fetch().  How do you intend to do it?
> 
> Well there's one bug in how that function ends in looking at it again,
> basically the return case shouldn't happen, and that function should
> end, like your suggesting in the first part of your question (with
> respect to DONE_GITWEB)
> 
> In the second part, your not thinking with the fork() going (though in
> thinking sans the fork this might not work right).
> 
> It's the background process that will call die_error in such a way that
> die_error_cache will get invoked.  die_error_cache will write the .err
> file out, and the whole thing should just exit.
> 
> Though now that I say that there's an obvious bug in the case where
> forking didn't work at all, in that case you would get a blank page as
> the connection would just be closed.  If you refreshed (say hitting F5)
> you'd get the error at that point.
> 
> Need to fix that non-forked problem though.

Well, if you, the author, cannot follow code flow of your own code, what
does it matter for being sure that this code is bug free?  What does this
matter for maintability of this code?
 

That rant aside, error / exception handling in gitweb is currently not
fitting well with output caching, at least the locking one.

die_error() functions as a kind of exception handling; we rely that on
the fact that calling die_error() would end request, independent on how
deep in the stack we are.  Originally die_error() ended with 'exit',
which ModPerl::Registry redefined for it to end request and not exit
worker.  Then 'exit' was replaced by 'goto DONE_GITWEB' to jump out of
several levels of calls; I didn't know then about ModPerl::Registry
redefining 'exit'... and actually it should be 'goto DONE_REQUEST', like
in "[PATCH/RFC] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in
die_error"

  http://permalink.gmane.org/gmane.comp.version-control.git/162156

It is because die_error is exception mechanism, and in current incarnation
always ends request, that is why error pages (generated by die_error) were
not cached: we jump out of capturing and out of caching.  The additional
reasoning is that we don't want to bloat cache with error pages, which 
IMHO usually gets requested only once (assumption: different clients makes
different errors).

Now in most cases the approach taken to modify die_error for caching only
by adding explicit turning off capturing at the beginning of die_error is
enough.

1. Single client, no generating in background (note that if given URL is
   never cached, we would not invoke background generation to refresh shown
   stale data - there wouldn't be stale data).

   In this case if there is an expected error, die_error() gets explicitely
   invoked, turns off capturing, prints error page to client, and ends
   request.

   In the case of uncaught "die", it would be caught by CGI::Carp error
   handler, and passed to handle_errors_html() subroutine (thanks to gitweb
   using set_message(\&handle_errors_html)), which runs die_error() with
   options making it not print HTTP header (which was already printed by
   CGI::Carp error handler), and not exit - the CGI::Carp error handler
   would end request instead.  die_error() turns of capturing, prints
   error page, and CGI::Carp error handler ends request.

2. Two clients arriving at exactly the same error (same link), at the
   same time.  This is quite unlikely.

   In my rewrite there is loop in ->compute method in rewritten caching
   engine, which reads:

      do {
          ...
      } until (<received data to show to user> || <tried to generate data ourself>);

   This means that one client acquires writers lock, die_error prints error
   page and exists, second client notices that it didn't get anything but
   didn't try it itself yet, and dies itself on die_error()

   Dealing with "die"-ing works the same as in the case described above,
   so there is no problem from this area neither.

   Alternate solution would be to treat it as the case described below.

3. Gitweb runs generating cache entry in background.  Note that if error
   pages are not cached, there would be no stale pages to serve while 
   regenerating data in background - so entering background process can
   be done only thanks to "Generating..." page.
   
   We can try _prevent this from happening_, as I did in my rewrite by
   introducing initial/startup delay in "Generating..." (which has also
   other reasons to use), or via 'generating_info_is_safe' protection.

   Otherwise we need to pass error page from background process to
   foreground proces that is showing "Generating..." page; well, to be
   more exact, with current workings of "Generating..." it would be its
   successor (next request, after reload / refresh).

   Note: the fact that it is *next request* that needs an error page
   (otherwise we would show "Generating..." page yet again).

   So what die_error needs to do if it finds itself in the background
   process (perhaps explicit $background boolean variable, perhaps
   comparing $$ with $my_pid, perhaps checking if STDOUT is closed)
   it needs to somehow write cache entry, perhaps in a special way
   marking it as error page.  The problem is to do it in generic way,
   that would not make it impossible to use other caching engine, or
   other capturing engine, in the future.

   Note also that at the end of background process (perhaps at the
   end of die_error) we need to exit process, and not just end request,
   so we should use 'CORE::exit(0);'.

The problem with 3rd case makes me think that it is high time that
die_error use Perl 5 exception throwing and handling mechanism, namely
"die" (for throwing errors, to be used in die_error), and "eval BLOCK"
(to catch errors).

As proposed on #perl channel when asking about this situation, die_error
would use 'die \$DIE_ERROR' to throw reference, or throw an object, to
easy distinguish between handled error from die_error, and unhandled
error from Perl (where we assume that all errors are strings).

run_request() or run() would then use 'eval { ... }', which has the
additional advantage that we can get rid of CGI::Carp::set_message,
which doesn't allow to use custom HTTP status, and supposedly doesn't
work with mod_perl 2.0.  Instead of adding capture_stop() to die_error(),
the capture mechanism should use 'eval { ... }', and just print response
if there was exception (like Capture::Tiny does)... or return captured
error page to be cached in the case of being in background process.


Well, any way we choose to handle it, the code should be very clear,
and handle all cases (other caching engines, perhaps also other capture
engines, non-persistent and persistent environments, redefined 'exit'
like in ModPerl::Registry case, not redefined 'exit' like I think in
FastCGI case, etc., etc.).

>>> This adds two functions:
>>>
>>> die_error_cache() - this gets back called from die_error() so
>>> that the error message generated can be cached.
>> 
>> *How* die_error_cache() gets called back from die_error()?  I don't
>> see any changes to die_error(), or actually any calling sites for
>> die_error_cache() in the patch below.
>>  
>>> cacheDisplayErr() - this is a simplified version of cacheDisplay()
>>> that does an initial check, if the error page exists - display it
>>> and exit.  If not, return.
>> 
>> Errr... isn't it removed in _preceding_ patch?  WTF???
> 
> in breaking up the series it got included in the wrong spot, and
> apparently removed and re-added correctly, should be fixed in v9

[...]
> 
> If you'd rather I can squash 17 & 18 into a single commit.

Yes, please.  Splitting those changes into 17 & 18 didn't make it more
clear (usually smaller commit == easier to review), but rather less
transparent.
 
>>> +sub die_error_cache {
>>> +	my ($output) = @_;
>>> +
>>> +	open(my $cacheFileErr, '>:utf8', "$fullhashpath.err");
>>> +	my $lockStatus = flock($cacheFileErr,LOCK_EX|LOCK_NB);
>> 
>> Why do you need to lock here?  A comment would be nice.
> 
> At any point when a write happens there's the potential for multiple
> simultaneous writes.  Locking becomes obvious, when your trying to
> prevent multiple processes from writing to the same thing at the same
> time...

Or you can use 'write to File::Temp::tempfile, rename file' trick for
atomic update to file.  I use it in early commits in my rewrite of gitweb
caching, see e.g.:

  http://repo.or.cz/w/git/jnareb-git.git/blob/refs/heads/gitweb/cache-kernel-v6:/gitweb/lib/GitwebCache/SimpleFileCache.pm#l362
 
>>> +
>>> +	if (! $lockStatus ){
>>> +		if ( $areForked ){
>> 
>> Grrrr...

Global variables, action at considerable distance.
 
>> But if it is here to stay, a comment if you please.
>> 
>>> +			exit(0);
>>> +		}else{
>>> +			return;
>>> +		}
>>> +	}
> 
> The exit(0) or return have been removed in favor of DONE_GITWEB, as
> we've already errored if we are broken here we should just die.

Note the difference between exit and Core::exit, when running gitweb
from mod_perl using ModPerl::Registry handler.
 

>>> +
>>> +	flock($cacheFileErr,LOCK_UN);
>>> +	close($cacheFileErr);
>> 
>> Closing file will unlock it.
> 
> Doesn't really hurt to be explicit though.

O.K., but please note that I have found LOCK_UN to be unreliable.
 
>>> +
>>> +	if ( $areForked ){
>>> +		exit(0);
>>> +	}else{
>>> +		return;
>> 
>> So die_error_cache would not actually work like "die" here and like
>> die_error(), isn't it?
> 
> that was ejected, it was a bug.  DONE_GITWEB is more correct, though I
> might need to add a hook to display the error message in the case that
> the process didn't fork.

By the way, why do you fork indiscriminately (remember that forking
is not without performance cost), even when background generation is
turned off, or you don't need background generation?
 
Wouldn't fallback on non-background generation if fork() fails, as in
my rewrite of gitweb caching series be a better solution?

>>> +	while( <$cacheFileErr> ){
>>> +		print $_;
>>> +	}
>> 
>> Why not 'print <$cacheFileErr>' (list context), like in insert_file()
>> subroutine?
> 
> I've had buffer problems with 'print <$cacheFileErr>' in some cases.
> This is small enough it shouldn't happen, but I've gotten into the habit
> of doing it this way.  I can change it if you like.

Perhaps

  print while <$cacheFileErr>;

(we use it in already in "print while <$fd>;" in git_blame_common())?

Or, if we use File::Copy, perhaps File::Copy::copy($cacheFileErr, \*STDOUT);
or something like that.
 
-- 
Jakub Narebski
Poland
