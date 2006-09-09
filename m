From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 10:47:49 +0200
Message-ID: <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 10:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLyVF-0008BB-RI
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 10:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWIIIrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 04:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWIIIrv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 04:47:51 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:33375 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932377AbWIIIru (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 04:47:50 -0400
Received: by py-out-1112.google.com with SMTP id n25so1203665pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 01:47:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Prd8ty4E8Ir54YEGiml88B5TbWK0iZhbopm5b+ECTClI+FEmECEv/k0V+6chLS05TJQgesHJTAo5t6cHgf5ElCle//aAm+lAHTDDqRKpqoGMs2XqfZdE3n6q/yS9KN4SFeaSCMKPcLxzZcr7IaxDxKJmP2DTMrCXOQyFsbxjpAc=
Received: by 10.35.33.15 with SMTP id l15mr4539435pyj;
        Sat, 09 Sep 2006 01:47:49 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 01:47:49 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26739>

On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>
> In contrast, doing some of the same sorting that git-rev-list already does
> in the consumer instead, is obviously duplicating the same basic notions,
> but once you do it in the consumer, you can suddenly do things that simply
> weren't possible in git-rev-list - do things incrementally, and then if
> you notice half-way that you did something wrong, you can go back and fix
> it up (which can be quite acceptable). That just isn't an option in a
> linear environment like the git-rev-list output.
>

Perhaps is total idiocy but why do not implement the fix-up logic
directly in git-rev-list?

If the out of order revisions are a small amount of the total then
could be possible to have something like

git rev-list --topo-order --with-appended-fixups HEAD

Where, while git-rev-list is working _whithout sorting the whole tree
first_, when finds an out of order revision stores it in a fixup-list
buffer and *at the end* of normal git-rev-lsit the buffer is flushed
to receiver, so that the drawing logic does not change and the out of
order revisions arrive at the end, already packed, sorted and prepared
by git-rev-list.

Instead of changing drwing logic is  then enough to add a fixup
routine that cycles through out of order commits and  updates the
graph.

This also avoids recursive reordering  where perhaps the same part of
a graph should be redrawn more then one time due to differtent new
parents to the same child arrives at different times.

Marco
