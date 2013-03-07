From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] p4merge: create a virtual base if none available
Date: Wed, 6 Mar 2013 19:33:26 -0800
Message-ID: <CAJDDKr5YOONEKKXRH4yO55SdC235QROsnTa6o7UGzXtmgm6EWA@mail.gmail.com>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
	<1362601978-16911-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 07 04:34:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDRag-00048g-UE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 04:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758922Ab3CGDd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 22:33:29 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:42661 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab3CGDd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 22:33:27 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so7465eek.10
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=eAzPcNJ+EO/R3gmIAHq1m6Qo/Aebz83ZNl1DOfKXpvw=;
        b=GpyTQT5Top1FMBnPNApXWne/gGba0fYVd53GsP0bt4XMC6vmefCiJ6g0SvWFcleNgj
         e196gjeFkXeeGXvDhV1fqK43IG7aNakSe5JtlCssMTczmnobfjArZPdIV7n2lhukiXc9
         OLS7YgXioXVQhxVtx6qu44EW+FKh1X/pSrtAE99gRPL7rcsZ2SGQW3TXUHy5/54JQCP3
         deQR50JtSmZlgsTI/qmpaHEbD01zsHEWrKUnK8GMMNxsiPivMgjE7B5KJ3Z/1p/7SZpT
         J2SbfKiyFxNJc8S39FwegX1FBLZQe0IAlMTnWJa4SOC6QpWu9nloWFfKT4GIOXzWrqhd
         eX2w==
X-Received: by 10.15.67.134 with SMTP id u6mr87312756eex.6.1362627206436; Wed,
 06 Mar 2013 19:33:26 -0800 (PST)
Received: by 10.14.194.3 with HTTP; Wed, 6 Mar 2013 19:33:26 -0800 (PST)
In-Reply-To: <1362601978-16911-3-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217571>

On Wed, Mar 6, 2013 at 12:32 PM, Kevin Bracey <kevin@bracey.fi> wrote:
> +make_virtual_base() {
> +               # Copied from git-merge-one-file.sh.
> +               # This starts with $LOCAL, and uses git apply to
> +               # remove lines that are not in $REMOTE.
> +               cp -- "$LOCAL" "$BASE"
> +               sz0=`wc -c <"$BASE"`
> +               @@DIFF@@ -u -L"a/$BASE" -L"b/$BASE" "$BASE" "$REMOTE" | git apply --no-add
> +               sz1=`wc -c <"$BASE"`
> +
> +               # If we do not have enough common material, it is not
> +               # worth trying two-file merge using common subsections.
> +               expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$BASE"
> +}

This seems to be indented deeper then the other functions
(or gmail is whitespace damaging my view).
Please use one hard tab to indent here.

We prefer $(command) instead of `command`.
These should be adjusted.

Also, the "@@DIFF@@" string may not work here.
This is a template string that is replaced by the Makefile.

I don't think the tools in the mergetools/ directory go through
cmd_munge_script so this is not going to work as-is.

Can the same thing be accomplished using "git diff --no-index"
so that we do not need a dependency on an external "diff" command here?


I am not a regular p4merge user myself so I'll defer to others
on the cc: list for their thoughts.  It does seem like a good idea, though.
-- 
David
