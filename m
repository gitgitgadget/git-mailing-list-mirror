From: Kevin <ikke@ikke.info>
Subject: Re: [bug report, possibly] Multiple pushes with passwords in URL
Date: Mon, 2 Jul 2012 09:17:32 +0200
Message-ID: <CAO54GHCS+KYeUYjK5oStJpi_Ztw5bXduCUqWecoi-QzDEFjG8g@mail.gmail.com>
References: <CAJQBtg=yg_T=Vfq--9oivbbK86bxqLONTOBSRA+wSp2iiHGaTA@mail.gmail.com>
 <CAJQBtg=-drwKEU2iSDeUWZPbO+OENNL-rDMoy6XYPrnzFV1VyQ@mail.gmail.com> <CAJQBtg=XN1Txsp8Q3C=GgxyZQvCK3vAJouJkXfZgwtG9hvuubw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Left Right <olegsivokon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 09:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlatS-0006mX-R1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 09:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab2GBHRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 03:17:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51173 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2GBHRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 03:17:53 -0400
Received: by wgbdr13 with SMTP id dr13so4939524wgb.1
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=pmdiJKLgkr7L4RfrDv9QowGIOZp3OnQV3AKw5tAVwRQ=;
        b=sZV7DySy4fbWwJ6X8+HrMtChr6UKTqWBYxhsk3YMqtVmC3wAkA4ulCzdouHoY8gexg
         gu2+VrPsPz/4RWhtcQGCUFnSyd3+NAE3S/B4Hfn2A/lHnxfIGC1XLWHyzb16hBb/02se
         solfFJcaW5MCEIguUc+VaCQTOd7chjTyCfqWfaZ4ShUAoT3ug2/uHmol9bRHh68BrR79
         dDgjfKM2kg1VsIYNRX644314OZZvBOilMMcmmfAGyA85Tf5d5hP/xBKRFVrkv4N9N/pE
         ZGqrctU4EHr88C5xsRHdDhl4+5y8QMeH+YW3qOrKCu4404PptEQ7nMNaHXoa7rIfnChw
         eHAw==
Received: by 10.180.109.129 with SMTP id hs1mr14424683wib.0.1341213472587;
 Mon, 02 Jul 2012 00:17:52 -0700 (PDT)
Received: by 10.227.42.148 with HTTP; Mon, 2 Jul 2012 00:17:32 -0700 (PDT)
In-Reply-To: <CAJQBtg=XN1Txsp8Q3C=GgxyZQvCK3vAJouJkXfZgwtG9hvuubw@mail.gmail.com>
X-Google-Sender-Auth: BFS0YgvETHdiOq8cihzrvb_Z6Zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200847>

Hi,

First, this is the right place for reporting bugs.

I don't know why it's using the credentials for the first remote. But I know
that recent versions of git ship a credentials[1] helper that can ask a wallet
or keychain for credentials, so you don't have to store them in the git
config.

Kevin


[1]: http://git-scm.com/docs/gitcredentials

On Tue, Jun 26, 2012 at 8:43 PM, Left Right <olegsivokon@gmail.com> wrote:
> Hello list,
> I didn't find a bug tracker and some comments on StackOverflow
> suggested I should post to the mailing list... please excuse me if I
> followed the wrong info, it's not really easy to find your bug
> tracker, if there is one.
>
> I've came across this behavior trying to organize my repository to
> push updates to several remote repositories. Here's what I did:
>
> in .git/conf
>
> [core]
> repositoryformatversion = 0
> filemode = true
> bare = false
> logallrefupdates = true
>
> [remote "github"]
>         fetch = +refs/heads/*:refs/remotes/origin/*
> url = https://username1:password1@github.com/some.git
>
> [remote "googlecode"]
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         url = https://username2:password2@code.google.com/p/some/
>
> [remote "origin"]
> url = https://username1:password1@github.com/some.git
> #        url = https://username2:password2@code.google.com/p/some/
>
> [remote "all"]
> url = https://username1:password1@github.com/some.git
>         url = https://username2:password2@code.google.com/p/some/
> [branch "master"]
> remote = origin
> merge = refs/heads/master
>
> Now, what happens if I try to push origin master:
> the commit is sent to the first origin with the credential specified
> in the first URL, but then the request to second URL is sent with the
> credentials from the first URL. I tried switching them, and the result
> is the same. I tried separate push'es to both repositories and it
> works fine. I thought there might be something particular about
> "origin" and tried moving the list of URLs to "all" - with the exact
> same results.
>
> This is kind of frustrating... but this is also a tiny security threat
> as you are basically sending the credentials of the users they used at
> one site to another... w/o any notice or warning.
>
> That aside, I would be very happy to find some way to save passwords
> in some... well... more secure format. Like on the keyring, for
> example... .netrc is out of question though because of duplicating
> user names :(
>
> Best.
>
> Oleg
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
