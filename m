From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/10] Add label for common ancestor to
 conflictstyle=diff3
Date: Mon, 15 Mar 2010 02:47:48 -0500
Message-ID: <20100315074748.GA28827@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 08:48:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr51m-0005Jw-6i
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 08:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934551Ab0COHrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 03:47:49 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:62913 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933904Ab0COHrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 03:47:48 -0400
Received: by yxe29 with SMTP id 29so1373804yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tzh6x3Ep+O7rd249hj7LpttxrdHzHke7wwMhpOqDBzA=;
        b=B5KCVv1/kP6baUBKAUN/omg9mPHdh9q1eNhV1XTIK/302m1ChhOKSKEqt7er0IoQKg
         ZtH5A6wgd5naNEab3Q165R+tNvCmzxEU+O5kWQJfhOBo4IunetfWiAkA5KqRuaBTlX4x
         sW4Qr5JFwEOgYd+FdUWi5dcR8JY+hicO3T2Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gVVQk4vTsZ/9X+rwLWuDB5jPGrzPiSt/jl90ctzDZeVDZbq0dgr9aIgOO6Ld6VqJmA
         hEXnDEfi1acFbNj7YZYjpwG3SpiPEAOMPZrnRYKBh59uaa5siDv9P39mNr+Pc2Vys0w9
         hi/r77+VQHRavHFrJ1x8lWAcRXb02C7aDNee4=
Received: by 10.100.20.22 with SMTP id 22mr2182240ant.204.1268639268124;
        Mon, 15 Mar 2010 00:47:48 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4014607iwn.14.2010.03.15.00.47.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 00:47:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100305221950.GB5083@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142176>

Jonathan Nieder wrote:
> Stefan Monnier wrote [1]:

>> I can't live without conflictstyle=3Ddiff3m and I'm very happy it ex=
ists.
>> But it has a little problem: it uses "|||||||\n" as a separator for =
the
>> ancestor version of the text, whereas diff3 uses "||||||| <ancestorn=
ame>\n".
>> The difference is harmless for a human (tho the <ancestorname> can s=
ometimes
>> be useful, assuming it's meaningful), but it makes some tools fail t=
o
>> recognize the conflict markers properly.
>> So please add a " BASE" or " ANCESTOR" after the "|||||||".
>
> No opinion on this myself.

I changed my mind; it looked like a useful and fun thing to do, so
here it is.

The bad news is that sometimes the labels for the ancestor are kind of
pointless, as in =E2=80=9Cmerged common ancestors=E2=80=9D for merge-re=
cursive.  I am
not planning to improve this soon.  I=E2=80=99d be thrilled if someone =
changes
it to something like =E2=80=9Cmerge of ac76d, 8d7ca9, and 81873=E2=80=9D=
=2E

This patch series adds a label for the common ancestor to various
places git outputs conflict hunks:

 <<<<<<< ours
 Text from the current branch
 ||||||| original
 Text from the merge base
 =3D=3D=3D=3D=3D=3D=3D
 Text from the remote branch
 >>>>>>> theirs

I am hoping this output will be more self explanatory, especially in
cases where it is not completely obvious to a na=C3=AFve user what the
common ancestor would be, such as cherry-pick.

This passes all tests here and I tried to find any untested in-tree
consumers of conflict hunks that would be affected to make sure it
would be safe.  I would like to see it get some testing on other
machines, especially by people using merge tools and other programs
that parse conflicts.

Thoughts?
Jonathan Nieder (10):
  xdl_merge(): add optional ancestor label to diff3-style output
  merge-file --diff3: add a label for ancestor
  ll_merge(): add ancestor label parameter for diff3-style output
  checkout --conflict=3Ddiff3: add a label for ancestor
  merge_file(): add comment explaining behavior wrt conflict style
  merge_trees(): add ancestor label parameter for diff3-style output
  tests: document format of conflicts from checkout -m
  checkout -m --conflict=3Ddiff3: add a label for ancestor
  cherry-pick: add a label for ancestor
  merge-recursive: add a label for ancestor

 builtin/checkout.c    |    3 +-
 builtin/merge-file.c  |    1 +
 builtin/revert.c      |    1 +
 ll-merge.c            |   20 ++++++++------
 ll-merge.h            |    2 +-
 merge-file.c          |    8 +++++-
 merge-recursive.c     |   12 ++++++--
 merge-recursive.h     |    1 +
 rerere.c              |    4 +-
 t/t6023-merge-file.sh |    2 +-
 t/t7201-co.sh         |   69 +++++++++++++++++++++++++++++++++++++++++=
+++----
 xdiff/xdiff.h         |    1 +
 xdiff/xmerge.c        |   16 ++++++++++-
 13 files changed, 114 insertions(+), 26 deletions(-)

[1] http://bugs.debian.org/572720
