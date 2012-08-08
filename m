From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v3 01/13] Move index v2 specific functions to their
 own file
Date: Wed, 8 Aug 2012 19:04:48 +0700
Message-ID: <CACsJy8CY--Z_BfscRCG8+Om1Z8JsFgj0BkjNyMJnwsbmyGRLXQ@mail.gmail.com>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com> <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 14:05:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz50w-0002lV-1B
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 14:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977Ab2HHMFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 08:05:20 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33810 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab2HHMFT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 08:05:19 -0400
Received: by qaas11 with SMTP id s11so448369qaa.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YTuj896YgTQLjAr0/Uk5zxpGW/TMrIMMlbFzsKzYalA=;
        b=cSO9GIu4U2mf0LE81s2nLQfrOv91yCpZlWu8gbwTOMFH7aVC8C9eXtHRyx9Fqtq1Te
         yUOJzeABpV/wGDXyveh6OKfO4MBL0odPRvb/zF4BKE9iI3c7h4v/bpD9w2khue6a9EEC
         v69c5j8U+mZXFwMfWoEsuK5958ET87E1hFhXa0whDKQfXfVkgmc32mgOaty7kQSoY6i2
         q7QeYZy8eLxaZZzeDiQ87FnL+fnj7QXcL8eHInJWY0m/34Z0nwAblOQq71UezSsEPiTM
         UpdXkAid2KyB9CnZ39OjXjKEpa1VIuAiteRSJq9YPBSldVbsxiyCHISFbsTtZEikgx46
         piAQ==
Received: by 10.224.71.1 with SMTP id f1mr20361292qaj.90.1344427518335; Wed,
 08 Aug 2012 05:05:18 -0700 (PDT)
Received: by 10.49.84.73 with HTTP; Wed, 8 Aug 2012 05:04:48 -0700 (PDT)
In-Reply-To: <1344424681-31469-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203086>

On Wed, Aug 8, 2012 at 6:17 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Move index version 2 specific functions to their own file,
> to prepare for the addition of a new index file format. With
> the split into two files we have the non-index specific
> functions in read-cache.c and the index-v2 specific functions
> in read-cache-v2.c

You still mix code changes and code move in one patch, but we can skip
it for now.

> --- a/cache.h
> +++ b/cache.h
> @@ -267,6 +259,7 @@ struct index_state {
>         unsigned name_hash_initialized : 1,
>                  initialized : 1;
>         struct hash_table name_hash;
> +       struct index_ops *ops;
>  };

Do we really need to modify "ops" content? If not make it "const
struct index_ops *ops;" which makes..

> @@ -471,8 +464,8 @@ extern int index_name_is_other(const struct index_state *, const char *, int);
>  #define CE_MATCH_RACY_IS_DIRTY         02
>  /* do stat comparison even if CE_SKIP_WORKTREE is true */
>  #define CE_MATCH_IGNORE_SKIP_WORKTREE  04
> -extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> -extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> +extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat *, unsigned int);
> +extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, unsigned int);

..this hunk go away
-- 
Duy
