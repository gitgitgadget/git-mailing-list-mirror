From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: File based caching layer (from git.kernel.org)
Date: Thu, 28 Oct 2010 09:10:41 -0700 (PDT)
Message-ID: <m37hh2i9ir.fsf@localhost.localdomain>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
	<1288226574-19068-4-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 18:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBV47-0001mt-8O
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 18:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759347Ab0J1QKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 12:10:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40795 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab0J1QKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 12:10:45 -0400
Received: by bwz11 with SMTP id 11so1716947bwz.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HB9kC2CXbg2y1TmP6hTSpCcGCnjDwylwb1J6x8LLC/w=;
        b=JmnS2cKDtX84sbjqxuvMot8mrWXft/b4f9QVFuuUKOgLWtY5UEVdGc0C0XHvDGZOtb
         vwvDYGA2kJfL4S34DhIsdWLOVDU5jZgdxf0fiGEFgJOBRNUBL4tugKmwarhd/kKh4nki
         myy78J/Rgt/kIzfs8lOpknaq4znk7ylNMic30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CBkzyhjLQOMXMGDluXdyshebj4ZFvTW0AKRtOB6OUL6+67IR6tCW1hw0jSXksYoLW7
         e7VipKAl+1g+oAW60nyabW+fyMg3QIewPTCECXrmqpntXi1PmYi9YlEAvv1+DqCyAhxv
         vLVdh80y36yIySCS0i8ItdbhtCkXP3/++W+5g=
Received: by 10.204.52.7 with SMTP id f7mr813825bkg.190.1288282243881;
        Thu, 28 Oct 2010 09:10:43 -0700 (PDT)
Received: from localhost.localdomain (abvj108.neoplus.adsl.tpnet.pl [83.8.207.108])
        by mx.google.com with ESMTPS id g8sm5767bkg.23.2010.10.28.09.10.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 09:10:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9SGA64k011581;
	Thu, 28 Oct 2010 18:10:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9SG9nmR011570;
	Thu, 28 Oct 2010 18:09:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1288226574-19068-4-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160184>

I am not commenting on minor style issues, like using camelCase names
of variables and subroutines, of 'if( ... )' instead of 'if (...)'
etc. minor issues.


"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This is a relatively large patch that implements the file based
> caching layer that is quite similar to the one used  on such large
> sites as kernel.org and soon git.fedoraproject.org.  This provides
> a simple, and straight forward caching mechanism that scales
> dramatically better than Gitweb by itself.

"Quite similar" - what does it mean?  In what way it is different from
the one used on git.kernel.org?

> 
> The caching layer basically buffers the output that Gitweb would
> normally return, and saves that output to a cache file on the local
> disk.

O.K.  This means caching HTTP response (caching output of CGI script),
using "simple" file based caching engine, without any serialization.

But this doesn't tell us how the cache expiration is handled, i.e. how
do you know that cache entry is expired, and should be regenerated.


