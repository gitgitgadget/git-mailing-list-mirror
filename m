From: =?iso-8859-1?Q?David_R=F6thlisberger?= <david@rothlis.net>
Subject: "git log --simplify-by-decoration" but including branch & merge points
Date: Fri, 23 Sep 2011 22:20:11 +0100
Message-ID: <EEB5CA46-D4FB-4B59-BDAF-36AE9BCC1D1E@rothlis.net>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 23:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7DAW-0003Fk-K7
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 23:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab1IWVUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 17:20:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47593 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab1IWVUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 17:20:15 -0400
Received: by wyg34 with SMTP id 34so4347423wyg.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=0xvqp9T9skQYueouVz4ksV+vesuB01qLKwSFaUjnLJI=;
        b=HMtCYTcfMz1cK5tJfEqbOGuLsdioXmh1wuy1x/HjwaWMULLbG+GF946aoag+srjxNV
         CBzGYInps9A3ZYYMDeS+sRZRhwGcqCX+rpV/zmkbZpf6dBAoaytLSSgsdQBmI5fvmmne
         oFz6JIVcf7AdFtsjI1AWmy8B53Dt9vWsRUI5Y=
Received: by 10.227.2.206 with SMTP id 14mr3973278wbk.94.1316812814840;
        Fri, 23 Sep 2011 14:20:14 -0700 (PDT)
Received: from [192.168.1.100] (94-194-137-39.zone8.bethere.co.uk. [94.194.137.39])
        by mx.google.com with ESMTPS id en9sm18212052wbb.24.2011.09.23.14.20.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 14:20:13 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182002>

Hi,

I'd like something like "git log --simplify-by-decoration" that also in=
cludes the commit that a branch was branched *from*. I find this useful=
 to understanding the relationships between branches.

=46or example, for the following repository with 2 branches "master" an=
d "branch":

    git log --graph --all --pretty=3D"format:%d %s"
    *  (branch) b
    *  a
    | *  (master) 4
    | *  3
    |/ =20
    *  2
    *  1

I would like a way to hide commits "a" and "3" (like --simplify-by-deco=
ration) but to *include* commit "2" (unlike --simplify-by-decoration) b=
ecause it shows me the crucial information of *when* "branch" and "mast=
er" started to diverge. Ideally I would also like to see merge commits.

In summary:=20
* Show any commit referred to by some branch or tag (as with --simplify=
-by-decoration),
* or with more than one parent (merges),=20
* or with more than one child, as long as at least 2 children are reach=
able from the commits you've specified (this is to include branch-point=
s of any branches you are interested in, but to exclude branches you do=
n't care about. It's probably impossible to get this criteria absolutel=
y perfect, but better to include some additional commits than to exclud=
e ones I want to see).

I don't think this is currently possible. What would be the best way to=
 achieve it? Maybe a new flag to git-log, to be used together with --si=
mplify-by-decoration? I am willing to work on a patch for this if peopl=
e agree that it would be useful and likely to be accepted.

In general, when providing several commit-limiting and history-simplifi=
cation parameters to git-log, should they be ANDed or ORed together? Fo=
r example "git log --merges --simplify-by-decoration" doesn't seem to p=
rovide any useful output; would it makes sense to change this to mean "=
show anything that simplify-by-decoration would show, but also show mer=
ge commits"?

Thanks,
David R=F6thlisberger.
