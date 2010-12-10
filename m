From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 00/18] Gitweb caching v8
Date: Thu, 09 Dec 2010 16:43:02 -0800
Message-ID: <4D017796.4030506@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3bp4u34vj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:41:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQr36-0006bp-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab0LJAlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:41:19 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:36355 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0LJAlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:41:19 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA0fFUw010133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 16:41:16 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3bp4u34vj.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 16:41:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163370>

On 12/09/2010 03:26 PM, Jakub Narebski wrote:
> John, could you please in the future Cc me?  I am interested in gitweb
> output caching development.  Thanks in advance.

Apologies, apparently screwed up on my git send-email line.  I'll get
that right one of these eons.

> Could you please rebase it on top of v7.2 version?  The v7.2 patch
> series contained a few bugs that needs to be corrected.

I assume you mean 7.4, as opposed to 7.2... otherwise already done!

> I guess that in the final submission (i.e. the one that is to be
> merged in into git.git repository) those changes would be squashed in,
> isn't it?

I have no objections to squashing the reversions into a single patch,
just figured it was easier to break them out for the time being.

>> This still differs, by two patches, from whats in production on kernel.org.
>> It's missing the index page git:// link, and kernel.org and kernel.org also
> 
>>
>> has the forced version matching.  As a note I'll probably let this stew
>> another day or so on kernel.org and then I'll push it into the Fedora update
>> stream, as there's a couple of things in this patch series that would be 
>> good for them to have.
> 
> There was some discussion about git:// link in the past; nevertheless
> this issue is independent on gitweb caching and can (and should) be
> sent as a aeparate patch.
> 
> IIRC we agreed that because of backward compatibility forced versions
> match is quite useless (in general)...

The former wasn't submitted as that is a separate issue, the later was
not agreed on really but mostly me retracting the patches as they
weren't making any headway.

I mention the patches at all as clarification of what's actually running
on kernel.org, and eventually what will be in the gitweb-caching
packages that are part of Fedora and EPEL.

>> There is one additional script I've written that the Fedora folks are using,
>> and that might be useful to include, which is an 'offline' cache file generator.
>> It basically wraps gitweb.cgi and at the end moves the cache file into the right
>> place.  The Fedora folks were finding it took hours to generate their front
>> page, and that doing a background generation almost never completed (due to 
>> process death).  This was a simple way to handle that.  If people would like
>> I can add it in as an additional patch.
> 
> Are you detaching the background process?

No, in fact I completely turn off forking (using the $cacheDoFork variable.)

> It would be nice to have it as separate patch.

I can add it easily enough.

>> v8:
>> 	- Reverting several changes from Jakub's change set that make no sense
>>                 - is_cacheable changed to always return true - nothing special about
>>                   blame or blame_incremental as far as the caching engine is concerned
> 
> 'blame_incremental' is just another version of 'blame' view.  I have
> disabled it when caching is enabled in my rewrite (you instead disabled
> caching for 'blame_incremental' in your v7 and mine v7.x) because I
> couldn't get it to work together with caching.  Did you check that it
> works?

blame works fine, blame_incremental generates but doesn't..... ohhhh
someone added ajaxy kinda stuff and doesn't mention it anywhere.

Exciting.

blame_data needs to not get a 'generating...' page in all likelihood,
generating a blame_incremental page, letting it load and then refreshing
the whole thing gets me what I'm expecting.

Is enough to mask.

Guess I'm looking at a v9 now.

> Besides, withou "tee"-ing, i.e. printing output as it is captured,
> cached 'blame_data' means that 'blame_incremental' is not incremental,
> and therefore it vanishes its advantage over 'blame'.

There are only 2 ways to get to a blame_incremental page

1) By going to a blame page and clicking on the incremental link in the nav

2) By enabling it by default so when you click 'blame' it goes to
incremental first.

> In the case data is in cache, then 'blame_inremental' doesn't have
> advantage over 'blame' either.

Agreed, though it's easy enough to support in the caching engine,
basically don't return 'Generating...' and wait for that data to cache.
 Not really an advantage except that your not waiting for the whole
generation to get a page back at all.

>>                 - Reverted change to reset_output as
>>                         open STDOUT, ">&", \*STDOUT_REAL;
>>                   causes assertion failures:
>>                   Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.
>>                   if we encounter an error *BEFORE* we've ever changed the output.
> 
> Which Perl version are you using?  Because I think you found error in Perl.
> Well, at least I have not happen on this bug.

This is perl, v5.10.0 built for x86_64-linux-thread-multi

> I have nothing againts using
> 
>   open STDOUT, ">&STDOUT_REAL";
> 
> though I really prefer that you used lexical filehandles, instead of
> "globs" which are global variables.
> 
> The following works:
> 
>   open STDOUT, '>&', fileno($fh);
> 
> Note that fileno(Symbol::qualify_to_ref($fh)) might be needed...

I see 0 advantage to shifting around STDOUT and STDERR to a lexical
filehandle vs. a glob in this case.  STDOUT_REAL retains all the
properties of STDOUT should it be needed elsewhere, including what it
was going and what it was doing.

I have no objection to shifting the file handles I'm using to lexical
variables, if nothing else the argument about them closing when falling
out of scope is worth it, but for STDOUT, STDERR, etc I don't think
switching to lexicals makes a lot of sense

>>         - Cleanups there were indirectly mentioned by Jakub
>>                 - Elimination of anything even remotely looking like duplicate code
>>                         - Creation of isBinaryAction() and isFeedAction()
> 
> Could you please do not use mixedCase names?

I'm fine with renaming those if you wish.

> First, that is what %actions_info from
> 
>   [PATCH 16/24] gitweb: Introduce %actions_info, gathering information about actions
>   http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163038
>   http://repo.or.cz/w/git/jnareb-git.git/commitdiff/305a10339b33d56b4a50708d71e8f42453c8cb1f
> 
> I have invented for.

I have not based any of my caching engine, right now, on anything you've
done for your rewrite.

> Second, why 'isBinaryAction()'?  there isn't something inherently
> different between binary (':raw') and text (':utf8') output, as I have
> repeatedly said before.

It's a binary action in that you are shoving something down the pipe
with the intention of sending the bits completely raw.  You read the
data raw, and write the data raw.  There is no interpretation of the
data as being anything but straight raw.

Right now, in gitweb already, there are two places that treat output
completely differently:

	- snapshot
	- blob_plain

The only reason isBinaryAction() (or any other function name or process
you want to grant it) exists is so that I can figure out if it's one of
those actions so I can deal with the cache and output handling
differently for each.

Yes, I could flip the entire caching engine over to following the same
mantra for everything and thus there is no need to care, but gitweb
itself isn't really setup to handle that separation cleanly right now,
and I'm trying to make as few bigger changes right now as is.


>>         - Added better error handling
>>                 - Creation of .err file in the cache directory
>>                 - Trap STDERR output into $output_err as this was spewing data prior
>>                   to any header information being sent
> 
> Why it is needed?  We capture output of "die" via CGI::Util::set_message,
> and "warn" output is captured to web server logs... unless you explicitely
> use "print STDERR <sth>" -- don't do that instead.

I have seen, in several instances, a case where git itself will generate
an error, it shoves it to STDERR which makes it to the client before
anything else, thus causing 500 level errors.

Added this so that STDERR got trapped and those messages didn't make it out.

>>         - Added hidden field in footer for url & hash of url, which is extremely useful
>>           for debugging
> 
> Nice idea, I'll see it.  Can it be disabled (information leakage)?

There's not really any information leakage per-se, unless you call
md5suming the url information leakage.

- John 'Warthog9' Hawley
