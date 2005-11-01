From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 17:29:19 +0000
Message-ID: <b0943d9e0511010929u22b33e4el@mail.gmail.com>
References: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <20051101141149.GA26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 18:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWzwq-0003TO-3M
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVKAR3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVKAR3V
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:29:21 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:4246 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751009AbVKAR3U convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:29:20 -0500
Received: by xproxy.gmail.com with SMTP id i30so1368932wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 09:29:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q8GXGRo9X1ZjuGRFpHrAcdV7scBeTuL3Av2uGrA8TYGLdJj1BIVtUYLRKdu579r9O7uckWRR6iN3ou9ifxybc//PAOSBk3eR+10yiriaQ7NOmnSSlLkcrLDsvfI9zU4uhMbycUtpKnRjjQoAoc/qCBafbcn/Jtagdczsfs/yrE8=
Received: by 10.70.72.15 with SMTP id u15mr2655391wxa;
        Tue, 01 Nov 2005 09:29:19 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 09:29:19 -0800 (PST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051101141149.GA26847@watt.suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10942>

On 01/11/05, Chris Mason <mason@suse.com> wrote:
> On Tue, Nov 01, 2005 at 10:08:04AM +0100, Petr Baudis wrote:
> > Did anyone do any current detailed comparison between hg mq and StGIT?
>
> I don't think so, but I'll give it a rough try.  I have not used stgit
> extensively, so please correct any mistakes below.  Most of the
> differences center around the ways we store patches.

Thanks for this comparison. It is correct.

> mq is closer to quilt.  The patches are stored as patches, and hg qpush
> is very similar to importing a patch.  This means metadata must be
> stored at the top of the patch in some form the import code can
> understand (it tries to be smart about this).

The problem with this is allowing people to modify the patch directly
(with vi). This would make it difficult to do a three-way merge
without either losing the direct changes or simply failing to apply a
modified patch to its old base (I thought about using patches as an
optimisation but after some benchmarking found that "git-diff-tree |
git-apply" is fast enough and most of the time when pushing is
calculating the sha1 hash of the resulting index file).

> hg qrefresh will update the patch file, so the patch is always up to
> date wrt to the hg repo.

Chuck, I think, has a patch to automatically export the patch when
pushing or refreshing. With the latest StGIT snapshot, the tool
reports if the patch was modified during push and can only be exported
in this case (the way it detects this is by assuming that if git-apply
is successful, the patch is unmodified since no fuzzy applying is
accepted; the fall back to three-way merge just reports the patch as
modified).

> You can import/export patches with hg commands, or by copying patches
> into/from the .hg/patches directory.  This also means you can take a
> quilt patch dir, copy it into .hg/patches and just start using mq.

As I said, you might have problems with implementing a three-way merge.

> I'm not sure if stgit has some form of annotate, but it's a nice way to
> find out which patch changed a given loc in hg/mq.

There is git-whatchanged which also reports the StGIT patches applied
onto the stack. But there is no command similar to 'quilt patches'
yet.

--
Catalin
