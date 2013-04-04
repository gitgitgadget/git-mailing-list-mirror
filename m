From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 10:14:33 -0600
Message-ID: <CAMP44s02PUGctgacuGRw3p8uEXhowZJWJjdq0g9aO9bBbpnv2w@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:15:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmof-0006Ap-Im
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762828Ab3DDQOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 12:14:37 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36794 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762800Ab3DDQOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 12:14:35 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so2648292lab.39
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=EXrlKtcwzlPvpuDneei9VI5wWYwn1trQlZ7pKoAh8pw=;
        b=ZAA1WvIvncA2YagVFTT1Ema/N4dqY934gachmq9AmkA7GL2UQJs4fNPR5eUQ3mK8oS
         1X8CkZQNeLFCWEr2q6M+F+APiv6I4IlQl5Vhq4uh4ADiEKjx8tWjxF22Deb6oRE4VJLq
         I7P+JY5Es8VXP9N8yM4X/40w9GTC5Q8XpJEAeTvmNqotbti1s73uiYwCruKv7vQaQJnO
         PHOLGerFSNwIG01cAe6hCv8Gl8X+Wn0T41nmMgdirrwCOPd4fvqza7Q1Z6O5slorekmu
         s6kKfea2uqTnaBMQrGLOQJMB+S/WnMIsVDTlsVLmUU/A7LZwMC1RnfxQpcjMQIsOo7xu
         82zQ==
X-Received: by 10.152.46.17 with SMTP id r17mr3808199lam.47.1365092074021;
 Thu, 04 Apr 2013 09:14:34 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 09:14:33 -0700 (PDT)
In-Reply-To: <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220028>

On Tue, Apr 2, 2013 at 4:23 PM, Max Horn <max@quendi.de> wrote:

> I'll try to list some of remaining differences, mostly (in my biased opinion) improvements on the gitifyhg side. Note that some of these might be outdated with felipe's recent changes, i.e. I have not yet had time to review and/or test them all. So please bear that in mind.

I've implemented a lot of these, cleaned them up, and pushed them, the
ones that will be integrated:
http://github.com/felipec/git/tree/fc/remote/hg-next

The ones that won't (at least not without more discussion):
http://github.com/felipec/git/tree/fc/remote/hg-gitifyhg-compat

> * added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)

I don't think there's anything inherently better about these tests,
with the compatibility patches here are the results on v0.8 running
remote-hg:

=========================================================== test
session starts ===========================================================
platform linux2 -- Python 2.7.3 -- pytest-2.3.4
collected 80 items

test/test_author.py ........F
test/test_clone.py ......xx.........x...x..
test/test_notes.py ..Fx.
test/test_pull.py ....x..xx..
test/test_push.py ..........F...x........FF...
test/test_special_cases.py ...

============================================= 5 failed, 66 passed, 9
xfailed in 75.52 seconds =============================================

> * improved handling of hg user names (remote-hg is not able to deal with some pathological cases, failing to import commits). Sadly, mercurial allows arbitrary strings as usernames, git doesn't...

This is not true; after checking the code, remote-hg can't possibly
fail, if it does, so does gitifyhg. I guarantee it. The only
differences are cosmetic.

That being said, I'll integrate a patch that I believe produces
superior sanitation than gitifyhg's, and passes the gitifyhg test (as
you can see above) (for the most part):

https://github.com/felipec/git/commit/c0e363915eb6459233e37d5082fb2ff7c7c727b4

> * failed pushes to hg are cleanly rolled back (using mq.strip() from the mq extension), instead of resulting in inconsistent internal state. This is quite important in real life, and has bitten me several times with remote-hg (and was the initial reason why I switched to gitifyhg). A typical way to reproduce this is to push to a remote repository that has commits not yet in my local clone.

After the change to force=true, let's see if this happens any more in
remote-hg (Doubt it).

> * git notes are used to associate to each git commit the sha1 of the corresponding hg commit, to help users figure out that mapping

Easy:
https://github.com/felipec/git/commit/2294fb445f5c018a39f421cba70e4d8510c04c89

I will not integrate this for the moment, there must be a better way
to interact with transport-helper to update these.

> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.

I will investigate the pros and cons of this, but either way it's not
something people are going to immediately need (I doubt the
semi-broken states will happen again).

> * Better handling of various hg errors, see e.g. [2]. More work is still needed there with both tools, though [3].

No idea why something so trivial was mentioned:
https://github.com/felipec/git/commit/d12e35d23b9d26d384c3dbbce25a09720ccbceff

> * Support for creating hg tags from git (i.e. pushing light git tags to heavy hg tags)

This was already merged to git.git:
https://git.kernel.org/cgit/git/git.git/commit/?id=32f370f62177b505daf96aaf711c0249d881b6c0

(link might change)

> * The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
> In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg

This is nice, but doesn't translate necessarily to anything tangible
for the user. remote-hg, like all git.git, has good development
practices, which minimizes the risks of regressions.

> * Renaming a gitifyhg remote just works [5]. Doing that with remote-hg triggers a re-clone of the remote repository (if it works at all, I don't remember).

Changing a remote-hg URL remote just works. Potato potato.

Cheers.

-- 
Felipe Contreras
