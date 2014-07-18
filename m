From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Fri, 18 Jul 2014 11:42:46 -0700
Message-ID: <20140718184246.GS12427@google.com>
References: <53C944B3.5080106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:43:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8D7Y-0004Tc-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 20:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbaGRSmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 14:42:53 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52317 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030567AbaGRSmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 14:42:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so5846879pab.26
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LJZ9dqply5oABxJPIy3YZh1H7VgejvtZ+hMefoSENJA=;
        b=uXQJ2Nhsb9vZUP24t3deJ5UJunwJi3n+Cq5gnBtZq5qzd5IInAcayOly2ALw/cNLcB
         WtTiseYlnC9PY4pYRyRHNdwYfJn488RGL0r09x7E6X7tgvEWTkMaogseZK+P1LOah1ob
         6VEYg4lpVniInUN0+dvxXHTeo1kt0wUoHkFzczsZAxKSTQuinhgKNb9wULDZxEPIkYxm
         XvD9ojx5y0RN+CufNnNlKVNfoPKCdW9R1WvtXzrFixb1rwx2EwZAbY0RzysBGCBemvZ9
         Icpn0inZh/oQqRo5QvqedGKH6IAjksKXcncDHdvSFINWYMzbLY1J4m/txVbocUTSR2q+
         TZNg==
X-Received: by 10.67.2.73 with SMTP id bm9mr7502449pad.73.1405708969203;
        Fri, 18 Jul 2014 11:42:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6d3d:4f:6892:efc2])
        by mx.google.com with ESMTPSA id ry10sm25722734pab.38.2014.07.18.11.42.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 11:42:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53C944B3.5080106@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253836>

Ren=E9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  fast-import.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Before:

  $ size git-fast-import
     text    data     bss     dec     hex filename
   804138    6768  754160 1565066  17e18a git-fast-import

After:

  $ size git-fast-import
     text    data     bss     dec     hex filename
   804154    6768  754160 1565082  17e19a git-fast-import

So this makes the text size worse on this machine (amd64, building
with gcc 4.8.2 -O2).  That's probably because the old code does 'call
memcmp', while the new code inlines it.  Inlining is presumably the
better choice.

More importantly, the new code is more readable.

=46or what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
