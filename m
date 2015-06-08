From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/13] Improve "refs" module encapsulation
Date: Mon, 8 Jun 2015 10:03:39 -0700
Message-ID: <CAGZ79kbEzrAB+Jmt8vcv2FfTsPNKY0a343ARpM8o9y0+tMiQ7g@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20Sg-0002i0-Md
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbbFHRDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:03:42 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34498 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbFHRDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:03:40 -0400
Received: by yhid80 with SMTP id d80so33014449yhi.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6qpUm85PcQudDTefHwGGF03DLphsvnI62sB3bM4RGsc=;
        b=Xa1ttq2PCqwWeEh2hztz7nACesXv2TUCpkel9qpIgi7XAFkgevgzBZaRCOiqHbkXWk
         d6CDTUbScHQRnzFy009kHU2nvh0wV3ULpag2IA/c2GGfdmw8fQxWnK/TeO3Am5TVGklN
         1wzqfWQDHc8J4E7R/sLjx98SE7MLIWHx0ldQUtH7ZdCKqePrAUNgtq9MwYDTBFLFchGW
         hGd9aC0880dWQL8X+yk6lRGuMJyWMRLd0RPOmuIcj8IzjesY1CAnYbzyr8UZVvOrjlW5
         yW80yoAFZzBn0zPs0bon47y8KK0bcGFI6Ja54GhykH1vGuC8SrQl0zXl4/S265hRMVTI
         m2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6qpUm85PcQudDTefHwGGF03DLphsvnI62sB3bM4RGsc=;
        b=Pq7K+jJK8OvwVsfFn07XjeAHJqzylbQ4YtTtiVbUz4VPtPJjVczqpN7cZujLYX1/JH
         ndMvEQ2iv18CBiQ9NrTuseZnIXz3WAOQAZRvtfdsPkcFqWenHmyNDj1LJKYPLtxw7v+f
         DayHyG2IvFqGSLtRYB1lvFsRf/79ULG9BEgOVJEkpruwJrHj5zzS2/3uDl+kOScXOCfv
         HGRKIHbF344++S5QwKtI8b3xkQDGCpeK9NS30NhmvlDSIo0EgM8XuprHubpst2nBCWkm
         1r+Ha2Pivhi3oVKPMJAk6U4iNYQBpyb1K9IWCJSt/sMHnxqwiO7hYvvQj5IDKxtnhLTY
         Oo8g==
X-Gm-Message-State: ALoCoQmz8Q7C9d7p4D5EnFmgBDvUEdsyqaR7M4ixFPFvCnC1gSQg5rcjdU+UDzWeTtL3OV+TL8y8
X-Received: by 10.170.112.18 with SMTP id e18mr19526548ykb.101.1433783020022;
 Mon, 08 Jun 2015 10:03:40 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 10:03:39 -0700 (PDT)
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271079>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Add functions to the reference API to
>
> * Delete a bunch of references at once, but *without* failing the
>   whole transaction if one of the deletions fails. This functionality
>   is used by `git remote remove` and `git remote prune`.
>
> * Create initial references during `git clone`. (During clone,
>   references are written directly to the `packed-refs` file without
>   any locking.)
>
> Also move the remaining "refs" function declarations from `cache.h` to
> `refs.h`.
>
> This improves the encapsulation of the refs module. Especially, it
> means that code outside of the refs module should no longer need to
> care about the distinction between loose and packed references.
>
> These patches are also available from my GitHub account [1] as branch
> "init-delete-refs-api".
>
> [1] https://github.com/mhagger/git

Thw whole series looks good to me.
>
> Michael Haggerty (13):
>   delete_ref(): move declaration to refs.h
>   remove_branches(): remove temporary
>   delete_ref(): handle special case more explicitly
>   delete_refs(): new function for the refs API
>   delete_refs(): improve error message
>   delete_refs(): convert error message to lower case
>   prune_remote(): use delete_refs()
>   repack_without_refs(): make function private
>   initial_ref_transaction_commit(): function for initial ref creation
>   refs: remove some functions from the module's public interface
>   initial_ref_transaction_commit(): check for duplicate refs
>   initial_ref_transaction_commit(): check for ref D/F conflicts
>   refs: move the remaining ref module declarations to refs.h
>
>  archive.c               |   1 +
>  builtin/blame.c         |   1 +
>  builtin/clone.c         |  19 ++++-
>  builtin/fast-export.c   |   1 +
>  builtin/fmt-merge-msg.c |   1 +
>  builtin/init-db.c       |   1 +
>  builtin/log.c           |   1 +
>  builtin/remote.c        |  33 +-------
>  cache.h                 |  68 ----------------
>  refs.c                  | 167 +++++++++++++++++++++++++++++++++++---
>  refs.h                  | 210 +++++++++++++++++++++++++++++++-----------------
>  remote-testsvn.c        |   1 +
>  12 files changed, 316 insertions(+), 188 deletions(-)
>
> --
> 2.1.4
>
