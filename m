From: Valery Yundin <yuvalery@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Fri, 30 Jan 2015 00:59:20 +0100
Message-ID: <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
	<20150129233429.GA7162@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGyze-0003us-1r
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 00:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbbA2X7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 18:59:22 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:37948 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbA2X7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 18:59:20 -0500
Received: by mail-qa0-f48.google.com with SMTP id v8so17701383qal.7
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vm2K5uNijaNUBImgbhDgjBk1LvnNCA1FAj1okZ0J9v0=;
        b=MKyLL0RiPlQ1mNPlaOPy/s59X5rMWdyjzFnimFz+coMdgxG6uwYHErZIC5BFKMBX0i
         aWqTyejl9RVk5N6WsjpwiomzfYBP8JaHOfi7J38Uc+5V1tcYkr/bqXYrSOByLqsAuA2q
         c+zbXvTSgqnJ1moFsOi8CAu2HaiLeS92XqNdZbSuZQ6OyxdJCepPG1jOEJ2GccbtlwJy
         e7s9qwvx1jOUepBDnr0vDglPaXwq0PExA62StnMZUbCHwlKkjukUZA5yzCU+MB0xoYUr
         t006+bkthVpfWZd8LrSJh6B/rUaFPlBmORgZ+YVGL1gxvHHGzwyD9PPAukUR1KMWfTKE
         rxcg==
X-Received: by 10.140.102.165 with SMTP id w34mr6784626qge.26.1422575960106;
 Thu, 29 Jan 2015 15:59:20 -0800 (PST)
Received: by 10.96.46.170 with HTTP; Thu, 29 Jan 2015 15:59:20 -0800 (PST)
In-Reply-To: <20150129233429.GA7162@dcvr.yhbt.net>
X-Google-Sender-Auth: zz6gpmNM5EBn2F3q-x52AbVpfr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263167>

Hi,

Here you go:
dfa72fdb96befbd790f623bb2909a347176753c2 is the first bad commit
commit dfa72fdb96befbd790f623bb2909a347176753c2
Author: Eric Wong <normalperson@yhbt.net>
Date:   Fri Oct 24 22:53:52 2014 +0000

    git-svn: reload RA every log-window-size

    Despite attempting to use local memory pools everywhere we can,
    (including our call to SVN::Ra::do_update and all subsequent reporter
    calls), there does not appear to be a way to force the Git::SVN::Fetcher
    callbacks to use a pool other than the per-SVN::Ra pool.
    Git::SVN::Fetcher ends up using the main RA pool which grows
    monotonically in size for the lifetime of the RA object.

    Thus the only way to free that memory appears to be to destroy and
    recreate the RA connection for at every --log-window-size interval.

    This reduces memory usage over the course of fetching 10K revisions
    using a test repository created with the script at the end of this
    commit message.
    .........

Cheers,
Valery
With best regards, Mr. Valery Yundin.


On 30 January 2015 at 00:34, Eric Wong <normalperson@yhbt.net> wrote:
> Valery Yundin <yuvalery@gmail.com> wrote:
>> Tested on:
>> git-svn version 2.3.0.rc2 (svn 1.8.11) - FAIL
>> git-svn version 2.2.2 (svn 1.8.10) - FAIL
>> git-svn version 1.8.4.5 (svn 1.8.11) - WORKS
>
> Thank you for that info.  Do you think you can bisect which
> versions/revisions of git-svn introduced that failure for us?  I don't
> have much time this part of the year for git-svn, but maybe it's related
> to the performance work we did around fall 2014.
>
> Thanks again.
