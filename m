From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Sun, 08 Nov 2015 06:54:31 +0100
Message-ID: <563EE397.4080608@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>	<3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>	<1446670884.4131.42.camel@twopensource.com>	<563AD452.2030301@alum.mit.edu>	<1446740535.4131.50.camel@twopensource.com>	<563CAC58.3070907@alum.mit.edu>	<xmqq611f3umt.fsf@gitster.mtv.corp.google.com> <xmqqd1vm3e59.fsf@gitster.mtv.corp.google.com> <563ED7A0.7040007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 07:02:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvJ3a-0005bv-Oz
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 07:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbbKHGBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 01:01:48 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52647 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764AbbKHGBr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2015 01:01:47 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2015 01:01:47 EST
X-AuditID: 1207440e-f79516d0000012b3-86-563ee39a3fa9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 63.A9.04787.A93EE365; Sun,  8 Nov 2015 00:54:34 -0500 (EST)
Received: from [192.168.69.130] (p4FC97053.dip0.t-ipconnect.de [79.201.112.83])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA85sVO5005014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 8 Nov 2015 00:54:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <563ED7A0.7040007@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqDvrsV2YQdNWQYv5m04wWnRd6Way
	aOi9wmzxo6WH2YHF41nvHkaPi5eUPRY8v8/u8XmTXABLFLdNUmJJWXBmep6+XQJ3xvz591gL
	/rNW/HjZw9LAeJ2li5GTQ0LARGL29QnMELaYxIV769m6GLk4hAQuM0o8PdUA5Zxjkuj9cQqo
	g4ODV0Bb4vomXpAGFgFViXO77zGB2GwCuhKLeprBbFGBIIkVy18wgti8AoISJ2c+AVsmIqAm
	MbHtEJjNLJAicWDGATYQW1jAUeLXk8fMELvmMEvM3bwF7CJOAR2J6Y/3QDXoSey4/osVwpaX
	2P52DvMERoFZSHbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSml
	mxghAc23g7F9vcwhRgEORiUe3ohcuzAh1sSy4srcQ4ySHExKorw77gOF+JLyUyozEosz4otK
	c1KLDzFKcDArifAq3QXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	eHMfATUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgYrSApHqC9S0HaeYsL
	EnOBohCtpxh1ORb8uL2WSYglLz8vVUqc1xekSACkKKM0D24FLH29YhQH+liYtxekigeY+uAm
	vQJawgS0xCHKBmRJSSJCSqqBsclhxdf3y6eqlR+u23A/7GjIpiO3Vsz65qV/6+/zqyJiF5i/
	WP5tMfZQ/vhBeO9Ll8z7OpP05uY4uteEtTDfer3tIZui+svns/2cFm5ayV5xr6b9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281032>

On 11/08/2015 06:03 AM, Michael Haggerty wrote:
> [...]
> I can see a few ways that we could make our series even more
> straightforward:
> 
> 1. Leave refs.c in its original location (as suggested by Junio).
>    Optionally, it could be moved at a later date when this area is
>    quiescent.
> [...]

I just tried this (it was less work than expected). It doesn't make the
merge conflict with lf/ref-is-hidden-namespace go away because the
functions in the new refs.c are ordered differently than in the old
refs.c. But it does turn it into a simple rerere-able conflict.

I'll check how much work it would be to make the order of functions in
the new refs.c match that in the old one...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
