From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 13:39:11 -0400
Message-ID: <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
References: <47E37A63.9070209@glidos.net>
	 <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paul Gardiner" <osronline@glidos.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:40:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JclDf-0006Op-Pe
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 18:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198AbYCURjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 13:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbYCURjO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 13:39:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:11287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbYCURjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 13:39:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1413418fgb.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Gz+3HF7UAWN/EYZuWEeBTUBqkiSb63JVPfHcZJcrOHY=;
        b=Yu4yWUxBPX0d8hAMkCqqRS3cCfTFmkWpG85jGHsAGjbAE8XcMNP5xjDzHtTbekmr1sRm3WfYE3nuKxi7AKJb8jj6QczlOBZpJPMd7KxK6cbcpnj4YNB4Al0qVzix8NTaML4pgWhcFOBie2kq44D25gA+0ra9Wco8yWV8+PS0l5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MPFhKTiIdSAv1Tlo+b2V8tBQg+NCvY1sgyUybh9x6eN7DH3MzMcyY5KhvO58/EgJ/4D/OFVa+HOGrBGScZtVm8AUVD5T1d+esqXhAAWNTbJwSyHlts+wCeNEjzxTp3Dw6Ax/LWccrVmk00gzY/zYLUkCZbe93/dzcwde/P3irW0=
Received: by 10.82.148.7 with SMTP id v7mr7975467bud.37.1206121151109;
        Fri, 21 Mar 2008 10:39:11 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Fri, 21 Mar 2008 10:39:11 -0700 (PDT)
In-Reply-To: <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77749>

On Fri, Mar 21, 2008 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Gardiner <osronline@glidos.net> writes:
>  > I need a command that will find the remote branch from which
>  > the currently checked out branch was started. I don't know
>  > git very well, and the only way I can think to do it so far
>  > is to iterate over the remote branches and find the one
>  > for which git-rev-list <branch>..HEAD gives the smallest
>  > number of objects. I'm guessing there must be a better
>  > way. Any ideas?
>
>  There will be _no_ way.  It is simply impossible.
>
>     $ git checkout -b my-new-branch origin/somerandombranch~27^2^2~23
>
>  is a perfectly valid way to create a new branch.
>
>  You would probably want to re-think in a bigger picture, _why_
>  you would want to find such information, [...]

I frequently want to do this.  Basically, I start from "some version"
of the upstream program, and I put together some patches, then I want
to use rebase to reorder and recombine them before I send them in.

In order to do this, however, I'm forced to remember where I got my
"original" version from, which isn't even that important.  As the
developer of a particular patch, all I *really* should have to know
is: a) here are the things I added since I made my topic branch, and
b) here is the branch I want to rebase them onto so I can submit my
cleaned patches upstream.

If git would explicitly track the rev at which my branch was created,
it would mostly solve *my* problem here, even though I wouldn't know
the *name* of the branch I branched from.

Alternatively, we could avoid tracking anything extra at all.  If git
could suggest a branch or tag that mine is "currently closest to",
ie., the one that has as many of the commits from my branch as
possible (even if it has additional commits that I don't have), then
that might be the branch I'm interested in.  If not, I could use this
comment repeatedly to produce a "chain of parent branches", one of
which is probably the one I'm interested in.

Have fun,

Avery
