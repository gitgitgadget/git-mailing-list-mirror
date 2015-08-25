From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gc: save log from daemonized gc --auto and print it next time
Date: Tue, 25 Aug 2015 10:49:16 -0700
Message-ID: <xmqqtwrnz2ar.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AKbXqsuNJL7Usb-haiynDcCDQXk56WYh5PxzGU3NvaAw@mail.gmail.com>
	<1440209546-23442-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUILb-00081u-0k
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbbHYRtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 13:49:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35049 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbbHYRtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:49:18 -0400
Received: by pacdd16 with SMTP id dd16so130889215pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=IF8s2eNnQTOOfJndaPtDwCCr/sxLFn9QpkLd4vHq3Ec=;
        b=W1XJVjqsb5+xOPv5SwvJj3OdtIXRaafYaZXDPBHIjTVakz8ELmLtAvMCkFIVwvo313
         ZhTNIXvq3xFNTx/iWnWNfGgz3IGg4I/BUBFFVU0akEAzbqM8Jnjd87siYm2UBgMLZm5f
         +vWsVdGXHpf+bFegNhP64yQO79cU1CAXb7paywo+NDGtxLmrOq4N0DXNMm9gU3H7+cRU
         j5xYSO5rKbFBfwXvG1jRy9zAAnB65xzUULb08hdHsQ43RGBAxQRivl18bq0jOvDTDTzt
         xcqMcMZQQQ66TZnbKAaEqIJkKeLK+Yy5Y4bIHQFMdVktdx41pkutW0rlJYUOYBypnnIE
         VrHQ==
X-Received: by 10.68.135.194 with SMTP id pu2mr59280685pbb.131.1440524957705;
        Tue, 25 Aug 2015 10:49:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id gx1sm21747352pbc.29.2015.08.25.10.49.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:49:16 -0700 (PDT)
In-Reply-To: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Aug 2015 09:12:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276552>

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
> Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc runs
> will not be daemonized and gc.log printed out until the user removes
> gc.log.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Let's try again. Compared to v2 [1], this version does not delete
>  gc.log automatically any more. The user needs to take action, then
>  delete gc.log to bring it background again.

Sounds a bit more sensible, but I wonder if it is a good idea to
keep going in the first place.  If the last gc run reported an
issue, would it make it likely that we would hit the same issue?

An alternative design I have in mind is to exit "gc --auto" with
success without doing anything, after giving the new warning
message.  What would be the pros-and-cons between this patch and
that alternative design?



>  [1] http://thread.gmane.org/gmane.comp.version-control.git/266182/fo=
cus=3D266320
>
>  builtin/gc.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index bcc75d9..00a83e1 100644
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
> @@ -330,13 +341,24 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n=
"));
>  		}
>  		if (detach_auto) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0) {
> +				warning(_("last gc run reported:\n"
> +					  "%s\n"
> +					  "running in foreground until %s is removed"),
> +					sb.buf, git_path("gc.log"));
> +				detach_auto =3D 0;
> +			}
> +			strbuf_release(&sb);
> +		}
> +		if (detach_auto) {
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
> @@ -349,6 +371,18 @@ int cmd_gc(int argc, const char **argv, const ch=
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
