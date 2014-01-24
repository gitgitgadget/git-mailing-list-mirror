From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 15:31:46 -0800
Message-ID: <xmqq1tzxq7ml.fsf@gitster.dls.corp.google.com>
References: <201401242205.16313.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org,  zwanzig12@googlemail.com,  stefanbeller@googlemail.com,  kusmabite@gmail.com,  Johannes.Schindelin@gmx.de,  msysgit@googlegroups.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRB2HPROLQKGQEYYZINTY@googlegroups.com Sat Jan 25 00:31:55 2014
Return-path: <msysgit+bncBCG77UMM3EJRB2HPROLQKGQEYYZINTY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f185.google.com ([209.85.213.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB2HPROLQKGQEYYZINTY@googlegroups.com>)
	id 1W6qE5-00084v-Vm
	for gcvm-msysgit@m.gmane.org; Sat, 25 Jan 2014 00:31:54 +0100
Received: by mail-ig0-f185.google.com with SMTP id uq10sf270641igb.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 24 Jan 2014 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=TwQC8mjjS6XNH4iviTBzi6GflehA6X2Ty7rygpEjzBw=;
        b=Mo9NjahXwAY0CCpZiMAejmkvmOQ/IcNzSbyPnx+85Yx5PsGzOuwAsXUP7tuykwVCdC
         THs17MmxX4b7ObgmMRt4s49XAv6qLYd7AJuK8jGqqbwQfGPMmCVh3kQC6OBNKnGRnooW
         o2uxASd6hOyhz/UmphatZDbBcDIRCxHcDVyqI+qaql7leXREzUShJUCdksm7qiIWUhyV
         LDRfnMc/807V+2CkHwC0VVLyzMkqv+/fjJcWbD1gpqIrNGIO4WX5VJ9WR1aL5Ipgf7Wf
         ASbxF59xhiom7XQMpPJnGOuAt31raZh2HROncs3xvssVXJ74DlYHhX9i+y4COczDB/qp
         Z/TA==
X-Received: by 10.50.43.137 with SMTP id w9mr64241igl.14.1390606313087;
        Fri, 24 Jan 2014 15:31:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.78.167 with SMTP id c7ls1144419igx.14.canary; Fri, 24 Jan
 2014 15:31:52 -0800 (PST)
X-Received: by 10.66.163.67 with SMTP id yg3mr382263pab.45.1390606312234;
        Fri, 24 Jan 2014 15:31:52 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ox2si418416pbc.1.2014.01.24.15.31.51
        for <msysgit@googlegroups.com>;
        Fri, 24 Jan 2014 15:31:51 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 361A1647CB;
	Fri, 24 Jan 2014 18:31:51 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA92647C9;
	Fri, 24 Jan 2014 18:31:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED48A647C5;
	Fri, 24 Jan 2014 18:31:49 -0500 (EST)
In-Reply-To: <201401242205.16313.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Fri, 24 Jan 2014 22:05:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2D77564-854F-11E3-9AC3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241052>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Another solution could be to do the "chmod +x" in mingw_rename().
> This may be done in another commit, because
> a) It improves git gc only when Git for Windows is used
>    on the client machine
> b) Windows refuses to delete a file when the file is read-only.
>    So setting a file to read-only under Windows is a way for a user
>    to protect it from being deleted.
>    Changing the behaviour of rename() globally may not be what we want.

But doesn't this affect non Windows platforms in negative ways?  We
unconditionally run stat(2) and chmod(2) unnecessarily, and we leave
the resulting file writable when it originally may have been marked
read-only on purpose.

Also, it feels to me that doing this in mingw_rename() the right
approach in the first place.  If the user wants "git mv a b" to
rename "a" in the working tree and if that path is read-only, what
happens, and what should happen?  Does "chmod -w" on a file in the
working tree mean "I want to make sure nobody accidentally writes to
it, and also I want to protect it from being renamed or deleted"?

So perhaps mingw_rename() can be taught to

 - First try to just do rename(), and if it succeeds, happily return
   without doing anything extra.

 - If it fails, then

   - check if the failure is due to read-only-ness (optional: if you
     cannot reliably tell this from the error code, do not bother),
     and if not, return failure.

   - otherwise, stat() to grab the current permission bits, do the
     chmod(), retry the rename, then restore the permission bits
     with another chmod().  Return failure if any of these steps
     fail.

That way, it can cover any call to rename(), be it for packfiles or
a path in the working tree, and you would need to pay the overhead
of stat/chmod only when it matters, no?

> Reported-by: Jochen Haag <zwanzig12@googlemail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  builtin/repack.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ba66c6e..033b4c2 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -324,6 +324,10 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
>  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
>  				chmod(fname_old, statbuffer.st_mode);
>  			}
> +			if (!stat(fname, &statbuffer)) {
> +				statbuffer.st_mode |=3D (S_IWUSR | S_IWGRP | S_IWOTH);
> +				chmod(fname, statbuffer.st_mode);
> +			}
>  			if (rename(fname_old, fname))
>  				die_errno(_("renaming '%s' failed"), fname_old);
>  			free(fname);
> --=20
> 1.9.rc0.143.g6fd479e
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
