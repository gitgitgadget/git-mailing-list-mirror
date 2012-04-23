From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-svn: use POSIX::sigprocmask to block signals
Date: Mon, 23 Apr 2012 14:13:51 -0700
Message-ID: <xmqqd36yi228.fsf@junio.mtv.corp.google.com>
References: <cover.1335198921.git.rkagan@mail.ru>
	<d21d7433574e8ea7628320dbe1a5fc0dc9d94e64.1335198921.git.rkagan@mail.ru>
	<xmqqipgqjqtk.fsf@junio.mtv.corp.google.com>
	<CANiYKX68AJyE3+3BT7QSjziGS=HGKuk95rxS_04c0sGz9pywXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMQa5-0007IO-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab2DWVNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 17:13:53 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:58009 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab2DWVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 17:13:52 -0400
Received: by qcsp5 with SMTP id p5so1396736qcs.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 14:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=TX/D4xzz1NSuOg1twP0n6x4fWCHBQ44Qr2OWVMMA+bc=;
        b=Tw8tq1JpxIww8dUrXQagp9nuWjQdIut57tPu/tVm6YvbCETXeR0PskO0H27r2Qj9ir
         03mRaM9WoRvnt46DyEwNaPOvtXqF/ye1CPmz+6kPta54kn9Sng8cbljOViXbDd/5UBKE
         oD81V28ircBVwre5KcIhJugCkO5BtmcWbsyXLc/b1FlJUZfRflXqjFljJVC/eBX1iMDy
         8xvuzy0xacIk+TTpgcoZn3cM8WTQ/RrFKCwoL7Qw5ASh9QuF/IA+Z8NVtvszT+6GdcMU
         Vl3lfVBm7KXvkFvVkNrfjOp76NWPw+uJv+yTxfbeJJIPrvp4ZkgVj0eTT8nkoBPpohie
         C/sQ==
Received: by 10.236.76.4 with SMTP id a4mr22276603yhe.2.1335215632003;
        Mon, 23 Apr 2012 14:13:52 -0700 (PDT)
Received: by 10.236.76.4 with SMTP id a4mr22276584yhe.2.1335215631919;
        Mon, 23 Apr 2012 14:13:51 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i36si2459488anp.0.2012.04.23.14.13.51
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 14:13:51 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id CAF7F10004D;
	Mon, 23 Apr 2012 14:13:51 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 74AE1E120A; Mon, 23 Apr 2012 14:13:51 -0700 (PDT)
In-Reply-To: <CANiYKX68AJyE3+3BT7QSjziGS=HGKuk95rxS_04c0sGz9pywXw@mail.gmail.com>
	(Roman Kagan's message of "Tue, 24 Apr 2012 01:07:23 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlwtbom26fktw/bvMITWGmauJ2yA0eY/AE5En0zZT9VBMrZ4VrONRSz/RidyfzY852zUWtqyMAo1I2Rw8KpGxPQhCYlM/CQH+/8xPvQUD7w9IeMGx5lSkn8ktOHLY0jKvTPXVfXNh90Ys3EhrRHBHFU68Sn6TgsMv5dVB0tcoFJY1DM1dg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196167>

Roman Kagan <rkagan@mail.ru> writes:

> [B]locking some signals is obviously not a good enough
> protection measure: the program may die on SIGKILL or the power may go
> off.

Ahh, that is what you meant.  I agree that it is of dubious value to
only try to catch signals, even though it may be better than nothing.

It should be sufficient to replace the "[...]" part with the above,
and conclude it with "But it will be a separate topic that this patch
does not address." or something.

Thanks.
