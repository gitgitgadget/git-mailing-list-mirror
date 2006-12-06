X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 6 Dec 2006 13:30:59 +0100
Message-ID: <81b0412b0612060430u2124a4c8v4f0dc2de65e722fb@mail.gmail.com>
References: <4576680B.7030500@gmail.com>
	 <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
	 <45769417.70601@gmail.com>
	 <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com>
	 <4576A60A.3060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:31:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r13S5CTj7WR9Pk+E8VM/Q7NfzlvSIZ7ZpniUWR9NbAP079m41jIxn8zD4fXVLMSoulXFb3Gea494Egkhk5Mm4XCbP3/wjwfEoQhcYccr/sZkWhSdl9iMS2DQbvUw+9hSEclcIyrqrnABgZQv1LV09YPuxOKEamuxCipycosM6LQ=
In-Reply-To: <4576A60A.3060003@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33442>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrvvW-0001lJ-DU for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760550AbWLFMbD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760554AbWLFMbD
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:31:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24187 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760550AbWLFMbB (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 07:31:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so125442uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 04:31:00 -0800 (PST)
Received: by 10.78.203.13 with SMTP id a13mr433721hug.1165408259486; Wed, 06
 Dec 2006 04:30:59 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 6 Dec 2006 04:30:59 -0800 (PST)
To: "Liu Yubao" <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
> >> > They problem is the exec-bit which windows does not
> >> > have and cygwin failed to correctly workaround the
> >> > limitation.
> >> >
> >> > Do a "git repo-config core.filemode false" to almost
> >> > disable the checks for exec bit.
> >> >
> >>
> >> It has been set. I guess the cause is a interrupted merge
> >> operation that leads to textual difference.
> >
> > yes, though what I can't understand is why don't you have
> > unmerged entries... Maybe it comes from playing with
> > all these commands you mentioned in the original mail.
> >
> >> After run "git reset --hard", all deleted files come back, but I reach
> >> the old state:
> >> $ git status
> >
> > When? Immediately after git reset --hard? Then you very
> > likely have no permission to write (or lost it somehow) into
> > the working directory, otherwise I don't see could this be
> > possible. git reset --hard rewrites everything.
> >
> Yes, immediately after git reset --hard. I'm sure I have write
> permission because all deleted files come back and no "permission
> denied" like message appears.

Maybe you have the files open in some editor?
Otherwise something is broken. Could you try current git
(I mean something like ba988a83f0cfdafdcfdc7ed44253840ea83578fb?

> I will try to run git in debugger, wish I can get the reason.

don't think It'd be as simple as step-by-step in debugger.
Try to instrument builtin-read-tree.c or unpack-trees.c and
see if it actually updates the files...

> $ git merge "sync from origin" HEAD origin
> Updating 088406b..ff51a98

just for fun, what does following print:

  git read-tree --reset -u HEAD && git update-index --refresh

