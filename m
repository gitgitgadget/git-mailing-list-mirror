From: Ludvig Strigeus <ludde@spotify.com>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 12:20:00 +0000 (UTC)
Message-ID: <loom.20091020T141138-782@post.gmane.org>
References: <hbi4mt$tjt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0DrC-00008E-9Y
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 14:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbZJTMaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 08:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZJTMaU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 08:30:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:43857 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbZJTMaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 08:30:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N0Dqn-0008L6-69
	for git@vger.kernel.org; Tue, 20 Oct 2009 14:30:05 +0200
Received: from c83-248-101-21.bredband.comhem.se ([83.248.101.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 14:30:05 +0200
Received: from ludde by c83-248-101-21.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 14:30:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.248.101.21 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130791>

Sebastian Schuberth <sschuberth <at> gmail.com> writes:
> 
> When compiling with MSVC on x86-compatible, use an intrinsic for byte swapping.
> In contrast to the GCC path, we do not prefer inline assembly here as it is not
> supported for the x64 platform.
> 
>  
> +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> +
> +#include <stdlib.h>
> +
> +#define bswap32(x) _byteswap_ulong(x)
> +
> +#endif

unsigned long (as used by _byteswap_ulong) is 64 bits on x64, right? Then it
doesn't make sense to use _byteswap_ulong to swap 32-bit quantities (assuming
that's what bswap32 does) would it?

/Ludde
