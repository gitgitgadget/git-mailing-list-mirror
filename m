From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 12/24] read-cache: read index-v5
Date: Sat, 30 Nov 2013 13:19:37 +0100
Message-ID: <CALWbr2ybgpdDJLRKA4zwPmRE4LQv4VWLJM6Jv0dO-GyHREGW7g@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
	<1385553659-9928-13-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, robin.rosenberg@dewire.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 13:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmjWd-0004Nw-UE
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 13:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab3K3MTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 07:19:40 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:38581 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3K3MTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 07:19:39 -0500
Received: by mail-la0-f54.google.com with SMTP id b8so1283582lan.27
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 04:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0URBZ/UF9xM0PjAJV3Ciml/q4NLotZKf5TSs25ywSeg=;
        b=grNv16APIXboiXgAwPYA1D0EpAInQbmQEJXX7nTAvzvQ6q2X/ljp5SebiUGuoijnXy
         dSm7dF8AywOxOatzjG8Q0s+8UbcBZI6/OuKSNzJ3ybbAYqIPeT/T9RBzIgPDBHyFeArQ
         EtQHYgmegCsoMKW6XNTSmPyKyVNYzrFIs2mNPJNe23+ZIOgPJs9UoZ+e7X0t8IdP+OY6
         PlXOjIRXhV31EiCU6mbpwwUMTWvjJGRAmK44x9KklhYAKFk/8BdO5BMJo8nla/5Sc2XF
         sTX/JxMfN24cAozJBfbpyMzO744bsJW5QS77GoAmeWXpVo7w/GTIYUhKpaG6MFqp6mJ4
         8JoQ==
X-Received: by 10.112.37.134 with SMTP id y6mr667410lbj.29.1385813977553; Sat,
 30 Nov 2013 04:19:37 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Sat, 30 Nov 2013 04:19:37 -0800 (PST)
In-Reply-To: <1385553659-9928-13-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238557>

On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make git read the index file version 5 without complaining.
>
> This version of the reader reads neither the cache-tree
> nor the resolve undo data, however, it won't choke on an
> index that includes such data.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> [...]
> +static struct directory_entry *read_directories(unsigned int *dir_offset,
> +                                               unsigned int *dir_table_offset,
> +                                               void *mmap, int mmap_size)

Minor nit: why is this mmap_size "int" while all others are "unsigned long" ?

> [...]
> +static int read_entry(struct cache_entry **ce, char *pathname, size_t pathlen,
> +                     void *mmap, unsigned long mmap_size,
> +                     unsigned int first_entry_offset,
> +                     unsigned int foffsetblock)
> [...]
> +static int read_entries(struct index_state *istate, struct directory_entry *de,
> +                       unsigned int first_entry_offset, void *mmap,
> +                       unsigned long mmap_size, unsigned int *nr,
> +                       unsigned int foffsetblock)
> [...]
> +static int read_index_v5(struct index_state *istate, void *mmap,
> +                        unsigned long mmap_size, struct filter_opts *opts)
