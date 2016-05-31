From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Tue, 31 May 2016 18:29:32 +0000
Message-ID: <20160531182932.GA27021@dcvr.yhbt.net>
References: <20160530232142.21098-1-e@80x24.org>
 <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net>
 <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:29:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7oQ6-000453-2A
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbcEaS3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 14:29:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55414 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbcEaS3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 14:29:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22F81F992;
	Tue, 31 May 2016 18:29:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296006>

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> wrote:

<snip>  Ah thanks, I can see your point-of-view, now.
I always had the '^' in my mind since I've written the same
thing in Perl and Ruby.

> >> I wonder if hand-coding, rather than using a regex, could be an improvement:
> >>
> >>     static int is_mboxrd_from(const char *s, size_t n)
> >>     {
> >>         size_t f = strlen("From ");
> >>         const char *t = s + n;
> >>
> >>         while (s < t && *s == '>')
> >>             s++;
> >>         return t - s >= f && !memcmp(s, "From ", f);
> >>     }
> >>
> >> or something.
> >
> > Yikes.  I mostly work in high-level languages and do my best to
> > avoid string parsing in C; so that scares me.  A lot.
> 
> The hand-coded is_mboxrd_from() above is pretty much idiomatic C and
> (I think) typical of how such a function would be coded in Git itself,
> so it looks normal and easy to grok to me (but, of course, I'm
> probably biased since I wrote it).
> 
> > I admit a regex isn't necessary, but I'm wondering if the above
> > could be made less frightening to someone like me.
> 
> Perhaps, but it's difficult to say without knowing how it frightens you.

Pointer arithmetic leading to buffer overruns;
but yeah, I don't do string parsing in C often, if ever.

> > Maybe extra test cases + valgrind can quell my fears :)
> 
> I can envision tests such as:
> 
>     ""
>     "F"
>     "From"
>     "From "
>     "From     "
>     "From foobar"
> 
> and so on, if that's what you mean.

Yes, I also noticed trailing spaces are dropped anyways, so
there's no perfect round-tripping going on.
