From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Re: git clone combined with --depth, --branch and --single-branch
Date: Sun, 17 Feb 2013 18:46:31 +0100
Message-ID: <CAByu6UWw-6ssEug-Fm1t7_L2jVuC-KMh-NC=kzxfum=r6X5VcQ@mail.gmail.com>
References: <CAByu6UWNZLrtwo+FUeq2OELoX3jo1Qng9amko36JGa5pq+y11A@mail.gmail.com>
	<CACsJy8C5G7yy=KDtdsE-9aYTdSEO3v=-25WKtGnLALshXnE+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U78KI-0001xQ-6y
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 18:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3BQRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 12:46:33 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:45198 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3BQRqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 12:46:33 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so5234740oag.17
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=deid55jS934hojr3sLebaqn/YsE+V0jsfSHyJqD+OYo=;
        b=QQ2GZSYD3H3lpTn0GOcFqTae+oaAcTStVVL4pleFUn4NeAgYPztFPDHoJDk2SARIIc
         +FOAIlhWfPR9mPLy+DvAiZusXkL6impjLu72Mvj8gu443+WhB+FDeSJfo4xqLGe5yuAa
         89iIdiGIOrxoOkLMDOIK6p25fCp8aEsuWAjAWYHtVlgYAPL+bgwj+yggDSBMWp2QtH38
         3NgG0IIzp8qjDFCksByU8d5JpFZnaMsQsWmxb+0V3GAGw3FKBHEYcK0QGWx6b9rTQIGa
         sUS0A6xxyYRx0hLnG54PoStta3LNkBur2AH1aqgb92SthxEiO6yjfYj5ccaxKoKptsxQ
         67Vw==
X-Received: by 10.182.151.9 with SMTP id um9mr4937774obb.89.1361123191427;
 Sun, 17 Feb 2013 09:46:31 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Sun, 17 Feb 2013 09:46:31 -0800 (PST)
In-Reply-To: <CACsJy8C5G7yy=KDtdsE-9aYTdSEO3v=-25WKtGnLALshXnE+uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216400>

Hi Duy,

On Sun, Feb 17, 2013 at 3:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Feb 17, 2013 at 7:29 PM, Thibault Kruse
> <tibokruse@googlemail.com> wrote:
>> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
>> * 4565162-5  (foo)
>> * 20ce846-4
>> * a0615eb-3
>> * fa4131d-2
>> * f0683bd-1  (bar)
>> | * 432b5ec-m1  (HEAD, master)
>> |/
>> * 39df203-0
>>
>> git clone repo1 repo2 --depth 1
>> cd repo2
>> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
>> * 432b5ec-m1  (HEAD, origin/master, origin/HEAD, master)
>> * 39df203-0
>>
>> # Why are branches "foo" and "bar" missing?
>
> --depth implies --single-branch. Without explicit --branch,
> --single-branch will fetch HEAD. You need --no-single-branch to get
> foo and bar.

Agreed, sorry. I forgot that --depth implied --single-branch. Probably
because it don't like that being a default that breaks behavior to
versions that did not have the --single-branch feature.
So this example is the only one which I agree does actually what can
be expected from the documentation (with respect to branches. --depth
also does not restrict the history length, but the example does not
show it).

>> cd ..
>> git clone repo1 repo3 --depth 1 --branch foo
>> git log --pretty=format:'%h-%s %d' --graph --decorate  --all
>> * 4565162-5  (HEAD, origin/foo, foo)
>> * 20ce846-4
>> * a0615eb-3
>> * fa4131d-2
>> * f0683bd-1
>> | * 432b5ec-m1  (origin/master, origin/HEAD)
>> |/
>> * 39df203-0
>>
>> # Why is --depth not having effect, and why is branch bar not there,
>> yet master is?
>
> I'm not sure, but I can't reproduce it.

Do you mean you cannot reproduce with 1.7.10.4?


So far I used ubuntu packaged versions, Here is what I got with master:
git --version
git version 1.8.1.3.619.g7b6e784
# added commit m2 and m3 to master branch in repo1 to show that
--depth is not working locally
git clone repo1 repo2 --depth 1
git log --pretty=format:'%h-%s %d' --graph --decorate  --all
* 704f0c4-m3  (HEAD, origin/master, origin/HEAD, master)
* 7b90b28-m2
* 1fa92bd-m1
* 5da3517-0

So I still get the --depth not having affect locally, but I confirm
all other cases I posted work as expected with 1.8.1.3.619.g7b6e784.
Meaning --depth works from a remote repo, and --single-branch (implied
by depth) really just creates that branch locally.

I don't even know where to start looking for why --depth has no effect
for disk-local remotes.
I don't have the git command aliased, and in repo1, I get:
alias.br=branch
alias.co=checkout
alias.ci=commit
alias.di=diff
alias.st=status
alias.mt=mergetool
alias.pr=pull --rebase
alias.ri=rebase --interactive
alias.sa=stash apply
alias.c-p=cherry-pick
alias.lg=!git log --pretty=format:%h%x09%an%x09%ad%x09%s
alias.lgg=log --graph --pretty=format:'%Cred%h%Creset
-%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
--abbrev-commit --date=relative
alias.top=!eval cd $(pwd)/$(git rev-parse --show-cdup) && pwd
core.excludesfile=/home/kruset/.bashconfig/gitignore.global
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true

Not sure whether any of the "core" properties can cause this.
