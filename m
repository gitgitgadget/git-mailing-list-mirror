From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Can I remove stg sync --undo ?
Date: Thu, 3 Jul 2008 23:02:28 +0100
Message-ID: <b0943d9e0807031502x5f7c4babtd65511d7966c69f6@mail.gmail.com>
References: <20080702072524.GA26805@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWtn-0000gE-A8
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYGCWCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 18:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbYGCWCc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:02:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:29625 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbYGCWCb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 18:02:31 -0400
Received: by wa-out-1112.google.com with SMTP id j37so622903waf.23
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XjOrJ/G7OCWVBYCxdcPhIr+TiiraYCz7jrQi3JhBglo=;
        b=dPQxiBbgXdCwIEA1PD2bbFYW81BgPaI3CovEKTIdCkOMR877Gw1vIWhtySqEqJrCu2
         /aSE7jNomTeWorDmG6y4SKVnWEFVmyZ6mbNiPxQtqpDPx9Uh2ih1xgH5m3ZkOdGDJqYW
         jQxXhrDdA4zbXAosXrZdmpN7ZVRw/mcSv5OG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MAwyamJ+vS5JYqGg3g53uhBrO2vthgG92DU3BIoaEcDpsuCXnBsyoD9VMHjHgUt2rP
         yjsP52S7mrFKOyZqw/Uiqzx4d3q0hRwiQMDGEtItQblOxepiXUV/za28B4n1JlVq9vJ7
         ytVleBawZXZh5sua1eQyRruUgex0NqKreaBOs=
Received: by 10.115.14.1 with SMTP id r1mr1724759wai.139.1215122548781;
        Thu, 03 Jul 2008 15:02:28 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Thu, 3 Jul 2008 15:02:28 -0700 (PDT)
In-Reply-To: <20080702072524.GA26805@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87327>

Hi Karl,

Sorry for the delay, I've been really busy recently.

2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
> I'm preparing a patch that removes all the old --undo flags, and
> discovered that stg sync has an --undo flag backed by
> stack.undo_refresh().

The current --undo flag restores the state of the patch before a
successful sync. If the sync fails with a conflict and it needs a
refresh after resolving, I think it loses the previous state of the
patch and just restores to whatever it was before the refresh.

> Is it OK if I remove it? "stg undo" will allow you to undo the whole
> command, or, in case of conflicts, either the whole command or just
> the last conflicting push. But it does not allow for undoing the last
> refresh (whether it succeeded or not). I don't know how refresh is
> used, so I can't really tell if "stg undo" is currently insufficient.

The sync performs three operations - push, merge and refresh (if the
refresh is automatic after merge, it doesn't update the backup
information since it was done by merge).

If merge fails, the refresh is manual after solving the conflicts. I
suspect this will be recorded as a separate step for undo (BTW, is
resolved take into account for undo?).

--=20
Catalin
