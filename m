From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 12:55:58 +0200
Message-ID: <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVhi-0005ZV-05
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZIOK4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 06:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbZIOK4A
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:56:00 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49607 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZIOKz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 06:55:59 -0400
Received: by ewy2 with SMTP id 2so330555ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=asgltPPOQ3oXtRoF++YiTHKxpZ2tmjJjCPZyTDitvPg=;
        b=nP48dEN0ZnLUmVcyWfhHBLbX6uCDEkmulBK0clwtRGG+Oh0pSl32rpHMXIxaMEHF9z
         kCePSwRJI4UNGRMEQYnJzQ9TxVHiW/wG+J3WP29alSgeu3fBMGqW6t5w45OgubyJvff7
         DhSDgbluAKbWV16gkry6bwfKtXZeL3wHmGqyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Suo27zukHC3QtNHQWfW7nruiRwy5NB2jBmfJlW021L3h6YXlDTxPbniLMzhwoof/d8
         /ROVHLtUDtzkZ1HAug25PaMNbHFqxfJjuPOn201BoN3wxe5dGIs13aHfocGBwCrXgl1x
         J2QtvGPAyHAU+bF9VcjsOIuxfr3ZvDCmxax/8=
Received: by 10.210.154.20 with SMTP id b20mr676651ebe.29.1253012158380; Tue, 
	15 Sep 2009 03:55:58 -0700 (PDT)
In-Reply-To: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128526>

On Tue, Sep 15, 2009 at 12:31 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I am resurrecting a discussion from a week or two back (been on
> holiday). =A0As follows...
>
> I had made some changes to some files and then done a commit. Only
> then did I realise that I had the wrong branch checked out. To make
> matters worse I then did a 'git reset HEAD^' which means that I can
> now no longer switch branches. I am stuck. I had some advice (thanks!=
)
> but it was not complete. I'd appreciate some more help.

Hi Howard,

just to make sure I understand your issue

  1 - you were on branch X, thinking your were on branch Y
  2 - edit, diff, commit, realised the mistake
  3 - git reset HEAD^

so if you now run `git status` and `git diff` it will show your
changes as if they were uncommitted and unstaged.

(Before you start with various attempts to recover below, a great
trick is to make an instant-backup in case things go wrong: cd .. / ;
cp -pr moodle.git moodle-backup.git ; cd moodle.git )

You can now try do do

  4 - git checkout Y

and if the changes are on files that don't change between X and Y,
then git will change the branches and keep your changes there. If the
files are different between X and Y, it won't work.

What I can recommend is to save your patch, as follows

  5 - git diff > tempchanges.patch
  6 - git reset --hard # this will discard your changes, careful
  7 - git checkout Y
  8 - patch -p1 < tempchanges.patch

The patch may not apply cleanly :-) -- note that patch is more
tolerant of iffy merges than git's internal implementation ("git
apply") -- so it will succeed more often... but the results need
review.

There is a more git-style approach that is to use git-stash -- it uses
git-apply and may not do what you want. The steps are

 5a - git stash # will save your changed files into a "stashed commit"
and clear out the changes from your working copy
 6a - git checkout Y
 7a - git stash apply

hth,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
