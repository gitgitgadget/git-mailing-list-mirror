From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/6] diff --stat: mark any file larger than
 core.bigfilethreshold binary
Date: Wed, 13 Aug 2014 15:32:14 -0400
Message-ID: <CAPig+cRwe0+RjLRpCmvFGczmy5x6J7Kz43XsMiOOL2trVQn4bw@mail.gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeHT-0006MX-2n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbaHMTcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 15:32:15 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:38545 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaHMTcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2014 15:32:15 -0400
Received: by mail-yk0-f178.google.com with SMTP id 142so185823ykq.37
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xcR6BMs6l1n4nf6YHkZ1gv1QcGCUWNsvXMRQeWAivUw=;
        b=kC+5u5gKWcmtLIsYV0iS29c3B4XRoja0QKJsTF3whs2X+e5kM9eIj+yRHSYzt1J7X3
         KRkfQrSEJdfqlW1rmS7CHVcl9EQbxKb8D2RN+fMV5tIYUPayPPu4CG0VhAfofUGFPCp/
         vYKCLftGatvD9h+9xOyqWoAFV7CgqeiDwa9yc5wqCcX1V0v9lWO4gydDcfS1D/yih9/H
         G+vjfkgDaNgOFHgW5Fm1PM35Fd44iXK+Pr71RZSBUdd9xiY6GqHTCBZ9q1fU4jnxPESj
         b+UuRQRj2SozJErYul2sgihNKBPODlwjheTHNrLRlDnl8+A4KTqvUKg9VBJ2eGi6tEeg
         sIiQ==
X-Received: by 10.236.23.163 with SMTP id v23mr9825805yhv.52.1407958334300;
 Wed, 13 Aug 2014 12:32:14 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 13 Aug 2014 12:32:14 -0700 (PDT)
In-Reply-To: <1407927454-9268-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: m4k2BgCQ7UDwQX-oebOGa5A_O0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255227>

On Wed, Aug 13, 2014 at 6:57 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Too large files may lead to failure to allocate memory. If it happens
> here, it could impact quite a few commands that involve
> diff. Moreover, too large files are inefficient to compare anyway (an=
d
> most likely non-text), so mark them binary and skip looking at their
> content.
>
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt        |  3 ++-
>  Documentation/gitattributes.txt |  4 ++--
>  diff.c                          | 26 ++++++++++++++++++--------
>  diffcore.h                      |  1 +
>  t/t1050-large.sh                |  4 ++++
>  5 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..53df40e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -499,7 +499,8 @@ core.bigFileThreshold::
>         Files larger than this size are stored deflated, without
>         attempting delta compression.  Storing large files without
>         delta compression avoids excessive memory usage, at the
> -       slight expense of increased disk usage.
> +       slight expense of increased disk usage. Additionally files
> +       larger than this size are allways treated as binary.

s/allways/always/

>  Default is 512 MiB on all platforms.  This should be reasonable
>  for most projects as source code and other text files can still
