From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Wed, 28 Oct 2009 12:00:59 -0400
Message-ID: <32541b130910280900p421e69b1nbcd8dcfa211521ac@mail.gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com> 
	<32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com> 
	<AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com> <32541b130910272220p59482397wef0d51b1adf1a5bd@mail.gmail.com> 
	<19979334-07EB-48CA-8E62-4ECC5E1FA51C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:02:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AyF-0001vp-HF
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 17:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZJ1QBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZJ1QBR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 12:01:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:6944 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZJ1QBQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 12:01:16 -0400
Received: by qw-out-2122.google.com with SMTP id 9so254776qwb.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=J7EF8N/YPC14njCZsNsJlEj0Cge6KrD/Q6Oc2QUtLgg=;
        b=nkVR9Zm+pBHr2bpwm22+KiOqFdVWvNr66YVMNZqf8AtbMVSGXid+tKRGa/nEbzyh2U
         m+QlN2x4rPTcBw3FJj4/7J37SaODRWlvZWYcCtOVqMAVTdyLS7yIcbo7WdCMAQWEEdVR
         PTZvigoCGyOmqhY1qRcENePnvln2HvruzNevQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KUrv4VL5/eD+wsX1UIe5TgbHNBc3af2KqoYwY0ERsv0X912GuBbEAdUuZe8/vWl1dJ
         Ao8AhdMp09qSRpiTkvc15FoPM5Cz+Ew4bI5n1Pk00OY76UfmPgeLgICkS+wIv2BgHW00
         2LkvkpogCvIdFdn3lUAMLM5fyJrSmqvHCY6vI=
Received: by 10.150.254.3 with SMTP id b3mr29369955ybi.161.1256745680467; Wed, 
	28 Oct 2009 09:01:20 -0700 (PDT)
In-Reply-To: <19979334-07EB-48CA-8E62-4ECC5E1FA51C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131477>

On Wed, Oct 28, 2009 at 1:59 AM, Lachlan Deck <lachlan.deck@gmail.com> =
wrote:
> On 28/10/2009, at 4:20 PM, Avery Pennarun wrote:
>> So which are the files you don't want to import from trunk? =A0It
>> doesn't sound like there are any... so it's getting simpler already.
>
> There are. I've currently (as a workaround) done the following within=
 the
> main branch:
> add the following to .git/info/exclude
> .settings
> target
> .classpath
> .project
>
> The last two of these has no effect of course because .project and
> .classpath files already exist -- and thus are marked as modified. So=
 I'm
> currently doing a git stash && git svn rebase && git svn dcommit && g=
it
> stash pop
>
> I'm also wanting to exclude 'lib' folders from trunk (as these are no=
t
> needed).

The problem is that as your branch diverges from what you *actually*
want to commit, it becomes exponentially more complicated to figure
out what you *do* want to commit.

Note that if you're planning to share your git project with other
people anyway, then you have an additional problem: you're using git
svn rebase, which is almost useless for sharing with other people
(other than through svn, of course), for the same reason any git
rebase is.

One option you have is to maintain two branches:

1. (git-svn) The git-svn trunk, which contains only stuff you want upst=
ream

2. (master) Your live branch, which contains everything from (1) plus
your local customizations.

When you want to fetch from svn, you do this:

  git checkout master
  git svn fetch git-svn
  git merge git-svn

When you want to push to svn, you do this:

  git checkout git-svn
  git merge --squash --no-commit master
    (now undo your local customizations)
  git commit
  git svn dcommit
  git checkout master
  git merge git-svn

Note that master never gets rebased, only merged.  If you can write a
simple script for "undo your local customizations" - such as reverting
a particular commit, for example - then you can put the above in a
shell script and it should work fine most of the time.

Good luck.

Avery
