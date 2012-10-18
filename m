From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 05:44:30 +0200
Message-ID: <CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 05:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOh2J-0001BR-HS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 05:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab2JRDoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 23:44:32 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37349 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2JRDob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 23:44:31 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8179857oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1aE8m+s+k1WyUKbQoGCvgqkSqe62tGXJE8Ioi5UyjKM=;
        b=w1tT6tSs/hOkFq9USweKRU7VBUtUH6FyxH5O5PDmQfc3Y/igXwipenND59gwnE0039
         Zc2/YxLa2aHa0WLV9PRZRn0JHqd0E57eIBWOfgs84NRli6lQR/+oMTUS32RN0QiiDvrQ
         jBwzl4p7RV2GH1l26ht8xtwpsIRgatQVDMpeTpK9UOZ1WnUbfCJNu60x5ov8vvQRClyJ
         13LtF8+tA1kMrSZiJIdISE6nQWLNPvsiMppB32u5PNFnn5fTP6BFYkBqXXPnN0oiJOu2
         AH6cqF05Or3CCEVZv2t7IJwY298D0fOqZ5VcxdCswuuBLVJvUEoZ3blMlnDcEvRj9xM4
         7rZA==
Received: by 10.60.32.19 with SMTP id e19mr18244315oei.9.1350531870354; Wed,
 17 Oct 2012 20:44:30 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 20:44:30 -0700 (PDT)
In-Reply-To: <20121017225913.GC21742@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207956>

On Thu, Oct 18, 2012 at 12:59 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 17, 2012 at 02:58:41PM +0200, Felipe Contreras wrote:
>
>> I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
>> slow, or to difficult to setup, etc.
>
> I run into this every few months, evaluate all of the options, and come
> to the same conclusion. So I am excited at the prospect of something
> simple that just works out of the box.
>
> Unfortunately, when I tried it, it did not work for me. :(
>
> Details below.
>
>>  contrib/remote-hd/git-remote-hg | 231 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
>>  create mode 100755 contrib/remote-hd/git-remote-hg
>
> Is this "hd" a typo, or is there something clever I am missing?

Yeah, I've fixed that now.

>> --- /dev/null
>> +++ b/contrib/remote-hd/git-remote-hg
>> @@ -0,0 +1,231 @@
>> +#!/usr/bin/python2
>
> I do not have /usr/bin/python2. I do have (on my Debian box):
>
>   $ ls -l /usr/bin/python* | perl -lne 'print $& if m{/.*}'
>   /usr/bin/python -> python2.7
>   /usr/bin/python2.6
>   /usr/bin/python2.7
>   /usr/bin/python3 -> python3.2
>   /usr/bin/python3.2 -> python3.2mu
>   /usr/bin/python3.2mu
>   /usr/bin/python3mu -> python3.2mu
>
> Obviously a minor, easily fixable issue, but I wonder if it should ship
> with a more portable default (like just "/usr/bin/python", or even
> "/usr/bin/env python").

Yeah, this has always been an issue in Arch Linux; I have to compile
git by exporting PYTHON_PATH.

I'm OK with using any of the two above suggestions above, as they are
more standard.

>> +# Inspired by Rocco Rutte's hg-fast-export
>> +
>> +# Just copy to your ~/bin, or anywhere in your $PATH.
>> +# Then you can clone with:
>> +# hg::file:///path/to/mercurial/repo/
>
> The first thing I tried was:
>
>   $ git clone hg::https://code.google.com/p/dactyl/

Right, doesn't look like it works for remote repositories. I think
that's the next feature I want to implement, but to be honest, I don't
think it's a big issue. To replace this:

git clone hg::https://code.google.com/p/dactyl/

With this

hg clone https://code.google.com/p/dactyl/
git clone hg::dactyl dactyl-git

We could do what other tools do, manually clone the repository and
store it internally, but I'll rather not trick the users this way.

> I worked around it by doing an hg-clone and trying to git-clone from
> that local clone. But that didn't work either:
>
>   $ hg clone https://code.google.com/p/dactyl/ hg
>   [... clone eventually completes ...]
>
>   $ git clone hg::$PWD/hg git
>   Cloning into 'git'...
>   progress revision 99 'pentadactyl-1.0b5-branch' (100/5367)
>   [... many more progress updates ...]
>   progress revision 6766 'cpg-hack' (1400/1467)
>   ERROR: Branch 'default' has more than one head

Yes, this is deliberate, we can't have more than one head per branch in git.

What you should do is go to the mercurial repo, and 'hg merge' (I think).

We could just pick the first head, and warn the user instead.

But at the moment it should fail at this point, I wonder why you get
the errors below.

>   error: refs/tags/VIMPERATOR_2_2_b1 does not point to a valid object!
>   error: refs/tags/muttator-0.5 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b1 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b2 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b3 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b4 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b4.1 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b4.2 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b4.3 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b5 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b5.1 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b6 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b7 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0b7.1 does not point to a valid object!
>   error: refs/tags/pentadactyl-1.0rc1 does not point to a valid object!
>   error: refs/tags/vimperator-0.4.1 does not point to a valid object!
>   error: refs/tags/vimperator-0.5 does not point to a valid object!
>   error: refs/tags/vimperator-0.5-branch-HEAD-merge-1 does not point to a valid object!
>   error: refs/tags/vimperator-0.5.1 does not point to a valid object!
>   error: refs/tags/vimperator-0.5.2 does not point to a valid object!
>   error: refs/tags/vimperator-0.5.3 does not point to a valid object!
>   error: refs/tags/vimperator-1.0 does not point to a valid object!
>   error: refs/tags/vimperator-1.1 does not point to a valid object!
>   error: refs/tags/vimperator-1.2 does not point to a valid object!
>   error: refs/tags/vimperator-2.0 does not point to a valid object!
>   error: refs/tags/vimperator-2.0a1 does not point to a valid object!
>   error: refs/tags/vimperator-2.1 does not point to a valid object!
>   error: refs/tags/vimperator-2.2 does not point to a valid object!
>   error: refs/tags/vimperator-2.2b1 does not point to a valid object!
>   error: refs/tags/xulmus-0.1 does not point to a valid object!

This is weird.

> I seem to remember getting this with other importers, too (probably
> because they were also based on the same script).

hg-fast-import also fails if there are multiple heads, also deliberately.

> We do not need to fix every bug before bringing a script into git
> (especially into contrib/), but I am wondering if this script errs too
> much on the side of "simple" and not enough on "works out of the box".
> Maybe this repo is really complex and unusual, and the multi-heads thing
> is not common enough to worry about. But I feel cloning a remote is the
> first thing most people are going to try, and it doesn't work.

Well, maybe the next time you try the branch will be merged. In
mercurial they even warn you about this when you do 'hg push', so it's
not a good practice that they are doing that in their own repo.

As for remote repos, I don't know what we should be doing at the moment.

Cheers.

-- 
Felipe Contreras
