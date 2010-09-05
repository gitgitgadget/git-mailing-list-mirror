From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 05/15] read_tree_recursive: Avoid missing blobs and
 trees in a sparse repository
Date: Sun, 5 Sep 2010 12:00:24 +1000
Message-ID: <AANLkTinkz1YG45t3njtzj--LcPs3MPbGMTj9cWG_Nj6B@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 04:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os4X1-0006NE-EE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 04:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab0IECA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 22:00:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60142 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab0IECA0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 22:00:26 -0400
Received: by wyf22 with SMTP id 22so1593424wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k+Q+GGIEHgePYXOihSRfArJ1A7BvhTSA8TyZ8GX99Gg=;
        b=fyehhrpoEKJnIT9chMJe+VLUhCaONlBzef+JkS++CohNEykAjcuz2DETh/FMpY3lM1
         gpLl9/wKs+vWYijNhXNCYuNy1SiIa6f5Ejd/wnhaFaEaYEX7neJt0WRIejdpY8dj+grN
         FQ4HyzOIo9Dx5oxpDdMXEricG2EOiyhJXDFeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=huNS9YuVnbtpUEyVsSnlRjHk8NbZ4Td1UhTFfU5b9TObQfdT2+znTIwIIME3BzAspC
         rIeDHpY71u0Ia75bZyKw6PlYlB1dkx+dS8qwFRNxhy24D0rLg4Y0NPGAghU5oG6PwYms
         rBLVMU40U0cUf8BycYGgu5H3h5YRKJIUbQL88=
Received: by 10.216.232.229 with SMTP id n79mr2316848weq.52.1283652024780;
 Sat, 04 Sep 2010 19:00:24 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sat, 4 Sep 2010 19:00:24 -0700 (PDT)
In-Reply-To: <1283645647-1891-6-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155409>

On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote=
:
> @@ -119,6 +119,11 @@ int read_tree_recursive(struct tree *tree,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (git_sparse_pat=
hspecs &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1=
_object_info(entry.sha1, NULL) <=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> +

I suppose this is temporary and the final solution would have stricter
checks (i.e. only ignore if those entries are outside sparse zone)?
This opens a door for broken repo.
--=20
Duy