>  When the file is requested it attempts to gain a shared lock
> on the cache file and cat it out to the client.  Should an exclusive
> lock be on a file (it's being updated) the code has a choice to either
> update in the background and go ahead and show the stale page while
> update is being performed, or stall the client(s) until the page
> is generated.

In my rewrite of earlier version of your gitweb caching patch it is
responsibility of caching engine (GitwebCache::FileCacheWithLocking)
to serialize (via locking) (re)generating cache entry.  Gitweb just
passes page key, function that returns captured output to cache
instance; it passes callback for "staling" the client to cache
constructor.

It is not the "file" that is being requested: on the gitweb level it
is a page / action / view that is being requested, on the level of
caching negine it is cache entry that is requested... only at the low
level of cache driver that a file holding a cached entry is requested.

> 
> There are two forms of stalling involved here, background building
> and non-background building, both of which are discussed in the
> configuration page.
> 
> There are still a few known "issues" with respect to this:
> - Code needs to be added to be "browser" aware so
>   that clients like wget that are trying to get a
>   binary blob don't obtain a "Generating..." page

Right.  This is also missing from my rewrite.

Sidenote: why "binary blob"?  Most downloading utilities do not follow
http-meta in-HTML redirects, do they?

> 
> Caching is disabled by default with the $cache_enable variable,
> setting this to 1 will enable file based caching.  It is expected
> that this will be extended to include additional types of caching
> (like memcached) in the future and should not be exclusively
> considered a binary value.

Why not do the same as in my rewrite, namely $cache_enabled or
$caching_enabled *boolean* value (not "binary"), and $cache variable
to select caching engine (undef to use default)?

> ---
>  gitweb/cache.pm          |  365 ++++++++++++++++++++++++++++++++++++++++++++++
>  gitweb/gitweb.perl       |   99 +++++++++++--
>  gitweb/static/gitweb.css |    6 +
>  3 files changed, 458 insertions(+), 12 deletions(-)
>  create mode 100644 gitweb/cache.pm

It would be nice to have at least some minimal testing for caching
enabled gitweb.  Hmmm... I should have split update to t9500-* test
so you would be able to cherry-pick it.

Also, it would be good idea to have 'make install-gitweb' to install
'cache.pm' alongside gitweb, especially that you do not do any error
checking for "do 'cache.pm';" (see below).

> 
> diff --git a/gitweb/cache.pm b/gitweb/cache.pm
> new file mode 100644
> index 0000000..c86265c
> --- /dev/null
> +++ b/gitweb/cache.pm
> @@ -0,0 +1,365 @@
> +# gitweb - simple web interface to track changes in git repositories
> +#
> +# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
> +#
> +# This program is licensed under the GPLv2
> +
> +#
> +# Gitweb caching engine
> +#

Wouldn't it be better to use real Perl module, i.e. start with
'package' line, like in my rewrite?

> +
> +#use File::Path qw(make_path remove_tree);

Is above line really needed?

> +use File::Path qw(mkpath rmtree); # Used for compatability reasons

Because [stable] Perl earlier than 5.10.0 has pre-2.00 version of
File::Path in core, which didn't have make_path and remove_tree.

At least that is compatibility with pre-2.00 File::Path should be
mentioned in this comment, if we are to mention it at all.

BTW. do you need rmtree?

> +use Digest::MD5 qw(md5 md5_hex md5_base64);

Do you use *all* those subroutines?

> +use Fcntl ':flock';

All right.

> +use File::Copy;

Why do you need this for?

> +
> +sub cache_fetch {
> +	my ($action) = @_;
> +	my $cacheTime = 0;
> +
> +	# Deal with cache being disabled
> +	if( $cache_enable == 0 ){

Wouldn't it be better to use boolean 'if (!$caching_enabled) {' rather
than explicitely test for numeric 0?

Wouldn't it be better to have this conditional _outside_ cache_fetch?

> +		undef $backgroundCache;
> +		#$fullhashpath = \$nocachedata;
> +		#$fullhashbinpath = \$nocachedatabin;

Leftover debugging?

> +		$fullhashpath = *STDOUT;
> +		$fullhashbinpath = *STDOUT;

WTF is this for?  Defensive programming?  You shouldn't protect
yourself against bugs in your program...

> +		$actions{$action}->();
> +		return;
> +	}elsif( $cache_enable == 1 ){
> +		#obviously we are using file based caching
> +
> +		if(! -d $cachedir){
> +			print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";

Why print this warning?  Why not use 'warn' instead, so it would get
in web server logs?

Wouldn't printing this here screw up HTTP headers something fierce?
I think it is a bug; rarely encountered but still a bug.

> +			mkdir ("cache", 0665) || die "Cannot create cache dir - you will need to manually create";
> +			print "Cache directory created successfully\n";
> +		}
> +
> +		our $full_url = "$my_url?". $ENV{'QUERY_STRING'};

Why not use 'href(-replay => 1, -full => 1, -path_info => 0)'?

> +		our $urlhash = md5_hex($full_url);
> +		our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";

Why 'our' and not 'my', i.e. why use global variables, and not local
to function (lexical scoped to be more exact)?

We use 'our' in gitweb *only* because otherwise mod_perl with
ModPerl::Registry handler wouldn't work, see e.g. dde80d9 (gitweb: Fix
mod_perl support., 2008-11-06) which fixes one issue of 'my' instead
of 'our'.  But global variables are bad idea...

> +
> +		eval { mkpath( $fullhashdir, 0, 0777 ) };
> +		if ($@) {
> +			die_error(500, "Internal Server Error", "Could not create cache directory: $@");
> +		}

Good... but wouldn't it leak sensitive information?

> +		$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );
> +		$fullhashbinpath = "$fullhashpath.bin.wt";
> +		$fullhashbinpathfinal = "$fullhashpath.bin";

First, why do you treat binary and non-binary case differently,
i.e. you have $fullhashbinpathfinal (egh, thats a mouthfull ;-), but
not $fullhashpathfinal?

Second, do you really need to have distinct code for binary and
non-binary case besides what gitweb already has with 
"binmode STDOUT, ':raw';" in those places few that needs it?

If you are capturing to in-memory file (to scalar), and binmode acts
on said in-memory file, then what gets saved is raw (bytes) data.
Then you can print it raw to web browser, save it raw to cache file,
and read it raw from cache file.

> +	} # done dealing with cache enabled / disabled
> +
> +	if(! -e "$fullhashpath" ){

Why it is not within 'if ($caching_enabled)' branch of conditional?

> +		if( ! $cache_enable || ! $cacheDoFork || ! defined(my $childPid = fork()) ){
> +			cacheUpdate($action,0);
> +			cacheDisplay($action);
> +		} elsif ( $childPid == 0 ){
> +			#run the updater
> +			cacheUpdate($action,1);
> +		}else{
> +			cacheWaitForUpdate($action);
> +		}

WTF do you have forking *here*?  If cache entry is not expired, you
can just read it, without need for forking.  It is only when you need
to (re)generate cache that forking is needed.

> +	}else{
> +		#if cache is out dated, update
> +		#else displayCache();

Lefotover statement.

> +		open(cacheFile, '<', "$fullhashpath");
> +		stat(cacheFile);
> +		close(cacheFile);

You don't need to open file to stat it, you can do

  +		stat($fullhashpath);

BTW. what happens if output is binary?

> +		my $stat_time = (stat(_))[9];
> +		my $stat_size = (stat(_))[7];
> +


> +		$cacheTime = get_loadavg() * 60;
> +		if( $cacheTime > $maxCacheTime ){
> +			$cacheTime = $maxCacheTime;
> +		}
> +		if( $cacheTime < $minCacheTime ){
> +			$cacheTime = $minCacheTime;
> +		}

All right.

> +		if( $stat_time < (time - $cacheTime) || $stat_size == 0 ){

Some comment about '$stat_size == 0' test would be good idea, I think.

> +			if( ! $cacheDoFork || ! defined(my $childPid = fork()) ){
> +				cacheUpdate($action,0);
> +				cacheDisplay($action);
> +			} elsif ( $childPid == 0 ){
> +				#run the updater
> +				#print "Running updater\n";
> +				cacheUpdate($action,1);
> +			}else{
> +				#print "Waiting for update\n";
> +				cacheWaitForUpdate($action);
> +			}

The above block of code is almost verbatim copy of code higher up.
Not good.

> +		} else {
> +			cacheDisplay($action);
> +		}

Wouldn't it be better to have those two branches of conditional
reversed, so that else part is larger?  Just a thought...

> +
> +
> +	}
> +
> +	#
> +	# If all of the caching failes - lets go ahead and press on without it and fall back to 'default'
> +	# non-caching behavior.  This is the softest of the failure conditions.

This comment refers to...

> +	#
> +	#$actions{$action}->();

... commented out code?  Eh?

> +}

