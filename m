From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Small "git clean" annoyance
Date: Fri, 1 Apr 2011 10:29:19 +0200
Message-ID: <AANLkTikP17k4FWgfuZa6Fto5qtp1Bp_+4vOBwp=e2JZy@mail.gmail.com>
References: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com> <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 10:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Zjx-0000xz-Rv
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 10:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab1DAI3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 04:29:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58893 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1DAI3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 04:29:40 -0400
Received: by fxm17 with SMTP id 17so2438201fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/Wv+toryz1k+Ju8mLJwsf/YpLnv/BTyzLnGhbeOPOII=;
        b=epIxBOLolXOoxD3sItcIAMjUvMVkNbojC4UHmv9T6yvdSnk9ttktIZqeq9sGF9N4oY
         fz+ERtG8C4TaXTmvntu/fc7GXfj8KqpnAQbraWggBMJQy7j+yWfvlncVb4t0mjmmdc5M
         1fhkZ4hWI7Twklvv4cumRe62uLLYtZgq6NLfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Gl+L+Gv8Sd8++mritObdIq5+UTIMjZfcHQjq5RVAfejBDf2btoIkMb8sDr39HCOHAH
         KVXgA1s8vDC63IHtiR/hg8A1cCqI+ZthPN6/rF3qavc2gRg4qh8Tife0Ya3rJtxofj2w
         uAV72hPoW1/nVMRJbo5DCKUac6UzkU26E/Fp8=
Received: by 10.223.14.90 with SMTP id f26mr987660faa.146.1301646579102; Fri,
 01 Apr 2011 01:29:39 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 01:29:19 -0700 (PDT)
In-Reply-To: <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170561>

On Fri, Apr 1, 2011 at 9:34 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Fri, Apr 1, 2011 at 00:01, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Now, I realize that if the directory isn't empty, and is unreadable,
>> we really should give up (although a better error message about _why=
_
>> we failed may be in order) rather than try to chmod it or anything
>> like that. But the simple "try to rmdir it" might be a good addition
>> for the trivial case.
>
> Something like this?
>
> diff --git a/dir.c b/dir.c
> index 325fb56..7251426 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1191,8 +1191,11 @@ int remove_dir_recursively(struct strbuf *path=
, int flag)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0dir =3D opendir(path->buf);
> - =A0 =A0 =A0 if (!dir)
> + =A0 =A0 =A0 if (!dir) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rmdir(path->buf) =3D=3D 0)

nit-pick:
don't we usually do "if (!rmdir(path->buf))"?
