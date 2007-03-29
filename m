From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 20:32:37 +0200
Message-ID: <20070329183237.GB2809@steel.home>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 20:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWzQa-0007QH-FI
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 20:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbXC2Scl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbXC2Sck
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 14:32:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:20840 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030654AbXC2Scj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 14:32:39 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (fruni mo2) (RZmta 5.5)
	with ESMTP id M038d1j2TFvQR0 ; Thu, 29 Mar 2007 20:32:37 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A1F3E277B6;
	Thu, 29 Mar 2007 20:32:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5FA5DD24E; Thu, 29 Mar 2007 20:32:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43461>

Alex Riesen, Thu, Mar 29, 2007 17:04:31 +0200:
> CONFLICT (rename/rename): Rename 1->a in branch HEAD rename 1->b in B
> Automatic merge failed; fix conflicts and then commit the result.
> 
> Tom, either the stack trace of -O0 -ggdb or your repo is badly needed.
> The stack preferred, as I have that feeling it'll just work everywhere
> else but your system (can you try it somewhere else, BTW?).

Ok-key... Thanks Tom, for the testcase. I believe we haven't had this
one yet: the merge base in the second (inner) merge is the initial
commit. Which is strange:

(gdb) p *merged_common_ancestors
$4 = {
  object = {
    parsed = 1,
    used = 0,
    type = 0,
    flags = 0,
    sha1 = "\001", '\0' <repeats 18 times>
  },
  util = 0x8082b40,
  date = 0,
  parents = 0x8ff5180,
  tree = 0x0,
  buffer = 0x0
}

tree == 0x0? Strange, I don't get why it is NULL, the initial commit
definitely hase a tree (git cat-file -p initial-commit shows a tree
name and there is a tree with that object name).

The structure looks like this:

    o---o-o-o---o-o-o-o-o
     \   ____\_/
      \ /     \
       o-------o-o-o-o

Fsck reports no errors.
Still looking into it.
