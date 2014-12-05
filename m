From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Fri, 5 Dec 2014 14:13:19 -0800
Message-ID: <20141205221319.GK16345@google.com>
References: <20141205205335.GA28935@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx17v-0000DD-As
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaLEWNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:13:23 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:46726 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaLEWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 17:13:22 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so1601831iec.11
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VihdF5SCqH54qi9JEVefIMqLkzVPyd8pyRzmZob9cHM=;
        b=ECWdEC+R7JN/1gHeEUjy3FNEju+waOBVsZWVxVZ2vIMIzdizHX2G5OWFdpHnRiuH1Q
         r++nzfdif1ZKo81tAn5ItXNIgXku1JJY70UhhxmlnRjHg/LK3N/gP1tqDe1dXa1io1Ro
         +FVidDcQsIE62/0P5avNb6dHMwKtJQklHYacuRH9XK9+ktR2u1w0bVg1wWJqz4+YdPb3
         8oa/RsNDTq1OFK6uo8wb8kz6R4QzVTqQC2fD1xCAgit1fg+Ze3nNBhGHaTXL8TznCjVz
         ORz7HewJthUZBeNwE/4nUsGNGcdhHOskNWw4GqwlBh/pjXFgcTVFeJVbN+hqu5en0dyB
         sYqw==
X-Received: by 10.107.137.199 with SMTP id t68mr936573ioi.38.1417817601749;
        Fri, 05 Dec 2014 14:13:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d425:9c48:1673:7021])
        by mx.google.com with ESMTPSA id r12sm16599877ioe.43.2014.12.05.14.13.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 14:13:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141205205335.GA28935@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260899>

Mike Hommey wrote:

> I'm currently evaluating what the final tool would look like. I'm *very*
> tempted to implement it in C, based on core git code, because there are
> many things that this helper does that would be so much easier to do
> with direct access to git's guts. And that wouldn't require more
> dependencies than git currently has: it would "just" need curl and ssh,
> and git already uses both.
>
> If I were to go in that direction, would you consider integrating it
> in git core?

Yes --- I would like this a lot.

The general trend has been to carry fewer contrib-style tools in-tree,
since the problem of discovering tools built on top of git is not as
hard as it used to be.  What you describe above seems to be a bit of an
exception:

 - libgit.a in its current state evolves too quickly for it to be
   convenient for out-of-tree tools to use.  cgit <http://git.zx2c4.com/cgit/>
   uses git pinned to a particular version as a submodule to get around
   this, which is fussy and has bad implications for remembering to
   get security updates.

 - an in-tree user of libgit.a would be useful as a reference example
   to use to try to make libgit.a into be a better library internally
   (and eventually expose e.g. by merging with libgit2 as something
   outside tools can link to, I hope)

 - if it makes sense to help people using the current remote helper
   in contrib to migrate to this, it could be convenient for users

In other words, although in the long term I would be happiest if
libgit becomes good enough to let this project live in a separate tree
and link to it, it's tempting to build this in-tree because we're not
there yet.

Some other alternatives:

 - using libgit2 <https://libgit2.github.com/>

 - improving git plumbing (e.g., with new fast-import commands) or
   exposing a small library with a stable API for the tool's use

I haven't thought it through carefully but at the moment I like the
in-tree approach best.

Thanks,
Jonathan
