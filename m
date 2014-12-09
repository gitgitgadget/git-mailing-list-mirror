From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Tue, 9 Dec 2014 16:01:50 +0000
Message-ID: <CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
References: <5485D03F.3060008@fu-berlin.de>
	<20141209141457.GA18544@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Scherer <m.scherer@fu-berlin.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 17:02:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyNEb-00075w-HO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 17:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbaLIQBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 11:01:53 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35648 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbaLIQBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 11:01:51 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so784478ier.0
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zofte0AFq93JoyUDbttCz1WLZOrwyjlf2U6Ni08FbwM=;
        b=Yk1NTY9vGzR5pa2xqJ8E3YswFd6CVQPZHHHilz2TnMw8J9NUbvcQpledPyAmttPEsg
         VzVXCd9bqawFw8GZvx9Gc1EdhMGKNalhI8QR7W9tZELW8PJDQFxTyWPiZx9NtM4nM85T
         dx+GapsQvgT8C6BRUaTClSbckmKKxQNEDAIvBqETz+vDlm3U+jJ3sYOum6WrbV1nr0pi
         yyvdpSLjHOAiSBu+HC2syGM7xKX56Yp6OgM6hLBVg8poL13KKhvqtzL2UovCSqh8dfAd
         jOBlMPPXaPlhaiU4lcWf8mSk2oMZvhooFFxThFRgd0c5r0oI+EUReLao1u6W7ZA0SdSj
         plkQ==
X-Received: by 10.107.170.98 with SMTP id t95mr16750997ioe.7.1418140910632;
 Tue, 09 Dec 2014 08:01:50 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Tue, 9 Dec 2014 08:01:50 -0800 (PST)
In-Reply-To: <20141209141457.GA18544@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261128>

On 9 December 2014 at 14:14, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 08, 2014 at 05:22:23PM +0100, Martin Scherer wrote:
>
>> # invoke bfg --delete-folders something multiple times with different
>> pattern.
>>
>> # try to cleanup
>>
>> git gc --aggressive --prune=now # big blobs still in history
>> git fsck # no results
>> git fsck --full  --unreachable --dangling # no results
>
> Might you still have reflogs pointing to the objects? Try:
>
>   git reflog expire --expire-unreachable=now --all

Yeah, we figured that's what it was!

https://github.com/rtyley/bfg-repo-cleaner/issues/62#issuecomment-66152559

> I also don't know if BFG keeps backup refs around (filter-branch, for
> example, writes a copy of the original refs into refs/original; you
> would want to delete that if you're trying to slim down the repo).

The BFG reports the ref changes to the command line (and outputs a
full list of changed object-ids in
repo-name.git.bfg-report/[datetime]/object-id-map.old-new.txt) but
doesn't keep refs (like refs/original) around because that would get
in the way of the BFG's explicit intended use-case of removing
unwanted data.

Thanks for the object-size checking scripts, very useful.

Roberto
