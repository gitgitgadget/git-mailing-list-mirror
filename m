From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: do not segfault when specifying a nonexistent branch
Date: Sat, 5 Oct 2013 06:55:30 +0700
Message-ID: <CACsJy8BX_fWdsCGa4jnh4CbkSMxp7btOFjwzB9K0eRtjUR_F-Q@mail.gmail.com>
References: <524EC896.3050703@opensoftware.pl> <1380896459-6451-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	robert.mitwicki@opensoftware.pl,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 05 01:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSFEF-0003jk-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 05 Oct 2013 01:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3JDX4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 19:56:04 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64335 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3JDX4C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 19:56:02 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so4662771oag.40
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qOownOykmVblwilrYFf47qcMvhY1As0z7ibqAKyiuXw=;
        b=W/t6VB4iputt0EkTil6IFHsOIttkNnCrdw/wy5/FtsgZoXncn+el2AGwuaD27goCrK
         iywOtdIk4hV/DyV/+CqlDKYFBWUMy/qzc5X3BuWYVeYhVZO1pH5hLgW/Q0BxbX/6K21z
         c7KSvkq/KYo8X6ysSAHP+f9W4NJADqFEerduU7P4lPKH/wJEKQfvKIsoeF1A1uLaY5C2
         QM7z86J1uZ/tIdP06syS7d6tQfjeMaG4eiXwuMBu2XOz/OB49fk4HnWNoUnT6mIY9o9/
         TKNSsmA9rqHAjUIVpFmi1EpsanDk80MqvVfgFZ5vTTMq9PgyvFAqKTtXUYfjXT8NLrlU
         bn/w==
X-Received: by 10.60.80.8 with SMTP id n8mr25691298oex.33.1380930961027; Fri,
 04 Oct 2013 16:56:01 -0700 (PDT)
Received: by 10.76.131.130 with HTTP; Fri, 4 Oct 2013 16:55:30 -0700 (PDT)
In-Reply-To: <1380896459-6451-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235719>

On Fri, Oct 4, 2013 at 9:20 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> I think we should emit a warning additionally?
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

I think it's nice to credit Robert for reporting the fault in the
commit message (something like "reported-by:" or "noticed-by:"...)

> ---
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0aff974..b764ad0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -688,7 +688,7 @@ static void write_refspec_config(const char* src_ref_prefix,
>
>         if (option_mirror || !option_bare) {
>                 if (option_single_branch && !option_mirror) {
> -                       if (option_branch) {
> +                       if (option_branch && our_head_points_at) {
>                                 if (strstr(our_head_points_at->name, "refs/tags/"))
>                                         strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
>                                                 our_head_points_at->name);

This prevents the segfault, but what about remote.*.fetch? Should we
setup standard refspec for fetch or..?
-- 
Duy
