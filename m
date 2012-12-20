From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [RFC] test: Old shells and physical paths
Date: Thu, 20 Dec 2012 11:25:42 -0500
Message-ID: <CAEvUa7k8uimzjHd9jA=qjqK2pH-=oNRoY=ypN=bosmyGV52LoQ@mail.gmail.com>
References: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com>
	<7vmwx97f0o.fsf@alter.siamese.dyndns.org>
	<CAEvUa7=_iyXxaaRs3WtxZOy5PNnncG-iMAUNkCMLJ19ZtReqaw@mail.gmail.com>
	<CAJDDKr78ugSo9hNerHO0Y46_bSzLJWznB3E3+6H98NjMtBwHsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 17:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tliwi-0003Eg-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 17:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab2LTQZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 11:25:50 -0500
Received: from mail-vb0-f53.google.com ([209.85.212.53]:48335 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2LTQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 11:25:45 -0500
Received: by mail-vb0-f53.google.com with SMTP id b23so3923687vbz.40
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v3U4gJxzE59wB7K1UMAGAz0Ju7jvRCHQVJ+zo4VvdB4=;
        b=XJpon6bW3SHag5IlneHgTvk4SlGTH7l1+UM6OpnTdSaa0JWPsD5WAQSy2gwOOVj+aC
         yJlHzK5JjU25rGOKEp9vTAyntW18SbDkbWZZTMPS/Sr6ZlGcZSay01P9S9jN/CBZPYCo
         1fN16J/zwYKjyTiU0C6uKtxEVyfuywoESehn5/BSQyaqR53hP5RFiMbgnRK/axgSUJaH
         9H/o7LnUH66HcCdd4fiyYs+0KI8UzPAeDuymX1Bbx6TCtsZaVgUSXRInHtFDBkmoa0a3
         EMrWrFWZUXOcxbYPsYKcCSJ/lvMsFgu4gyxGnrG5MA2dkeWbvpnqcuQa9DJEIkquSFt2
         LPNA==
Received: by 10.220.157.9 with SMTP id z9mr15350268vcw.45.1356020742731; Thu,
 20 Dec 2012 08:25:42 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Thu, 20 Dec 2012 08:25:42 -0800 (PST)
In-Reply-To: <CAJDDKr78ugSo9hNerHO0Y46_bSzLJWznB3E3+6H98NjMtBwHsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211905>

Hi,

On Thu, Dec 20, 2012 at 12:01 AM, David Aguilar <davvid@gmail.com> wrote:
> Do you know if the differences are relegated to "cd",
> or do other common commands such as awk, grep, sed, mktemp, expr,
> etc. have similar issues?

There are almost certainly going to be incompatibilities with other
commands.  The system implemented UNIX95 plus some extensions, then
they began supporting UNIX03/SUSv3/POSIX.1-2001/whatever for certain
commands by using an environment variable to toggle between the
incompatible behaviors.

Their documentation on the UNIX03 commands indicates it is still only
partially supported.  For example: "cp" supports "-L" and "-P", but
"cd" doesn't.

> I wonder if it'd be helpful to have a low-numbered test that checks
> the basics needed by the scripted Porcelains and test suite.
> It would give us an easy way to answer these questions, and could
> be a good way to document (in code) the capabilities we expect.

I'd be in favor of something like this as well.

Thanks.

David


P.S.
In the meantime, I am handling the "cd" situation by replacing "-P"
with "$PHYS" and prepending the following to t/test-lib.sh.
set +o logical >/dev/null 2>&1 || PHYS=-P
