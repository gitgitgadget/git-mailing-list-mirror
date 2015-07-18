From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Fri, 17 Jul 2015 21:00:46 -0700
Message-ID: <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Garbageyard <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 06:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGJJI-00039T-MK
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 06:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbbGREBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 00:01:07 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38002 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbbGREBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 00:01:06 -0400
Received: by iggf3 with SMTP id f3so49888764igg.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HLIKieS8MgPYp13NXd0yemNuCrwpElmzn86g6ywru14=;
        b=L9CC1UC0ch0gFOGGTBqrN1dOFdWOjIDXLNiNCTFxoujV6Di1bSxbFDBjQgPRjJN+7Y
         PLtKB68KkyDCqrmNj9ZUO0I6Vw7tX0IrXOTSiU7r3p6cRB1feEpQPY7V1Gms/ZrYqB7i
         FG8p8GRVyxnXolRdWdeZORJqqOAioCJDauFxRgnNRGwRZ14Xq7iO4DnZYsSLRbBl50au
         FC6GUO1fnkudE3XGPej9pbafn4KWwZKWCMZOIPPkUitYFPdtcv8U5xdGcnKdGdWGg7u2
         2XrLkuZ2Jf+nKbzmYB9tyessaAuBIAlP00AQdlIl+pGIebtmpSZz682iKDhvkQq3eh4L
         9tfA==
X-Received: by 10.50.88.6 with SMTP id bc6mr890430igb.24.1437192065729; Fri,
 17 Jul 2015 21:01:05 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Fri, 17 Jul 2015 21:00:46 -0700 (PDT)
In-Reply-To: <1437159533304-7635764.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274154>

On Fri, Jul 17, 2015 at 11:58 AM, Garbageyard <varuag.chhabra@gmail.com> wrote:
> We have a pre-receive hook that checks for JIRA ID whenever someone pushes
> code to Git server. I'm trying to avoid this check when someone is applying
> a tag. Here's the link for the script: http://pastebin.com/VnMQp5ar
>
> This is the link for output: http://pastebin.com/tBGmYaZF
>
> Problem is that if i run the following command, the output that i get on
> command line is 0
>
> git describe --exact-match ac28ca721e67adc04078786164939989a5112d98 2>&1 |
> grep -o fatal | wc -w
>
> So i'm wondering why it's not entering the IF block (as confirmed in the
> output link)
>

Probably due to environment variables set by the git hook. But.. this
is definitely not at *ALL* what you want to do. Junio has a good
explanation below. This doesn't make even any sense at all to me...

> I agree this is a bad implementation (and i will change it soon) for
> checking tags and can be easily done by just checking whether $refname
> starts with refs/tags/ but i'll really appreciate if someone could tell me
> the mistake i'm committing. I've spent few hours banging my head on this.
>
>
>

Ok, so the issue I believe is this:

you're running git describe on the local side. But the pre-receive
hook hasn't actually accepted the ref yet so git-describe on the
server will fail.

This is why you should just check refs/tags/* as regular pre-receive
hook examples do.

Regards,
Jake

> --
> View this message in context: http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
