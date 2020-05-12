Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD9C2D0F6
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7388320673
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgELTBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:01:02 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38063 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgELTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:01:02 -0400
X-Originating-IP: 157.36.149.57
Received: from localhost (unknown [157.36.149.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F410AC0002;
        Tue, 12 May 2020 19:00:58 +0000 (UTC)
Date:   Wed, 13 May 2020 00:30:54 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "J. Paul Reed" <preed@sigkill.com>
Subject: Re: git-gui patch staging errors
Message-ID: <20200512190054.4s3pm7543stuhu4w@yadavpratyush.com>
References: <20200512010750.GA7127@sigkill.com>
 <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
 <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/20 02:27PM, Kerry, Richard wrote:
> 
> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of Pratyush Yadav
> Sent: 12 May 2020 13:15
> To: J. Paul Reed <preed@sigkill.com>
> Cc: git@vger.kernel.org
> Subject: Re: git-gui patch staging errors
> 
> Hi,
> 
> On 11/05/20 06:07PM, J. Paul Reed wrote:
> > 
> > Hey all,
> > 
> > I ran into an interesting problem this week where git gui was erroring 
> > out on staging partial patches in a particular file I was working on.
> > 
> > I worked around it with "git add -i," which worked like a champ.
> > 
> > I later realized the source file has some special characters (Unicode,
> > probably) in it to print emojis (or colors or whatever fun animations 
> > the kids want on their terminals these days).
> > 
> > Interestingly, lines/hunks before the first Unicode character will 
> > partial-stage appropriately, but attempting to stage any hunks/lines 
> > after the characters produces a "Failed to stage selected line. error: 
> > patch failed ... error: ... patch does not apply" error dialog.
> > 
> > This can be reproduced by cloning
> I can't reproduce it. I cloned the repo and then edited the file at line
> 60 with a diff that looks something like:
> 
>   diff --git a/glacierupload.sh b/glacierupload.sh
>   index 3b956c7..265349b 100755
>   --- a/glacierupload.sh
>   +++ b/glacierupload.sh
>   @@ -57,7 +57,9 @@ fi
>    
>    # count the number of files that begin with "$prefix"
>    fileCount=$(ls -1 | grep "^$prefix" | wc -l)
>   -echo "📦 Glacier Upload with $AWS_PROFILE"
>   +bar
>   +echo "📦 Glacier s Upload with $AWS_PROFILE"
>   +foo
>    echo "Total parts to upload: " $fileCount
>    
>    # get the list of part files to upload.  Edit this if you chose a different prefix in the split command
> 
> I tried a bunch of combinations if partially staging parts of this diff, but everything worked fine without any error message. The emoji didn't render properly (though that might be my font's problem), but there were no problems in partial staging or unstaging.
> 
> Does this example work fine on your system or does it error out? Could you give an example diff where git-gui has problems while staging? Maybe something in your config is different?
>  
> > Removing these control characters seems to calm git gui's indigestion 
> > on this file.
> > 
> > [preed@underworld ~]$ git --version
> > git version 2.26.2
> > [preed@underworld ~]$ git gui --version git-gui version 
> > 0.21.0.66.ga5728
> > 
> > best,
> > preed
> 
> -----------------------
> 
> I've recently found  something very similar to this using the Fork Gui.  I am tempted to report it to that project, but on seeing something similar here perhaps both Fork and Gut-Gui have a similar issue relating to Gui applications for Git?
> If the chunk I want to stage includes characters  in some category [1], then an attempt to Stage that chunk will fail with a similar fault to what is described here.  (I don't have one available to me at the moment to check whether it is exactly this failure)
> I have recently found myself cutting and pasting some chunks of text from a PDF into my C++ source, and in particular that includes "handed" quotes, rather than the usual use of the usual single quote character (ie the apostrophe).  If I then use Fork's ability to Stage chunks of text containing these (or possibly not containing, but close after) I get this failure reported.
> The work-around is to do it from the command line using "git add --patch", which works fine.

I suspect this is an encoding mismatch, but I wonder why it doesn't show 
up on my system but does on Paul's. Anyway, I would be surprised if the 
two bugs in Git Gui and Fork Gui are related in any way other than two 
programmers making the same mistake by chance.
 
> Regards,
> Richard.
> 
> [1] 
> I can't be entirely sure of the category as I haven't looked for the codes yet, but it is presumably some group of characters outside the basic ASCII page.
> 
> PS Sorry about posting style, I'm using Outlook and I've yet to find a way of getting it to help out by indenting everything using ">".

I use Outlook 2010 for reading HTML emails at $DAYJOB. I went and 
checked, and there is an option to use "> " in Options -> Mail -> 
Replies and Forwards.

-- 
Regards,
Pratyush Yadav
