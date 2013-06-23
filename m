From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other
 remotes
Date: Sun, 23 Jun 2013 15:35:16 +0200
Message-ID: <1371994516.24315.8.camel@localhost>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	 <1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	 <7v8v23mhjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 15:35:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqkRx-0003Qj-QA
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 15:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab3FWNfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 09:35:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33349 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3FWNfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 09:35:21 -0400
Received: by mail-we0-f174.google.com with SMTP id q58so7524662wes.19
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 06:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=2cEWca3vFRaLg23XS21GYWobqGJ2MjqwwnfTotWmGjA=;
        b=plp/MBjUhv+p3EPnk4+oqcInwY27SVW++Q9hZralUTWacvRqTiL4QMDuTUAjtMFtyN
         Lr/mrU4kZzdjZbNSeucTQMbxFPLDcFE/irdXzG+WAk7tvbivVfsND1s9y93ouPr06M0u
         Nef/Mit4ZCFLktTt1OyaN5tOlUNC3FizW6l06/A3gx7OOD0iq4oIy/CEwtEdY7Mf+NXW
         xyUJ3GA2Negv4UvJw0bCjSasomFN5Npo4Bw8Madt2ZePpaIuYnIPmcj0umS2EOh6EgJQ
         lFS5h8MskxToI7BJildP5TzPZGBszdvJhbVRVud1Ikb9zhiYTlqL8AH8xk5y5bXCLzix
         CHSg==
X-Received: by 10.194.11.72 with SMTP id o8mr14499161wjb.0.1371994519389;
        Sun, 23 Jun 2013 06:35:19 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id x13sm10067482wib.3.2013.06.23.06.35.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Jun 2013 06:35:18 -0700 (PDT)
In-Reply-To: <7v8v23mhjy.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQnbOdabHqzmGeccdbC2D9OnK8eh0QSkIcI8k1DWtbKPGDwSBPrftjhHTvq7+bgAzk90+O4L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228737>

On vr, 2013-06-21 at 11:42 -0700, Junio C Hamano wrote:
> > +                (!fnmatch(refspec, remote->fetch[i].dst, 0) ||
> > +                 !fnmatch(remote->fetch[i].dst, refspec, 0))) {
> 
> Does .dst always exist and is never a NULL?  My quick scan of
> remote.c::parse_refspec_internal() tells me otherwise.
> 
> Also what are you matching with what?  refs/* against
> refs/remotes/origin/*?
> 
> What if remote->fetch[i] is not a wildcarded refspec, e.g.
> 
>         [remote "origin"]
>                 fetch = +refs/heads/master:refs/heads/origin
>                 fetch = +refs/heads/next:refs/remotes/origin/next
> 
> You would want to check for equality in such a case against the RHS
> of the refspeec you have.

Thanks for all the feedback, I've incorporated it all in a reroll that's
in progress, except for the above.

I've added a prefix check, so refs/foo and refs/foo/bar will be
considered clashes, but not yet an equality check. Equality for
wildcards is allowed and tested for, so do we really want to 'outlaw'
equality of non-wildcard refspecs?

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
