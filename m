From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 20:10:49 +0200
Message-ID: <CAN0XMOL6m0B0bLwdp9mviOLqYORGcnf9LMS5=+WkXhGinBrzgA@mail.gmail.com>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwGuF-00030A-SZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab2GaSKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:10:51 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60749 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2GaSKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:10:50 -0400
Received: by eeil10 with SMTP id l10so1743395eei.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mNU9w7lPVWYTohLmw4/UEOG74DXTRqNaKTpY8GqQKHA=;
        b=fu4NkAlH/Hj0izzbmvRaPk5TZXLwXDz022Na0Dv5LtXTW7PMWVjjoVR6g1cR3YBQ6Z
         iRgjCixT8G7pHlVC/nfPSYD4l2RrW+QAMb76Lba+MbKRTIQ+5kgml32eotTPyKcvwe4T
         kM1Q/kvWVRDxkzzne4xKbm5oWNH005Fpp09Sc2Vs+/Cnma2IrE+gAX6YlB5v0cMOqntx
         CiC7SZ79Ra0TNPJOe8aS1mzEIrrH+Ek46fHLUCSgiv05MeJ0G3TJ3pj+/Pi83DyzenDQ
         kvxIhfGDyKmVBmDxQ2VyLlUJm+4XjTkIiPbfFJtJMlPRRDmP7HOWHQAS6ufCO+hTLXbN
         p+Qg==
Received: by 10.14.214.196 with SMTP id c44mr18818332eep.7.1343758249239; Tue,
 31 Jul 2012 11:10:49 -0700 (PDT)
Received: by 10.14.176.70 with HTTP; Tue, 31 Jul 2012 11:10:49 -0700 (PDT)
In-Reply-To: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202665>

On Tue, Jul 31, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +       /* Avoid iconv_open()/iconv_close() if there is nothing to convert */
> +       for (i = 0; i < argc; i++) {
> +               if (has_utf8(argv[i], (size_t)-1, NULL))
> +                       break;
> +       }
> +       if (i < argc)
> +               return;
> +

I'm not very familiar with this code but:

before: it reencodes everything which is utf-8 in argv
after: it reencodes *nothing* if one string in argv is not in utf-8

am i wrong?
