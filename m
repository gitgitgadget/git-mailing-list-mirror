From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Tue, 26 Jan 2010 02:49:35 +0100
Message-ID: <201001260249.36678.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <20100125135653.GN4159@machine.or.cz> <4B5DFFE5.6060908@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 02:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZaYv-00016e-My
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 02:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0AZBtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 20:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279Ab0AZBto
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 20:49:44 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:54277 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab0AZBtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 20:49:43 -0500
Received: by fxm7 with SMTP id 7so772438fxm.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 17:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bUBgnH8WZGWwTqEhD3tjWe83IPnyRwpwfiqujnvlbrU=;
        b=IWW2s4VjGYOi6jkJOtooPRcGXD0mR4uhjPlp68YnPuRZyO2hdyfudvL5WsM5ZMWHfj
         791rn5nMlpSNLd8N4rI0Ou+phlYcSh48FAf6VAu5ipzvR5cxalubwOLAh6e2DGB4a9cs
         zw0t5Ifh/j3Ch3vLlCMBYoT+V3rQIfSYOvpNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cheeJDHxVF1ogrvWegA0nTISYKi0Xm3fgqfHiZWecieHv9/14o15RP0wrHkScHxgAs
         MEzPf/sj7HoOnETIDJjheKO460YrNvUHpcXd1/alDjoI0Rm6driNZG9dXS9LPzkPWxSu
         cSEJO+bzPSTSAHRmUn0BlM0QBNkR3Ukkft4q0=
Received: by 10.223.18.137 with SMTP id w9mr7698869faa.61.1264470581997;
        Mon, 25 Jan 2010 17:49:41 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id p9sm7339954fkb.14.2010.01.25.17.49.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 17:49:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B5DFFE5.6060908@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138021>

On Mon, 25 Jan 2010, J.H. wrote:
> On 01/25/2010 05:56 AM, Petr Baudis wrote:
>> On Mon, Jan 25, 2010 at 02:48:26PM +0100, Jakub Narebski wrote:

>>> Now those patches (mine and J.H. both) make gitweb use locking
>>> (it is IIRC configurable in J.H. patch) to make only one process
>>> generate the page if it is missing from cache, or is stale.  Now
>>> if it is missing, we have to wait until it is generated in full
>>> before being able to show it to client.  While it is possible to
>>> "tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
>>> CGI::Cache) writing it simultaneously to browser and to cache for 
>>> the process that is generating data, it is as far as I understand
>>> it impossible for processes which are waiting for data.  Therefore
>>> the need for "Generating..." page, so the user does not think that
>>> web server hung or something, and is not generating output.
>> 
>> Ah, ok, so the message is there to cover up for a technical problem. ;-)
>> I didn't quite realize. Then, it would be great to tweak the mechanisms
>> so that the user does not really have to wait.
> 
> No, that is an incorrect assumption on how the 'Generating...' page
> works, and your missing a bit of the point.
> 
> (1) The message itself 'Generating...' is a cue to the user that
> something is happening and that the browser is not actually hanging.
> Web users are at the point where if things are not instantaneous and
> show immediately they will either browse away completely or hit the
> refresh button incessantly until content does appear.  While the page is
> usually only seen for about a second, and I'll admit it can be annoying,
> it's nothing more than a 'sit tight a second'.  For things like the
> front page it can take upwards of 7 seconds to generate for a single
> user, a lot to ask for a no response scenario.

Pasky is asking later whether instead of separate "Generating..." page
(be it server side using trick with http-equiv refresh taking place when
page/connection is closed, or JavaScript Ajax-y one) couldn't gitweb
use streaming and have early parts of generated page (in particular the
page header and navigation bar) serve as activity indicator.  I think
it is possible, if a bit more complicated, and such feature can be 
introduced in a separate commit.

As to 'sit tight for a second': the code can be modified to print/show 
"Generating..." page only if we are waiting more than second (or more
than half of second with utime from Time::HiRes) for the data.  Pasky,
would such change address some of your concerns about "Generating..."
page as activity indicator?

