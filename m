From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 04/10] column: add dense layout support
Date: Fri, 2 Mar 2012 19:47:37 +0700
Message-ID: <CACsJy8CdmK0827qjiW6-tCkhpGK5Prkhb=bt7wPgAuSsf1qpDw@mail.gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com> <1330430331-19945-5-git-send-email-pclouds@gmail.com>
 <7vty2azudf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:48:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3RuA-0000Bz-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705Ab2CBMsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 07:48:09 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50885 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012Ab2CBMsI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 07:48:08 -0500
Received: by wibhm2 with SMTP id hm2so584027wib.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 04:48:07 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr5021065wiv.13.1330692487339 (num_hops = 1);
        Fri, 02 Mar 2012 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rA/GCyWwZ0uO1MMAC8tHn/SXKMgj3DyL39ibT965OfE=;
        b=z8AjxeUoOS8YNmDUA7bak2R2goACSXUlxRUQG7VvT1GwcH+eUhhQVKjg3PJmejiz6e
         c3x6ahCCOCgqSNaBbSYvnnd+1k8+zH3m0heeEqtj4cYIfwMNLKWPHJr9bMVwR0XMRZNt
         KXXxM8L57BET+5qxrygrSgTF2BoXExOBTDx6JGLee9BYxU7PI4hXVzdiXNVYfLfG+DZ4
         XeqzDA0vOOrfQ5jZ7Jl1R76unvfqLfOb9ZO4EosypoAbXKUrDBBB5U5hs74KS4PDXeSU
         IJshWeaBGfPDzB6FZCWO0uY2khuWE53RbgHw3qggf9+7ZZ34r5TDCr+tbgU93ztTjx5i
         iwVw==
Received: by 10.180.74.177 with SMTP id u17mr4028830wiv.13.1330692487218; Fri,
 02 Mar 2012 04:48:07 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 04:47:37 -0800 (PST)
In-Reply-To: <7vty2azudf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192036>

2012/2/29 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Normally, all items will be gone through once. The largest cell will=
 set
>> column width for all columns. With this strategy, one long item will
>> stretch out all columns, wasting space in between them.
>>
>> With COL_DENSE enabled, it shrinks all columns to minimum, then atte=
mpts
>> to push the last row's cells over to the next column with hope that
>> everything still fits even there's one row less. The process is repe=
ated
>> until the new layout cannot fit in given width anymore, or there's o=
nly
>> one row left (perfect!).
>
> As you have given 4 bits for COL_MODE in the previous patch, I expect=
ed
> that this will be one of the mode that you can use, e.g. column-first=
 dense,
> or row-first no-dense, with two more bits for operating modes. =C2=A0=
Not calling
> it COL_MODE_DENSE and assigning a "are we dense of not?" bit out of C=
OL_MODE
> bits feels wrong.

I reserve the 4 bits for strategies to fill the layout. One day I'm
crazy enough maybe I'll add spiral mode that put the first item in the
center, then next items in a spiral outward. COL_DENSE is about cell
size and should be applicable to any layout strategies. Maybe
COL_LAYOUT_COLUMN, COL_LAYOUT_ROW, COL_WIDTH_DENSE (and
COL_WIDTH_EQUAL) would be better names
--=20
Duy
