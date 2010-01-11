From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Sun, 10 Jan 2010 20:13:22 -0600
Message-ID: <20100111021322.GA8480@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 03:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9nE-00039f-KK
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 03:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab0AKCN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 21:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169Ab0AKCN1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 21:13:27 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:57942 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0AKCN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 21:13:27 -0500
Received: by gxk3 with SMTP id 3so9990987gxk.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 18:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rBCNjiNnwXEWNs5fjy8REFp2QWbBRaDkXVBwDWKOfSA=;
        b=sdZhv0XKtMVJShmeRo6AFwuUVaorHFYuyysFojZ/3/t8KZgX6IRckIjpgBrdzOxp4Z
         sxEs5RX+Ti7lWJTG6JhLzLngONNe+hxJL9lTKE2vxGpWHWC5Hzy2cOyRTdReWSX7N8g9
         BSEtGjG3COWNdodxznu4C2qJamJeqBfV7/DRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Fc1CKOfTDIsjSy+Jxi6Vut1YLqlL3heD+/bbyK7DYSG4WEwNhoeMCFF77ih4uB/4oI
         PbhApRNR6TNC1yZ1OFbyzHYgLKqT0rw6+kfEeWfPS3soVRJ4Q5lxjB+4wdHv9pCnkCRP
         scSmq11Ai6ZIm/7qLdDUPL3HC0am4SWkZKEqA=
Received: by 10.101.187.18 with SMTP id o18mr4086814anp.8.1263176006143;
        Sun, 10 Jan 2010 18:13:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1494259iwn.11.2010.01.10.18.13.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 18:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vskaefp2v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136598>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Oh, that is a problem.  Maybe 'git merge' should refuse to merge
>> unless told otherwise, if there is a dirty index and there might be
>> conflicts.
>
> "git reset --merge" will keep your local changes after such a merge, =
and
> "mergy" operations (not just "merge" but also "revert", "am -3", etc)
> won't get you into a situation where you cannot, by refusing to do
> anything when e.g. your index is dirty.  Especially when Christian's
> "reset --merge" update becomes solid, "... is hard to back out of" wi=
ll
> become a false statement.

Here is a scenario I worry about:

Suppose I have a change to main.c staged, to add a feature that others
have discussed as well.  After a short distraction, I return and run
=E2=80=98git pull=E2=80=99 to see what upstream has been working on.  A=
s luck would
have it, the remote version of main.c is exactly the same as my
modified version, so the merge happily proceeds.  Some other files
merge cleanly.  Eventually there is some conflict.

Now I regret the pull.  Will =E2=80=98reset --merge=E2=80=99 restore th=
e index and
work tree to its original state?

If the change to main.c was _not_ staged, then the merge would have
failed early, so that is not something to worry about.

> Of course, the user needs to understand what he or she is doing (see
> http://thread.gmane.org/gmane.comp.version-control.git/136166/focus=3D=
136171
> for example).

Agreed.  And probably the user who understands what is going on will
not make the mistake I described above.  Otherwise, they could succumb
to a related problem:

Suppose all is as above, except that git detects no conflict.  Suppose
further that some upstream commit was bogus.

Now I regret the pull.  How can I restore the index and work tree to
its original state?

If I reset --hard (or --merge) to the previous HEAD commit, the
modification to main.c is forgotten.  In practice, I would do
'git reset --hard HEAD^ && git checkout HEAD@{1} -- main.c'.
