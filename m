From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2] check-ignore: Add option to ignore index contents
Date: Mon, 2 Sep 2013 18:15:31 -0400
Message-ID: <CAPig+cRPmFViknOkq3OnK3wjTtdd+7ywrCJUHd_85=4xyzHH_g@mail.gmail.com>
References: <20130902212054.GA7012@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 03 00:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcPJ-0006AC-IF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077Ab3IBWPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:15:34 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61410 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070Ab3IBWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:15:33 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so4215177lbi.8
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QnvOuEQ4EMkf9PzBc6jF5UX7nw0iLj5RRKFzSLx2wKM=;
        b=aLUCs+R2oxnCrQzc54TtIPYRxFwn1qP+Di3R533wox8ebNzJB20d1cFN/jnOFiba6a
         IdWTSpLV+ddHK7w8EuHJkHwJxHacPx3P1P8CU/4ac+vRfr9WH02BdzSYV5W/ekpeuSdb
         wzEkMfx4CSznF+TMuuHs16Nb0Xw/6VStdUcq95Sr0bCv1JYMWBHZ3T7KDQj9TDNFw5pj
         2dcVjCTH+87GNIvfgDxLGoL8QxObuZi5fu4IviYAkgo/n5lPIKC7JnDuhIuQrG5Ksb9q
         VqN1luEB2hblT5B1MeoZJwbWqCjn8FskHUVw/vAMKUmJfp6PKdN4Ywz0nSqxfTMcVvbC
         E6vw==
X-Received: by 10.152.19.70 with SMTP id c6mr8483139lae.25.1378160132013; Mon,
 02 Sep 2013 15:15:32 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 2 Sep 2013 15:15:31 -0700 (PDT)
In-Reply-To: <20130902212054.GA7012@opensourcesolutions.co.uk>
X-Google-Sender-Auth: 9xzwviMypqYhOHtcBlT4552A3vI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233664>

On Mon, Sep 2, 2013 at 5:20 PM, Dave Williams
<dave@opensourcesolutions.co.uk> wrote:
> I have updated the original version of this patch to encompass the
> feedback comments obtained. Updates include:
> 1) Rename option to --no-index for consistency with other commands
> 2) Improved Documentation text
> 3) Extension to test scripts to include this option
>
> Regarding test scripts I have scoped coverage to ensure correct
> behaviour with the new option in all standard cases but without
> duplicating every single corner case.
>
> The original patch is at $gmane/233381.

This commentary, which is not intended as part of the commit message,
normally goes below the '---' line after your sign-off just before the
diffstat. When the project maintainer applies a patch with git-am,
such commentary is stripped out automatically, otherwise he has to
strip it manually. (Alternately, you could use a -->8-- line to
separate the above commentary from the commit message.)

One more minor issue below...

> check-ignore currently shows how .gitignore rules would treat untracked
> paths. Tracked paths do not generate useful output.  This prevents
> debugging of why a path became tracked unexpectedly unless that path is
> first removed from the index with `git rm --cached <path>`.
>
> This option (-i, --no-index) simply by-passes the check for the path
> being in the index and hence allows tracked paths to be checked too.
>
> Whilst this behaviour deviates from the characteristics of `git add` and
> `git status` its use case is unlikely to cause any user confusion.
>
> Test scripts are augmented to check this option against the standard
> ignores to ensure correct behaviour.
>
> Signed-off-by: Dave Williams <dave@opensourcesolutions.co.uk>
> ---
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index c29342d..0ad0534 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -87,6 +87,9 @@ test_check_ignore () {
>  # check-ignore --verbose output is the same as normal output except
>  # for the extra first column.
>  #
> +# A parameter is used to determine if the tests are run with the
> +# normal case (using the index), or with the -i or --no_index option.

s/--no_index/--no-index/

> +#
>  # Arguments:
>  #   - (optional) prereqs for this test, e.g. 'SYMLINKS'
>  #   - test name
