From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] t5304: Add test for .bitmap garbage files
Date: Fri, 13 Nov 2015 16:47:55 -0800
Message-ID: <CAGZ79kaHCC=M6g7gahLsX0vfyQ=fOOU3xJbtMQPOe3dtByKRMw@mail.gmail.com>
References: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
	<1447459853-28838-3-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxP0Z-0003TN-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbKNAr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:47:56 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33457 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbbKNAr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:47:56 -0500
Received: by ykdv3 with SMTP id v3so175004149ykd.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u1q2AxsQCdQl3KmhiOpkoWAsrkoK8vW1d2ypnVEiEn8=;
        b=WxtzYV/ju125YuwfA9HCvkyWdFTBFQIo6vRJ+8F2Gefp7Xcs7WnplmHcL8gTH237qq
         kHbxxqngWtglGhacH47PeMpwGe4jdX0D2XGpvOUWEvMakziYtaIFKRxmUNwzZFY4z2dV
         2maOQc1hCHd/d1+gfGkbyaooWJbpD4pu0xizMvMyYaMSVKJz1neEXLdIfhU0ANppo9ni
         jD+Adn87jjel3g5xdlXCqD3zpCu9PPSaX+1JenXZcdQKs/m92JYm2ibTxGEs6gBbffm3
         ybIvQpeB4JzV8/P3+C4SJHXgzqxxQxnGJFFyfDWS/3ilsjZrzsUSVxrlD7uooYIRpxvD
         aOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=u1q2AxsQCdQl3KmhiOpkoWAsrkoK8vW1d2ypnVEiEn8=;
        b=ZmaOou7SqxtxYv8fHQ5ly2y/KYLMo4gMmr+R87D1qOQr6IbJN3MoXoCKIkAKYrj+9J
         v8sQmzJg9ruYoFuv1Qcoyye72KZIPc48Yoy5Ya2O31Ww2LHkAL7Lh6dJH6W13nd27gys
         VNBsLKMNkvdVC4OKCi2dnPcGtwBu42lqmlFkhQZlLghYqsNyjxLyAJcQLP9dr9M+aB9f
         tszkIfHBIm73O30Pfb5EwbW3ihGKFQOEe+fqeORPu/7tAIKVDghSKGP1/rf+9b5PA9oG
         kanZQqtJYJcH5jovOJSkhrWMiehN30lfQIjuvQMefHokRaOYeZak81TujW2EwCzE3CXO
         mByQ==
X-Gm-Message-State: ALoCoQk7nti8UjVWRifjhKq+5h33X3zwx9jALaspKFJXDgaG4ZjrkLnt39LFQbzzhUFX6WfwFxNt
X-Received: by 10.13.254.69 with SMTP id o66mr24401071ywf.252.1447462075346;
 Fri, 13 Nov 2015 16:47:55 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Fri, 13 Nov 2015 16:47:55 -0800 (PST)
In-Reply-To: <1447459853-28838-3-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281289>

On Fri, Nov 13, 2015 at 4:10 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
> When checking for pack garbage, .bitmap files are now detected as
> garbage when not associated with another .pack/.idx file.
>
> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
> ---
>  t/t5304-prune.sh | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 1ea8279..4fa6e7a 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -230,6 +230,12 @@ test_expect_success 'garbage report in count-objects -v' '
>         : >.git/objects/pack/fake.idx &&
>         : >.git/objects/pack/fake2.keep &&
>         : >.git/objects/pack/fake3.idx &&
> +       : >.git/objects/pack/fake4.bitmap &&
> +       : >.git/objects/pack/fake5.bitmap &&
> +       : >.git/objects/pack/fake5.idx &&
> +       : >.git/objects/pack/fake6.keep &&
> +       : >.git/objects/pack/fake6.bitmap &&
> +       : >.git/objects/pack/fake6.idx &&
>         git count-objects -v 2>stderr &&
>         grep "index file .git/objects/pack/fake.idx is too small" stderr &&
>         grep "^warning:" stderr | sort >actual &&
> @@ -238,14 +244,20 @@ warning: garbage found: .git/objects/pack/fake.bar
>  warning: garbage found: .git/objects/pack/foo
>  warning: garbage found: .git/objects/pack/foo.bar
>  warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
> +warning: no corresponding .idx or .pack: .git/objects/pack/fake4.bitmap

Do we want to split that up further, into

    no corresponding .idx and .pack:...

to tell that actually both files are missing and we know it?

>  warning: no corresponding .idx: .git/objects/pack/foo.keep
>  warning: no corresponding .idx: .git/objects/pack/foo.pack
>  warning: no corresponding .pack: .git/objects/pack/fake3.idx
> +warning: no corresponding .pack: .git/objects/pack/fake5.bitmap
> +warning: no corresponding .pack: .git/objects/pack/fake5.idx

Wondering if we can condense this into one message (because only
one pack is missing).

> +warning: no corresponding .pack: .git/objects/pack/fake6.bitmap
> +warning: no corresponding .pack: .git/objects/pack/fake6.idx
> +warning: no corresponding .pack: .git/objects/pack/fake6.keep

same here.
    no corresponding .pack: .git/objects/pack/fake6.{keep,idx, bitmap}
would look nice and be shell compatible. (rm on that multi path just works,
in case you expect the pack to be gone)
