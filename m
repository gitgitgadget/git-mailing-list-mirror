From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 21:58:28 +0100
Message-ID: <201001252158.29516.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <201001251448.27513.jnareb@gmail.com> <20100125135653.GN4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZW1L-0003sa-Pi
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0AYU6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852Ab0AYU6j
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:58:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:11896 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab0AYU6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 15:58:38 -0500
Received: by fg-out-1718.google.com with SMTP id l26so1237314fgb.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/wbJ694v79boMX4jFkE1aX39AVG4cdXhy02GywcRr8o=;
        b=Jkt/T8ArS5lXHFSG03d10IF0RE20dXkZDyenls8FA0qGCoRZy2XmC03xwkrKv0sJL9
         Hg6Mbds6jh4ppnyRuleTuRhvvuAh4I/d/9exAu5zjOn3I9guN8PrGxeZzmljPiViOAHS
         hHdgYW2gFAWoUwOdLPzNYdWuqifHkELHJ6upo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dfk1T6A5ihs4utSMfqJ5cpO3VJej8xs8WblQ46knbnG8oQdgvDl1MR7ZRGLpD/kw6Q
         BCwT9/HmZZ5mSHcpEiebbhGkQmspAzI23KTe+fO87K2cCeZl76IUYJYp+krKXXtjLkVV
         rkAFgatstN8mibZlr3RixbKSDajAs1OakoI0s=
Received: by 10.103.84.19 with SMTP id m19mr3723406mul.66.1264453116851;
        Mon, 25 Jan 2010 12:58:36 -0800 (PST)
Received: from ?192.168.1.13? (abvr10.neoplus.adsl.tpnet.pl [83.8.215.10])
        by mx.google.com with ESMTPS id j10sm448007mue.30.2010.01.25.12.58.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 12:58:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100125135653.GN4159@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137993>

On Mon, Jan 25, 2010 at 14:56 +0100, Petr Baudis wrote:
> On Mon, Jan 25, 2010 at 02:48:26PM +0100, Jakub Narebski wrote:

> > Now those patches (mine and J.H. both) make gitweb use locking
> > (it is IIRC configurable in J.H. patch) to make only one process
> > generate the page if it is missing from cache, or is stale.  Now
> > if it is missing, we have to wait until it is generated in full
> > before being able to show it to client.  While it is possible to
> > "tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
> > CGI::Cache) writing it simultaneously to browser and to cache for 
> > the process that is generating data, it is as far as I understand
> > it impossible for processes which are waiting for data.  Therefore
> > the need for "Generating..." page, so the user does not think that
> > web server hung or something, and is not generating output.
> 
> Ah, ok, so the message is there to cover up for a technical problem. ;-)
> I didn't quite realize. Then, it would be great to tweak the mechanisms
> so that the user does not really have to wait.

Well, the mechanism would certainly be configurable in final version
(current split version is more of proof of concept of splitting).

> 
> So, I wonder about two things:
> 
> (i) How often does it happen that two requests for the same page are
> received? Has anyone measured it? Or is at least able to make
> a minimally educated guess? IOW, isn't this premature optimization?

To be more exact the question is how often second request for the same
page appears when earlier request didn't finished processing.  It is
the matter of both frequency of given requests, and time it takes to
generate request (which grows with growing load on server).

As to measurements: Pasky, do you have access logs, or their analysis
a la AWStats, Webalizer and the like, for repo.or.cz?  Warthog9, do
you have access logs or analysis for git.kernel.org?  Can you get similar
from fedorahosted?
 
> (ii) Can't the locked gitwebs do the equivalent of tail -f?

Well, it could, in principle, but it would need some changes.  

First, instead of using temporary file to create cache entry atomically
(write to temporary file, then rename) the process generating data would
have to write to file other processes can read from.  It could be e.g.
lockfile.

Second, there would be needed extended cache API so that generated data
is streamed to cache file, ->set($key, $data) ==> ->set($key, $fh) or
->set_io($key, $fh).  This would mean some complications, but what might
be more important is that this trick would not work as far as I can see
with other caching backends / caching engines that the one from 
gitweb/cache.pm (like memcached or mmap based ones).

Then the code could look like the following (in pseudocode):

  try to acquire writers lock
  if (acquired writers lock) {
  	generate and "tee" response
  	create cache entry
  } else {
  	# <<<<<<
  	while (not acquired writers lock &&
  	       sysread something) {
  		print <data>;
  	}
  	# >>>>>>
  	retrieve and print (rest) of data
  }

where parts between <<<<<< and >>>>>> are new.

But there is another complication: gitweb needs to be able to deal with
the situation where process generating data got interrupted before 
creating full output, or process generating data ran die_error which
does not generate any cache entry (e.g. if the URL we are trying to
access returns 404 not found - the check for existence of object can
take a while if the system is busy, I think).  

Now in current implementation either cache entry is written in full, or it
is not written at all.  It would be, I think, fairly easy to check with the
current code whether cache entry got generated when we acquired readers
lock (when the process get terminated, the lock gets released, which
is advantage over using atomic creating file with O_EXCL for locking),
and if we didn't repeat the whole process.  With the "tee"/"tail" 
solution if the process generating data got interrupted before end,
we can detect such situation, but currently I have no idea what should
be done in such situation.  We can as easily as for the current solution
(which needs "Generating..." page for activity indicator) to detect
die_error situation, and with some care i.e. with not writing to cache
file directly we can ensure that cache entries contain full, correctly
generated data.

> 
> P.S.: Again the disclaimer - if this is "too hard", it's better to
> accept patches like they are, then improve this later. But perhaps
> a better solution would be not to clutter the code by optimizing this
> case at all if it's not clear it really matters in the real world.

See above.


P.S. I have noticed that with current implementation (well, I am not sure
if it is true also for J.H. implementation) there is problem if there is
more than one process trying to request URL which result in die_error being
called.  The design decision, present in original patch, was to not cache
"die_error" / non-"200 OK" pages; it seems sane, but I don't know if it
was a correct decision.  The solution for interrupted generating process,
described above, works also for die_error pages, although it makes 
die_error pages slower for such (hopefully rare) situation of simultaneous
errorneous request.

P.P.S. Both Pasky's approach to caching projects_list page, and Lea Wiemann
work on "gitweb caching" project for Google Summer of Code 2008 approached
caching in different way: by caching (parsed) data, not by caching output.
Note however that for some actions like 'snapshot' we would probably want
to have response/output caching anyway.  Also for output caching we can
use X-Sendfile (or like) extension.

-- 
Jakub Narebski
Poland
