From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Tue, 16 Apr 2013 14:29:51 -0700
Message-ID: <CA+sFfMd-pfmPXNCoAfH59om1cdYh1=bJ7yb-BGZHjkra5Gm_uw@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
	<CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
	<CALkWK0=L4mqVBqDMWgzN+BT5bnEF0L6d=GPXvrNhPL_Asvdq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDRu-0006K2-2q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414Ab3DPV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 17:29:53 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49466 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965271Ab3DPV3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 17:29:52 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so3089936wiw.14
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sqzoNX/2x1XTx8+gCiGOABEk9YXUEq7kwoi73TisNSs=;
        b=kiTcMDgJ75hIvxHXi2TZSjcetFimLotgDYK1H3lINSUqafEHc/XHrEqZF5l3qwf2/i
         cOmPb0X8mJjsfD2XXcQwBXedlTQ74t7kq8APqkZL+Q517wMDTVvb9C5pqwd0qhCLI9ep
         V5cysIUNFeLc9r5IjGG3ha1Yk3/mK0EJqYmnWtLYf2QELvIiZ9qiAF+pveZ/S2y1hoz0
         0ugVE53RQ8Vsq8PvA6MJybGryG8chR1mcQ2mySSqr8ECODk0BhX/ce/lYS1udTT/6oQg
         sK1DXMWLsdgWpYTXbcNrCmzFCXTigN6aYrpsMUZk4qtrGhNrCL5RlxBptVGfWQOU7OdL
         ZK5Q==
X-Received: by 10.194.10.129 with SMTP id i1mr6989750wjb.21.1366147791320;
 Tue, 16 Apr 2013 14:29:51 -0700 (PDT)
Received: by 10.194.249.69 with HTTP; Tue, 16 Apr 2013 14:29:51 -0700 (PDT)
In-Reply-To: <CALkWK0=L4mqVBqDMWgzN+BT5bnEF0L6d=GPXvrNhPL_Asvdq8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221476>

On Tue, Apr 16, 2013 at 1:11 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Brandon Casey wrote:
>>             # Save another stash here
>>
>>             echo bash >file
>>             git add file
>>             git stash save "something"
>>
>>             # Now git stash show stash^{/quuxery} no longer works.
>
> Ah, yes.  My stupidity.  Why was I expecting ^{/quuxery} to dig
> through the reflog?
>
>> An extension to the reflog dwimery that implements @{/<text>} could be
>> interesting though.
>
> Yeah, this sounds interesting.
>
> My initial itch that led up to this: I wanted a way to stash something
> away and recover it at a later time predictably for rebase.autostash
> (there might have been other stash invocations in between).
> Originally, I thought I'd need a refs/stashes/* or something of the
> sort to solve this problem, but git-stash.sh hard-codes refs/stash
> everywhere (and so do other things like reflog).  So, I was thinking
> about retrieving it based on commit message, but the solution is still
> short of ideal.  What are your thoughts on my original refs/stashes/*
> idea?

You can create a stash without modifying the refs/stash reflog using
'sha1=`git stash create`' and then later apply it using 'git stash
apply --index $sha1'.  You'll have to reset the work directory
yourself though since 'git stash create' does not do so.  The stash
created this way is just a dangling commit so it will have a lifetime
according to the gc.pruneexpire (default 2 weeks currently).

-Brandon
