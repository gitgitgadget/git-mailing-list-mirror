From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cvsexportcommit/cvsimport workflow
Date: Mon, 5 Dec 2005 20:57:37 +0000
Message-ID: <46a038f90512051257gf185f0cy11894a1114bc6872@mail.gmail.com>
References: <200511212043.57434.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:59:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjNP4-0000zk-8g
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVLEU5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVLEU5j
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:57:39 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:29321 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751465AbVLEU5i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 15:57:38 -0500
Received: by zproxy.gmail.com with SMTP id i28so1231447nzi
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 12:57:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZeMBsXSLvamx5Faw314W34B0+HjR7F+hfh7j8cUZZDCNVteFnsVvWstL2WsXM6Etxug7Eweb6FrNt3wW9y4wBkDgar4av2uYLrNCyRdO6sP/+Bn4QQkJltKpBK7de/I4IySq4Ds30g8rrbtTcSX4Z1xqvJZL0OICUj43/Yx9Ocg=
Received: by 10.65.73.3 with SMTP id a3mr3243320qbl;
        Mon, 05 Dec 2005 12:57:37 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Mon, 5 Dec 2005 12:57:37 -0800 (PST)
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200511212043.57434.lan@ac-sw.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13231>

On 11/21/05, Alexander Litvinov <lan@ac-sw.com> wrote:
> Can ypu please explain how to use cvsimport with cvsexportcommit scripts ?

Your approach is good -- that's exactly how I use them too. I normally
use git-format-patch to review what patches I have 'pending' to be
pushed upstream. It's great because it knows your last common commit,
and it uses git-cherry to spot commits that are identical on both
sides.

We should perhaps create git-cvsexport, followning git-format-patch's
usage of git-cherry, and calling git-cvsexportcommit with them.
There's been talk about doing it -- I'll probably do it as soon as I
need it for a project. Feel free to have a go at it  ;-)

> 7. Export git commits to cvs: What should be exported question become harder
> and harder. Possible I should use some tag and run:
> git-rev-list MY-TAG..master | xargs -n 1 git-cvsexportcommit -vX -cX (by the
> way, why just -v -c does not work ? I must add something to make options
> work)

Strange. The getopts line should look like:

     getopts('hpvc');

(al least it does on my repo) which means that it doesn't expect
parameter _values_. Have you got the same line in the script? Perhaps
your getopts is broken or strange?

> This cycle is a bit of mess. I can write some scripts but I have no idea how
> this is supposed to work !

Well... you have the right idea... and yes it's a bit of a mess.

> The biggest problem - conflict. I should resove them twice, during merging
> origin branch to master and when exporting these changes to cvs. By the way,
> I still can't export merge commit :-)

That's exactly the issue. It's somewhat manual -- because you can't
really automate it 100%. CVS won't know what to do with a merge, so
every time you develop in paralell under git and then merge, you'll
have to fudge things somehow to trick cvs. There's an impedance
mismatch there.

cheers,


martin
