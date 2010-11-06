From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/5] verify-tag: factor out signature detection
Date: Sat, 6 Nov 2010 15:40:25 -0200
Message-ID: <AANLkTi=hHk5Ot-5E5kUQy7x+UgYP8O7KV8qgrvLJ3=X0@mail.gmail.com>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
	<4CAB90EC.1080302@drmicha.warpmail.net>
	<970e9c2c52aea06c330c330f12b95750d9e9dabd.1289041051.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 06 18:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEmkk-00013C-Ua
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 18:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0KFRk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 13:40:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63195 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0KFRk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 13:40:27 -0400
Received: by bwz11 with SMTP id 11so3620634bwz.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NjmC6issNFG0c+c0Qgz3Q8Cgo1vQYnV1y/r7K5mAYCE=;
        b=cvQMiMasCv60+Jh15MbMVJjBlGwl7nHJLDcohEZA80AtSjFM/CRorzWSfEKW5CNO20
         366H0kkVltcn41etNkHbxoum4EGYm8bAV2YM9V4XWuIZo8RxQ9y275I5Hp4xu0WJZWWK
         e0N+flrhbuGpFm5Grz+5NCO6bsR0MLUggaTOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UW2zxXVLP37r9d3pTZPZmVO3HMB5Lsg2mhEn03i3+8Wk2KOjOU+iUY8C2PVdcdazLc
         /ENzMtM6jnSl5Fg3sYwjvL1wvrdQEMCy2d0u8pq+uzrqJWMsgMthRprN8hizTHct+e2G
         8YExhFi4mrelT+jsYTyQdXH4KCa9S+gMy6mbo=
Received: by 10.204.121.83 with SMTP id g19mr3140043bkr.13.1289065225864; Sat,
 06 Nov 2010 10:40:25 -0700 (PDT)
Received: by 10.204.58.71 with HTTP; Sat, 6 Nov 2010 10:40:25 -0700 (PDT)
In-Reply-To: <970e9c2c52aea06c330c330f12b95750d9e9dabd.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160851>

On Sat, Nov 6, 2010 at 9:04 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> diff --git a/tag.h b/tag.h
> index 4766272..4ba2a42 100644
> --- a/tag.h
> +++ b/tag.h
> @@ -3,6 +3,8 @@
>
> =C2=A0#include "object.h"
>
> +#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> +

nit: I'd move this into the tag.c file. It's only used there now.
