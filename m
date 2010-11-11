From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Thu, 11 Nov 2010 07:59:06 -0500
Message-ID: <AANLkTinBhDR2+SGtz4rmj8CrOh4yLPAB3A74BV-yBCxa@mail.gmail.com>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
	<AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
	<201011111141.33623.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 11 13:59:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWkS-0007eo-2T
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0KKM7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:59:10 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62770 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab0KKM7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:59:07 -0500
Received: by qyk30 with SMTP id 30so664519qyk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rqlbChvKZ9lVPXoOQ91npf6rRn7nfbiXXZUp/bHkquk=;
        b=g9iQyt3yR2Y4cqkyVG8bmaHyNgXTf8JRGXpeamRiY480sNff0/r5a2cLB1SUOEEHyw
         XLAOHDm1nSBIc6RslcJytBNHW6IfqyRgp2o9T2UUPqiWFBKFHy3k607wzPNeWqcnOTGp
         aqBXeJVdTsXrIgKPF7XwRHxTGn0H6dwkF5Pxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rpVS0IGazHcjJv0+QzjS3zXqfvUn5abxRy7uJp6CKU7770CZ2v79NZLcb39UJNkgs2
         QWo4415HJCDlukrGD1+kD/XEEQ6TQ3NjSi+9agI3TSfMHOSDKFjMVDv74vIDA39bvW4m
         nX9gNRaHeNKs0AsQngNf+i7xNhul0wI3rUbIM=
Received: by 10.224.135.227 with SMTP id o35mr930263qat.75.1289480346634; Thu,
 11 Nov 2010 04:59:06 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Thu, 11 Nov 2010 04:59:06 -0800 (PST)
In-Reply-To: <201011111141.33623.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161244>

On Thu, Nov 11, 2010 at 5:41 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Martin von Zweigbergk wrote:
>> Btw, why is the default (if no strategy is specifed) for 'git rebase' to
>> use 'recursive', while for 'git merge' "a built-in list of strategies is
>> used instead (git merge-recursive when merging a single head, git
>> merge-octopus otherwise)"?
>
> Because rebase does a tree-level merge, so it never attempts to merge
> than one branch, so octopus never enters the picture.

I can see why octopus doesn't make sense when doing a linearizing
rebase, but what if it's merge-preserving rebase? The call to
'git merge' in git-rebase--interactive.sh looks like this:
    new_parents=${new_parents# $first_parent}
    [...]
    git merge $strategy -m "$msg" $new_parents

Also, it sounds like "a built-in list" is something that could one day
be expanded. So my question is then whether it would make sense to call
'git merge' without specifying a strategy when 'git rebase' is called
without a strategy?

> Sorry for the original breakage; while it has Mike Lundy assigned as
> author, I resurrected and resubmitted his patch and should have
> noticed.

Well, since there are no other strategies than recursive that support
strategy options, it was not really a breakage in reality, at least as
far as I can see.

Speaking of that and about my earlier comment about writing a test case,
what should really happen if the user calls 'git rebase -s ours -X foo'?
Should it really be allowed? (I tried it and it does work, though.)
