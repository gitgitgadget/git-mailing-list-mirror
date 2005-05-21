From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach diff-tree to report unmodified paths for -C
 option.
Date: Sat, 21 May 2005 03:51:13 -0700
Message-ID: <7vll68j1i6.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsvkj3bu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 12:51:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZRZA-00018w-LG
	for gcvg-git@gmane.org; Sat, 21 May 2005 12:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVEUKvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 06:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEUKvR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 06:51:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13706 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261725AbVEUKvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 06:51:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521105114.ZFEW1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 06:51:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpsvkj3bu.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 03:11:49 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Linus, I have a bit of design issue that...

Another thing I forgot to mention, even in the documentation.
Currently all the diff-tree family says -M and -C imply -p which
is by itself sensible, because rename-edit and copy-edit cannot
be expressed with the diff-raw format (the format only takes one
path).

On the other hand, pickaxe is really a diff filter, so it can
work with both diff-raw and diff-patch format.  Here is my
favorite example, in git.pasky aka cogito archive:

    ./git-rev-list pasky |
    ./git-diff-tree --stdin -S'static const char *tag_cached = "";
    static const char *tag_unmerged = "";
    static const char *tag_removed = "";'

.....
ffbe1addd5a5b7b7c2f987625a5aa6c1d22e3705 (from 20d37ef67286e5131d2333d7b4662bc70f9d4937)
20d37ef67286e5131d2333d7b4662bc70f9d4937 (from e78d97723cd77d46d8767a5a27965077249fd080)
*100644->100644 blob 58b5aee94ee76c9201c580d271fcb6aaf20d421f->a2d8cbb2f8d0090a496177cd38f252786d29c3d6 ls-files.c
e78d97723cd77d46d8767a5a27965077249fd080 (from cc167ccaeb1adcdc392f9e03ed1225762ea3cf96)
cc167ccaeb1adcdc392f9e03ed1225762ea3cf96 (from 4df1e7950787197f7cad081b98f9ffe6c4089fc9)
.....



