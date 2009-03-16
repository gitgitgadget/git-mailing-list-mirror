From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: fetch and pull
Date: Mon, 16 Mar 2009 18:14:48 -0400
Message-ID: <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
	 <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjL6j-00019k-Ex
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbZCPWOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbZCPWOv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:14:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:25372 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbZCPWOu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 18:14:50 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1795360rvb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r+OgQNAmO6SqBPLr5mRnMYgazlmMvLRcnkw7bjbITjI=;
        b=Sk7Z0OYnp95VblLQIaufOvlufN6gpgJMjE7F2ZI+8SlmN0GsXJrO5XSI9Z9MUIAMLa
         6vlQVpwiq8TOzccpE/mQOHSjGGqthI5hfRN4LOXUaGrWxiK9pH6TfgWY4KVTASp2UqCS
         RkWUH2Dyp9ETWX/rJGRhE5MhW7lWHcjM1B1TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H0AGwg7q5N/9wtCwAJdFjAHEPqMqZr8mv+MUQ11i6ckE2Sxtw+xEJ+ItL9AKKduIYn
         thTqwJq7bsB47Q/UMFoc/VDJabD0PniPhwBlUpQXeibI6EljKxjjfKXqdslWgNtahoc6
         xOl2hxCQxtk+WuInCJ97/3v1vqJTWmxcUoQTA=
Received: by 10.141.196.8 with SMTP id y8mr2539550rvp.101.1237241688742; Mon, 
	16 Mar 2009 15:14:48 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113394>

On Mon, Mar 16, 2009 at 4:39 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> Yes, I do. =C2=A0If the central repository changed dev in some way ot=
her than a fast-forward, or if you really messed up your local dev, it =
still needs to be repointed.
>
> Remember the overall flow: =C2=A0first fetch (not pull) and then insp=
ect the difference between your dev and origin/dev. =C2=A0Then, change =
your dev to match.

Let me illustrate why this is still probably wrong. I have a clone of
git://git.kernel.org/pub/scm/git/git.git. It has the following remote
tracking branches:

$ git branch -r
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo

origin/master is never reset. origin/pu resets often. When I want to
work on git, I typically create a branch from origin/master. In this
case, I would almost never want to reset that branch. So I'd typically
do:

$ git checkout -b topic origin/master
$ edit, commit, edit, commit...
$ git fetch
$ git log origin/master..topic
$ git rebase origin/master

Rarely, I'll base a topic on origin/pu. And origin/pu might get reset.
But even if it were, I wouldn't want to blindly reset my local branch
to match, thus losing my local changes. Instead I'd do this:

$ git checkout -b pu-topic origin/pu
$ git tag pu-topic-base # handy when origin/pu is reset
$ edit, commit, edit, commit
$ git fetch
drat, origin/pu was reset
$ git rebase --onto origin/pu pu-topic-base

And in the rare circumstance that I really do want to reset a local
branch, I'd do this:

$ git checkout dev
examine, make sure I really want to reset
$ git reset --hard origin/dev

I can't really think of a good reason I'd want to reset a local branch
which I haven't checked out.

j.
