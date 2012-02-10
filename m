From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 10 Feb 2012 14:46:09 +0100
Message-ID: <CAA01Csq+zVhRTjGqy1DJGK7o5wByd9ADsSim214T7Vkxmk+ykQ@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CACsJy8DnqYZ5CdZqbebWS4NS85mfwumyao0abeqDxMXrHhDELA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 14:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvqno-0005N5-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 14:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252Ab2BJNqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 08:46:12 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:60946 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754675Ab2BJNqK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 08:46:10 -0500
Received: by obcva7 with SMTP id va7so3797800obc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A5nzZH0tMOBND6GjNRNWGGnM7tLeAIssRVSwZJV/2TA=;
        b=RJSicngeyY4NDWI3K1wruHPZnLPc7RAyuf4GHJmJ5DEB6Mmhgmmx3rQxKiWMJRUYYn
         pKBiCwvgFx+6jtSdCZci4UBNCgfnyDv78gVHbky/VdFIqaw4TNa5bzWcw9+e4pjJ+fR0
         Q1huew+DnTFL0yr64LObNJZsjiLkwsVxCyCfo=
Received: by 10.50.34.202 with SMTP id b10mr11305165igj.2.1328881569882; Fri,
 10 Feb 2012 05:46:09 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Fri, 10 Feb 2012 05:46:09 -0800 (PST)
In-Reply-To: <CACsJy8DnqYZ5CdZqbebWS4NS85mfwumyao0abeqDxMXrHhDELA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190408>

On Fri, Feb 10, 2012 at 1:33 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Fri, Feb 10, 2012 at 4:42 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> Hi,
>>
>> I compared stating whole tree vs one small subdirectory, and I
>> expected that for the subdirectory status will be very very fast.
>> After all, it has only few files to stat. But it's not fast. Why?
>
> Because stat'ing is not the only thing git-status does? In order to
> find out staged changes, unstaged changes and untracked files, it has
> to do the equivalence of "git diff --cached", "git diff" and "git
> ls-files -o". I think copy detection is also enabled, which uses more
> cycles.

I believe copy detection is not done, neither for tracked nor untracked files.
Rename detection is done for tracked files. In this case it should not
matter, as there were no changes to the files.

My point is, that for such small number of small files (55 files and
223KB), which had no changes at all, the status took a lot of time (17
seconds) and doing status on whole repository which has more than
2000x files and 10000x data took only 2x more time.

I don't think that the algorithm scales so well, so my guess is that
'status' is so inefficient for subdirectories (i.e. the "git status --
dir" filter does not filter as much as it could).


> Profiling it should give you a good idea what parts cost most.

I'll try that later.

BTW by stating I meant using "status", not that it uses stat() or whatever.


-- 
Piotr Krukowiecki
