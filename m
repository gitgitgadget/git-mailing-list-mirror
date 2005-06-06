From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Modify git-rev-list ... in merge order [ repost with bug fixes ]
Date: Mon, 6 Jun 2005 11:09:42 +1000
Message-ID: <2cfc4032050605180958fcf395@mail.gmail.com>
References: <20050605134733.3123.qmail@blackcubes.dyndns.org>
	 <Pine.LNX.4.58.0506051741190.1876@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 03:06:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df64L-0002fE-4W
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 03:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFBJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 21:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFFBJw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 21:09:52 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:12348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261152AbVFFBJn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 21:09:43 -0400
Received: by rproxy.gmail.com with SMTP id i8so1744611rne
        for <git@vger.kernel.org>; Sun, 05 Jun 2005 18:09:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLn51kvTV0zIC6a/yK8SRjNf9lsmW0iNOHElWbm7Yr22ul1KuP5oloNp5kjyszqquS+VYLzI6XKV3CFsoDP2/qrIqH0vOAKOGYMB28m2az7Bag1c3Xjv/PdxZ8mzoWJW57YDstG1zDPGqR3Z+lplF8tuCTkk/0f0u4g+1hbGh8c=
Received: by 10.38.78.59 with SMTP id a59mr2116530rnb;
        Sun, 05 Jun 2005 18:09:42 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 5 Jun 2005 18:09:42 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506051741190.1876@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Sun, 5 Jun 2005 jon@blackcubes.dyndns.org wrote:
> >
> > -static void show_commit(struct commit *commit)
> > +static int show_commit(struct commit *commit)
> 
> Ick. You've mixed "show_commit()" to be three totally independent things
>  - deciding whether to show at all
>  - showing the commit in traditional format
>  - showing the commit tree in the new "break" format
> 
> I really hate functions that do totally unrelated things, and I'm so much
> happier with the new show_commit() than the old "everything in one big
> function" thing, that I'm unhappy about mixing the thing up again.
> 
> Please leave show_commit() to just show the commit, and make the other
> decisions be independent of that.

My rationale was to re-use both the filtering logic currently in the
show_commit_list while loop and the display logic, since I need both
in order to maximise compatibility with the standard algorithm.

However, I understand your concerns.

My plan, therefore, is to split the filtering logic from
show_commit_list's while loop into a separate function and create a
third function which calls the filtering logic, then show_commit. I'll
pass a pointer to the third function to sort_list_in_merge_order. I
can leave the show_breaks functionality in show_commit (it is, after
all, display functionality) or I can move it into the third function.

Is that ok by you?

jon.
