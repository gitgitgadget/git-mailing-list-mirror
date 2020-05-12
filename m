Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F20C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 12:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3682E206A5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 12:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELMPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 08:15:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54835 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMPW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 08:15:22 -0400
X-Originating-IP: 106.76.68.114
Received: from localhost (unknown [106.76.68.114])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4298F60002;
        Tue, 12 May 2020 12:15:18 +0000 (UTC)
Date:   Tue, 12 May 2020 17:45:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "J. Paul Reed" <preed@sigkill.com>
Cc:     git@vger.kernel.org
Subject: Re: git-gui patch staging errors
Message-ID: <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
References: <20200512010750.GA7127@sigkill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512010750.GA7127@sigkill.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 11/05/20 06:07PM, J. Paul Reed wrote:
> 
> Hey all,
> 
> I ran into an interesting problem this week where git gui was erroring out
> on staging partial patches in a particular file I was working on.
> 
> I worked around it with "git add -i," which worked like a champ.
> 
> I later realized the source file has some special characters (Unicode,
> probably) in it to print emojis (or colors or whatever fun animations the
> kids want on their terminals these days).
> 
> Interestingly, lines/hunks before the first Unicode character will
> partial-stage appropriately, but attempting to stage any hunks/lines after
> the characters produces a "Failed to stage selected line. error: patch
> failed ... error: ... patch does not apply" error dialog.
> 
> This can be reproduced by cloning
> https://github.com/debek/aws-glacier-multipart-upload.git and editing
> glacierupload.sh; the special characters are in echo statements on lines
> 60, 74, and 97.

I can't reproduce it. I cloned the repo and then edited the file at line 
60 with a diff that looks something like:

  diff --git a/glacierupload.sh b/glacierupload.sh
  index 3b956c7..265349b 100755
  --- a/glacierupload.sh
  +++ b/glacierupload.sh
  @@ -57,7 +57,9 @@ fi
   
   # count the number of files that begin with "$prefix"
   fileCount=$(ls -1 | grep "^$prefix" | wc -l)
  -echo "📦 Glacier Upload with $AWS_PROFILE"
  +bar
  +echo "📦 Glacier s Upload with $AWS_PROFILE"
  +foo
   echo "Total parts to upload: " $fileCount
   
   # get the list of part files to upload.  Edit this if you chose a different prefix in the split command

I tried a bunch of combinations if partially staging parts of this diff, 
but everything worked fine without any error message. The emoji didn't 
render properly (though that might be my font's problem), but there were 
no problems in partial staging or unstaging.

Does this example work fine on your system or does it error out? Could 
you give an example diff where git-gui has problems while staging? Maybe 
something in your config is different?
 
> Removing these control characters seems to calm git gui's indigestion on
> this file.
> 
> [preed@underworld ~]$ git --version
> git version 2.26.2
> [preed@underworld ~]$ git gui --version
> git-gui version 0.21.0.66.ga5728
> 
> best,
> preed

-- 
Regards,
Pratyush Yadav
