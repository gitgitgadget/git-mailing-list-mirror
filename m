From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Tue, 25 Mar 2008 10:46:00 +0000
Message-ID: <b0943d9e0803250346h7405c37egc9ba170a6dcc06bf@mail.gmail.com>
References: <20080320002604.13102.53757.stgit@yoghurt>
	 <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
	 <20080324181225.GC23337@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Erik Sandberg" <mandolaerik@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6g2-0001gc-FF
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbYCYKqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 06:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYCYKqE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:46:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:23380 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYCYKqC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 06:46:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1724845rvb.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KST+Rl8sPdEbcEG3ONsDp5YLB7WJDSayr3w/4g/43dw=;
        b=CvbiW4F3QQX9psjS+iES7oI54hfGrFhydnHcs1xzTJPjIOAguYXZ6m8lBTOjYStOyV4NFcwSjEoCfv2bTF3N4C45DtziMZWmccOTcVoiP9z5IZ9mftkNS3KUtps2/k0QRWzQRjhg2f681G25yy+iD+MeA4HyDBHHn4ht+nXrLdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tbRZX8ll4yCq8mLw0+2Jcb8bfQ9L5Yuzt6gcCXNFXvU4Lb3zIuP/O52fAtP3TJo+vq/wp2tY6Ez596Rlks+jU+osWjll6IsD6V4ZesY5aJgRKHE0O2FZP63cDYX/jh+j8MMcCKY5rtiRWgt3vr95sOJHSgTr0/uzR9t2xwIpXSA=
Received: by 10.141.212.5 with SMTP id o5mr3124462rvq.20.1206441961021;
        Tue, 25 Mar 2008 03:46:01 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Tue, 25 Mar 2008 03:46:00 -0700 (PDT)
In-Reply-To: <20080324181225.GC23337@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78175>

On 24/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-03-20 15:19:12 +0000, Catalin Marinas wrote:
>
>
> > As I wrote on the patch system, I'd like to put back the explicit
>  > --keep option in goto.
>
>
> There are three possible values of "keepiness":
>
>   1. Make sure there are _no_ local changes. (Default for old
>      infrastructure.)
>
>   2. Make sure there are no local changes in the files we need to
>      touch. (Default for new infrastructure.)
>
>   3. Bring along local changes by means of a merge. (What the --keep
>      option does.)
>
>  git defaults to doing (2), and optionally does (3). (1) is
>  significantly slower than (2); I don't know how slow (3) is.

With the current functionality (see below), I prefer (1) to be the
default and (3) as optional (on stable, it does a reverse-apply of the
diff and it's kind of combination between 2 and 3 but without the
conflicts you could get with only 3).

My reason for this is that usually you "goto" a patch to do some
changes followed by "refresh". If there were local changes, they would
be included in the refreshed patch since this is the default StGIT
behaviour. To avoid this, I find myself running "status" before any
"goto".

>  I think that (2) should be the default, because it's faster, it's wh=
at
>  git does, and I don't really see the point in complaining about loca=
l
>  changes in a file we won't need to touch anyway.

But in git, for committing, you usually need to run "git add" on the
files or specify "commit -a" explicitly. We would need to change the
"refresh" behaviour in the same way and, in this case, I would be OK
with (2) as the default.

I personally prefer the current "refresh" way but maybe because I'm
used to it. It would be useful to get other users' opinion on this UI
change. Might not be a bad change since git does this already, quilt
needs an explicit "add" (anyone knows about guilt?).

--=20
Catalin
