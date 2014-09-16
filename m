From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 00/23] Signed push
Date: Tue, 16 Sep 2014 16:33:59 -0400
Message-ID: <CAPig+cRscb5WJK0ZNchdtn6DDoT8vABnQLtkPTFfL6acULnGMQ@mail.gmail.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
	<xmqq7g132yui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzRy-0003ma-CU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbaIPUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:34:05 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:60183 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaIPUeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:34:00 -0400
Received: by mail-ie0-f172.google.com with SMTP id rd18so416930iec.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WdpH6RkQtNDJ2okU59RGUKWs8Cn70eImuJEWjr5Vcj8=;
        b=rUk5GG6iKuSWRBFQZMS9cRfXM/ovl38n2ifJ+tFLLEKpp7ijlvn9JqG6YBZ7IISjVR
         fj0685XSbmJU0LyCIbHeP6inXkq5td7zOydMXCuXOotFvKgX8AADnH/X3fjQbu5fS1n8
         2sbnMnmLZOG0oQyTwLQJHom5L2jzGFafeHKsGl9QWiV6iZ7gijzRcih/3msQvbIp54WM
         LpH7RuNvDMoEYGawTbdL5tg719Ix16hGjNLBACR1YG4gfMOCpcwTkoj6rctzCj8LZ/9o
         tXFPuE/MGKarn0G9VsYkF20b8gVheHJeHPvYFPFL4OdDoG/2adCsKja7RhZqwCeGu8gR
         WXAw==
X-Received: by 10.50.176.202 with SMTP id ck10mr34108166igc.2.1410899639275;
 Tue, 16 Sep 2014 13:33:59 -0700 (PDT)
Received: by 10.107.34.196 with HTTP; Tue, 16 Sep 2014 13:33:59 -0700 (PDT)
In-Reply-To: <xmqq7g132yui.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: mcgMiiDOEMUHWCc1UX_bx3R0Erw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257185>

On Tuesday, September 16, 2014, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > A failing test has been added at the end for smart HTTP.  It appears
> > that somewhere in the callchain "--signed" is forgotten and the
> > sending end not to send the certificate for some reason.  If
> > somebody with a fresh set of eyes can look into it, that would be
> > very much appreciated, as I do not expect I would have sufficient
> > concentration to dig it quickly for several days at least.
>
> I lied.  This is to replace the patch at the end (23/23).
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 15 Sep 2014 14:59:00 -0700
> Subject: [PATCH] push: teach smart-HTTP to pass "git push --signed" around
>
> The "--signed" option received by "git push" is first passed to the
> transport layer, which the native transport directly uses to notice
> that a push certificate needs to be sent.  When the transport-helper
> is involved, however, the option needs to be told to the helper with
> set_helper_option(), and the helepr needs to take necessary action.

s/helepr/helper/

> For the smart-HTTP helper, the "necessary action" involves spawning
> the "git send-pack" subprocess with the "--signed" option.
>
> Once the above all gets wired in, the smart-HTTP transport now can
> use the push certificate mechanism to authenticate its pushes.
>
> Add a test that is modeled after tests for the native transport in
> t5534-push-signed.sh to t5541-http-push-smart.sh.  Update the test
> Apache configuration to pass GNUPGHOME environment variable through.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
