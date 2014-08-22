From: Patrick Reynolds <patrick.reynolds@github.com>
Subject: Re: [PATCH] unblock and unignore SIGPIPE
Date: Fri, 22 Aug 2014 00:40:49 -0500
Message-ID: <CAJrMUs_P25m68F_Rv4beSUiGB0uybbP=hBGULzZaefiW4gh=XQ@mail.gmail.com>
References: <1408080565-33234-1-git-send-email-patrick.reynolds@github.com>
	<20140818011445.GA22180@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 07:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKhas-0007zt-QR
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 07:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaHVFku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 01:40:50 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49933 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaHVFkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 01:40:49 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so8134255obc.7
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=g/IyU4NwakjzRmBVHYmm53DegwVPIWlE7MeVRKkoaK0=;
        b=cEacljx48U1c89hFY4gaWkFvOD1nPgW8e022+VH6JawkInslmpyoNV6JYDlHapBL7U
         sg8FXNzET+aNuItFHmdmpR8u9i5baTPHgDMldeq5nY40ji9pDLTKqRt1vP0o1LFTiO2X
         tfgMS6Qxug80ttZPlVjCMmuEfH/ALkFelWccc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=g/IyU4NwakjzRmBVHYmm53DegwVPIWlE7MeVRKkoaK0=;
        b=BjkFwT36tKhaYSz0JbrLlyZAa0NTYSdkW6NbK1bMqVkRd2xdDIek1CTexrb0/GDjns
         ixuISQboWrZCwndMI0wbWx+avEskQo1dsDxSwQlMX9KxurFxhdY8Q+j54jybhOvpjgeB
         hNhoNYK57cy0eRd2uE5mN9SypmXW6CJ/xLBAsjCtp+U5fs3wIzfEOgObWhQ81XmI7ajG
         J7i63m0C15g8fA+MJ3vz/77OjOpwdB69YX4Yy3FQNpKZfauQyaW3bnQ9n/HgFS6vXdxP
         BrpxZrtO8r/xj2CdAdhblJKsJ1QqkNyD8Lkq+RRVqtiTT+6QbPNWK53pmbVCFnS5QqcG
         4h2Q==
X-Gm-Message-State: ALoCoQmosws/pfhLMT90KiF8FmlYsxCN2oSIMkGYZPkekZwP6y/7azbNPDntViZs1QUlfvMIimq/
X-Received: by 10.60.51.9 with SMTP id g9mr2804394oeo.63.1408686049178; Thu,
 21 Aug 2014 22:40:49 -0700 (PDT)
Received: by 10.76.9.103 with HTTP; Thu, 21 Aug 2014 22:40:49 -0700 (PDT)
In-Reply-To: <20140818011445.GA22180@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255663>

On Sun, Aug 17, 2014 at 8:14 PM, Eric Wong <normalperson@yhbt.net> wrote:
> But unicorn would ignore SIGPIPE it if Ruby did not; relying on SIGPIPE
> while doing any multiplexed I/O doesn't work well.

Exactly.  Callers block SIGPIPE for their own legitimate reasons, but they
don't consistently unblock it before spawning a git subprocess that needs
the default SIGPIPE behavior.  Easier to fix it in git than in every potential
caller.

--Patrick