You don't use persistent web environment[1] for git.kernel.org, do
you?

With persistent web environments, where gitweb script runs for a long
time, and doesn't exit after end of request, you really should
"daemonize" (detach) background process which regenerates cache, at
least when said process doesn't display web page to server (serve
stale data + regenerate cache in background).  Otherwise you would get
lots of zombie processes...

[1] Gitweb currently supports FastCGI (just rename it to gitweb.fcgi,
but you would need FCGI perl module installed together with
CGI::Fast), mod_perl via ModPerl::Registry handler, and you can use
it with PSGI via gitweb.psgi wrapper like the one generated by 
'git instaweb --httpd=plackup'.

> +
> +sub cacheUpdate {
> +	my ($action,$areForked) = @_;

Strange API.

> +	my $lockingStatus;
> +	my $fileData = "";
> +
> +	if($backgroundCache){
> +		open(cacheFileBG, '>:utf8', "$fullhashpath.bg");
> +		my $lockStatBG = flock(cacheFileBG,LOCK_EX|LOCK_NB);
> +
> +		$lockStatus = $lockStatBG;
> +	}else{
> +		open(cacheFile, '>:utf8', "$fullhashpath") if ($cache_enable > 0);
> +		open(cacheFile, '>:utf8', \$fullhashpath) if ($cache_enable == 0);

Why do you save to in-memory file if caching is disabled, instead of
just printing to STDOUT?

> +		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
> +
> +		$lockStatus = $lockStat;
> +	}

Why do you need different names for lockfiles for background cache
entry enabled and for it disabled?  Why do you need $lockStat and
$lockStatBG if what you do is just assign it to $lockStatus?

Why do you use fileglobs (which are *global* variables!) and not
lexical filehandles?

> +	#print "lock status: $lockStat\n";

Leftover debugging?  

BTW. didn't you have problems debugging it from withing gitweb code,
and not as a separate caching engine which can be tested individually?

> +
> +
> +	if ($cache_enable != 0 && ! $lockStatus ){
> +		if ( $areForked ){
> +			exit(0);
> +		}else{
> +			return;
> +		}
> +	}

Strange code flow...

> +
> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		my $openstat = open(cacheFileBinWT, '>>:utf8', "$fullhashbinpath");
> +		my $lockStatBin = flock(cacheFileBinWT,LOCK_EX|LOCK_NB);
> +	}

