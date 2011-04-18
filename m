From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: "negative" dirstat
Date: Mon, 18 Apr 2011 14:46:24 -0700
Message-ID: <BANLkTimEUSb9Na7Z+tnmytsqeeKLkQb9xA@mail.gmail.com>
References: <BANLkTi=it7r7UsAZGYJC1mntL6wtFipB9g@mail.gmail.com> <7vzknn6y7y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBwHS-0002Ch-Af
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab1DRVqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:46:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41250 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751516Ab1DRVqp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2011 17:46:45 -0400
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3ILkiT0025581
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:46:44 -0700
Received: by iyb14 with SMTP id 14so4243415iyb.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:46:44 -0700 (PDT)
Received: by 10.231.34.4 with SMTP id j4mr4390093ibd.83.1303163204123; Mon, 18
 Apr 2011 14:46:44 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Mon, 18 Apr 2011 14:46:24 -0700 (PDT)
In-Reply-To: <7vzknn6y7y.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-102.974 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171763>

On Mon, Apr 18, 2011 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Are these removal really "remove old cruft, replace with a better version
> which does not have much common to removed stuff", or are they more like
> "remove N duplicated similar copies of old cruft, refactoring them
> properly and the result is used by N callsites"?

Right now, there not so much of either.

The _hope_ is that there will be "remove <n> different implementations
of some gpio driver, and replace them with a couple of generic ones
and some setup code".

So no, it wouldn't necessarily be about code movement at all, but
about totally different code.

> The second reason you gave in an earlier discussion why dirstat uses the
> damage assessor code was to disregard code movements.

No, that only works within a file, which sometimes is common when you
have to re-order functions because or some re-organization.

See for example commit 9d412a43c3b2 ("vfs: split off vfsmount-related
parts of vfs_kern_mount()") in the kernel for an example of why line
ordering shouldn't necessarily count against damage.

But what I'm talking about is really different code, not
re-organization of existing one.

> I guess what it boils down to is what you are trying to measure as the
> "goodness" value of a change.

Yes.

>                               Adding a lot of Documentation may be good,
> adding a lot of "subarchs that do not deserve to be" may be bad, and
> moving common logic from one existing subarch to a common file (which
> counts towards "literal-added" in that new common file, at the same time
> counting towards deletion, i.e. "size - copied", from the original) and
> reusing it in a new subarch by simply calling that common infrastructure
> is a very good thing.

Yes. If I see a lot of lines added in Documentation/, I really don't
mind at all. And if I see a diffstat that says something like

   1057 lines added, 2901 lines deleted

I'm extremely happy. It's very different from one that would say

   2958 lines added, 0 lines deleted

even though --dirstat might consider the two equivalent right now.

> At least, if you count literal-added vs src-copied
> across the files within the subarch, instead of doing it per-file, you
> would be able to detect the "moving" part more accurately.

Yes. However, "moving" is in many ways still not as interesting as
"actually removed".

Moving, on it's own, is a pretty neutral operation. So I really don't
want to concentrate on the moving part. It's really about "some
operations actually clean up code and remove code in the process".

                  Linus
