From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature Request: Support logic or shell execution to control values in .gitconfig
Date: Thu, 08 Aug 2013 17:23:00 +0200
Message-ID: <vpq1u64dx63.fsf@anie.imag.fr>
References: <CANY-LFJZazieg-7gLq1=pv=nkED81Gck4=95ffgZ6tGVgX5ffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Morgan McClure <mcclure.morgan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7S3T-0002Ff-9s
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818Ab3HHPXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:23:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50159 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965811Ab3HHPXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:23:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r78FMxcG002854
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 17:22:59 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7S3J-000735-8L; Thu, 08 Aug 2013 17:23:01 +0200
In-Reply-To: <CANY-LFJZazieg-7gLq1=pv=nkED81Gck4=95ffgZ6tGVgX5ffg@mail.gmail.com>
	(Morgan McClure's message of "Thu, 8 Aug 2013 08:09:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Aug 2013 17:22:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78FMxcG002854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376580181.4744@hRaylZvL1rsCD++GHc3dxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231895>

Morgan McClure <mcclure.morgan@gmail.com> writes:

> I propose using something reminiscent of bash syntax, either:
> value = $(SOMETEXTTOEXECUTE)
>
> or
>
> value = `SOMETEXTTOEXECUTE`

That would mean executing SOMETEXTTOEXECUTE each time the config file is
read. This raises two issues:

* A security issue, as SOMETEXTTOEXECUTE could also be something
  dangerous. It would not be much worse than the current situation (if
  your config file is not trusted, then an attacker could put malicious
  code in core.editor for example), but still increase the security
  risk (as any command reading the config may trigger execution).

* A performance issue with the current git implementation, as the config
  file may be read many time for a single git execution.

> Is this a feature others could get behind?

I think it's unlikely that this ever be implemented. What I suggest
instead is to edit/track/share template configuration files like

~/.gitconfig.in
email = me@HOSTNAME@

and then script something like sed -e "s/@HOSTNAME@/$(hostname)/" <
~/.gitconfig.in > ~/.gitconfig.

You may also use the include.path functionality to share most of your
configuration, and include a small file which is different on each host.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
