From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 07 May 2006 16:35:53 -0700
Message-ID: <7vveshif1i.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<87mzdx7mh9.wl%cworth@cworth.org>
	<7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	<e3fqb9$hed$1@sea.gmane.org>
	<Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	<46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	<7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
	<20060507120149.40e9f749.vsu@altlinux.ru>
	<46a038f90605071627i6a335f61lf5e35291bfbe340c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 01:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcsnF-0002qy-KD
	for gcvg-git@gmane.org; Mon, 08 May 2006 01:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEGXfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 19:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWEGXfz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 19:35:55 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42736 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750789AbWEGXfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 19:35:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507233554.QUQT25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 19:35:54 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605071627i6a335f61lf5e35291bfbe340c@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 8 May 2006 11:27:24 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19723>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 5/7/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
>> For linux v2.6.16:
>>
>> 7,3M commits-b41b04a36afebdba3b70b74f419fc7d97249bd7f.pack
>>  24M commits_trees-8397f1c2a885527acd07e2caa8c95df626451493.pack
>>  97M full-c7b2747a674ff55cb4a59dabebe419f191e360df.pack
>
> With this pack arrangement, do you get any noticeable difference in
> walking commits? How about walking commits+trees with git-log <path> ?
>
> I wonder whether segregating packs by object type would make things better...

It shouldn't.  The existing packfile is designed to make "git
log" very efficient, by making it cheap to look only at the
commit message and ancestry information.

The objects are sorted first by type in the pack with the
existing code already, and commits come first.  Try this.

        git repack -a -d
        git show-index <.git/objects/pack/pack-*.idx |
        sort -n |
        while read offset objectname
        do
                git cat-file -t "$objectname"
        done
