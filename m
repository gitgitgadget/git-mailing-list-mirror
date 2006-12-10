X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 11 Dec 2006 00:37:54 +0100
Message-ID: <200612110037.54309.jnareb@gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <200612110002.05847.jnareb@gmail.com> <b0943d9e0612101524w3a2cccecqdd12023233e8ec0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 23:35:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FJbWRXQyRb3m45tTZKOIy1Cuimw0eDLhZsCczhiVyjHv4+/hrKgqXRHHt4By1aMNaWGoh3h6mb0jODh0447tPWQKmBc+l1zllBfRe8//CcArq/OVB1VCVIBKZz/ZSnNdewgAHiYkY0LzlcTTky/S9rwiRWnCU5is0BK6Gd6fqSg=
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0612101524w3a2cccecqdd12023233e8ec0c@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33961>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYCo-0000SW-TU for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762456AbWLJXfg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762464AbWLJXfg
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:35:36 -0500
Received: from hu-out-0506.google.com ([72.14.214.233]:44338 "EHLO
 hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762424AbWLJXff (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 18:35:35 -0500
Received: by hu-out-0506.google.com with SMTP id 36so755832hui for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 15:35:34 -0800 (PST)
Received: by 10.67.106.3 with SMTP id i3mr8967896ugm.1165793733708; Sun, 10
 Dec 2006 15:35:33 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id j3sm4986018ugd.2006.12.10.15.35.32; Sun, 10 Dec
 2006 15:35:32 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:
> On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Catalin Marinas wrote:
>>> Yes, only for updating HEAD. The refs in refs/patches/<branch>/ are
>>> written directly. I initialy wanted to add patch history support using
>>> reflogs and added "git-update-ref -m ..." for the patch commits but I
>>> found slow the pushing operation a bit. Do you only want to track the
>>> reflogs for HEAD?
>>
>> Yes, I want for StGit to provide reasons when updating HEAD. I know that
>> StGit manages it's own versioning of patches not using reflog -- fine.
>> What matters for me is reflog for HEAD after "stg commit; stg clean".
> 
> Just curious, do you run the "stg commit; stg clean" commands together
> and in this order? Neither of them would update the HEAD. The "commit"
> command simply removes the StGIT metadata for the applied patches
> since it no longer needs to track them (permanently stored to the
> repository). It doesn't change HEAD. The "clean" command only affects
> the HEAD if there are empty applied patches but after a "commit" there
> won't be any patches (only the unapplied ones which do not affect
> HEAD).
> 
> Maybe we could have reflog info for "push", "refresh", some undo
> operations. Are they of any use (I haven't used them so I can't tell)?

Ooops, I haven't been clear enough.

I meant that afer "stg commit; stg clean" I won't have any StGIT metadata,
but I'd have git metadata in reflog.

I'd like to have info in reflog for each command which changes head;
for example "push", "refresh", perhaps "pop", "float", "uncommit".
Just so I don't have long sequence of ref changes in reflog without
description of said changes after some work with StGIT on branch.


BTW. currently I use StGIT to manage a series of commits on feature
branch which implements step-by-step single feature, and would be
later send as a patch series. With StGIT I can work on final patch
in series, notice that underlying feature developed in earlier patch
(earlier commit) needs modification, so I do refresh, pop until
given patch, change patch, push all, and work on patch. Or for example
if I notice that I'd have to implement some basic feature separately,
best at beginning: pop all, create new patch etc. Very nice.

-- 
Jakub Narebski
