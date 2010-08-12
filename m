From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 18:25:32 +0300
Message-ID: <20100812152532.GA19956@LK-Perkele-V2.elisa-laajakaista.fi>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100812102125.GA19498@LK-Perkele-V2.elisa-laajakaista.fi>
 <4C63CD85.10304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@MIT.EDU>, Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 17:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjZc2-0003eM-Ca
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 17:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933714Ab0HLPW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 11:22:29 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38314 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0HLPW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 11:22:28 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id A62E6EF950;
	Thu, 12 Aug 2010 18:22:27 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0024962D69; Thu, 12 Aug 2010 18:22:27 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 42905158A65;
	Thu, 12 Aug 2010 18:22:20 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4C63CD85.10304@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153381>

On Thu, Aug 12, 2010 at 12:31:33PM +0200, Johannes Sixt wrote:
>
> builtin/remote-ext.c uses a loop that looks very much like what
> write_in_full() does; transport-helper.c's checks for EAGAIN look very
> similar to xwrite(). Why can't you reuse these functions?

Ah, the request sending loop (send_git_request()), not the bidirectional loop
(my bad). Yes, that function can be simplified a lot (patch sent).

> > [1] Some systems return EAGAIN on read/write failed due to blocking (with
> > EAGAIN == EWOULDBLOCK), others return EWOULDBLOCK.
> 
> But shouldn't then xwrite() and xread() be extended to check also for
> EWOULDBLOCK?

Based on what I understand, yes. read() and write() that fails due to blocking
being needed but disabled returns EWOULDBLOCK, which may or may not be the
same as EAGAIN, so the return value in no-blocking case equals EAGAIN only
if EAGAIN == EWOULDBLOCK, which isn't guaranteed.

Have a macro that does the non-fatal error check?

-Ilari
