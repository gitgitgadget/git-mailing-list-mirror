From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Thu, 27 Feb 2014 18:38:04 -0500
Message-ID: <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 00:38:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJAWp-0005Kp-UW
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 00:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbaB0XiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 18:38:07 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:55638 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaB0XiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 18:38:05 -0500
Received: by mail-oa0-f49.google.com with SMTP id g12so1204852oah.22
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 15:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DqgHmlrAgGy758gc5ULiupjicVIF6x+pykN70lXwyKk=;
        b=VMxJ4qqmu/JT4Jnlz07iFznXv5bA207HITHWDrvgn68m5furcGC3OV100/G/A72ndj
         Dm2iNXOt+C2WZKSezIXNriC85TwhRV2dWaJQSkHUsyKuDxNZYm1zv0NqUAgrOjLVre8u
         ezcZpLPu7L4tH6J41J0tlGMUAaXvvWLivnAIbDZ4tzRjpDQwtT+mjUyjFe9sNyu+wvZN
         Vmzo4nJs0L4PA+NstVJ51bZ8+D3zozDtl0hHz/pePFHLQMWgU+nN0kf45f3M0RPOtq8H
         SjZguQR+5P2WIWtsyw4lLSXvubQ0dIIJdYha+Y5Q4B7zC1fqtni/XGlnC4a+uixSTW3J
         qNXw==
X-Received: by 10.60.157.228 with SMTP id wp4mr14463731oeb.39.1393544284457;
 Thu, 27 Feb 2014 15:38:04 -0800 (PST)
Received: by 10.76.122.241 with HTTP; Thu, 27 Feb 2014 15:38:04 -0800 (PST)
In-Reply-To: <530FBB1D.3050505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242875>

> If I understand the issue correctly, the problem is that packed-refs are always case-sensitive, even if core.ignorecase=true.
> OTOH, checking / updating _unpacked_ refs on a case-insensitive file system is naturally case-insensitive.
> So wouldn't it be a better workaround to disallow packed refs (i.e. 'git config gc.packrefs false')?

You are correct, the issue boils down to mixing the usage of
packed-refs and loose refs on case insensitive file systems. So either
always using packed-refs or always using loose refs would take care of
the problem. Based Michael Haggerty's response, it seems that always
using loose refs would be a better workaround.

If I understand gc.packrefs = false correctly, it only prevents git gc
from running git pack-refs, so my question would be is there anything
else aside from git gc that would trigger git pack-refs? Are there
significant downsides to always using loose refs? Would checking
core.ignorecase in builtin\pack-refs.c, and exiting if true, be
appropriate?

Thanks,
-Lee