Why '>>', and not '>'.  Why use ':utf8' on binary file?  Shouldn't you
use different file for locking than for saving cache output in?

> +
> +	# Trap all output from the action
> +	change_output();
> +
> +	$actions{$action}->();
> +
> +	# Reset the outputs as we should be fine now
> +	reset_output();

All right.

> +
> +
> +	if($backgroundCache){
> +		open(cacheFile, '>:utf8', "$fullhashpath");
> +		$lockStat = flock(cacheFile,LOCK_EX);
> +
> +		if (! $lockStat ){
> +			if ( $areForked ){
> +				exit(0);
> +			}else{
> +				return;
> +			}
> +		}
> +	}
> +
> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		my $openstat = open(cacheFileBinFINAL, '>:utf8', "$fullhashbinpathfinal");
> +		$lockStatBIN = flock(cacheFileBinFINAL,LOCK_EX);
> +
> +		if (! $lockStatBIN ){
> +			if ( $areForked ){
> +				exit(0);
> +			}else{
> +				return;
> +			}
> +		}
> +	}

Didn't I see nearly exactly the same code?  Copy'n'paste programming
isn't good idea...

> +
> +	# Actually dump the output to the proper file handler
> +	local $/ = undef;
> +	$|++;
> +	print cacheFile "$output";
> +	$|--;

Why stringify $output?  Why not 'local $| = 1' too?

> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		move("$fullhashbinpath", "$fullhashbinpathfinal") or die "Binary Cache file could not be updated: $!";

Do you really need 'File::Copy::move' instead of simple 'rename' here?
Both files are in the same directory, so there should be no problems
with it.

> +
> +		flock(cacheFileBinFINAL,LOCK_UN);
> +		close(cacheFileBinFINAL);
> +
> +		flock(cacheFileBinWT,LOCK_UN);
> +		close(cacheFileBinWT);

Closing lockfile unlocks it, there is no need for LOCK_UN; moreover,
LOCK_Un is unreliable, as I have checked myself, and as I have read
on http://perl.plover.com/yak/flock/ and also on StackOverflow
http://stackoverflow.com/questions/34920/how-do-i-lock-a-file-in-perl
  

Why do binary files needs _two_ locks for?

