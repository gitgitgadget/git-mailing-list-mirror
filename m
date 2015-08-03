From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 3 Aug 2015 19:35:54 +0700
Message-ID: <CACsJy8B4HY2Vv=Zyf_T6qXkWY79JaGjPafv-SK0UcYukf=fH1w@mail.gmail.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
 <55BC4438.8060709@alum.mit.edu> <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
 <55BC6C5C.1070707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 14:36:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMEyo-0004bq-JV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 14:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbbHCMgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 08:36:24 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34131 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbHCMgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 08:36:24 -0400
Received: by ioea135 with SMTP id a135so142699703ioe.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CrAdpAMQCsgt/YTh2MiZFOf8IDPo9+4xiPNmeVSu9uQ=;
        b=lH19IQawH/n3uV0ds+KpHQJf0u2oo/FFER8Kd1Vm7a2eEl0ghLiVjyLOpQyoRGe3NG
         knzMNyTRlrMLYIMp6X6oO8TXTPWZUehUw2dkodrNkaYMtOff2gh3V1hl25KkJVD2hj8S
         /iJihi7abBTyA9iBtuIxOovnaM7uXCUm3xdK0LqKiR7zr38rReM4ljttu03v0NXWe4fl
         +piZosXohazTANdACIxWqSoHwsz8UZc1whMBb59r12S8+dCobTxAKY/OgiIvbJ+CDE83
         EUXqKjPDpR5laLRNs6y7qMTCtGVxlBjDTaHXg99cky2pIs8NRgyXLo2UA/vlpKSd2+4+
         9V3g==
X-Received: by 10.107.4.1 with SMTP id 1mr19537616ioe.10.1438605383400; Mon,
 03 Aug 2015 05:36:23 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 05:35:54 -0700 (PDT)
In-Reply-To: <55BC6C5C.1070707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275162>

On Sat, Aug 1, 2015 at 1:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> For each worktree, we could then create a different view of the
> references by splicing parts of the full reference namespace together.
> This could even be based on config settings so that we don't have to
> hardcode information like "refs/bisect/* is worktree-specific" deep in
> the references module. Suppose we could write
>
> [worktree.refs]
>         map = refs/worktrees/*:
>         map = refs/bisect/*:refs/worktrees/[worktree]/refs/bisect/*

Perhaps the destination should be worktrees/[worktree]/refs/bisect/*.
Does it have to start with "refs/"?

> which would mean (a) hide the references under refs/worktrees", and (b)
> make it look as if the references under
> refs/worktrees/[worktree]/refs/bisect actually appear under refs/bisect
> (where "[worktree]" is replaced with the current worktree's name). By
> making these settings configurable, we allow other projects to define
> their own worktree-specific reference namespaces too.
>
> The corresponding main repo might hide "refs/worktrees/*" but leave its
> refs/bisect namespace exposed in the usual place.
>
> "git prune" would see the whole namespace as it really is so that it can
> compute reachability correctly.

For multiple wortrees, first we basically remap paths in .git,
relocate some to worktrees/[worktree]/ (already done), then we're
going to remap config keys (submodule support, just proof of concept
so far), remapping ref paths sounds like the logical next step if some
under refs/ needs to be worktree-specific. I wonder if current ref
namespace code could be extended to do this?
-- 
Duy
