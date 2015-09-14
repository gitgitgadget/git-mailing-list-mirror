From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it next time
Date: Mon, 14 Sep 2015 10:24:47 -0700
Message-ID: <xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
	<1442108202-25746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:24:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXUt-0001yc-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbbINRYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 13:24:51 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35600 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbbINRYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:24:50 -0400
Received: by pacfv12 with SMTP id fv12so152416240pac.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Agym1d8xUExwXgtCOkEy/jJumMMbQ4khJR/aFJNiE78=;
        b=hD/0xutEj+3Roo4/9V6XXo9aMfvjLnxRC3NhRiW6a4CUHwdAbBRq4ws9A3ARV5lllu
         IkDhvq7tlfuXnfwxRSm9VojQsFKmRL3128/UsVVIFqGeNEsQ6TJ7RJLSwZxAKtSW82Me
         PneW0tdpehM2spF8KhKqKHSaL5KGt+3Vxwvi1EdwEnrKN6WK7orIHifJIgd04itRTqRr
         B6QrQFyfzvTGC1SpyDmwn6r6by8rYLXPuuOUD0M/kOkKckINXhpgYkQPhJBx5EYZsTuj
         oL1E534/MtEn78as4D7sageUcsEZMq3UXWEvgGarz/KX/r6ejDD24IRnRmG7qEyjAr70
         118A==
X-Received: by 10.68.219.194 with SMTP id pq2mr36517247pbc.20.1442251489583;
        Mon, 14 Sep 2015 10:24:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id xs7sm17405352pab.4.2015.09.14.10.24.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:24:48 -0700 (PDT)
In-Reply-To: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13
 Sep 2015 08:36:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277847>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> While commit 9f673f9 (gc: config option for running --auto in
> background - 2014-02-08) helps reduce some complaints about 'gc
> --auto' hogging the terminal, it creates another set of problems.
>
> The latest in this set is, as the result of daemonizing, stderr is
> closed and all warnings are lost. This warning at the end of cmd_gc()
> is particularly important because it tells the user how to avoid "gc
> --auto" running repeatedly. Because stderr is closed, the user does
> not know, naturally they complain about 'gc --auto' wasting CPU.
>
> Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc --aut=
o
> will not run and gc.log printed out until the user removes gc.log.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  When gc.log exists, gc --auto now simply exits
>
>  builtin/gc.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Thanks, will queue.

This is sufficient for non-novice users, but I wonder if the error
message is strong enough.

A knee-jerk reaction to "Last run reported an error so we won't run
until the log is removed" may be "Then why don't you remove the log
for me automatically?", which is a total brain-less raction [*1*],
and "then I'll remove the log" is not all that better.  The message
we want to convey is "correct the root cause so that gc can run
without having to give an error message."

I guess it all depends on what is in gc.log; after all, this new
codepath is not in a good position to read the diagnosis left in
there and offer good pieces of advice to resolve them.


[Footnote]

*1* ... which is what a knee-jerk reaction is by definition.



>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index bcc75d9..2c3aaeb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -43,9 +43,20 @@ static struct argv_array prune_worktrees =3D ARGV_=
ARRAY_INIT;
>  static struct argv_array rerere =3D ARGV_ARRAY_INIT;
> =20
>  static char *pidfile;
> +static struct strbuf log_filename =3D STRBUF_INIT;
> +static int daemonized;
> =20
>  static void remove_pidfile(void)
>  {
> +	if (daemonized && log_filename.len) {
> +		struct stat st;
> +
> +		close(2);
> +		if (stat(log_filename.buf, &st) ||
> +		    !st.st_size ||
> +		    rename(log_filename.buf, git_path("gc.log")))
> +			unlink(log_filename.buf);
> +	}
>  	if (pidfile)
>  		unlink(pidfile);
>  }
> @@ -330,13 +341,21 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n=
"));
>  		}
>  		if (detach_auto) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0)
> +				return error(_("last gc run reported:\n"
> +					       "%s\n"
> +					       "not running until %s is removed"),
> +					     sb.buf, git_path("gc.log"));
> +			strbuf_release(&sb);
> +
>  			if (gc_before_repack())
>  				return -1;
>  			/*
>  			 * failure to daemonize is ok, we'll continue
>  			 * in foreground
>  			 */
> -			daemonize();
> +			daemonized =3D !daemonize();
>  		}
>  	} else
>  		add_repack_all_option();
> @@ -349,6 +368,18 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>  		    name, (uintmax_t)pid);
>  	}
> =20
> +	if (daemonized) {
> +		int fd;
> +
> +		strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"));
> +		fd =3D xmkstemp(log_filename.buf);
> +		if (fd >=3D 0) {
> +			dup2(fd, 2);
> +			close(fd);
> +		} else
> +			strbuf_release(&log_filename);
> +	}
> +
>  	if (gc_before_repack())
>  		return -1;
