From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Commit 140b378d07229e breaks gitk highlighting
Date: Wed, 10 Sep 2008 16:03:35 -0400
Message-ID: <30e4a070809101303u15b98bd5uc11f545fdb5a8835@mail.gmail.com>
References: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
	 <7vtzcnx0uc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Paul Mackerras" <paulus@samba.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdVw3-0001XX-1d
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYIJUDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbYIJUDi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:03:38 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:39990 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbYIJUDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:03:37 -0400
Received: by yw-out-2324.google.com with SMTP id 9so6608ywe.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1fYog8Z+0UhNIuc95H6xCj+OG3WXRodct7/n1G8zJLY=;
        b=vI0xKw9Yuk5exT3DAUOTwxzEGWUQBzE50+CDnNBJ8PE1TGfekvZvqPCvx8SB1KgdEN
         t3ClHUUVg0ciM+V1uu3KPwESxFV1pyNIa0MHuT4QsOO5izFy7YUCQAd3uyFHCeoPWeHA
         pALqi/lrTQzROuGXZFdZQ3z7yN36j+bOBVAHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LtPFzK6J1bKplvBxGNk/v+ym/o35cntRJVslvbcPVzw0pQ51RHrBmXtc6NRxk+SN3m
         diosx3CKfOGOZmaymbUxDBOPDmGYc57j0slanPTdrIbFG9JD/6ZpeQsSuhNudbzk5KPi
         VFLJ3IU/LkDt0KnAkyfrZHj1c9o6tRn0pmpWg=
Received: by 10.187.163.5 with SMTP id q5mr201053fao.44.1221077015054;
        Wed, 10 Sep 2008 13:03:35 -0700 (PDT)
Received: by 10.187.158.14 with HTTP; Wed, 10 Sep 2008 13:03:35 -0700 (PDT)
In-Reply-To: <7vtzcnx0uc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95549>

On Wed, Sep 10, 2008 at 3:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Feeding the following to "git diff-tree -r -s --stdin -- t" misbehaves
> with that change.  The second line is skipped.
>
> 7c4d0219cf9ab6a7738a09ad7fec72d5e9f2ac67
> a786091b4a487bc08bbff4864717cf5d8383e983
> 4a09bc966449ca0a7e9a5bb70f91b47debdd7c4e
>
> This should fix it.
>

> diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
> index 1138c2d..a9e32c9 100644
> --- a/builtin-diff-tree.c
> +++ b/builtin-diff-tree.c
> @@ -71,8 +71,7 @@ static int diff_tree_stdin(char *line)
>        line[len-1] = 0;
>        if (get_sha1_hex(line, sha1))
>                return -1;
> -       obj = lookup_object(sha1);
> -       obj = obj ? obj : parse_object(sha1);
> +       obj = parse_object(sha1);
>        if (!obj)
>                return -1;
>        if (obj->type == OBJ_COMMIT)
>

Yes, that fixes the problems I see.

Thanks,
Mark
