From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Thu, 29 Jun 2006 10:43:38 +0200
Message-ID: <81b0412b0606290143g5a3a0f5atbda3f4250411e92e@mail.gmail.com>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060627223249.GA8177@steel.home>
	 <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
	 <20060629002547.GA27507@steel.home>
	 <7vzmfwy97w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Fredrik Kuivinen" <freku045@student.liu.se>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 10:43:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvs7j-0004nT-KU
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 10:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWF2Ink (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWF2Ink
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 04:43:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:49984 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWF2Inj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 04:43:39 -0400
Received: by ug-out-1314.google.com with SMTP id a2so212902ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 01:43:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q4ROGQpJD9by1K1ED59KW1RJMFI5PCRMbklZZBiCh8Zzx8txq0yO7Z5ddTfPb0NE0Hmir9jFWjZ9fB/8tewLjaMI3YrMb/wcqIIdKVuI2SDoQFG1IZ7AwZBbrcFzZm905w8r0sxDTFCKngDqILzEy4TizsOabBRK1OwqxjVjfG8=
Received: by 10.78.97.7 with SMTP id u7mr921782hub;
        Thu, 29 Jun 2006 01:43:38 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Thu, 29 Jun 2006 01:43:38 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vzmfwy97w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22847>

[cc list restored, I'm lost in the maze of git update-index, all cache
changing functions looking almost the same]

On 6/29/06, Junio C Hamano <junkio@cox.net> wrote:
> > this broke t6022-merge-rename.sh (the second test). It produces an
> > index with this:
> >
> > .../t/trash$ git-diff-index white
> > :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B
> > :100644 100644 ba41fb96393979b22691106b06bf5231eab57b85 0000000000000000000000000000000000000000 M      N
> >
> > whereas git-merge-recursive (and the previous version, without pipe):
> >
> > .../t/trash$ git-diff-index white
> > :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a 0000000000000000000000000000000000000000 M      B
> >
> > I can see that "git update-index --add" is somehow different from a
> > pipe to "git update-index --index-info", but not very clear. Does this
> > "zero-sha1" mean that the file "N" is not in the index?
>
> When diff-index and diff-files compare a tree entry or an index
> entry with a file in the working tree, they do not compute the
> blob hash value for the file in the working tree.  0{40} is used
> on the RHS in such a case.  When the working tree file matches
> the corresponding index entry, then we know RHS matches what is
> in the index, so both sides have the blob hash value.

Ok. Am I correct in the assumption, that if the file in working tree has
the same SHA1 as LHS, than the next "git-update-index --refresh" will
remove the entry from git-diff-index output?
This is what actually happens, if I do "git-update-index --refresh", so I
suspect that I have an SHA1 update gone missing somewhere.
