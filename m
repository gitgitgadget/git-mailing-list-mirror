From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Sun, 31 Jan 2010 12:58:41 +0100
Message-ID: <201001311258.43202.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com> <4B5DFFE5.6060908@eaglescrag.net> <20100128173950.GH9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jan 31 12:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbYSb-0002U7-Oi
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 12:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab0AaL6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 06:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618Ab0AaL6w
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 06:58:52 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33169 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab0AaL6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 06:58:51 -0500
Received: by bwz27 with SMTP id 27so2398627bwz.21
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sJNTSvKR12EScesgdOIo/nXIiIiqq3YJDloTvYGT1PQ=;
        b=GZZx0VJwEgmSOeyMoqMqjr3ODIGEAPehAnJsqtkok7lcHtVA2d2ZpZx01SghKw+2y7
         BA8P1U449JUuaoiy8aeZQVnZEtdeIF8feU80QwrMqixXMfOibeVgZ+htYgPFyd8km74o
         mkPPqahtQBi0SYv8z85TDyAk63v8HtRKhJpdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wKGjJC2/VnjC3ihB1cJVQ9sgUrhN6lc4aA70rz+r6tYLveY9C2Lv2v3RJ8xhCdgm5k
         QcLp7pWO2u/yyRAHIdLUdo1VoX2w3MHF0gKl18usKa1U4QjD8zitF9a9h3u+5e0fHwsO
         r4apTnOtrZ42cahuR0UHXBJVeBcd5ousj54fc=
Received: by 10.204.6.72 with SMTP id 8mr1715754bky.28.1264939129323;
        Sun, 31 Jan 2010 03:58:49 -0800 (PST)
Received: from ?192.168.1.13? (abvf106.neoplus.adsl.tpnet.pl [83.8.203.106])
        by mx.google.com with ESMTPS id 16sm1654790bwz.7.2010.01.31.03.58.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 03:58:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100128173950.GH9553@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138539>

On Thu, Jan 28, 2010, Petr Baudis wrote:
> On Mon, Jan 25, 2010 at 12:32:37PM -0800, J.H. wrote:
> > This does 2 things in the end:
> > 
> > 1) means there's only 1 copy of the page ever being generated, thus
> > meaning there isn't extraneous and dangerous disk i/o going on on the system
> 
> But this has nothing to do with what you _do_ when there are multiple
> requests, whether you do the same as if caching was disabled (hang until
> content is generated) or doing something novel (creating redirects
> through "Generating..." page).
> 
> > 2) prevents a user from reporting to the website that it's broken by
> > giving them a visual que that things aren't broken.
> 
> But this has nothing to do with caching per se, right? I think it
> actually makes _no difference_ if caching is enabled or not to this
> problem, or am I missing something?
> 
> 
> My point is, I guess, that showing the Generating page doesn't seem to
> have actually anything to do with the caching itself?

The point is that without caching it is easy to streaming response, and
to consider early parts of page (like page header, generated before any
heavy work) to serve as activity indicator.

With caching it is difficult to have streaming response, both from
technical point of view (writer must generate to client and to cache
simultaneously, readers must know when writer finished work to close
connection), and from robustness point of view (what happens if writer
is interrupted / killed before finishing generating output).  With
"generate then display" (which is not exclusive to caching, and is
another possible way of generating content even without caching) we
rather need some kind of activity indicator like "Generating..." page.

I think that "Generating..." page can be improved in two ways:
* Show "Generating..." page only if we are waiting for response for
  more than one second.  This might need mucking with alarms, as I think
  that sleep 1 before $self->generating_info(...) would be not a good
  solution.
* Stream response (using PerlIO::tee layer from PerlIO::Util, or 
  Capture::Tiny module, or tied filehandle like in CGI::Cache) for
  writer (i.e. process generating data), and wait for it to be finished
  (perhaps with "Generating...") in readers.  This way you wouldn't get
  "Generating..." page for rare views/URLs, and for common views/URLs
  there is high probability that you would not need "Generating..."
  page as there would be slightly stale response to serve.
Of course one can implement _both_ of those solutions, i.e. wait one
seconds in readers, and stream in writer.

I am not sure, but there might be another issue why activity indicator
is more important for the case with caching enabled.  If you interrupt
writer, one of readers waiting for finished data would have to take
role of writer, which besides need for technical solution to this problem
would mean longer wait.

[..] 
> > > (ii) Can't the locked gitwebs do the equivalent of tail -f?
> > 
> > Not really going to help much, most of the gitweb operations won't
> > output much of anything beyond the header until it's collected all of
> > the data it needs anyway and then there will be a flurry of output.  It
> > also means that this 'Generating...' page will only work for caching
> > schemes that tail can read out of, which I'm not sure it would work all
> > that well with things like memcached or a non-custom caching layer where
> > we don't necessarily have direct access to the file being written to.
> > 
> > At least the way I had it (and I'll admit I haven't read through Jakub's
> > re-working of my patches so I don't know if it's still there) is that
> > with background caching you only get the 'Generating...' page if it's
> > new or the content is grossly out of data.  If it's a popular page and
> > it's not grossly out of date it shows you the 'stale' data while it
> > generates the new content in the background anyway, only locking you out
> > when the new file is being written.  Or at least that's how I had it.
> 
> Well, my user experience with gitweb on kernel.org is that I get
> "Generating..." page all the time when I dive deep enough to the object
> tree. I just find it really distracting and sometimes troublesome when
> I want to wget some final object.

First, the user_agent checking would help there (it's a pity that all
web spiders (bots) and all non-interactive downloaders do not say what
they are explicitly in User-Agent string).  

Second, I guess that waiting 1 second (or more) before showing 
"Generating..." page would help in most cases.

> 
> I think it's fine to take in the caching support with the Generating...
> page in the bundle, but I do want to declare my intention to get rid of
> it later, at least for caching backends that could do without it - for
> pages where content appears incrementally, tail -f, for pages where
> content appears all at once, show at least the header and some "I'm
> busy" notification without redirects.

In the final version this should be fully configurable.  Note that
the series of patches I have send were just proof of concept for 
splitting caching patch into smaller parts / individual features.

-- 
Jakub Narebski
Poland
