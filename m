From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Sun, 06 Dec 2009 16:05:29 -0800
Message-ID: <7v4oo3ejhy.fsf@alter.siamese.dyndns.org>
References: <4B1C384A.8000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHR6u-0003Qy-5h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124AbZLGAFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 19:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758115AbZLGAFb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:05:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbZLGAFa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 19:05:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 661048551A;
	Sun,  6 Dec 2009 19:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gs7+5gNM5fAk
	COyGsp+mCtGPegY=; b=V4Rz+/x8OiO14dBgMYlAuikiX3x18rU4HQNnLC3YP7Kl
	sBxw0Xm6wLTMfgZN90f/TUUZVdf+bGeot5NVTqt9xooryjGoOTf99HetruzgLsQS
	qHWdPreL92LAUpxyfdMHInJNtMr+I3Wy8JKi6dqY9ubjWGQrxTs7p3eT6NaKnsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a/Oz7i
	ECeG4W6xLFdmqFNCPUYohASleVXOw2Cra34DDiVWcDA0YGNN25h8RlGcdDQcFYBg
	JQnZYk+VcL0jYS+C2is8HoeLIY06ge/b4YODmjRFUdQW11K7JWv6zDHQeuxz40Lf
	55XvTrK02MXbZ8H8UKiEE54tV9DRYizHoc5lU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B88A85519;
	Sun,  6 Dec 2009 19:05:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 623EB85517; Sun,  6 Dec
 2009 19:05:31 -0500 (EST)
In-Reply-To: <4B1C384A.8000106@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Mon\, 07 Dec 2009 00\:03\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D90B0A4-E2C4-11DE-9C97-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134696>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> I have cut out the mention of rsync and the reference from
> git-rm.

I am sorry, but I would like to rescind my earlier comment on the 'rsyn=
c'
issue.  When tracking "vendor code drop", you often need to:

    - untar the version 1 of vendor code drop
    - git init
    - git add -A
    - git commit -m 'vendor #1'
    - git ls-files -z | xargs -0 rm -f ;# remove everything
    - untar the version 1.1
    - git add -A
    - git commit -m 'vendor #1.1'
    ...

and the ability to notice and remove "gone" files while adding anything
new indeed is a very valid and useful thing to have.  The initial "-A" =
can
also be spelled as "git add .", but not the second and subsequent code
drop.

If your vendor tree is online and rsync'able, "untar" in the above
sequence will naturally be replaced with "rsync", and it is entirely
within the scope of SCM.

Regarding "git rm", if people very often need to remove paths from the
index that are already gone from the filesystem, perhaps we would need =
an
option to "rm" to let them do that.

However, if the reason these people want to do such a removal is almost
always because they are accepting a vendor code drop (meaning, they not
only want to remove disappeared paths but also want to add new paths at
the same time), referring to "git add -A" from that manual page would m=
ake
a lot of sense.  So in that sense, I am not against your original patch
per-se, but I think the prerequisite context needs to be explained in t=
he
documentation a bit better.

Here is my attempt.  I didn't check the existing text of "git rm" manua=
l,
so I do not know if its structure to use displayed examples flows
naturally with the existing text; you may need to rewrite to adjust to =
the
existing style.

--

Sometimes people ask how paths that disappeared from the filesystem can=
 be
removed from the index.  A straight answer is

----------------
git diff --name-only --diff-filter=3DD -z | xargs -0 git rm --cached
----------------

but it often is not what these people really want to do (XY problem), a=
nd
there are two alternate answers that may suit their situation better.

1. They may be doing their own development and have removed files from =
the
filesystem using "rm" (not "git rm"), fully intending that they want to
record the removal of these paths in the next commit.  If you make the
next commit with "git commit -a", it will automatically notice these
removals, and there is no need for such a removal they ask in the first
place, as long as they intend to make a full commit.

Asking for "removing all the removed paths from the index" is a sign of
wanting to commit the full state of the work tree, as opposed to "commi=
t
this and that change but not others, which you do not use "commit -a" f=
or.

So the second answer may be "you do not need to in your use case."

2. They may be accepting a new vendor code drop, and have just updated
their work tree by untarring (or rsync'ing).  They not only want to rec=
ord
removal of disappeared paths, but also want to record addition of new
paths, but if they know only "git add" (but not "add -A" or "add -u"), =
it
may appear that a separate "git rm" to remove disappeared paths is need=
ed.
In such a case, instead of doing

----------------
git add .
git diff --name-only --diff-filter=3DD -z | xargs -0 git rm --cached
----------------

they can simply do so with

----------------
git add -A
----------------

Hence the third answer may be "you do not have to in your use case."
