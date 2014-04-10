From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 9/9] sha1_name: add support for @{publish} marks
Date: Thu, 10 Apr 2014 17:40:20 -0400
Message-ID: <CALkWK0nC7Ai_LbJNpy-oK-qfWZELx6NVWTNS-5iWzhn8t9JoTw@mail.gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com> <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:41:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYMia-0002d4-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 23:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbaDJVlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 17:41:03 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:45874 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbaDJVlC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 17:41:02 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so5151934obc.30
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CKFE9QLm1YOFsSQWE4Zj6NbJFyRRvbSYOl1iohbnGK4=;
        b=ybMCfV9Jqp8PzUGecgCoabVUrSpFee/jsrurRBq0Tebw5+qphxhDmPXLT97KIWCvtC
         VtfuHCFD/EYN+tJ57ZxBwFNX+sCHmMQ/4RNwCSsKCCtZ3LnFCwWGnpF5EhDKN+so7i1g
         A3c3IT3ZE+CY95HaUpQRkndsKfheQd30ysC5EGJHRmtG7LhOAAvro7GiORrNkFkaITuN
         BfolsslPzAmvx1X5tuvbA3NVM/lfpirjBeKC8cdR8MA7e35HdBiPUek8h7d3PXpGLJ5a
         Ctewqr86qBUKq2Uk2aWrhXKfqn3uexvga/8lf0jHMnJXwGU3DGYEFRG3mxCPbRvLfLTV
         azqg==
X-Received: by 10.60.37.166 with SMTP id z6mr16044981oej.22.1397166060811;
 Thu, 10 Apr 2014 14:41:00 -0700 (PDT)
Received: by 10.182.151.43 with HTTP; Thu, 10 Apr 2014 14:40:20 -0700 (PDT)
In-Reply-To: <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246055>

Felipe Contreras wrote:
> @@ -1068,23 +1069,35 @@ static const char *get_upstream_branch(const char *name_buf, int len)
>          */
>         if (!branch)
>                 die(_("HEAD does not point to a branch"));
> -       if (!branch->merge || !branch->merge[0]->dst) {
> -               if (!ref_exists(branch->refname))
> -                       die(_("No such branch: '%s'"), name);
> -               if (!branch->merge) {
> -                       die(_("No upstream configured for branch '%s'"),
> -                               branch->name);
> +       switch (type) {
> +       case 'u':
> +               if (!branch->merge || !branch->merge[0]->dst) {
> +                       if (!ref_exists(branch->refname))
> +                               die(_("No such branch: '%s'"), name);
> +                       if (!branch->merge) {
> +                               die(_("No upstream configured for branch '%s'"),
> +                                       branch->name);
> +                       }
> +                       die(
> +                               _("Upstream branch '%s' not stored as a remote-tracking branch"),
> +                               branch->merge[0]->src);
> +               }
> +               tracking = branch->merge[0]->dst;
> +               break;
> +       case 'p':
> +               if (!branch->push.dst) {
> +                       die(_("No publish configured for branch '%s'"),
> +                                       branch->name);

This assumes a push.default value of 'current' or 'matching'. What
happens if push.default is set to 'nothing' or 'upstream', for
instance?

p.s- Good to see you back on the list :)
