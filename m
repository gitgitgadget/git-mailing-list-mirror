From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] backup_file dummy function
Date: Thu, 8 Aug 2013 09:45:46 +0700
Message-ID: <CACsJy8BfUJL6C2tignfgP5iQq2Egz03ZL7vDvVBJpaFWtD3XNQ@mail.gmail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
 <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com> <1375884049-14961-3-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 04:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7GF4-00026p-1m
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 04:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537Ab3HHCqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 22:46:18 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57109 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933375Ab3HHCqR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 22:46:17 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so2069395pde.24
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a3qZwJLVPU+TmTfeqxS5jmSBfdugGshvLYmqoXI6Qk8=;
        b=jL9I5sPNCgklFs3RHn+zpApGnvTXy4+KbnFWwlQ9XLWWaVLkTRXTYjghuLfWPinsQh
         bL6vtqHeqZCZceWSzg0kVFXWpi8q0hKyLCVwsqywkWePv1LXHMRei5iw6m16H241Ka2E
         Cyc734q8PKPU0bxwAAQy2wk6vaVBO2JXxNwffezhcsxwtYiJWHS4XdW4h1KyBRF2Lpoc
         lmdFeJaF6BbDDzun1Pm6/uRgLZqvj6tO8ilMGw81A5y493VEgOOpKF85v/kjPAVq9Owh
         2S4oIm7IBnhX3iz3RwTko4fH3qm0OEK0+9QbqtvN5fxIyspS9Ku6Yv5jMI/mqrX5ZysE
         jCwQ==
X-Received: by 10.68.115.15 with SMTP id jk15mr131533pbb.36.1375929976944;
 Wed, 07 Aug 2013 19:46:16 -0700 (PDT)
Received: by 10.70.102.163 with HTTP; Wed, 7 Aug 2013 19:45:46 -0700 (PDT)
In-Reply-To: <1375884049-14961-3-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231859>

On Wed, Aug 7, 2013 at 9:00 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> ---
>  pack-write.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/pack-write.c b/pack-write.c
> index e6aa7e3..b728ea2 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -344,6 +344,11 @@ struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>         return sha1fd(fd, *pack_tmp_name);
>  }
>
> +void backup_file(char *filename)
> +{
> +
> +}
> +

I think the function looks like this (before it got lost after rebase)

+static void backup_file(const char *path)
+{
+       struct stat st;
+       if (repack_flags & REPACK_IN_PROGRESS &&
+           !stat(path, &st)) {
+               struct strbuf old = STRBUF_INIT;
+               strbuf_addf(&old, "%s.old", path);
+               if (rename(path, old.buf))
+                       die_errno("unable to rename pack %s", path);
+               string_list_append(&backup_files, strbuf_detach(&old, NULL));
+       }
+}
+
-- 
Duy
