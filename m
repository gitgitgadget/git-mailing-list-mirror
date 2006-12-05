X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/3] Document some current bugs and add to the TODO list.
Date: Tue, 5 Dec 2006 17:30:56 +0000
Message-ID: <b0943d9e0612050930t187e65c4g6a3c44ea1fefc940@mail.gmail.com>
References: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
	 <20061130002717.21981.38049.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 17:31:14 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ObyI0tmeJZZ7e3ThOq5K9jzFQ39487UuwOXNKEQSqaTc3NAXaF5r74SmqnzYbhyUQgeKE83/Th6Zk4t/jgyhjF48gTWPAOdjde9hA+O9u3irfKVozrwXaK+kS0tQBcBp9FLvT0WQG18TdlyX0Gh/OYa63GXL3EXsediZlZ97asE=
In-Reply-To: <20061130002717.21981.38049.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33358>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gre8D-00032p-BY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 18:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968499AbWLERa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 12:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968501AbWLERa6
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 12:30:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:1236 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S968497AbWLERa5 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 12:30:57 -0500
Received: by nz-out-0102.google.com with SMTP id s1so2139874nze for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 09:30:56 -0800 (PST)
Received: by 10.65.250.11 with SMTP id c11mr15497190qbs.1165339856188; Tue,
 05 Dec 2006 09:30:56 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Tue, 5 Dec 2006 09:30:56 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

Hi Yann,

See some comments below (I removed those which I am OK with or I fixed).

On 30/11/06, Yann Dirson <ydirson@altern.org> wrote:
> +- numeric shortcuts for naming patches near top (eg. +1, -2)

We currently have the -n option for push and pop that accepts number.
Because of python, you can also, for example, push to the last but one
with "push -n -1" (similar for pop). Do you mean shortcuts for the
"goto" command?

> +- refuse to "stg init" a branch known as remote (through .git/remotes/,
> +  .git/branches/ or any other info)

I think it is up to the user not to do this. You would first need to
check out such a branch anyway.

> +- cannot use "stg refresh file" after "cg-rm file"

It seems to work for me. Can you send some log messages?

> +- "stg goto $(stg top)" fails with unhandled exception

It works for me. What StGIT version do you use?

> +- at least "commit is not robust wrt out-of-diskspace condition:
> +|deps$ stg commit
> +|error: git-checkout-index: unable to write file MANIFEST
> +|error: git-checkout-index: unable to write file META.yml
> +|error: git-checkout-index: unable to write file Makefile.PL
> +|error: git-checkout-index: unable to write file doc/README.dbk.xml
> +|error: git-checkout-index: unable to write file graph-includes
> +|error: git-checkout-index: unable to write file lib/graphincludes/params.pm
> +|fatal: unable to write new index file
> +|stg commit: git-read-tree failed (local changes maybe?)
> +|Committing 4 patches...
> +(luckily nothing was really committed)

But that's the correct behaviour, not to commit anything. The only
problem I see (and I fixed) is the "Committing..." message on stdout
without flushing, causing it to appear afterwards. StGIT cannot know
how much space is needed by GIT to check this beforehand. It simply
exits when a GIT command failed.

Thanks.

-- 
