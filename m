From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PULL] Module fixes, and a virtio block fix.
Date: Mon, 21 Jan 2013 13:27:11 +1030
Message-ID: <871udfw8e0.fsf@rustcorp.com.au>
References: <87zk03wg7r.fsf@rustcorp.com.au> <CA+55aFwzdcv0LXovZobha=EH=L6DapJt+ODP0nq=TWWAqCxLYQ@mail.gmail.com> <87fw1vwcao.fsf@rustcorp.com.au> <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	Prarit Bhargava <prarit@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 21 03:59:47 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Tx7bu-0001ev-Kj
	for glk-linux-kernel-3@plane.gmane.org; Mon, 21 Jan 2013 03:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab3AUC7W (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 20 Jan 2013 21:59:22 -0500
Received: from ozlabs.org ([203.10.76.45]:34855 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab3AUC7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jan 2013 21:59:20 -0500
Received: by ozlabs.org (Postfix, from userid 1011)
	id ECF892C009C; Mon, 21 Jan 2013 13:59:19 +1100 (EST)
In-Reply-To: <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com>
User-Agent: Notmuch/0.14 (http://notmuchmail.org) Emacs/23.4.1 (i686-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214077>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Jan 20, 2013 at 5:32 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>> Due to the delay on git.kernel.org, git request-pull fails.  It *looks*
>> like it succeeds, except the warning, but (as we learned last time I
>> screwed up), it doesn't put the branchname because it can't know.
>
> I think this should be fixed in modern git versions.
>
> And it sure as hell knows the proper tag name, since you *gave* it the
> name and it used it for generating the actual contents. The fact that
> some versions then screw that up and re-write the tag-name to
> something randomly matching that isn't a tag was just a bug.

I'm confused.  The default argument is HEAD: what does it know about tag
names?

        git request-pull master korg

The bug is that if it can't find that commit at the remote end, it
still generates a valid-looking request (with a warning at the end),
where it guesses you're talking about the master branch.

>> For want of a better solution, I'll now resort to sending pull requests
>> with the anti-social gitolite URL in it, like so:
>
> That's even worse, fwiw. It means that the pull request address makes
> no sense to anybody who doesn't have a kernel.org address, and then
> I'm forced to just edit things by hand instead to not pollute the
> kernel changelog history with crap.

Since I use a wrapper script now for your pull requests I can use sed to
unscrew it:

[alias]
	for-linus = !check-commits && TAGNAME=`git symbolic-ref HEAD | cut -d/ -f3`-for-linus && git tag -f -u D1ADB8F1 $TAGNAME HEAD && git push korg tag $TAGNAME && git request-pull master korg | sed s,gitolite@ra.kernel.org:/pub,git://git.kernel.org/pub, && git log --stat --reverse master..$TAGNAME | emails-from-log | grep -v 'rusty@rustcorp' | grep -v 'stable@kernel.org' | sed 's/^/Cc: /'

> Junio, didn't "git request-pull" get fixed so that it *warns* about
> missing tagnames/branches, but never actually corrupts the pull
> request? Or did it just get "fixed" to be a hard error instead of
> corrupting things? Because this is annoying.

Here: git version 1.7.10.4

Cheers,
Rusty.
