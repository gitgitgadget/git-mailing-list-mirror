From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] 'git verify-pack -v' on multiple packs fails for all but the first pack
Date: Fri, 22 Aug 2008 15:27:21 +0200
Message-ID: <200808221527.21971.johan@herland.net>
References: <200808221439.31219.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 15:29:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWha-0001Rw-Fp
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbYHVN2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYHVN2O
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:28:14 -0400
Received: from sam.opera.com ([213.236.208.81]:37017 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYHVN2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:28:14 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7MDRMkH007567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Aug 2008 13:27:27 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200808221439.31219.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93293>

On Friday 22 August 2008, Johan Herland wrote:
> (I don't have time to look into this right now, but will do so later
> if nobody comes up with a solution in the meantime...)
>
> When running 'git verify-pack -v' on multiple packs (.idx files), it
> fails for all packs, except the first, with exit code 128, and the
> following single line:
>
> 	fatal: internal error: pack revindex fubar
>
> This does not happen when given only a single pack, or when given
> multiple packs, but without '-v' option.
>
> To reproduce, simply do:
>
> 	git verify-pack -v .git/objects/pack/*.idx
>
> in any repo with more than one pack file.
>
> This happens with a fairly current 'next' (1.6.0.96.g2fad1). AFAICS,
> it also happens in v1.6.0.

Bisection point to this commit:

commit 1f5c74f6cf918d317c73b328dcd4cf6f55c44d8a
Author: Nicolas Pitre <nico@cam.org>
Date:   Mon Jun 23 21:22:14 2008 -0400

    call init_pack_revindex() lazily

    This makes life much easier for next patch, as well as being more efficient
    when the revindex is actually not used.

    Signed-off-by: Nicolas Pitre <nico@cam.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
