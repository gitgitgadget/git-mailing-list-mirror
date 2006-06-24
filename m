From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 22:08:44 +1200
Message-ID: <46a038f90606240308g8ec9ceelb18ea505a8708b91@mail.gmail.com>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <11511257501323-git-send-email-martin@catalyst.net.nz>
	 <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jun 24 12:08:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu54L-0001Rc-3z
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 12:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbWFXKIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933376AbWFXKIq
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 06:08:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:31523 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933022AbWFXKIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 06:08:45 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1394529ugf
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 03:08:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d467Zjea3LQLED2TljeMQbTtM8N0LOiyeM51mZslC0gEmGkZ1vj2HXoRC7UJ6QboYNTL20YS2Zi1oOcbYXhWWSYAmit6s6HbUue1wFC78i6QtjDZhNqMpxAC6SvSDYeblvPPPmcGVYd0vqeC3WkaJytfRgcgQycaIOjAhf9LBR0=
Received: by 10.78.151.3 with SMTP id y3mr1547262hud;
        Sat, 24 Jun 2006 03:08:44 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Sat, 24 Jun 2006 03:08:44 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22499>

On 6/24/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Thank you. This fixes the error.

Your welcome!

> HOWEVER, it does not fix the main problem: when I try to git-cvsimport,
> there is no index for that branch yet, since I used to git-cvsimport with
> the old cvsimport.
>
> Now, when cvsimport sees there is no index, it evidently assumes that the
> current state is an empty tree, which is *not* true.
>
> The effect is: the first commit removes all files from the tree which were
> not touched by the cvs commit. Bad.

I don't quite understand. No it shouldn't be the case -- it should
create the index using git-read-tree based on the tip of the branch.
Right after the call to tmpnam() the code looks like

 $index{$branch} = tmpnam();
 $ENV{GIT_INDEX_FILE} = $index{$branch};
 system("git-read-tree", $branch);
 die "read-tree failed: $?\n" if $?;

> > This usage of tempfiles is open to a race condition
>
> I would not care too strongly about that. Eventually, I really would like
> this file to reside in $GIT_DIR, not /tmp, but whatever. That is not my
> biggest concern right now. That I cannot update since June 18th, however,
> is.

It's worrying me too. Running some tests now...




martin
