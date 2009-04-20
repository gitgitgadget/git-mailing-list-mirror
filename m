From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/4] Revisiting cache-tree
Date: Mon, 20 Apr 2009 15:08:27 +0200
Message-ID: <81b0412b0904200608r7b986160p15ec0afb826ee1f6@mail.gmail.com>
References: <1240225100-29960-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvtMN-0003Pk-HA
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbZDTNO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZDTNOz
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:14:55 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:57242 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZDTNOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 09:14:55 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2009 09:14:54 EDT
Received: by gxk10 with SMTP id 10so488923gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e4R7sg7AEEuipyxPbbWdrNmAozLSuu6rBNuTWfzaY+k=;
        b=X6QT//HeNczpOCK0+Ekb/G14yN6nVvGMYsqadZqlZTqOGUtoA096Dl9R9w88JxQw3U
         O0HGUTvZvU1PCeEIJ9ckGUIOvMHqBIs9cGpiUnrYDhAaS0Y/EJx1t60UNCGksYe+zV5Y
         QFaFnxNHGoRORba5St3OUla7k6kQMm/ZEIR8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fXY1+WUU37PXCASKo+gU/3+jLykZUgFoB6Ka9Ye9tGtA4v/43P9TwT76c4brPl5Wyd
         rf+5td7Ekiq52rFV5rb8ApBc0P1BhnJ/oRADIkFfOJgwcAHJ+8AMZ+HllDOS3WXu8qE3
         bGKHxPIQFm6lbyaIzO9UzbOMYsUc9D2JEeE20=
Received: by 10.151.45.2 with SMTP id x2mr3250159ybj.12.1240232907502; Mon, 20 
	Apr 2009 06:08:27 -0700 (PDT)
In-Reply-To: <1240225100-29960-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116980>

2009/4/20 Junio C Hamano <gitster@pobox.com>:
> This series consists of a fix meant for maint branch, and two perform=
ance
> fix. =C2=A0The second one is a refactoring of the code to support the=
 latter.
>
> I was doing a rather huge import as a multi-step process by doing
> something like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ rm -f $GIT_DIR/index
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add some ;# this one is huge
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git tag one $(git write-tree)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git repack -a -d
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ rm -f $GIT_DIR/index
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add other ;# this one is also huge
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git tag two $(git write-tree)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git repack -a -d
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git read-tree some other

"git read-tree one two"