> 
> (2) It prevents the stampeding herd problem, which was very vehemently
> discussed 4 years ago by HPA and myself and roughly boils down to this:
> 
> When a single user comes into the site, in particular the front page, it
> kicks off a process that will start to generate at it, causing a huge
> amount of git requests into individual repositories and a lot of disk
> i/o.  A second user will then come in and the same requests will start
> to be done from the beginning again, and so on until you basically kill
> the machine because the disk i/o goes up enough that it can't ever
> service the requests fast enough.

As you can see from the way my proof of concept (of splitting) caching
series is split, I think that those two features are separate.  Using
locking to have one writer, and protect against cache miss stampede 
problem is one issue, and having "Generating..." page is another issue.
They are not orthogonal as they are now, as "Generating..." page depends
on locking to check if page got generated, but it could simply check
whether the cache file is present already.

> 
> This does 2 things in the end:
> 
> 1) means there's only 1 copy of the page ever being generated, thus
> meaning there isn't extraneous and dangerous disk i/o going on on the system
> 
> 2) prevents a user from reporting to the website that it's broken by
> giving them a visual cue that things aren't broken.

1) is about locking ('expires_variance' can help there, too), 2) is about
"Generating..." but could be done with streaming: "tee"/"tail" solution.

>> So, I wonder about two things:
>> 
>> (i) How often does it happen that two requests for the same page are
>> received? Has anyone measured it? Or is at least able to make
>> a minimally educated guess? IOW, isn't this premature optimization?
> 
> For most pages, not many but it happens more often than you think.  The
> data I have is much too old to be useful now but the front page could,
> at times, have up to 30 people waiting for it without caching.  This is
> a very important patch believe it or not.  For a site the size of
> kernel.org it cannot exist without this.
> 
> But here's a quick stat, in 36 hours git.kernel.org has had
> 156099 accesses world wide or about 1.2 accesses a second.
> 
> android.git.kernel.org, in the same time period has had 115818 accesses.
> 
> If the first request takes 7 seconds to generate, by the time it's done
> there are now 3 additional requests running.  If it again takes 7
> seconds to generate there are now another 3 requests running, etc.  Very
> quickly you've got so much i/o running the box more or less is useless.

On the other hand do cache for front page (projects list) ever expire
so that there are no stale data to serve?  So the issue with growing I/O
is I guess only with priming the cache.  

BTW. I wonder how well the 'expires_variance' solution used in CHI would
protect against cache miss stampedes; that probably depends on the ratio
of variance to time it takes gitweb to generate the page.

>> (ii) Can't the locked gitwebs do the equivalent of tail -f?
> 
> Not really going to help much, most of the gitweb operations won't
> output much of anything beyond the header until it's collected all of
> the data it needs anyway and then there will be a flurry of output.  

Well, it might be enough to have headers as activity indicator... but
on the other hand users can think that server is broken if they see no
further data, as opposed to the "Generating..." page.

> It also means that this 'Generating...' page will only work for caching
> schemes that tail can read out of, which I'm not sure it would work all
> that well with things like memcached or a non-custom caching layer where
> we don't necessarily have direct access to the file being written to.

I don't think that caching interfaces such as CHI or Cache::Cache, or
individual caching engines such as Cache::Memcached or Cache::FastMmap
offer streaming access.  OTOH we can read from the side as the data
is generated ("tee" to a temporary file, or something), but it is even
more complication.

> 
> At least the way I had it (and I'll admit I haven't read through Jakub's
> re-working of my patches so I don't know if it's still there) is that
> with background caching you only get the 'Generating...' page if it's
> new or the content is grossly out of data.  If it's a popular page and
> it's not grossly out of date it shows you the 'stale' data while it
> generates the new content in the background anyway, only locking you out
> when the new file is being written.  Or at least that's how I had it.

It is there, i.e. gitweb would serve stale data if it can be found,
but it lacks 'too stale to serve as stale data' timeout/expire time.
I skipped this feature to get split series out of door faster.

-- 
Jakub Narebski
Poland
