From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 14 Dec 2015 15:14:08 -0800
Message-ID: <CAGZ79kZxp-FVty9uydy0-k6JiFJduLD3-UuxLdJsL0aRWKgs3Q@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-3-git-send-email-sbeller@google.com>
	<CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
	<xmqqmvtchbh7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cJr-000634-1A
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbbLNXOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:14:10 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34797 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbLNXOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:14:09 -0500
Received: by mail-ig0-f177.google.com with SMTP id m11so9690113igk.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bFD8izBAz0RQDsVpsKNxdcZ37CJVG9l6+9g3WaEXz/8=;
        b=anv747HaY7u1AUI9L0kf+XJnjw2n0qgxJJ0sbFB2/z9m955zn+NQtTZbEh+Ohoc5pH
         oWYiQLWu56RWtfmAtKBLZA13mvNLXyOKlbrz0NcDZt3JdoA4G6ZwvIjxO8mvOsozC5l0
         sQTkZvThwYTIq8POPP/REtHuNp1CTcjykvKI6xVGCWlG+82c0ibqDFW/9pJ4w4V2Gcny
         wAbC0A1bNySeddeK54e9/1cMOBsLVZ7xZx1NJOWAGB86MU1sWcoWKbj+M0nX6BdZer7G
         ODfZ2llonwig7CnyDlLo0jteQTXerOQaghqwPJS64HRCE2UEME6u99GW9elqzyK1rjZF
         BeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bFD8izBAz0RQDsVpsKNxdcZ37CJVG9l6+9g3WaEXz/8=;
        b=eMtwb5FLFzigGe40uaitNwraUzWQXe/5duhxAEJbl0YN6bunRPIc5Gd7rnX2VjDGNQ
         /HFJZdFsX6SDUs6YIQMczfwXlQS0epzZtF+Oy4qTl1EExkS5odypefi57zNYPXnddvMB
         /YRPDYctGXAM6pn2N4Cj02/AtQobRhZMQWiigMcZe0HDtuJphPTpkHEyqVBKG53mrrsZ
         fcJwAkmBNPdNEBRKZU4AoUWjEhYwUoNL54rJhm/HAJJ9YFQaKvk8t9j3kAJ0yO8I3uHh
         Gd4fm3XA8XZLDwkmx69O+kAoUdTVaYIbvKvMGkMphx0zn2e56+f2zt8qw446/fCOU89M
         O6eg==
X-Gm-Message-State: ALoCoQlVbXmZch27DWdiUEw9ZG+lDtqrsC+VbcVpqc5lbb0yqfJRXn1M8rBhdJkE3wba0kdeu2gDl1lLHWw5M5mfseGkpP/MnjX44LvgyyakVgw5Rbbimh4=
X-Received: by 10.50.88.97 with SMTP id bf1mr869026igb.94.1450134848490; Mon,
 14 Dec 2015 15:14:08 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 15:14:08 -0800 (PST)
In-Reply-To: <xmqqmvtchbh7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282449>

On Mon, Dec 14, 2015 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <ericsunshine@gmail.com> writes:
>
>> This comment tells us what the code itself already says, but not why
>> the value is being ignored. The reader still has to consult the commit
>> message to learn that detail, which makes the value of the comment
>> questionable.
>
> Let's do this for now, then.

That looks good to me. I'll pick it up for the resend.

>
> -- >8 --
> From: Stefan Beller <sbeller@google.com>
> Date: Mon, 14 Dec 2015 11:37:12 -0800
> Subject: [PATCH] xread: poll on non blocking fds
>
> The man page of read(2) says:
>
>   EAGAIN The file descriptor fd refers to a file other than a socket
>          and has been marked nonblocking (O_NONBLOCK), and the read
>          would block.
>
>   EAGAIN or EWOULDBLOCK
>          The file descriptor fd refers to a socket and has been marked
>          nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-2001
>          allows either error to be returned for this case, and does not
>          require these constants to have the same value, so a portable
>          application should check for both possibilities.
>
> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
> As the intent of xread is to read as much as possible either until the
> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.
>
> We should not care if the call to poll failed, as we're in an infinite
> loop and can only get out with the correct read().
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  wrapper.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index 6fcaa4d..1770efa 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -236,8 +236,24 @@ ssize_t xread(int fd, void *buf, size_t len)
>             len = MAX_IO_SIZE;
>         while (1) {
>                 nr = read(fd, buf, len);
> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> -                       continue;
> +               if (nr < 0) {
> +                       if (errno == EINTR)
> +                               continue;
> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
> +                               struct pollfd pfd;
> +                               pfd.events = POLLIN;
> +                               pfd.fd = fd;
> +                               /*
> +                                * it is OK if this poll() failed; we
> +                                * want to leave this infinite loop
> +                                * only when read() returns with
> +                                * success, or an expected failure,
> +                                * which would be checked by the next
> +                                * call to read(2).
> +                                */
> +                               poll(&pfd, 1, -1);
> +                       }
> +               }
>                 return nr;
>         }
>  }
> --
> 2.7.0-rc0-109-gb762328
>
