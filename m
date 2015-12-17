From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 21:12:05 +0100
Message-ID: <56731715.9000509@web.de>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 17 21:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9eud-0003ad-CO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbbLQUM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 15:12:26 -0500
Received: from mout.web.de ([212.227.17.12]:51886 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbbLQUMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 15:12:25 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MWB4X-1ZgsaH0sq9-00XMc8; Thu, 17 Dec 2015 21:12:08
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1450224252-16833-3-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:8MVPJNAZch7CYv08kAaZ08CH/hc7UD3BVa8N+aDpvw4aQsXa40u
 HsNh77GlOml1nWMVWDDoyHxDjxOwGEGKEEdzRAmuH+EnV/WODifBkvAqz10u3yfsTYuBpC1
 aFguJ0oRYDUy8bx5ZUL/4DqyRB1Cc8XrWWQFw58NKK6vX3sbk3+EkTujTsyhbF7IPegjja2
 IxslyveugQoelFzb6lKUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bcbC21ymVxE=:AJSQca6H8EYFKBiPFeW6Kz
 qVv82O+a3H4YiR/EK7qCaI1qRT73s9t2j0Kblj1pSzgWB5gplokpU+y7+izAUllIWrIk+m+v7
 RwdgGNyHvAvg9Cq3xOwMT4S3FK4i0NPReArPo7gbLE69GKQ4WJ6ON59cDcI+elLGQk85XtCJv
 dLYnIgyiTjbYLNlzPuG8AShIGeTxWuY+y0szQDRO36g5liraf2d74neXSKFi0bFtLm7Y7yTH1
 /txFRiACLHmkM8iB2ltDMkV5AF7BrNdZbA6G4tgO1t6ZcOF/qwKyPvACcQu8rSO7mQF/7RJAD
 GvJnBl2T0GNH+WweSNwDY4T3L+Ul03TEbCzVXl0se+vZJy760xfQkPEDqLPA+hbjnB+hPY2uK
 dLgfk0XFSg/3/YJV4p79v4NklqNl8Q5+CQqN5fMJwCv/rO5jVYlHPtZxyLwgY7vUr6Q+tLeN5
 vE4kjG7FlyVrX82/hJ/JXaNbVA2LgOFHI6P1vdRmR9REilJUnLyOEd3Twol+m6wPvPZw4WdPx
 Jh6FrwO0ay8YwUNPvAZ2YT8KjuzYbz+ZYetuyzLL7UOGBaGm2cyxrcPJ1EqaflG2CDIqzi/Ij
 zB90oMlEI9VMGE4dGqKkyO7BMUvNz///RF77DaoxAQ7Ar6G0ZNs4Mw/y+bqXnOr3sqNKxvxJQ
 He7r6JY35x5AnVc6z7AYL5WRbvGXxm1zvTaR3RHB94f7fLwIpDaRyyrRxlKkDoqD2d8JCefNk
 nGothsw06SCYknPwqOkFVzXpOkDVm5vBE5yBEytaehCV2hnn57px3owvypuSM7UP2g0/p1HZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282671>

On 16.12.15 01:04, Stefan Beller wrote:
> The man page of read(2) says:
> 
>   EAGAIN The file descriptor fd refers to a file other than a socket
> 	 and has been marked nonblocking (O_NONBLOCK), and the read
> 	 would block.
> 
>   EAGAIN or EWOULDBLOCK
> 	 The file descriptor fd refers to a socket and has been marked
> 	 nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-2001
> 	 allows either error to be returned for this case, and does not
> 	 require these constants to have the same value, so a portable
> 	 application should check for both possibilities.
> 
> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
> As the intent of xread is to read as much as possible either until the
> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.
> 
> We should not care if the call to poll failed, as we're in an infinite
> loop and can only get out with the correct read().
I'm not sure if this is valid under all circumstances:
This is what "man poll" says under Linux: 
[]
 ENOMEM There was no space to allocate file descriptor tables.
[]
And this is from Mac OS, ("BSD System Calls Manual")
ERRORS
     Poll() will fail if:

     [EAGAIN]           Allocation of internal data structures fails.  A sub-
                        sequent request may succeed.
And this is opengroup:
http://pubs.opengroup.org/onlinepubs/9699919799//functions/poll.html:
[EAGAIN]
    The allocation of internal data structures failed but a subsequent request may succeed.

read() may return EAGAIN, but poll() may fail to allocate memory, and fail.
Is it always guaranteed that the loop is terminated?



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
>  	    len = MAX_IO_SIZE;
>  	while (1) {
>  		nr = read(fd, buf, len);
> -		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> -			continue;
> +		if (nr < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			if (errno == EAGAIN || errno == EWOULDBLOCK) {
> +				struct pollfd pfd;
> +				pfd.events = POLLIN;
> +				pfd.fd = fd;
> +				/*
> +				 * it is OK if this poll() failed; we
> +				 * want to leave this infinite loop
> +				 * only when read() returns with
> +				 * success, or an expected failure,
> +				 * which would be checked by the next
> +				 * call to read(2).
> +				 */
> +				poll(&pfd, 1, -1);
> +			}
> +		}
>  		return nr;
>  	}
>  }
> 
