From: Ali Tofigh <alix.tofigh@gmail.com>
Subject: Re: many files, simple history
Date: Fri, 14 May 2010 12:18:03 -0400
Message-ID: <AANLkTimwd0DMc2gMbQfv9t_4YeEZrJETz2trszVqq3jd@mail.gmail.com>
References: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com> 
	<20100514040559.GB6075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 14 18:26:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxi6-0000Vh-4B
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab0ENQZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 12:25:46 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47204 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab0ENQZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 12:25:42 -0400
Received: by vws9 with SMTP id 9so226023vws.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=aBa7qJuCY0rL4qvTfXoDmgg3tnPXTUV64GTZJHWifHI=;
        b=SGFHBndakxcHNQcXZi6sT5cM80ilkvRNdrerogNW8kCIluMeabxW1kwrqXPiCl0E8l
         a2I864Yx1yUlpY6ZuIsuDKDSvLNDL3a6Q7T0OnjXes3L6b9IP5AekutUosWHi2EjbKxw
         FbQX7S5zA22AWgtLWXRmiHOuUSCvXSF7n3jKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NVbWwcMjk6PIGcMuk1CttxPnLnQ6mmdsUpBoC9wxbq8bDFRzGuOanTDDrt6sLgaLOd
         2W8iVPN/ilpUuuUFq5cAc9BXe+k+O7/PzRHQOh5zaxfQhLRRRzOYehZkY+/wwIs81JqR
         MMUPFGwYstC9GruIEWTOKODJZRKEuNUH8w7HQ=
Received: by 10.229.225.212 with SMTP id it20mr394194qcb.123.1273853903194; 
	Fri, 14 May 2010 09:18:23 -0700 (PDT)
Received: by 10.229.51.84 with HTTP; Fri, 14 May 2010 09:18:03 -0700 (PDT)
In-Reply-To: <20100514040559.GB6075@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147100>

On Fri, May 14, 2010 at 00:05, Jeff King <peff@peff.net> wrote:
> On Thu, May 13, 2010 at 10:57:22PM -0400, Ali Tofigh wrote:
>
>> short version: will git handle large number of files efficiently if
>> the history is simple and linear, i.e., without merges?
>
> Short answer: large number of files, yes, large files, not really. The
> shape of history is largely irrelevant.

thank you for the explanation. I will start using git for managing my
installed programs and will try to  report back to this list about my
experience.

/ali

>
> Longer answer:
>
> Git separates the conceptual structure of history (the digraph of
> commits, and the pointers of commits to trees to blobs) from the actual
> storage of objects representing that history. Problems with large files
> are usually storage issues. Copying them around in packfiles is
> expensive, storing an extra copy in the repo is expensive, trying deltas
> and diffs is expensive. None of those things has to do with the shape of
> your history. So I would expect git to handle such a load with a linear
> history about as well as a complex history with merges.
>
> For large numbers of files, git generally does a good job, especially if
> those files are distributed throughout a directory hierarchy. But keep
> in mind that the git repo will store another copy of every file. They
> will be delta-compressed between versions, and zlib compressed overall,
> but you may potentially be doubling the amount of disk space required if
> you have a lot of uncompressible binary files.
>
> For large files, git expects to be able to pull each file into memory.
> Sometimes two versions if you are doing a diff. And it will copy those
> files around when repacking (which you will want to do for the sake of
> the smaller files). So files on the order of a few megabytes are not a
> problem. If you have files in the hundreds of megabytes or gigabytes,
> expect some operations to be slow (like repacking).
>
> Really, I would start by just "git add"-ing your whole filesystem, doing
> a "git repack -ad", and seeing how long it takes, and what the resulting
> size is.
>
> -Peff
>
