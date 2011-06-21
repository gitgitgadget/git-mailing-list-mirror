From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] advice: Introduce error_resolve_conflict
Date: Tue, 21 Jun 2011 10:55:55 -0500
Message-ID: <20110621155555.GF15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 17:56:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3J8-0006a9-TM
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 17:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab1FUP4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 11:56:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39786 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1FUP4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 11:56:00 -0400
Received: by iyb12 with SMTP id 12so2957562iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2kib40Ynq/jEWQjYUFoU6+wUPxk8cWkYqk5KHB10X/8=;
        b=Jq1h7k1XdqeZuxWMr3Cxpg0VBywbUrE5amPUt2Zb0ltYSNdELY8FFqRayU9S1GSsJZ
         wrqX3RSqQoNdy/knOlJDjLGDifCFx4aXGDZYbJ2EacFjueuKQAmgKjxyQHwo4XdDLoBb
         i6C1f2h1JF7lXnEbtQ2TnEk3Mj++mPurUf2Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nTh1gVO6kbYdsmCWHTA4WbIJ87dJSajZg+jIa2/RYKE2N49g4pA4PPyy0CSeByuoZO
         JcaZwJbORYoyvH4i7ym91zUNNKH2f2Cx9GcS84xDno5jyqOQD82/xrsczfA6phy0VwCe
         J5Bq4ipaWiDy8XoYBzn5E23uTmQAUldA5As64=
Received: by 10.42.159.65 with SMTP id k1mr7712932icx.174.1308671759998;
        Tue, 21 Jun 2011 08:55:59 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id v15sm3865958ibh.28.2011.06.21.08.55.57
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 08:55:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176163>

Ramkumar Ramachandra wrote:

> Introduce error_resolve_conflict corresponding to
> die_resolve_conflict, and implement the latter function in terms of
> the former.  The only trade-off is that die_resolve_conflict is a
> little noisier now.

The above doesn't tell me what I would want to know, namely:

 1. The impact of this patch is to change an error message.

 2. The change is from

	fatal: 'commit' is not possible because you have unmerged files.
	Please, fix them up in the work tree ...
	... etc, etc ...

    to

	error: 'commit' is not ...
	error: Please, fix them up...
	... etc, etc ...
	fatal: Exiting because of an unresolved conflict.

 3. The intended benefit is that new, future callers may want the "error"
    without exiting.

Notice that after writing the above, a little detail jumps out:
namely, the second "error:" line is giving advice, so it might make
sense to make it say "hint:" instead.
