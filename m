From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 2 Feb 2014 19:15:44 +0700
Message-ID: <CACsJy8AWMr95fTS_TRkPiU_ety-KWYuimKj+SUAt-BRoAU0JTA@mail.gmail.com>
References: <20140131202142.GA9731@mule> <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com>
 <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com> <20140202111330.GB14729@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vyc-0004V6-8i
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaBBMQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 07:16:16 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33499 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaBBMQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:16:15 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so9755327qcx.10
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aKb3ntI3/qjhX/6QGcltdJgKDKMgF11E02FSfAoGd+Y=;
        b=FIbnEJEVks7iRGgqvQP4E5VhLw8+S6hFoDl58GGNCd8I50htpmxH+2GR0NPMLMTqf5
         c/RNw32Ra6W5QvNpVF5AH7O4TsHzfFirH+Cw3oLImZmbPWxj4L+Ksc6wvYJfOI6iqob6
         cSZybf6LmtKcFFFTQhWvmk4XJZz2LwI8V/EKwSfwS7zPkQIv6QEEu9pznX0GEKQ61OoY
         N28xaaiopzuuYQU+Mw5b4AAdjc0mzVcp8kTFotDfkdO235235TH6Tg9wgOiwNGpmJiou
         0u4gUqeXWpZ7TkQnclmN5hZ2uDxCXa61EHiFOdvKLGiRQHta6cW2dUe7sS2pIXfUK9nt
         4uHQ==
X-Received: by 10.140.47.212 with SMTP id m78mr44636544qga.21.1391343374967;
 Sun, 02 Feb 2014 04:16:14 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 2 Feb 2014 04:15:44 -0800 (PST)
In-Reply-To: <20140202111330.GB14729@mule>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241369>

On Sun, Feb 2, 2014 at 6:13 PM, Martin Erik Werner
<martinerikwerner@gmail.com> wrote:
> diff --git a/setup.c b/setup.c
> index 2270bd4..5817875 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -32,9 +32,11 @@ static inline int abspath_part_inside_repo(char *path)
>         if (strncmp(path, work_tree, wtlen) == 0) {
>                 if (path[wtlen] == '/')
>                         memmove(path, path + wtlen + 1, len - wtlen);
> -               else
> +               else if (path[wtlen - 1] == '/' || path[wtlen] == '\0')
>                         /* work tree is the root, or the whole path */
>                         memmove(path, path + wtlen, len - wtlen + 1);
> +               else
> +                       return -1;

No, you can't return here. "/abc/defghi" might actually be a symlink
to "/abc/def". If it does not match, let the following loop handle it.
-- 
Duy
