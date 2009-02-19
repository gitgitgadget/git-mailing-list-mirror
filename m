From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries 
	marked CE_REMOVE
Date: Thu, 19 Feb 2009 09:24:01 +0100
Message-ID: <81b0412b0902190024t3fc7ab20r9a23c72270ac1033@mail.gmail.com>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:25:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La4Dv-00014V-Q0
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbZBSIYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbZBSIYG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:24:06 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62764 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZBSIYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:24:04 -0500
Received: by ewy14 with SMTP id 14so243319ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 00:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cbHjEGtmm/5UmjoSlfbcp01W9JkTO70UFbFTDewoItM=;
        b=CC0ztkh/mZKBLpsKwPV6g6ZK6lrsBtfLDwL5D2bRORg3UUEa2SqxwbXfuiKof3aRVB
         X9QRgPD5o3Jc1FVYXx96I0uBdKr4jeB/9Mf62AdvLyfGMaonB045wp0Hjs1qvSoHbyWk
         W73UlOcfFqtQYqIDHcTJsa4JHB4aabdFADEko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FJYJRbgOox6JKhJog7pndU+BATFMz4Y83TIp2qlBVVGVaopdrRZNqJ4pHflUB96oBk
         04ClsxF/BXSg9geAYQpvcOR+H73S1TehbqAR6kuUdkQUQthCUYHxAHaEarHelCt5OxYi
         6pUHNg5F2w95rmDywWWSzPqU7skXU5Q7bc6w4=
Received: by 10.210.62.3 with SMTP id k3mr2229882eba.76.1235031841860; Thu, 19 
	Feb 2009 00:24:01 -0800 (PST)
In-Reply-To: <1234995483-933-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110646>

2009/2/18 Kjetil Barvik <barvik@broadpark.no>:
> If we can trust the numbers from oprofile in this case, we saved
> approximately ((7710 - 46) * 20000) / (2 * 1000 * 1000 * 1000) = 0.077
> seconds CPU time with this fix for this particular test.  And notice
> that now the CPU did only 46 / 15 = 3.1 cycles/instruction.
...
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e3c3fa1..273b5da 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -93,11 +93,9 @@ static int check_updates(struct unpack_trees_options *o)
>                        display_progress(progress, ++cnt);
>                        if (o->update)
>                                unlink_entry(ce);
> -                       remove_index_entry_at(&o->result, i);
> -                       i--;
> -                       continue;
>                }
>        }
> +       remove_marked_cache_entries(&o->result);
>        remove_scheduled_dirs();
>

What commit is this change based on? It does not apply to any
of Junio's master, next, or pu...
