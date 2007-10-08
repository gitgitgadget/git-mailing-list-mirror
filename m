From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 18:22:28 -0600
Message-ID: <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <20071007221920.GF2765@steel.home>
	 <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
	 <20071007234346.GA29433@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 02:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IegOP-0003b7-6o
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 02:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXJHAW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 20:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXJHAW3
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 20:22:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:8647 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbXJHAW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 20:22:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1471062wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NYepQ3Os2CxUa+OAsGN73uynYU+OKQp2+eDsrgnotVs=;
        b=Ts9hZO8gacZfq8w+wrV+o3/U/IvOai/D75boypTh+QTtNu2/Br6644prcy+iUOzfs/HG/IXPvi/dPjY1F51ZCFsqBZUKnIJek0n7kJVLKWCQD++5dzrXkiVD29/5U2OABjUf5Wx0+QSunkMaPzRDxisSunUkZhqNcL7yHpoP6ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dkjlM1X8i3Xoq/ZRiVGotC25KGR5Ltyz9oIx4W6V6bb7DykXc8Qg/dKjJIameE4bB24DPZbDG70I5HEoKC2V0mnA6b9u/kUp+koicRr7pMIiCoKrqPSendOy/7bdznibkYBbjvxb8bx4A2tkYciz4Nz0wJuiWGwekBkh94eVwtM=
Received: by 10.114.121.1 with SMTP id t1mr525932wac.1191802948064;
        Sun, 07 Oct 2007 17:22:28 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 17:22:28 -0700 (PDT)
In-Reply-To: <20071007234346.GA29433@potapov>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60268>

On 10/7/07, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sun, Oct 07, 2007 at 04:24:49PM -0600, Elijah Newren wrote:
> > $ git reflog expire --all
> > $ git gc --aggressive --prune
>
> I believe this should work:
>
> git reflog expire --all --expire-unreachable=0
> git gc --prune

Yes, this seems to work.  So the history-rewriting steps are

git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
git reset --hard
rm -rf .git/refs/original/
vi .git/packed-refs
# Use vi to remove the line referring to refs/original...
git reflog expire --all --expire-unreachable=0
git gc --prune

Seems like a wrapper is needed.  :-)

> Warning: all unreachable references will be removed!

What other scenarios could lead to unreachable references?  I don't
know how to determine whether this is safe or not (except that these
were test repositories anyway, so I don't care what happens to them).

Thanks!
Elijah
