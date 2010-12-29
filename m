From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] unpack_trees(): skip trees that are the same in all input
Date: Wed, 29 Dec 2010 21:43:09 +0700
Message-ID: <AANLkTinm=k_84Nh4YakbkdNNLO4-yeVxGF+p_rR5TFB=@mail.gmail.com>
References: <7vr5d94fs4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 15:43:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXxFj-0007I1-LK
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 15:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab0L2Onm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 09:43:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47466 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab0L2Onl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 09:43:41 -0500
Received: by wwa36 with SMTP id 36so10743163wwa.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6wfODEt1QnuDgKQXtkz3INpZOZfjVTd38jkFht4Bd3E=;
        b=aZK3GFPUmjGYhmc6fW7Hr1MUCp5bGabtjt6ySSXVECGgCnS5FkBndLP2eJEuPvvJUg
         nWOnOlgPF7d9FvCaDsWxv19hS5zbi3iw+jI7tk3AiUQB7qkIpa+NntMrNBfQbln5zHnX
         UIJ3jmCKaXvJ/WYA1LEPQe5FHLmIDuWR+uz/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SYAIEC7YFV7sBhGTp2OOE+ptqzzls+CSTGBIbPA+ahRgzkyNRpcMcxHlkd1cmju49L
         9IU3moNfvTAqzXgt1lvr7Zo3NvpCQsQUyqVsszWQBukN/mhj5UWhINuZoEO2I73zvtR9
         5457QK18mzBE2Y50X9xyBxZcETQXpfQ12hwPQ=
Received: by 10.216.24.134 with SMTP id x6mr18978501wex.34.1293633820722; Wed,
 29 Dec 2010 06:43:40 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 29 Dec 2010 06:43:09 -0800 (PST)
In-Reply-To: <7vr5d94fs4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164314>

On Thu, Dec 23, 2010 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> @@ -447,6 +451,11 @@ static int traverse_trees_recursive(int n, unsig=
ned long dirmask,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct traverse_info newinfo;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct name_entry *p;
>
> + =C2=A0 =C2=A0 =C2=A0 if (!df_conflicts) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int status =3D fas=
t_forward_merge(n, dirmask, names, info);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return status;
> + =C2=A0 =C2=A0 =C2=A0 }

Also skip the optimization when sparse checkout is active
(info->data->skip_sparse_checkout =3D=3D 0). People may need to just
update skip-worktree bits and add/remove worktree files along the
line.

Or you could make another step ahead and make fast_forward_merge aware
of sparse checkout too ;-)
--=20
Duy
