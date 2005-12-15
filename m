From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 16:14:59 +0100
Message-ID: <81b0412b0512150714t293c29fav6cddc1c74ee4a6b3@mail.gmail.com>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	 <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
	 <7vu0daphmf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 16:18:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emup3-000196-8g
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 16:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLOPPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 10:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLOPPE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 10:15:04 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:2547 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbVLOPPC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 10:15:02 -0500
Received: by nproxy.gmail.com with SMTP id m18so129529nfc
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 07:15:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uf79VAwLrb3P5QYDoojMPxrm/oBKDkrt6ImeEIa5Lb5l3MOzW7hsnuhwIoPnIl5gnGLLJn4TgZfCQIZ5KrlR3ynxfIB1nAq3oFUiEg2m2bgK+X4j5Rk6SVT1TzMEPO7PogQXmZbZ18Xtb9lSD4/gQOHEirwFYobc3OCIzym5G44=
Received: by 10.48.254.11 with SMTP id b11mr92183nfi;
        Thu, 15 Dec 2005 07:14:59 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 07:14:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0daphmf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13698>

On 12/15/05, Junio C Hamano <junkio@cox.net> wrote:
> >> I think the reason why my trial here worked correctly while you
> >> had trouble with it is because I have the send-pack fix from
> >> Pasky last night.
> >
> > yes, probably. It cleanups a reference if there was an error, right?
>
> Not really.  send-pack does not have anything to do with this
> (it is involved in git-push not git-pull).  Care to see how
> yours gets broken when you do "sh -x git-pull.sh . ref1 HEAD"?

I tried. Interesting: no refs/heads/HEAD. But, then I tried "ref1:HEAD":

broken-HEAD /d/download/git2 [822]
PATH=".:$PATH" sh -x git-pull . lf-usage:HEAD
+ . git-sh-setup
++ unset CDPATH
++ : .git
++ : .git/objects
++ GIT_DIR=.git
++ git-var GIT_AUTHOR_IDENT
+ strategy_args=
+ no_summary=
+ no_commit=
+ break
++ git-rev-parse --verify HEAD
+ orig_head=5a0b59da20d832fcfdf864b522718acbc2171525
+ git-fetch --update-head-ok . lf-usage:HEAD
* refs/heads/HEAD: storing branch 'lf-usage' of .
++ git-rev-parse --verify HEAD
git-rev-parse: fatal: Needed a single revision
+ curr_head=
+ test '' '!=' 5a0b59da20d832fcfdf864b522718acbc2171525
+ echo 'Warning: fetch updated the current branch head.'
Warning: fetch updated the current branch head.
+ echo 'Warning: fast forwarding your working tree.'
Warning: fast forwarding your working tree.
+ git-read-tree -u -m 5a0b59da20d832fcfdf864b522718acbc2171525 ''
usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
+ die 'You need to first update your working tree.'
+ echo 'You need to first update your working tree.'
You need to first update your working tree.
+ exit 1

And of course, there was refs/heads/HEAD now.
So it seems that I _had_ typed it with a colon (though I'm very sure I
did it with a space as well). Sorry for the whole confusion, but that
reveals that other problem, which Johannes' patch partially helps
with.
