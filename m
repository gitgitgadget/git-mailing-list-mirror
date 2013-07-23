From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 15/16] config: add core.noshallow to prevent turning a
 repo into a shallow one
Date: Tue, 23 Jul 2013 08:28:00 +0700
Message-ID: <CACsJy8Ddac5r7opAgtk-CAkc=jwmBmmOs7FU6DziysCZ=992dQ@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-16-git-send-email-pclouds@gmail.com>
 <BF5D998BFA5241938531635E1D8B79DF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 03:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1RP2-0006Dq-97
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 03:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab3GWB2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 21:28:32 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51950 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3GWB2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 21:28:31 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so8981795obc.13
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jDM9zz8P4+HIxiyZ/telmS/MLgUJ5CZ6+QqRXTAgYVk=;
        b=RvGFjzgDVnjQOxs9GcvKy0DK+YjCautjh1HbOwK6iGLJYTvtiyqDtOatz3n1jkXHxc
         T5g6e9TOm6GV20zWmQMwCiCYgXvbUPvkAE3YemoLqLZZjscu6Q6lyxfnBJZNfVBcpyHe
         KpG9ws/C1LkbtNDta0GVknno7BwYSSn1edI9PaQ2qVPuhsXRmDpwIxb/Hls5XXIT7fQ5
         wz/S8jZbkXuPKM3XJunAQAuLHHFnS06dv+pHv5/XHEAsyr/QQskSkZLPXN/TPO5hs9Ab
         eoRtjDFseR9gALwXani6dcpAGhPBDO8oMJcTO7M04MRnHvihMldZI6rR6ZtbEj5JF+R4
         2/lQ==
X-Received: by 10.182.213.10 with SMTP id no10mr22185615obc.76.1374542910988;
 Mon, 22 Jul 2013 18:28:30 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Mon, 22 Jul 2013 18:28:00 -0700 (PDT)
In-Reply-To: <BF5D998BFA5241938531635E1D8B79DF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231015>

On Tue, Jul 23, 2013 at 2:23 AM, Philip Oakley <philipoakley@iee.org> w=
rote:
> From: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> Subject: [PATCH v2 15/16] config: add core.noshallow to prevent turni=
ng a
> repo into a shallow one
>
> Surely this should be the default now that it is possible to corrupt =
a
> golden repo by pushing/fetching a shallow repository to it and it the=
n
> becomes shallow, and all the followers become shallow as well, with
> consequent problems (IIUC) [PATCH v2 05/16].
>
> It would be just as easy to change the config to core.allowshallow wh=
ich
> then must be enabled by the user, and can be mentioned in the shallow=
 clone
> option's documentation.

Clarification, it's not really "corrupt". If you have full history
from a ref "A", fetching from another shallow clone does not touch the
history of ref A at all (that is if you do _not_ specify --depth). It
may add a a shallow ref B, which is the reason the whole repo becomes
shallow. The same goes for push. This is not implemented, but I'm
thinking of adding "clean .git/shallow" to git repack -ad. Then if you
delete ref B and repack -ad, the repo could become full again.

But yeah, maybe defaulting to no shallow is better. Will do so in the
reroll unless someone objects.
--
Duy
