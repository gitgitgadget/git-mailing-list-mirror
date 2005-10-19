From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-send-pack segfaulting on DebianPPC
Date: Wed, 19 Oct 2005 23:07:02 +1300
Message-ID: <46a038f90510190307u232dd3e1u8644061e4eecb308@mail.gmail.com>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	 <7v7jc9c15w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 12:08:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESAqi-0000Zk-Hp
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 12:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVJSKHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 06:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVJSKHE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 06:07:04 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:21418 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964778AbVJSKHC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 06:07:02 -0400
Received: by qproxy.gmail.com with SMTP id v40so47285qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 03:07:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XvT1xcRX+ZmsfXiqPOO0HH+DXV3s5XKHPzr6GCWlbacvJLpAMTwwqhMdvThMpTt7eAclFF/xtqXZZhgHroZj0J6su3QJgEk7gk7Ae0ZH9pP9QrUfE2gh9DXTXb0ckhZLGWagIy6k9MRVZuCqUvHl/nQxPjybrZdxdTGMw7uYQQk=
Received: by 10.64.242.2 with SMTP id p2mr369111qbh;
        Wed, 19 Oct 2005 03:07:02 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 03:07:02 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jc9c15w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10283>

On 10/19/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
> > ... However, git-fetch-pack is segfaulting on this Debian PPC
> > (etch). This is true of the current git "master" and 0.99.8.c. I
> > don'thave strace on the box until tomorrow, so I can't tell you more
> > about it.
>
> Thanks, that is good to know.  As I said in another message, I
> looked at cg-fetch's current tag completion code while working
> on the ref^{tree} thing, and saw it used commit walker with '-a'
> option (IOW, not producing an incomplete tag) to download
> everything.

Ok -- I'm at home now so I can't test it any further, but reading
cg-fetch, it would actually be running git-ssh-fetch which was failing
(but cogito hides STDERR). When I tried it by hand, I used
git-fetch-pack, which segfaulted on Debian PPC and worked on i386.

> Even after fetch-pack segfaulted, since it does not update any
> refs itself (it only writes them to stdout for the wrapper to
> process), it should not have resulted in the repository that has
> refs pointing at objects it does not have. In fact, it writes
> its "SHA1 - name" list only after seeing unpack-objects exit
> successfully, that should not have resulted in a corrupt
> repository that records incomplete refs.  I suspect there is
> something else going on here.

Hmmm. You're right, it only spits out a list of things to retrieve...

> In cg-fetch, fetch-pack is used only in one location, and it
> does not have anything to do with the tag completion code.
> Presumably that explains why removing tags did not have any
> effect, although it does not explain why removing some objects
> did -- maybe those object files you needed to remove were
> corrupt?

Well, I'll strace the execution tomorrow and let you know. The tag
objects, however, are there. I can reliably git-cat-file tag <sha1>
them and they look pretty normal. The commit objects they refer to are
missing, though.

cheers,


martin
