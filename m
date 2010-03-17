From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/16] Add label for common ancestor to
 conflictstyle=diff3
Date: Wed, 17 Mar 2010 06:36:55 -0500
Message-ID: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 12:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrYH-0000S7-2V
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 12:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0CQLgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 07:36:36 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62118 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab0CQLgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 07:36:35 -0400
Received: by qyk9 with SMTP id 9so488666qyk.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=JyrFMY0j4CIW5X7yYrC0ZMfZzn5idx+rgeAnbYRSD6I=;
        b=UYhRL9sPsop/4bRd8fArEu2cwCKqdG/EfTDqKEA/BhOm0v0w3CSViASeyaD1WT3bil
         6RF0Yry/kROrPUendN/3FhM/+PcQXXrfDNwVkJQOEwr3ZRl61zPeJFLJy0T9w7Lpsx8d
         hGF/WmPInInzXo8596LzQnDcn0v/tWb+s5Gq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=lLq+VYTtfsM9DnlHSfcCzad3fgGCON8TF0jjb7TpzGdBdc8X3bt5exbOlbPbPndVMV
         D+dGz07pp927SvPIjImxNN/NkxxytkzChJRyisnMJdMWvCB2Uw0L57QGo5g8kiZNnnB+
         Qs/vGZ3sSHYNvDWKSQmlrnQIA4HtFQ8HNeQ5g=
Received: by 10.224.72.228 with SMTP id n36mr199676qaj.138.1268825793710;
        Wed, 17 Mar 2010 04:36:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6356517iwn.9.2010.03.17.04.36.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 04:36:32 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142374>

Hi all,

This is a more polished version of a series I sent a couple of days
ago [1].  Thanks to Junio for some helpful advice.

The purpose: When outputting diff3-style conflict hunks, this patch
series adds a label for the common ancestor (like diff3 -m would):

 <<<<<<< ours
 Text from the current branch
 ||||||| base
 Text from the merge base
 =3D=3D=3D=3D=3D=3D=3D
 Text from the remote branch
 >>>>>>> theirs

Apparently, without this label, smerge-mode.el found in emacs 22 and
later has trouble parsing the conflict hunks created by git with
merge.conflictstyle=3Ddiff3.  More importantly, humans can sometimes us=
e a
reminder of what the ancestor represents, especially in cases like
cherry-pick and revert.

As before, the bad news is that sometimes the labels for the ancestor
are kind of pointless, as in =E2=80=9Cmerged common ancestors=E2=80=9D =
for
merge-recursive.  I am not planning to improve this.  I=E2=80=99d be th=
rilled if
someone changes it to something like =E2=80=9Cmerge of ac76d, 8d7ca9, a=
nd
81873=E2=80=9D.

The good news is a couple of new tests thrown in.  All the other change=
s
I can remember are detailed in the comments after each patch (probably
missing some, since I haven=E2=80=99t started using git notes for this)=
=2E

I think the series is ready to receive wider exposure.  Please let me
know if you run into any problems when trying it out.  I would also be
glad to hear thoughts about the details of its behavior and
implementation.

The series is based against master.  There are a few small conflicts
with next, but nothing major; I=E2=80=99ll point out the few that I rem=
ember
as I go.

Enjoy,
Jonathan Nieder (16):
  xdl_merge(): add optional ancestor label to diff3-style output
  xdl_merge(): move file1 and file2 labels to xmparam structure
  merge-file --diff3: add a label for ancestor
  ll_merge(): add ancestor label parameter for diff3-style output
  checkout --conflict=3Ddiff3: add a label for ancestor
  merge_file(): add comment explaining behavior wrt conflict style
  merge_trees(): add ancestor label parameter for diff3-style output
  tests: document format of conflicts from checkout -m
  checkout -m --conflict=3Ddiff3: add a label for ancestor
  tests: document cherry-pick behavior in face of conflicts
  revert_or_cherry_pick(): get oneline_body from get_oneline()
  compat: add mempcpy()
  revert: simplify get_oneline() using mempcpy
  revert: clarify label on conflict hunks
  cherry-pick: add a label for ancestor
  merge-recursive: add a label for ancestor

 builtin/checkout.c              |    3 +-
 builtin/merge-file.c            |    7 +-
 builtin/revert.c                |   33 ++++---
 git-compat-util.h               |    9 ++
 ll-merge.c                      |   28 +++---
 ll-merge.h                      |    2 +-
 merge-file.c                    |    8 ++-
 merge-recursive.c               |   12 ++-
 merge-recursive.h               |    1 +
 rerere.c                        |    4 +-
 t/t3507-cherry-pick-conflict.sh |  198 +++++++++++++++++++++++++++++++=
++++++++
 t/t6023-merge-file.sh           |    2 +-
 t/t7201-co.sh                   |   69 ++++++++++++-
 xdiff/xdiff.h                   |    6 +-
 xdiff/xmerge.c                  |   29 ++++--
 15 files changed, 358 insertions(+), 53 deletions(-)
 create mode 100644 t/t3507-cherry-pick-conflict.sh

[1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/68077=
8/focus=3D142176
