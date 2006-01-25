From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 25 Jan 2006 15:56:19 -0800
Message-ID: <7vvew7lv4s.fsf@assigned-by-dhcp.cox.net>
References: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
	<8aa486160601250634v294857e0j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:57:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1uUx-0006ue-Ht
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 00:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWAYX4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 18:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWAYX4V
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 18:56:21 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39824 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751244AbWAYX4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 18:56:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125235347.GPOB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 18:53:47 -0500
To: Santi Bejar <sbejar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15144>

Santi Bejar <sbejar@gmail.com> writes:

> Junio C Hamano <junkio@cox.net> writes:
>...
>>         $ git whatchanged --cc --abbrev pu
>...
>       Then some comments :)
>
>       * There is an extra space between the +- and the content.

Thanks for noticing.  Fixed.

>       * I think the "diff command" could be just "diff --git".  And
>         "diff --git --cc" for the "dense combined diff".

I chose not say "--git" because I wanted to make sure people
would not run "git apply" by mistake.  I replaced them
with "--combined" and "--cc" to make the differences clearer.

>       * I miss the index lines

That would probably be easy to add in the later rounds if you
really want them, but I consider it lower priority for now.
This is designed to be human readable and not necessarily
machine applicable, so I do not see much point in showing them.

Mode changes, creation, deletion, rename, and copy may need to
be there, though.  The code currently punts on them.  Patches
welcome.

>       * In the case of 3 and more parents I find uninteresting the hunk
>         where the merge is equal to one (or more) of its children and
>         the rest are equal. For example the first hunk in 22573dd, where
>         all the children are equal expect the picked one:
>
> diff-tree 22573dd... (from parents)
> Merge: 92643a2 0359fe8 a428965 4aa079f
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Wed Jan 25 03:51:37 2006 -0800
>
>     Merge lt/revlist,jc/diff,jc/bind
>
> diff --combined rev-list.c
> @@@@@ +37,7 @@@@@
>      static int dense = 1;
>      static int unpacked = 0;
>      static int bisect_list = 0;
> ---  static int tag_objects = 0;
> ---  static int tree_objects = 0;
> ---  static int blob_objects = 0;
> +++  static int list_objects = 0;
>      static int verbose_header = 0;
>      static int show_parents = 0;
>      static int hdr_termination = 0;

I noticed it and found it somewhat less interesting than others,
but left it the way.  It is "changed the same way from all of
these parents except this one", which is different from what I
culled in the version you are commenting on, i.e. "changed only
from one parent".

I've since updated the logic to drop these hunks as well.
Please take a look at the tip of "pu".

>       * Like you said in another thread, the line numbers of all the
>         files.

This is left as an exercise for the reader ;-)

> So, at the end, I suggest this output for the diff:
>...
> and this for the diff-raw:
>
> :100644 100644 56505b4... 538d21d... M  Makefile
> :100644 100644 30479b4... 538d21d... M  Makefile

I do not find this to be so interesting.  diff-raw is primarily
for quick sanity check and machine processing, so I'd rather not
play games when generating diff-raw in order to keep the latter
form of users sane.
