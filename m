From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Speed up commands that use rev-list when max-count is 
	specified.
Date: Sun, 21 Mar 2010 10:09:20 -0400
Message-ID: <ca433831003210709k1da46c8docfdac358253625e@mail.gmail.com>
References: <1269142267-17127-1-git-send-email-bmeyer@rim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benjamin C Meyer <bmeyer@rim.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 15:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtLqo-0003Hn-Cj
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 15:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab0CUOJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 10:09:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64525 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0CUOJm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 10:09:42 -0400
Received: by gwaa18 with SMTP id a18so556991gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ajC64hsoblYIG6ZgXc6q/IhMoFYV6pYVZj5GdxXm8Rg=;
        b=YlV3lC2sNH/0XVS5BUh1EY6fqzFSnsPUSuti3/7UPTVt70VG4SdKxN3fR6qN1eVK+G
         6TNmARtYH/famoo33mSwVS6lXPBsB9UI4r66SdiSBO6Qz2ybteLvtlARBQNEdDA1QDtu
         sB741jeFg1dZfORBSkpEda37VsnBLHsz/rAgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R2fvpGd8JalNa6xej+1EKB+WCHJseamtBbyDdzvJkh20CHmP390cM5ZqPs517hqe5M
         MXBlVCj11v/C8cPOvdBhgayn9b06xOL602yoAC2P96euUriEXrZV502PH8Ht0UvYZrBn
         6sr2tDBGiPZEL5Xzo3Sqhdw1YtVOt8Q694QHM=
Received: by 10.90.7.29 with SMTP id 29mr2989345agg.16.1269180580688; Sun, 21 
	Mar 2010 07:09:40 -0700 (PDT)
In-Reply-To: <1269142267-17127-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142828>

On Sat, Mar 20, 2010 at 11:31 PM, Benjamin C Meyer <bmeyer@rim.com> wro=
te:
> =C2=A0struct commit *get_revision(struct rev_info *revs)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (revs->max_count =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit *c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_list *reversed;

Declaring variables in the middle of a function is a C99 feature (and
a GNU extension in C89 mode).  I don't know if this is allowed in git
code, but it would be easy enough to make this ANSI C89 compatible by
putting your new statement after the variable declarations.