> +	}
> +
> +	flock(cacheFile,LOCK_UN);
> +	close(cacheFile);
> +
> +	if($backgroundCache){
> +		flock(cacheFileBG,LOCK_UN);
> +		close(cacheFileBG);
> +	}

Why do background cache generation needs _two_ (or _four_ in case of
binary files!!!) locks?

> +
> +	if ( $areForked ){
> +		exit(0);
> +	} else {
> +		return;
> +	}

Why can't a caller do that?

> +}
> +
> +

I think it would be better to describe how cacheWaitForUpdate() works.

> +sub cacheWaitForUpdate {
> +	my ($action) = @_;
> +	my $x = 0;
> +	my $max = 10;
> +	my $lockStat = 0;
> +
> +	if( $backgroundCache ){
> +		if( -e "$fullhashpath" ){
> +			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
> +			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);

Same af above: when caching is disabled, why do you capture gitweb
output for?

> +			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +			stat(cacheFile);
> +			close(cacheFile);

Here you unlocked just acquired lock!

Sidenote: using real locsk with flock() has the advantage over trick
of creating *.lock files with O_CREAT in that if process dies (and all
files it opened are closed) the lock is automatically unlocked.
Therefore you don't have problems of dead lockfiles.

> +
> +			if( $lockStat && ( (stat(_))[9] > (time - $maxCacheLife) ) ){
> +				cacheDisplay($action);
> +				return;
> +			}

Is running time() a second time intended, or just a side effect of
arrangement of code?

> +		}
> +	}
> +
> +	if(
> +		$action eq "atom"
> +		||
> +		$action eq "rss"
> +		||
> +		$action eq "opml"
> +	){

Sidenote: this is a bit ugly, and that is why in my rewrite I have
commit d20e6a4 (gitweb: Introduce %actions_info, gathering information
about actions, 2010-10-05).

Also, in my rewrite I can simply 'return' instead of 'exit()' here,
and you would get data from caching engine: no need for below code
block (which is repeated in very similar way a bit later in same
subroutine).

> +		do {
> +			sleep 2 if $x > 0;
> +			open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
> +			open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
> +			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +			close(cacheFile);

Here you unlock just acquired lock.  Is it intended?  

Is it safe against other process acquiting writer's lock (LOCK_EX)?
If it is, I probably should unlock it earlier and not have exit() do
it...

> +			$x++;
> +			$combinedLockStat = $lockStat;
> +		} while ((! $combinedLockStat) && ($x < $max));

My rewrite instead tries to acquire LOCK_SH *without* LOCK_NB, i.e. in
a blocking way... but with a timeout via $SIG{ALRM} and eval { ... }.

> +
> +		if( $x != $max ){
> +			cacheDisplay($action);
> +		}
> +		return;
> +	}
> +
> +	$| = 1;

I have autoflush turned on later.  But by all thats's koly, please
localize $| before changing its value, i.e.

  +	local $| = 1;


> +
> +	print $::cgi->header(

Why $::cgi->header()?

In my rewrite git_generating_data_html() subroutine is defined in
gitweb.perl, and passed as callback to cache constructor instead.

> +				-type=>'text/html',
> +				-charset => 'utf-8',
> +				-status=> 200,
> +				-expires => 'now',

That I have.

> +				# HTTP/1.0
> +				-Pragma => 'no-cache',
> +				# HTTP/1.1
> +				-Cache_Control => join(
> +							', ',
> +							qw(
> +								private
> +								no-cache
> +								no-store
> +								must-revalidate
> +								max-age=0
> +								pre-check=0
> +								post-check=0
> +							)
> +						)

This I don't, and I probably should have.  Good idea.

> +				);
> +
> +	print <<EOF;
> +<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
> +<!-- git web w/caching interface version $version, (C) 2006-2010, John 'Warthog9' Hawley <warthog9\@kernel.org> -->
> +<!-- git core binaries version $git_version -->
> +<head>
> +<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
> +<meta name="generator" content="gitweb/$version git/$git_version"/>
> +<meta name="robots" content="index, nofollow"/>

You meant here "noindex, nofollow", isn't it?

