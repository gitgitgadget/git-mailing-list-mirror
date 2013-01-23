From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Wed, 23 Jan 2013 20:38:08 +0700
Message-ID: <CACsJy8DSQMQ_mLxTXDL3oHuV9DdRv9MFH0-h=KzaBEhXtkLpZQ@mail.gmail.com>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 14:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty0Xe-00081J-3w
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 14:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab3AWNik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 08:38:40 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:48056 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab3AWNij convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 08:38:39 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so8413755oag.27
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 05:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=VfLDO0i94FpGmgMZrZwETg7PVQ9GmT0xxM+Js6sGYgo=;
        b=pZHNCbWT4naExjjy1o/cpljphzImotUSP4VYPKfDNQ+W85R7qVT4r2vwk1Lr4HX5Db
         z9CdhA4MuQwrCn9Ja1qpg2qewgll9jO31CJudv94SNpDHe9fEqhcTiWqlNieMSNiVgPu
         7AUXrcVHtFr7dSqzjRwVSzBQqXVHL38BMBESxqTAjT+Q0ueqICp0tU9csvqd5fc6GNze
         Jp+Yjzy/Vz121iFd2yfBzv2gkcpuXl3sgZTaYqIKMS87DgGM3LCueTvXcVa+eHpqqgkP
         yy2Zf/fV/yP/JztwMENCtcIKspMiGFR3h2sDOtrmvi2ElmPOgba+FqGgDJzX/6YmbA68
         fX/w==
X-Received: by 10.182.18.133 with SMTP id w5mr988848obd.64.1358948318109; Wed,
 23 Jan 2013 05:38:38 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 23 Jan 2013 05:38:08 -0800 (PST)
In-Reply-To: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214318>

On Wed, Jan 23, 2013 at 8:34 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> add_submodule_odb() can be used to import objects from another
> repository temporarily. After this point we don't know which objects
> are ours, which are external. If we create an object that refers to a=
n
> external object, next time git runs, it may find a hole in the object
> graph because the external repository may not be imported. The same
> goes for pointing a ref to an external SHA-1.
>
> To protect ourselves, once add_submodule_odb() is used:
>
>  - trees, tags and commits cannot be created
>  - refs cannot be updated

=2E. and soon after I pressed send, I realized I missed at least two
other places write should not be allowed:

 - index
 - reflog

But the general idea is probably more important than implementation
details at this stage.
--=20
Duy
