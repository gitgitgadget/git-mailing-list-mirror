From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] repack.c: Use move_temp_to_file() instead of rename()
Date: Wed, 29 Jan 2014 10:17:43 -0800
Message-ID: <xmqqiot2k5yw.fsf@gitster.dls.corp.google.com>
References: <201401272124.42978.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org,  zwanzig12@googlemail.com,  stefanbeller@googlemail.com,  kusmabite@gmail.com,  Johannes.Schindelin@gmx.de,  msysgit@googlegroups.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRBTMLUWLQKGQEKQ326KI@googlegroups.com Wed Jan 29 19:17:51 2014
Return-path: <msysgit+bncBCG77UMM3EJRBTMLUWLQKGQEKQ326KI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f59.google.com ([209.85.212.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBTMLUWLQKGQEKQ326KI@googlegroups.com>)
	id 1W8Zhv-0003zU-0P
	for gcvm-msysgit@m.gmane.org; Wed, 29 Jan 2014 19:17:51 +0100
Received: by mail-vb0-f59.google.com with SMTP id f12sf546976vbg.4
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 Jan 2014 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=iGU+x0v8bKCMDZmCgXYdgBGIASAns2sATyKJuDaz4PE=;
        b=FRmfkc4IP/NKpDlfhQYmWfPkqC/5DPxc5RPi2RVpKdofm3nTHoEztVMYGNpFYNmXEA
         mW1+/kcIiwUC4FTKnXwGmjd6a5KCoYXZxYnr7ISC9UYj5ghT9OoD78QbxcL+V9wTQQaK
         Ytmn85BGfZILzjwdQFl40ePH2I5TJfmkBY2SpE/E62giSROMEBtq/2n/T8ibkvYwq9Fu
         dO7gs/xbVFOFLKyx5Lw1cOmKnilYwDRg/U4tSPG/Ro3mnA7DPEPFkV0UNW8mY+9S/SOn
         ief2zZX7/x4SXidUceB3SqXYhlv9eTSb3rIMuibVyPhdK/+le1Jms/euTK3WTSJ63nxo
         4nlA==
X-Received: by 10.140.97.73 with SMTP id l67mr4117qge.42.1391019470230;
        Wed, 29 Jan 2014 10:17:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.20.100 with SMTP id 91ls247726qgi.18.gmail; Wed, 29 Jan
 2014 10:17:49 -0800 (PST)
X-Received: by 10.58.47.99 with SMTP id c3mr5821899ven.41.1391019469547;
        Wed, 29 Jan 2014 10:17:49 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id t4si767532qcl.3.2014.01.29.10.17.49
        for <msysgit@googlegroups.com>;
        Wed, 29 Jan 2014 10:17:49 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B84068226;
	Wed, 29 Jan 2014 13:17:49 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D97E68225;
	Wed, 29 Jan 2014 13:17:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3293B68223;
	Wed, 29 Jan 2014 13:17:48 -0500 (EST)
In-Reply-To: <201401272124.42978.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 27 Jan 2014 21:24:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A84B358E-8911-11E3-9D03-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241216>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> In a1bbc6c0 a shell command "mv -f" was replaced with the rename() functi=
on.
>
> Use move_temp_to_file() from sha1_file.c instead of rename().
> This is in line with the handling of other Git internal tmp files,
> and calls adjust_shared_perm()

>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Thanks for all comments.
> I haven't been able to reproduce the problem here.
> Tips and information how to reproduce it are wellcome.
>
> I think this patch makes sense to support core.sharedRepository(),
> but I haven't made a test case for the pack/idx files.
>
> Jochen, doess this patch fix your problem, or do we need
> another patch on top of this?

Turning the call to rename(2) in the last hunk in your patch to
move_temp_to_file() may be an improvement, but the other changes are
wrong, I think.

There are two big differences between the rename(2) used here and
move_temp_to_file().  You need to understand what move_temp_to_file()
is from its name.

 - It is meant to move a temporary file we create ourselves, and the
   most important characteristic of such a file is that we do not
   create it read-only.  The function uses platform's rename(2) and
   returns a failure if the platform's rename(2) fails, but that is
   not a problem even on Windows because of this.

 - When returning a failure, it unlinks the temporary file.  This
   unlinking is necessary to clean up after our half-done mess.

The other two calls to rename(2) you changed in the patch are *not*
about turning a newly created temporary file into the final one.
They are about moving existing packfiles away just in case we fail
in the later phases of the command so that they can be moved back to
their original name to restore the state before we started, and
actually moving them back to their original name.  We do not want to
remove these files.  The platform's rename(2) must do the right
thing in these two calls and there is no guarantee these existing
packfiles are read-write.

Earlier, I said that turning the call to rename(2) in the last hunk
in your patch to move_temp_to_file() may be an improvement, because
I thought that it is a good thing that the latter makes a call to
adjust_shared_perm().

But after a closer inspection, I no longer think that hunk is an
improvement.  These new packfiles were created by pack-objects,
which finishes each packfile it produces by calling
finish_tmp_packfile(), and that is where adjust_shared_perm()
happens already.  As far as "pack-objects" that was called from
"repack" is concerned, these new packfiles are not "temporary"; they
are finished product.  It may be OK to remove them as part of
"rewind back to the original state, as a later phase of repack
failed" if we saw a failure (but note that the original
"git-repack.sh" didn't), but a plain vanilla rename(2) without any
frills is what we want to happen to them.

>  builtin/repack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ba66c6e..4b6d663 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -271,7 +271,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  				if (unlink(fname_old))
>  					failed =3D 1;
> =20
> -			if (!failed && rename(fname, fname_old)) {
> +			if (!failed && move_temp_to_file(fname, fname_old)) {
>  				free(fname);
>  				failed =3D 1;
>  				break;
> @@ -288,7 +288,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  			char *fname, *fname_old;
>  			fname =3D mkpathdup("%s/%s", packdir, item->string);
>  			fname_old =3D mkpath("%s/old-%s", packdir, item->string);
> -			if (rename(fname_old, fname))
> +			if (move_temp_to_file(fname_old, fname))
>  				string_list_append(&rollback_failure, fname);
>  			free(fname);
>  		}
> @@ -324,7 +324,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
>  				chmod(fname_old, statbuffer.st_mode);
>  			}
> -			if (rename(fname_old, fname))
> +			if (move_temp_to_file(fname_old, fname))
>  				die_errno(_("renaming '%s' failed"), fname_old);
>  			free(fname);
>  			free(fname_old);
> --=20
> 1.8.5.2
>
> --=20

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
