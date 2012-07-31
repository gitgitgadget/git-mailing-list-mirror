From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 20:55:04 +0200
Message-ID: <CAN0XMOKBPirJFzHM_QgDC8TGimoEhjWoAVA+JhaLzto4-SVvmw@mail.gmail.com>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
	<7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwHb9-0005ND-2P
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab2GaSzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:55:07 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44573 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373Ab2GaSzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:55:06 -0400
Received: by eeil10 with SMTP id l10so1758387eei.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2nu7kLo5rG3GUNwzKevqq67x4N0h0WRwEXP6z940Xfo=;
        b=C1zqGG7fNiLntcUsxgCgkyGz6PvgXmlybeOSpwC0BMw6vNH3DHQADW9CGNJr/Khxx4
         +sbLXRxQWOARyS6h2+8YjFlKpz3JQdnFM+Z6+mKcr5DEPZGapQVwD6qENy0vUYHWtWM3
         CNZvFcHS6l1zWcACdAsPsMQH1e2wMuDYjyZjzgcdfUPkmf05HQfg0pO5rQSR7fkzT6dg
         X2o7dRAHh2lfM98RBILYbNVWOBnO409dsUhCEPaHSsDr/Qq7Z+0Cf/pj9emmkSqCboMn
         4JXEJ/OlraZ9iocDdg8ibCupDYLC5ysIyOfiKD31jFF2sM2lHqESItNeQwF01RFL0FLW
         qiLA==
Received: by 10.14.218.137 with SMTP id k9mr18932439eep.25.1343760905132; Tue,
 31 Jul 2012 11:55:05 -0700 (PDT)
Received: by 10.14.176.70 with HTTP; Tue, 31 Jul 2012 11:55:04 -0700 (PDT)
In-Reply-To: <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202669>

On Tue, Jul 31, 2012 at 8:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +       /* Avoid iconv_open()/iconv_close() if there is nothing to convert */
> +       for (i = 0; i < argc; i++) {
> +               if (has_utf8(argv[i], (size_t)-1, NULL))
> +                       break;
> +       }
> +       if (argc <= i)
> +               return; /* no utf8 found */

sorry, but "argc" can never be smaller than "i", right?
