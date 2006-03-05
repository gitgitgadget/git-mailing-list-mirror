From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Sun, 05 Mar 2006 04:10:47 -0800
Message-ID: <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 05 13:10:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFs4e-0005Ak-Vm
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 13:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbWCEMKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 07:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbWCEMKu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 07:10:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46026 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752254AbWCEMKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 07:10:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305120726.PWSJ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 07:07:26 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305110351.GA23448@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 5 Mar 2006 12:03:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17225>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> The default output mode is slightly different from git-annotate's.
> However, git-annotate's output mode can be obtained by using the
> '-c' flag.

It might be better to default to human readable and make the
script consumption format an option, if only to reduce typing.

> diff --git a/Makefile b/Makefile
> index b6d8804..eb1887d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -534,6 +534,10 @@ git-rev-list$X: rev-list.o $(LIB_FILE)
>  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(OPENSSL_LIBSSL)
>  
> +git-blame$X: blame.o $(LIB_FILE)
> +	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) -lm
> +

I wonder what it is about to link this binary different from others...

> +char* format_time(unsigned long time, const char* tz)
> +{
> +	static char time_buf[128];
> +	time_t t = time;
> +
> +	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", gmtime(&t));
> +	strcat(time_buf, tz);
> +	return time_buf;
> +}

I think this shows GMT with time offset, which is compatible
with the human readable time Johannes did to git-annotate.  I do
not know what timezone CVS annotate shows its dates offhand (it
seems to only show dates).  Johannes, is this an attempt to
match what CVS does?

I am wondering if we want to be in line with the date formatting
convention used for our commits and tags, that is, to show local
timestamp with timezone.  The code to use would be show_date()
from date.c if we go that route.
