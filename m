From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 13:40:14 -0500
Message-ID: <20120328184014.GA8982@burratino>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxnJ-0001Kp-04
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619Ab2C1SkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:40:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64494 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab2C1SkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:40:23 -0400
Received: by yhmm54 with SMTP id m54so967593yhm.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1qp0Aec2YT7NY9lt2ADVOiD28HeLl/IXc4BVCrTn3LE=;
        b=agOPYdm4iqsff/hV+U/ItKKAsY2zjDRnLukphrfIlOtULZC14IbtcmAeLLbcb3Yr4v
         EL3QBZIP7YMfsmtvATNYL5CMaMSLx+eabQqa8LAQRQaIOnMAlpa/InvSb9VVIUL5uLvH
         rh4coEkaP8F0JLZgLnzABajMEaROZJJBgjCiP9uW7NM3vcgJfOq/fDpv63CQk10g/VxX
         WmFh3c05ZuYdv7JaepfqihGaOlom27S7iblDu2Wg78t1aIBrjORq2i4cgm3co8ACGhot
         qsNSTo1adcQa6Fa/NnLsfrY8lnu0yrS8BLw+ZRIf2U5/clsV6Ia+vuINFcJdBYIZ2V96
         VUfQ==
Received: by 10.50.94.133 with SMTP id dc5mr174423igb.24.1332960023168;
        Wed, 28 Mar 2012 11:40:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p5sm3016433igl.2.2012.03.28.11.40.20
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 11:40:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1uocwpap.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194160>

On Wed, Mar 28, 2012 at 11:31:10AM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Example: when I try
>>
>>  :; mkdir $HOME/cannotread
>>  :; chmod -x $HOME/cannotread
>>  :; echo nonsense >$HOME/bin/cat
>>  :; chmod -x $HOME/bin/cat
>>  :; PATH=$HOME/cannotread:$HOME/bin:/usr/local/bin:/usr/bin:/bin
>>  :; cat /etc/fstab
>>
>> the shell uses /bin/cat without complaint.
>
> Yeah, but I think that the case Peff is worried about is:
>
>         $ >~/bin/nosuch
>         $ nosuch
>         nosuch: Permission denied

Just remembering the EACCES and reporting it when no alias exists
would take care of that, no?  In other words, this seems analogous
to the example of a non-executable "cat" that is reported if no
other cat exists but does not prevent /bin/cat from being run.
