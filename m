From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 0/5] "diff --stat" counting fixes
Date: Sat, 1 Dec 2012 11:29:53 +0100
Message-ID: <CALWbr2xYrWkfSCUc7gocVGLQP_RHjWrMmFspPe5O_ekjisNqxw@mail.gmail.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 11:42:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TekWl-0002m1-G3
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 11:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab2LAK35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 05:29:57 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43498 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2LAK34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 05:29:56 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so742910eek.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 02:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DFufJoFczQZ2wSOsgSGhPpi1J/FiIvtx+ykSJ1FqAQo=;
        b=cqpj0kLAqrPKnnpDxnZ9jMf+gkqXlPO2Vik/0VUozh23rPaFbflcMYTWqVNbW/YCEM
         j/CAm6+oLUn2JrrAPOCH9w4Pa8uTvQFVqhmi5dQOSpDrHfz7fvkfujbmnlXNx988fikG
         hfseDLZ+bLXVJVvNyP3sPBePQuqo7G4tpI7/+xoOjv0UYOLuTr2Brsh0kPXcfsnhXU22
         Hxo6YRyJNcI6T/Rc8KfvMCh2r/r4b1lVVeZwIVrIYVBpy2IwI2uxTfEgUdxx4jyJy2J9
         oxN/XGN6L27g3OWl7rUafw35o7TWbMImyfyDS4R1Kt73SdkznyaFtv2/c7elxyK3p0jC
         Bt2w==
Received: by 10.14.208.137 with SMTP id q9mr14625504eeo.28.1354357793757; Sat,
 01 Dec 2012 02:29:53 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sat, 1 Dec 2012 02:29:53 -0800 (PST)
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210958>

Hi Junio,

That does make a lot of sense and I would have indeed missed a couple
of things here.

I've been thinking about that "Unmerged" line quite a lot, and I can't
get myself any good reason to keep it.
Would you mind taking a couple of minutes to make it clear ?

I feel like (but I can obviously be wrong):
1. The info is redundant. When performing a merge, all diffs (without
--staged flag) are unmerged
2. While status shows the line once, while diff shows the diff for the file
once, while diff --shortstat counts the file once, diff --stat shows two
lines for the file.
3. diff --numstat shows two lines for the same file. As a script
writer (I guess that's what it's meant for), I would definitely expect
uniqueness in third column/filenames.

Cheers,
Antoine

On Tue, Nov 27, 2012 at 10:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It turns out that there are at least two bugs in the diffstat
> counting code.  This series comes on top of the earlier 74faaa1 (Fix
> "git diff --stat" for interesting - but empty - file changes,
> 2012-10-17) to fix them.
>
> Junio C Hamano (5):
>   test: add failing tests for "diff --stat" to t4049
>   diff --stat: status of unmodified pair in diff-q is not zero
>   diff --stat: use "file" temporary variable to refer to data->files[i]
>   diff --stat: move the "total count" logic to the last loop
>   diff --stat: do not count "unmerged" entries
>
>  diff.c                     | 49 +++++++++++++++++++++++++---------------------
>  t/t4049-diff-stat-count.sh | 46 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 23 deletions(-)
>
> --
> 1.8.0.1.331.g808d2af
>
