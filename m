X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to show log for only one branch
Date: Mon, 06 Nov 2006 18:41:57 +0800
Message-ID: <454F1175.9080506@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 10:43:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m56M8dqMBfpijF560m24hFsYRD9/htiOZ4FFELVsI/SmDBAjEys5QSkclpbffi40IuFF2znWroNQ6F4sudVNCkCeJazb12d3RaXZEFiSaztrcY5B5D6MRhHTn65+nFa7GH8ZNbxi9dq9h0ozD3sCmSdGuBMaPPqtbMJDRHkzB98=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31006>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh1wR-0008NP-GD for gcvg-git@gmane.org; Mon, 06 Nov
 2006 11:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751046AbWKFKm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 05:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWKFKm4
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 05:42:56 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:56188 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1751046AbWKFKmz
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 05:42:55 -0500
Received: by nz-out-0102.google.com with SMTP id z3so766683nzf for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 02:42:54 -0800 (PST)
Received: by 10.35.102.18 with SMTP id e18mr387121pym.1162809774439; Mon, 06
 Nov 2006 02:42:54 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id x72sm4831711pyg.2006.11.06.02.42.52; Mon, 06 Nov 2006 02:42:54 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Liu Yubao <yubao.liu@gmail.com> writes:
> 

Snip many great detailed description, thank you very much, I have
a question about the way git treats fast forwarding but that will
be another topic.

> What's mainline is _not_ important, and which parent is first is
> even less so.  It solely depends on what you are looking for
> which branch matters more.  Putting too much weight on the
> difference between HEAD^1 vs HEAD^2 statically does not make any
> sense.
> 
> Reflecting this view of history, git log and other history
> traversal commands treat merge parents more or less equally, and
> _how_ you ask your question affects what branches are primarily
> followed.  For example, if somebody is interested in your device
> driver work, this command:
> 
> 	git log -- drivers/liu-s-device/
> 
> would follow your side branch.  On the other hand,
> 
> 	git log -- fs/
> 
> would follow Linus's development track while you were forked, if
> you did not do any fs/ work while on that side branch and
> Linus's development track had works in that area, _despite_ the
> merge you gave Linus has your development track as its first
> parent.
> 

This is perfect and enough for two branches that work on different
files, but if two branches modify same files, "git log" can't separate
commits clearly. For example, I want to know what happened in your
git's "next" branch, I hope to get logs like this:
     Merge branch 'jc/pickaxe' into next
     Merge branch 'master' into next
     Merge branch 'js/modfix' into next
     ...
     some good work
     ...
     Merge branch ....

I just want to *outline* what happened in "next" branch, if I am interested
in what have been merged from 'jc/pickaxe' I can follow the merge point again
or use something like "git log --follow-all-parents".

Instead, "git log" interlaces logs from many branches, I find it's a little
confused: why does "git log" of current branch contain many logs from other 
branches? (This is not a real question, I know the reason)

I indeed understand that HEAD^1 is not always the commit that my work
bases on before a merge (thanks for your detailed description again:-),
it doesn't make sense to show HEAD~1, HEAD~2, HEAD~3 and so on, that's
to say 'git log' will never meet my requirement.

Maybe reflog is what I need, I want to know which commits "next" have pointed
to, but reflog is only for local purpose, it's not downloaded by 'git clone'
