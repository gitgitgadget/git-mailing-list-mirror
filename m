From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 02/15] read-cache: allow to keep mmap'd memory after
 reading
Date: Wed, 20 Apr 2016 15:43:15 -0400
Organization: Twitter
Message-ID: <1461181395.5540.170.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-3-git-send-email-dturner@twopensource.com>
	 <CACsJy8D229ARqEjH29Gqd=u8KijGA_Fzk0cbUNRXB9GA0ittMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:43:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asy2I-0000QW-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbcDTTna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 15:43:30 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35045 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbcDTTnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:43:17 -0400
Received: by mail-qk0-f176.google.com with SMTP id q76so8032035qke.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tYs4vwWoRZnXYNM16n4P0dzP7vwdZIh3VFsLl7sfNDs=;
        b=PoRBVrb2uty9H2L6xVenyDiO+n9rMPDm+TvBaCNCSx2VFakGMQl+NXLFv5xZ8DdfOu
         cIdx2PCIdGtMOpWd5QHEk8P48u7iTc3hGDc9QbHRUfnE2yMpgK38C937zqdQlE0O/R9z
         37yrAoxyTnaU0IjgqLJXdTzkWil6JaGa0Dax4wV6CEfkf9WwLAPcGDQfqE4q7/dbkXbP
         bK2FenmvWCM4zWpFR2E8DtaX+9mkLPI2+37YqDdkv6EEWrsCViZ8EDRnsAT2+EhB7N/9
         cjePcdM6TEj1plvce5D1YNighE2OBdlax8ZWyizLnDMu+2E5V2quQxa8RNtcOBgAUS0P
         vnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tYs4vwWoRZnXYNM16n4P0dzP7vwdZIh3VFsLl7sfNDs=;
        b=mtMBXYA+7sxYxrSGjBB99AAYkMLx95Zf7qlk/ugfl4KN4veAL8Ey8hVqJX445xKdQq
         e7eq0y3d52nzXXX5EEpdGbQMLllxGv7WAfYpKaMSslW+UFdUFNjdaYwsDvWZABg5cyA7
         EvF2Wh7L1m5ozfcd8vfFAUQv+AOj5ZlLtyf66m2fK1Kqx6k7wBgxof3omrihGFdLuIOT
         yc5EbwtZaOYaZb8cqVxU8+XtuoyIPCDVFxy5FsjTTgt4dGcsf+mpQGdcCzXmZxYq6s5L
         j5SrEZ1ezOqHbZQhcEyu7f9yRsShe4PDQAuL4x/BSMswDM7JSdrPeUjmOOW8VbDIzjlv
         VtJA==
X-Gm-Message-State: AOPr4FWLJzW+X3w8ODi/vZu+jECZHFFWTJvlKsJVQUab7rH8Mte6sumBbqd5YgctBgjRkw==
X-Received: by 10.55.33.5 with SMTP id h5mr4626234qkh.99.1461181396440;
        Wed, 20 Apr 2016 12:43:16 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c193sm9343624qkg.43.2016.04.20.12.43.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 12:43:15 -0700 (PDT)
In-Reply-To: <CACsJy8D229ARqEjH29Gqd=u8KijGA_Fzk0cbUNRXB9GA0ittMg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292063>

On Wed, 2016-04-20 at 16:26 +0700, Duy Nguyen wrote:
> On Wed, Apr 20, 2016 at 6:27 AM, David Turner <
> dturner@twopensource.com> wrote:
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> >=20
> > Later, we will introduce git index-helper to share this memory with
> > other git processes.
> >=20
> > Since the memory will be shared, it will never be unmapped
> > (although
> > the kernel may of course choose to page it out).
>=20
> This is not entirely true. We do need to keep the mmap'd memory for
> longer, even after read_index_from() finishes. But we do not share
> the
> exact same address space to other processes (memcpy is used in
> index-helper.c:share_index()). We could even discard_index() at the
> end of share_index(), but I think we keep it anyway just in case
> another process asks, or when index is not updated.

Will reword.
