From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Fri, 22 Feb 2008 14:05:55 +0000
Message-ID: <b0943d9e0802220605t56257718p850c677a59671862@mail.gmail.com>
References: <20080214012119.22365.54526.stgit@yoghurt>
	 <20080214012912.22365.83207.stgit@yoghurt>
	 <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com>
	 <20080221071819.GA8250@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 15:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSYXr-0003cp-B5
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 15:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935982AbYBVOGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 09:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936135AbYBVOF7
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 09:05:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:49561 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765533AbYBVOF5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 09:05:57 -0500
Received: by wx-out-0506.google.com with SMTP id h31so383451wxd.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MmhswRY48mZ2vpT+Oja8ejY3L0O75jwP299/tfJSa2s=;
        b=qzAd8IsM3uXTuBQbsoqk8pq3Qgek2qiEcrHs6xea1AG4nJja1rGtSWlazTPgtra/PI9DwRxvzXf8RpJBrcQMmyHj1Zjnny7DUxtOvDl6m32fPKvVQtJ3ceMECjVMjPGR0FIb7hvKiBqSB4uFM+VqNcCpMEejS1DCTzhM5jmsspY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I/qNwIgQcxIiX9fBuKBXz5dyJFUoxUFmnqyuoZH9srq0Z9X7nfVXMonTzhjq5q65Srx0wHm+Ik1EQtVs8m37k5I8aIdAjX5g5+/XV34yPyVK4hKG4yssG/bKosfDi1NltEU1PLGjpp7e1twnUzdSeALphHaDZLhRsco6zAUa08A=
Received: by 10.140.251.1 with SMTP id y1mr7627690rvh.292.1203689155076;
        Fri, 22 Feb 2008 06:05:55 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Fri, 22 Feb 2008 06:05:55 -0800 (PST)
In-Reply-To: <20080221071819.GA8250@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74724>

On 21/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-02-20 22:46:48 +0000, Catalin Marinas wrote:
>
>  > The abstractions are really nice (and I still wonder how StGIT
>  > codebase increased that much when all I needed two years ago was a
>  > simple script-like application to reorder commits :-)).
>
>
> :-) I'll take some of the blame, but StGit was quite large already
>  when I started submitting patches to it.

Anyway, the new restructuring is much cleaner, though heavily OO and
some people might not like it (me not included).

>
>
>  > Anyway, I don't really like the idea of an additional commit (I
>  > don't even like the old patch log implementation) when the stack i=
s
>  > modified. It needs some profiling but it has a visible impact on
>  > stacks with a big number of patches (my last kernel release at
>  > www.linux-arm.org/git had 80 patches and it takes a lot of time to
>  > push them).
>
>
> One thing to remember is that my patch stack log gets one new commit
>  per StGit operation, not one per changed patch. So if you push 80
>  patches with one command, that will give you just one commit on the
>  log. (If someone makes a scripts that calls push 80 times this won't
>  help, of course.)

Ah, I got it now. Indeed, it would be faster than the current
per-patch log. I no longer that worried :-)

>  > In my kernel repository I have several branches with many patches
>  > and, even after "git gc" and repacking, it is still slow (mainly
>  > because of git-read-tree but I'd like to reduce the number of call=
s
>  > to GIT).
>
>
> When you say "it's still slow", are you referring to the existing
>  per-patch log, my per-branch log, or just StGit in general?

I think it's more GIT in general. Checking the tree status takes some
time and a 3-way merge on a 512MB RAM machine with GIT using over
200MB gets a bit slow.

>  Have you noticed any difference between commands using the old and n=
ew
>  infrastructure (say, stg push vs. stg goto)? The latter should be
>  taking less time, due to touching the worktree only when necessary.

In the patch pushing functions, it now first calls simple_merge()
which is still a 3-way merge but without rename detection. The old
StGIT implementation was using "git-diff | git-apply" and falling back
to the recursive merge. Most of the patches apply cleanly and we don't
need the three-way merge which uses more RAM.

The "(modified)" information was also displayed for a three-way merge
(either read-tree or recursive-merge) but now it is only shown for the
recursive one. Correctly, merging git-read-tree modifies a patch as
well since it no longer applied cleanly. We could use this "modified"
feature to automatically export patches (some people asked for this in
the past, as means for backup in case of StGIT failures).

--=20
Catalin
