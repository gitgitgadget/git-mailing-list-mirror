From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL
Date: Fri, 22 Apr 2011 14:36:13 +0000
Message-ID: <08195d5d-bd90-49d3-a1a6-63be0d833110-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
            <7vtydrutbq.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDHTL-0004XG-Im
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 16:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab1DVOge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 10:36:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46237 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab1DVOgd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 10:36:33 -0400
Received: by pwi15 with SMTP id 15so352113pwi.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:to:from:cc:message-id:in-reply-to
         :references;
        bh=58qY1A+oeAZ9mFR/HZRjp4wOHGuigvJ8vUq/Rv8GfZA=;
        b=Z4O4g2A2HCYOuuH5UdoEslKMcJX7SKfP9dG9EWy5YmuYbp+3nW41F5E3C2ZFrfMJVx
         aUQuBlgWU/fM3o7yrk6kt41mvtxBLUsWe7Pufz8VOMT4C6DXVviASq74Nh/9U0527uWq
         ByQ07jlnmRf8ebUGhQOaWCoTQX7+YN1DcG8Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:to:from:cc:message-id:in-reply-to:references;
        b=lUwFzW4Ln4fJ0MXwosjAqRFRfvTDLp8yE4wHCtWWX82EdmyFVrOxa0VI2rEs2icCrr
         pRnFKBECjRIkChFfxcyiBXYI4G0bUm6VOc2zNosazw8K0mskgOZqPCsc9NWcEcCK0/bm
         RY14A29+iEPr9NvlhyU+cNz8qSMvX7+kJNf4s=
Received: by 10.68.49.66 with SMTP id s2mr646368pbn.139.1303482993493;
        Fri, 22 Apr 2011 07:36:33 -0700 (PDT)
Received: from gmail.com (tor-exit-router37-readme.formlessnetworking.net [199.48.147.37])
        by mx.google.com with ESMTPS id k3sm1615916pbc.0.2011.04.22.07.36.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 07:36:32 -0700 (PDT)
In-Reply-To: <7vtydrutbq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171935>

On Thu, 21 Apr 2011 15:34:49 -0700, Junio C Hamano wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> Date: Fri, 11 Feb 2011 16:06:36 +0000
>> Currently, when the date mode is DATE_LOCAL, the
>> time zone is never pretty printed;...
>
> I am not opposed to have a new mode that shows timestamps in local
> timezone with zone information, but this change is a regression to people
> who have known and relied upon that asking for timestamps in their local
> timezone will give everything in the local timezone and result in a short
> output by the virtue of not needing to repeat the zone string, as they are
> the same (this is not strictly true near your dst boundary, and that is
> why I am open to the idea as a separate option).

Allow me to restate what I think you are saying:

How about having [the still deprecated] --date=local (that is, DATE_LOCAL)
option produce the old behavior, but have every combination of date mode
options that does not involve DATE_LOCAL always emit the time zone.

In other words, all of these do not emit a time zone:

  --date=local
  --date=local --time-zone=local
  --date=local --time-zone=default   # --time-zone is ignored for simplicity.

and all of these always emit a time zone:

  --date=default
  --date=rfc
  --date=rfc2822
  --date=iso
  --date=iso8601
  --date=short
  --date=raw
  --date=default --time-zone=default
  --date=rfc     --time-zone=default
  --date=rfc2822 --time-zone=default
  --date=iso     --time-zone=default
  --date=iso8601 --time-zone=default
  --date=short   --time-zone=default
  --date=raw     --time-zone=default
  --date=default --time-zone=local
  --date=rfc2822 --time-zone=local
  --date=rfc     --time-zone=local
  --date=iso     --time-zone=local
  --date=iso8601 --time-zone=local
  --date=short   --time-zone=local
  --date=raw     --time-zone=local
                 --time-zone=local
                 --time-zone=default
