Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770CC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E642075B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 10:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgH0KTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:19:34 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40823 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0KTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 06:19:34 -0400
Received: from localhost (unknown [103.82.80.232])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 944D4200002;
        Thu, 27 Aug 2020 10:19:28 +0000 (UTC)
Date:   Thu, 27 Aug 2020 15:49:24 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Toni Brkic <brkict@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: feature request - add --only-author option to git push
Message-ID: <20200827101924.iklvsy6lnscrpojs@yadavpratyush.com>
References: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Toni,

On 27/08/20 09:47AM, Toni Brkic wrote:
> Sorry if this mail list is not used for feature requests/discussions.
> This was the best list I found.
> Let me know if should post it somewhere else.
> 
> I would like to be able to configure git so that when doing git push
> git checks that I am author of
> all patches that are being pushed. If I am not authour it should not do push.
> 
> The reason for this is that a common mistake that happens when working
> with gerrit (at least for me)
> 
> Person A has uploaded patch1
> I need patch1 to continue development and cherry pick it to my repo.
> Person A uploads new version of patch1
> I have finished my patch and push to gerrit. What then happens is that
> I have an older version of patch1 and thus overwrite the new version
> by Person A
> 
> Maybe there is some way already to do this, but I could not find
> anything when searching.

Have you tried using a pre-push hook? It looks like it is exactly what 
you need:

   pre-push
     This hook is called by git-push(1) and can be used to prevent a 
     push from taking place. The hook is called with two parameters 
     which provide the name and location of the destination remote, if a 
     named remote is not being used both values will be the same.

     Information about what is to be pushed is provided on the hook’s 
     standard input with lines of the form:

         <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF

     For instance, if the command git push origin master:foreign were 
     run the hook would receive a line like the following:

         refs/heads/master 67890 refs/heads/foreign 12345

     although the full, 40-character SHA-1s would be supplied. If the 
     foreign ref does not yet exist the <remote SHA-1> will be 40 0. If 
     a ref is to be deleted, the <local ref> will be supplied as
     (delete) and the <local SHA-1> will be 40 0. If the local commit 
     was specified by something other than a name which could be 
     expanded (such as HEAD~, or a SHA-1) it will be supplied as it was 
     originally given.

     If this hook exits with a non-zero status, git push will abort 
     without pushing anything. Information about why the push is 
     rejected may be sent to the user by writing to standard error.

-- 
Regards,
Pratyush Yadav
