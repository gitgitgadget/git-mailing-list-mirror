From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/22] read-cache: read index-v5
Date: Sun, 7 Jul 2013 16:18:50 -0400
Message-ID: <CAPig+cSyvjSKR7s8KpwsZxGcbHbxHXU1-4BRY02VvOPNvkLTng@mail.gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-16-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 22:19:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvvQO-0002Nt-G6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 22:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab3GGUSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 16:18:54 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:45719 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab3GGUSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 16:18:52 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so3182544lab.8
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4z9c5x64p/sotb7ls1jgbjrcF554GTe8xK9SBMh7XXg=;
        b=LMLDCJ/VwJ7xqVkJ9DntzeVLSpxYzKc8RVYGkWAnEVDmjvU0fgB8Hu3z+d+JptfYwx
         NTOoI7kGMrXtnASPrnqbl8snesSEYBncifCiEgkPNkqguGtl1TMg5mLOpOzDLLaWcdRu
         d8qP5JSPzRTQ06fMO6SWM/qfVz/MB0662tD3Bzgb7RLvY9agG473yVq4I1PgspZlNnCZ
         wY6Pp5AYNZGB+fLe2cXc5TTWoGGVOMoAATTvVre/+6/8Zol+5FZ5aKdljwLOr3x8dJOq
         7foTuXmtmVYBGOhJbpF6mQxWgXmThHpLFnqe/gEys+R988w4lP2OdTVI8g/o6wPZtLKl
         OMVg==
X-Received: by 10.152.5.227 with SMTP id v3mr9133520lav.31.1373228330770; Sun,
 07 Jul 2013 13:18:50 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Sun, 7 Jul 2013 13:18:50 -0700 (PDT)
In-Reply-To: <1373184720-29767-16-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: JndN2OI9zrvAncBTdGV4renaoPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229803>

On Sun, Jul 7, 2013 at 4:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make git read the index file version 5 without complaining.
>
> This version of the reader doesn't read neither the cache-tree
> nor the resolve undo data, but doesn't choke on an index that
> includes such data.
> ---
> diff --git a/read-cache-v5.c b/read-cache-v5.c
> new file mode 100644
> index 0000000..e319f30
> --- /dev/null
> +++ b/read-cache-v5.c
> @@ -0,0 +1,658 @@
> +static struct directory_entry *read_directories(unsigned int *dir_offset,
> +                               unsigned int *dir_table_offset,
> +                               void *mmap,
> +                               int mmap_size)
> +{
> +       int i, ondisk_directory_size;
> +       uint32_t *filecrc, *beginning, *end;
> +       struct directory_entry *current = NULL;
> +       struct ondisk_directory_entry *disk_de;
> +       struct directory_entry *de;
> +       unsigned int data_len, len;
> +       char *name;
> +
> +       /* Length of pathname + nul byte for termination + size of
> +        * members of ondisk_directory_entry. (Just using the size
> +        * of the stuct doesn't work, because there may be padding

s/stuct/struct/

> +        * bytes for the struct)
> +        */

Also:

  /*
   * Format multi-line comment
   * like this.
   */

Remaining multi-line comments appear to be formatted correctly.
