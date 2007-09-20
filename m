From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Thu, 20 Sep 2007 10:20:29 +0300
Message-ID: <87lkb1iz0i.fsf@Astalo.kon.iki.fi>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224119.17650344AB3@madism.org>
	<20070919144604.7deca4f7.froese@gmx.de>
	<46F21097.5030901@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Keywords: vsnprintf,va_list
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 09:25:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYGPX-0006H4-78
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 09:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbXITHZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 03:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbXITHZN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 03:25:13 -0400
Received: from main.gmane.org ([80.91.229.2]:57123 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755586AbXITHZL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 03:25:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IYGPG-0007k2-My
	for git@vger.kernel.org; Thu, 20 Sep 2007 09:25:02 +0200
Received: from 82-128-246-229-rajakyla-tr1.suomi.net ([82.128.246.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 09:25:02 +0200
Received: from kon by 82-128-246-229-rajakyla-tr1.suomi.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 09:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-128-246-229-rajakyla-tr1.suomi.net
In-Reply-To: <46F21097.5030901@eudaptics.com> (Johannes Sixt's message of
	"Thu, 20 Sep 2007 08:17:59 +0200")
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.51 (gnu/linux)
Cancel-Lock: sha1:LOZaHDpZSzZXEvK3CwOEsV+ZOU8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58761>

Johannes Sixt <j.sixt@eudaptics.com> writes:

> Edgar Toernig schrieb:
>> The second vsnprintf won't work as the first one consumed all args
>> from va_list ap.  You need to va_copy the ap.
>
> Your analysis is not correct. The second vsnprintf receives the same
> argument pointer as the first, and, hence, consumes the same set of
> arguments.

C99 7.9.16.2p2 has a footnote: "As the functions vfprintf,
vfscanf, vprintf, vscanf, vsnprintf, vsprintf, and vsscanf invoke
the va_arg macro, the value of arg after the return is
indeterminate."

Normative text in 7.15p3 confirms this: "The object ap may be
passed as an argument to another function; if that function
invokes the va_arg macro with parameter ap, the value of ap in
the calling function is indeterminate and shall be passed to the
va_end macro prior to any further reference to ap."

Therefore va_copy is needed here, at least in principle.
