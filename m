From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Thu, 16 Jun 2011 10:51:59 +0200
Message-ID: <BANLkTikTt4vMj+iZMhGEi6JefRUkZGZ8dg@mail.gmail.com>
References: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com>
	<20110522114917.GA19927@arf.padd.com>
	<398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
	<BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com>
	<34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com>
	<BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com>
	<0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com>
	<1308212906486-6482174.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: tumik <tumik@tuomisalo.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX8J5-0000Nb-R0
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 10:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab1FPIwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 04:52:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62011 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab1FPIwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 04:52:01 -0400
Received: by vws1 with SMTP id 1so985894vws.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0tdpNjwV0muteQUwIxBwhs5Oe10a2qfIX65YTvrXd0A=;
        b=L4riWeFQ4zXcTenmG1SvOkW4hIjhsse10/Y/nl89Rgh+pC/LL8Le7oFUoog9xMxhU0
         ZgB78XcDUh3aSDtYrzNo9YCs7n9cskzbRuu/b4sY52XGfibZ0jFrytPVvagRidr01F03
         NshE59nbzkYMisBk/IujmihUVAuhDwvHkS+jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=slOqIIDXltu2JEgA5Ns19HdMIcuHZvB9ysIGzUhg0NgzTYIlU1gT+V/OAqQaufondN
         AWHT8I78hlgpFogPbYlyidxh6VAzVkAj5iKcAltju7imOZ7Ms9N0hm/XGSjMc9nTlYdS
         a5+y6uEj7clI+sp2lw2k4suS1/UQsRK+C9S24=
Received: by 10.52.66.10 with SMTP id b10mr862311vdt.250.1308214320369; Thu,
 16 Jun 2011 01:52:00 -0700 (PDT)
Received: by 10.52.167.69 with HTTP; Thu, 16 Jun 2011 01:51:59 -0700 (PDT)
In-Reply-To: <1308212906486-6482174.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175888>

On Thu, Jun 16, 2011 at 10:28 AM, tumik <tumik@tuomisalo.com> wrote:
> Did you get it working so that the branch integrates at Perforce show up as
> merges in git? I have been trying to do this for tens of hours now and just
> can't get it working.. I have tried making the branch mapping both ways, and
> even both at the same time but with no success.
>
> I have succesfully imported the two testing branches to git, but if I look
> at it in gitk for example, the history is linear and there are no merges
> from the other branch (it shows up as a normal commit, without the parent
> from other branch, just adding all lines that the merging did). in p4v it
> shows up as it should!

git-p4 only uses the branch mapping for the initial commit on a
branch. It does not attempt to detect merges after that point. After
importing to git, merges just appear as regular commits in the
history.

Unfortunately, implementing a general solution for this is
non-trivial. Perforce branches and merges per file, meaning that
partial merges are possible in Perforce. Such states can not be
correctly represented in Git, and depending on your needs, you may or
may not want a particular partial merge to be considered as a git
merge.

There was another script called git-p4raw for importing Perforce
history to git, which does merge detection. It solved the problem by
having configurable rules for what should be regarded as a merge, and
it supported manually reviewing the decisions afterwards (iirc).

One possibly useful feature in git-p4 would be an option to regard
every integration as a complete merge, which shouldn't be too hard to
implement. But this would break every time someone did a single-file
integration between two branches (which happens quite often in my
experience, for cherry-picking changes etc.).

Thomas
