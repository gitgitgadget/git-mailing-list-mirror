From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: repack_without_refs may be called without error
 string buffer
Date: Thu, 20 Nov 2014 10:15:00 -0800
Message-ID: <CAL=YDWkOa4wmQdq5wOUZVQUUhnm49AVpf6gGM=5RO9Qi5dCzew@mail.gmail.com>
References: <1416506666-5989-1-git-send-email-sbeller@google.com>
	<1416507040-6576-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:15:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWG4-0003OL-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbaKTSPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:15:02 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:51199 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680AbaKTSPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:15:01 -0500
Received: by mail-vc0-f172.google.com with SMTP id hq11so1652158vcb.3
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8aa116FecncK4bMZcwbJRG10/1zo25EuchTEE50OL8Q=;
        b=Gk9VOm+nhvghSCE+XsuoQ8ki+7YBYE+ZdXL4c4szwKGfuw/qmBRhFxZRHjc//tIeOp
         f9CO9wAASs9VKKo6vDlyU1SKCiBGDxTjGPyLeIsuqPWuIOsvQW+LNXOWrLp1EOxxn8kz
         CKNAkkLYYvHRchNB92g6rZYr06mekwTbFd36Lr4yKKbZYSG52O9zc6+lkbdBM6zC3F74
         ryZbf3xPoiXnta9refU4EB1fEoT/rcmycL4Zd3Iahk9r4exD6FHmwuMHDwWGS/Z0KjRk
         O1/8rUubJRYmugOMk8UViiTFEiDoFhpTSZRlO4gCeoHBVf5WT2H8405XYAKKfjDsnJ0X
         uXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8aa116FecncK4bMZcwbJRG10/1zo25EuchTEE50OL8Q=;
        b=HXxJSGJYnh/O5mUFi1LS2OGEVd9y4ZaE/1bZhkkG2Dvtn96k5Rb6SjUjvMU2RdFJ0G
         XH6N4R5tSGsRKoi9wrJMYTXIj9jBvLD/uE2R+gWalq5Ldt5hHv9M6L9CTXoU2i5R0P1n
         z0i+qj2WHnmmW/0SKigQxiZztT+WULSWaoOmlVziX8VxQVXw31jgXK1Hes63NfXZ7azc
         YS+DW3NQp9bZtomDR/eY06DV1tJBVmyEEy0asCywD6Yxw100U8OVruNptmHzdFzTDQzq
         d+e3HmoHwTceDy+3vJ65aRiI1KUbMIDO3jy81iZHQouPnH6r39w1MH7dzOQ+lYBgofV9
         U54g==
X-Gm-Message-State: ALoCoQmgysLhGNpJUUn0jkPbXO4mqtX4ZVWBIE/aYBjYvw7ixPPMbjsTULiNYPOVKWOU8ouTeXx/
X-Received: by 10.53.13.10 with SMTP id eu10mr38345237vdd.21.1416507300699;
 Thu, 20 Nov 2014 10:15:00 -0800 (PST)
Received: by 10.52.76.167 with HTTP; Thu, 20 Nov 2014 10:15:00 -0800 (PST)
In-Reply-To: <1416507040-6576-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:10 AM, Stefan Beller <sbeller@google.com> wrote:
> If we don't pass in the error string buffer, we skip over all
> parts dealing with preparing error messages.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This goes ontop of [PATCH v5] refs.c: use a stringlist for repack_without_refs
> if that makes sense.
>
>  refs.c | 8 ++++----
>  refs.h | 1 -
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ebcd90f..3c85ea6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2646,8 +2646,6 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
>         struct string_list_item *ref_to_delete;
>         int ret, needs_repacking = 0, removed = 0;
>
> -       assert(err);
> -
>         /* Look for a packed ref */
>         for_each_string_list_item(ref_to_delete, without) {
>                 if (get_packed_ref(ref_to_delete->string)) {
> @@ -2661,7 +2659,9 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
>                 return 0;
>
>         if (lock_packed_refs(0)) {
> -               unable_to_lock_message(git_path("packed-refs"), errno, err);
> +               if (err)
> +                       unable_to_lock_message(git_path("packed-refs"),
> +                                              errno, err);
>                 return -1;
>         }
>         packed = get_packed_refs(&ref_cache);
> @@ -2688,7 +2688,7 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
>
>         /* Write what remains */
>         ret = commit_packed_refs();
> -       if (ret)
> +       if (ret && err)
>                 strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
>                             strerror(errno));
>         return ret;
> diff --git a/refs.h b/refs.h
> index c7323ff..b71fb79 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -170,7 +170,6 @@ int pack_refs(unsigned int flags);
>   * strbuf.
>   *
>   * The refs in 'without' may have any order.
> - * The err buffer must not be omitted.
>   */
>  extern int repack_without_refs(struct string_list *without, struct strbuf *err);
>
> --
> 2.2.0.rc2.23.gca0107e
>

LGTM
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

Nit:
While it does not hurt to allow passing NULL,  at some stage later
this function will become
private to refs.c and ONLY be called from within transaction_commit()
which will always
pass a non-NULL err argument.
At that stage we will not strictly need to allow err==NULL since all
callers are guaranteed to
always pass err!=NULL.

That said, having err being optional is probably a better API. Maybe
err should be made optional for all other functions that take
an err strbuf too so that the calling conventions become more consistent?
