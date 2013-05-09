From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 1/5] msvc: Fix compilation errors caused by poll.h emulation
Date: Thu, 09 May 2013 03:42:20 +0200
Message-ID: <518AFEFC.8010904@cs-ware.de>
References: <510AB7D3.7010407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:42:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFsY-00084Q-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab3EIBm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:42:26 -0400
Received: from srv1.79p.de ([213.239.234.118]:33306 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164Ab3EIBm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:42:26 -0400
Received: from [192.168.0.20] (p5B03ACDA.dip0.t-ipconnect.de [91.3.172.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 49640441047;
	Thu,  9 May 2013 03:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2013; t=1368063740;
	bh=5a12YcphIG2LEqLMjBvnvmuz7Jd8SG7i3pKJ+EgVRnI=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Z2tKP+q/aSW7DKbTZsxbCIvLMG5HtjUuY30fl9MShOS0yYzgM85YpPP6SrVFoFqJh
	 QxlRfBqasz0JdYR+z99koR9QM/Qerll3JEHAj3JhKU2ZW/eXxcle60WAEU8HBX+Jh9
	 uFwY7V0kxOLJ4ifF9mB3kz8p8UTRMP1fnIdTtwjc=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <510AB7D3.7010407@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223710>

Am 31.01.2013 19:28 schrieb Ramsay Jones:
> Commit 0f77dea9 ("mingw: move poll out of sys-folder", 24-10-2011), along
> with other commits in the 'ef/mingw-upload-archive' branch (see commit
> 7406aa20), effectively reintroduced the same problem addressed by commit
> 56fb3ddc ("msvc: Fix compilation errors in compat/win32/sys/poll.c",
> 04-12-2010).
> 
> In order to fix the compilation errors, we use the same solution adopted
> in that earlier commit. In particular, we set _WIN32_WINNT to 0x0502
> (which would target Windows Server 2003) prior to including the winsock2.h
> header file.

This change causes problems compiling with MSVC2012 for me. If I don't
define NO_SYS_POLL_H git-compat-util.h now tries to include <sys/poll.h>
which does not exist for MSVC and if I define NO_SYS_POLL_H
git-compat-util.h now tries to include <poll.h> which also doesn't exist
for MSVC.

Including compat/poll into the includes path causes redefinition errors.

How have you tested this?

I think the check in git-compat-util.h has to be extended to only
include any poll.h if _MSC_VER is defined.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