> +<meta http-equiv="refresh" content="0"/>
> +<title>$title</title>
> +</head>
> +<body>
> +EOF
> +
> +	print "Generating..";
> +	do {
> +		print ".";
> +		sleep 2 if $x > 0;
> +		open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
> +		open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
> +		$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +		close(cacheFile);
> +		$x++;
> +		$combinedLockStat = $lockStat;
> +	} while ((! $combinedLockStat) && ($x < $max));

A bit of code repetition here.

> +	print <<EOF;
> +</body>
> +</html>
> +EOF
> +	return;
> +}
> +
> +sub cacheDisplay {
> +	local $/ = undef;
> +	$|++;
> +
> +	my ($action) = @_;
> +	open(cacheFile, '<:utf8', "$fullhashpath") if ($cache_enable > 0);
> +	open(cacheFile, '<:utf8', \$fullhashpath) if ($cache_enable == 0);
> +	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
> +
> +	if ($cache_enable != 0 && ! $lockStat ){
> +		close(cacheFile);
> +		cacheWaitForUpdate($action);
> +	}
> +
> +	if(
> +		(
> +			$action eq "snapshot"
> +			||
> +			$action eq "blob_plain"
> +		)
> +		&&
> +		$cache_enable > 0
> +	){
> +		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
> +		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
> +		if ($cache_enable != 0 && ! $lockStatBIN ){
> +			system ("echo 'cacheDisplay - bailing due to binary lock failure' >> /tmp/gitweb.log");

Errrrr... what? Using system("echo ...") instead of just writing to a
file?  Or better, using 'warn' and relying on CGI::Carp module to
deliver warning to web server logs?

> +			close(cacheFile);

Why not close 'cacheFile' earlier, or say, not opening it in first
place if it is not necessary... oh, sorry, I see that you are using
the same file for cache file for normal case and for lockfile.

> +			close(cacheFileBin);
> +			cacheWaitForUpdate($action);
> +		}
> +

> +		my $binfilesize = -s "$fullhashbinpathfinal";
> +		print "Content-Length: $binfilesize";

Good idea, bad solution.  "Content-Length: " HTTP header can be only _after_ 
'HTTP/1.1 200 OK' header, isn't it?

> +	}
> +	while( <cacheFile> ){
> +		print $_;
> +	}

Why not 'print <cacheFile>;'?  besides with $/ undefined you operate
in slurp / spew mode, and Perl now considers all file to be a single
line.

> +	if(
> +		$action eq "snapshot"
> +		||
> +		$action eq "blob_plain"
> +	){
> +		binmode STDOUT, ':raw';
> +		print <cacheFileBin>;
> +		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +		close(cacheFileBin);
> +	}
> +	close(cacheFile);
> +	$|--;

Wouldn't it be better to use 'local $| = 1' instead of this 
'$|++ / $|--'?

> +}
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 757ef46..eb53075 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -31,7 +31,7 @@ BEGIN {
>  our $version = "++GIT_VERSION++";
>  
>  # Output buffer variable
> -$output = "";
> +our $output = "";

This belongs to and should be squashed with earlier patch

>  
>  our ($my_url, $my_uri, $base_url, $path_info, $home_link);
>  sub evaluate_uri {
> @@ -244,6 +244,57 @@ our $git_versions_must_match = 1;
>  # Leave it undefined (or set to 'undef') to turn off load checking.
>  our $maxload = 300;
>  
> +# This enables/disables the caching layer in gitweb.  This currently only supports the
> +# 'dumb' file based caching layer, primarily used on git.kernel.org.  this is reasonably
> +# effective but it has the downside of requiring a huge amount of disk space if there
> +# are a number of repositories involved.  It is not uncommon for git.kernel.org to have
> +# on the order of 80G - 120G accumulate over the course of a few months.  It is recommended
> +# that the cache directory be periodically completely deleted, and this is safe to perform.
> +# Suggested mechanism
> +# mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
> +# Value is binary. 0 = disabled (default), 1 = enabled.
> +#
> +# Values of caching:
> +# 	1 = 'dumb' file based caching used on git.kernel.org
> +our $cache_enable = 0;

As I wrote earlier, having boolean $caching_enabled and $cache
specifying caching engine to use (undef for default) allows to
separate act of enabling cache from the cact of selecting (and
configuring) cache.  Isn't it?

> +
> +# Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
> +# if we calculate the cache to be under this number of seconds we set the cache timeout
> +# to this minimum.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +our $minCacheTime = 20;
> +
> +# Used to set the maximum cache timeout for the dynamic caching algorithm.  Basically
> +# if we calculate the cache to exceed this number of seconds we set the cache timeout
> +# to this maximum.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +our $maxCacheTime = 1200;
> +
> +# If you need to change the location of the caching directory, override this
> +# otherwise this will probably do fine for you
> +our $cachedir = 'cache';

If it is relative path, it is relative to location of gitweb.cgi
script, isn't it?

> +
> +# If this is set (to 1) cache will do it's best to always display something instead
> +# of making someone wait for the cache to update.  This will launch the cacheUpdate
> +# into the background and it will lock a <file>.bg file and will only lock the
> +# actual cache file when it needs to write into it.  In theory this will make
> +# gitweb seem more responsive at the price of possibly stale data.
> +our $backgroundCache = 1;

Boolean.

> +
> +# Used to set the maximum cache file life.  If a cache files last modify time exceeds
> +# this value, it will assume that the data is just too old, and HAS to be regenerated
> +# instead of trying to display the existing cache data.
> +# Value is in seconds.  1 = 1 seconds, 60 = 1 minute, 600 = 10 minutes, 3600 = 1 hour
> +# 18000 = 5 hours
> +our $maxCacheLife = 18000;
> +
> +# Used to enable or disable background forking of the gitweb caching.  Mainly here for debugging purposes
> +our $cacheDoFork = 1;
> +
> +our $fullhashpath = *STDOUT;
> +our $fullhashbinpath = *STDOUT;
> +our $fullhashbinpathfinal = *STDOUT;
> +

In my rewrite all cache parameters are in %cache_options hash, and
passed as parameters to cache constructor, instead of littering global
variables namespace...

>  # configuration for 'highlight' (http://www.andre-simon.de/)
>  # match by basename
>  our %highlight_basename = (
> @@ -500,6 +551,11 @@ our %feature = (
>  		'default' => [0]},
>  );
>  
> +#
> +# Includes
> +#
> +do 'cache.pm';

Unsafe!  If you have any error in 'cache.pm', you could get a very
strange error reports.

Also what if 'cache.pm' cannot be found because somebody forgot to
copy it along with gitweb.cgi?


See how we do it for $GITWEB_CONFIG:

        if (-e $GITWEB_CONFIG) {
                do $GITWEB_CONFIG;
                die $@ if $@;
        }

See also documentation for 'do' (perldoc -f do):

       If "do" cannot read the file, it returns undef and sets $! to the error.
       If "do" can read the file but cannot compile it, it returns undef and sets
       an error message in $@.   If the file is successfully compiled, "do"
       returns the value of the last expression evaluated.

       Note that inclusion of library modules is better done with the "use" and
       "require" operators, which also do automatic error checking and raise an
       exception if there's a problem.

       You might like to use "do" to read in a program configuration file.  
       Manual error checking can be done this way:

       # read in config files: system first, then user
       for $file ("/share/prog/defaults.rc",
                  "$ENV{HOME}/.someprogrc")
       {
             unless ($return = do $file) {
                 warn "couldn't parse $file: $@" if $@;
                 warn "couldn't do $file: $!"    unless defined $return;
                 warn "couldn't run $file"       unless $return;
             }
       }

In my rewrite I use simply "require", and I check it's output.

> +
>  sub gitweb_get_feature {
>  	my ($name) = @_;
>  	return unless exists $feature{$name};
> @@ -1089,7 +1145,8 @@ sub dispatch {
>  	    !$project) {
>  		die_error(400, "Project needed");
>  	}
> -	$actions{$action}->();
> +	#$actions{$action}->();
> +	cache_fetch($action);

Wouldn't a better solution be

  -	$actions{$action}->();
  +	if ($caching_enabled) {
  +		cache_fetch($action);
  +	} else {
  +		$actions{$action}->();
  +	}

>  }
>  
>  sub reset_timer {
> @@ -1159,6 +1216,7 @@ sub change_output {
>  
>  	# Trap the 'proper' STDOUT to STDOUT_REAL for things like error messages and such
>  	open(STDOUT_REAL,">&STDOUT") or die "Unable to capture STDOUT $!\n";
> +	print STDOUT_REAL "";

Why it is for?

>  
>  	# Close STDOUT, so that it isn't being used anymore.
>  	close STDOUT;
> @@ -1185,10 +1243,7 @@ sub run {
>  		$pre_dispatch_hook->()
>  			if $pre_dispatch_hook;
>  
> -		change_output();
>  		run_request();
> -		reset_output();
> -		print $output;
>  
>  		$post_dispatch_hook->()
>  			if $post_dispatch_hook;

Hmmm...

> @@ -3465,7 +3520,9 @@ sub git_header_html {
>  	# support xhtml+xml but choking when it gets what it asked for.
>  	if (defined $cgi->http('HTTP_ACCEPT') &&
>  	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
> -	    $cgi->Accept('application/xhtml+xml') != 0) {
> +	    $cgi->Accept('application/xhtml+xml') != 0
> +	    &&
> +	    $cache_enable == 0) {
>  		$content_type = 'application/xhtml+xml';
>  	} else {
>  		$content_type = 'text/html';

I also have something similar in my rewrite.

> @@ -3610,6 +3667,7 @@ sub git_footer_html {
>  	my $feed_class = 'rss_logo';
>  
>  	print "<div class=\"page_footer\">\n";
> +	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
>  	if (defined $project) {
>  		my $descr = git_get_project_description($project);
>  		if (defined $descr) {

In my rewrite it replaces "time to generate page" info, though
probably should be always there.

> @@ -3698,6 +3756,11 @@ sub die_error {
>  		500 => '500 Internal Server Error',
>  		503 => '503 Service Unavailable',
>  	);
> +	# The output handlers for die_error need to be reset to STDOUT
> +	# so that half the message isn't being output to random and
> +	# half to STDOUT as expected.  This is mainly for the benefit
> +	# of using git_header_html() and git_footer_html() since
> +	#
>  	# Reset the output so that we are actually going to STDOUT as opposed
>  	# to buffering the output.
>  	reset_output();
> @@ -5610,9 +5673,15 @@ sub git_blob_plain {
>  			($sandbox ? 'attachment' : 'inline')
>  			. '; filename="' . $save_as . '"');
>  	local $/ = undef;
> -	binmode STDOUT, ':raw';
> -	print <$fd>;
> -	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	if( $cache_enable != 0){
> +		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
> +	}else{
> +		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
> +	}
> +	binmode BINOUT, ':raw';
> +	print BINOUT <$fd>;
> +	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	close BINOUT;

Why it is here?  Why caching engine connot take care of that?

>  	close $fd;
>  }
>  
> @@ -5897,9 +5966,15 @@ sub git_snapshot {
>  
>  	open my $fd, "-|", $cmd
>  		or die_error(500, "Execute git-archive failed");
> -	binmode STDOUT, ':raw';
> -	print <$fd>;
> -	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	if( $cache_enable != 0){
> +		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
> +	}else{
> +		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
> +	}
> +	binmode BINOUT, ':raw';
> +	print BINOUT <$fd>;
> +	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	close BINOUT;
>  	close $fd;
>  }

Same as above.  I don't think that having to modify gitweb code beside
enabling caching somewhere at the top shows a good design...

>  
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 4132aab..972d32e 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -67,6 +67,12 @@ div.page_path {
>  	border-width: 0px 0px 1px;
>  }
>  
> +div.cachetime {
> +	float: left;
> +	margin-right: 10px;
> +	color: #555555;
> +}

O.K.

> +
>  div.page_footer {
>  	height: 17px;
>  	padding: 4px 8px;

P.S. Where is my review ;-)???

-- 
Jakub Narebski
Poland
ShadeHawk on #git
