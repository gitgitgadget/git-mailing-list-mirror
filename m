From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/14] connect: rewrite feature parsing to work on
 string_list
Date: Tue, 17 May 2016 18:23:49 -0400
Organization: Twitter
Message-ID: <1463523829.24478.78.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-5-git-send-email-sbeller@google.com>
	 <xmqqr3dhfuo9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 00:23:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2nPA-0003p2-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 00:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbcEQWXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 18:23:53 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34619 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcEQWXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 18:23:52 -0400
Received: by mail-ig0-f180.google.com with SMTP id u5so12308738igk.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=p1ZLUxj1iCEV1AF736l5M9fwgyBEkxAok2VvgcXEwCA=;
        b=qGegJjB2YupvkbkRAIO5rDm0TU2K5hKkuNceIfqEwZ565lGeeAtWV4Q05chD2RMJsD
         T9+Gi31J+63ptqknHBHSd30S9GNkLgHVKd9O2NAI2+FQ3f/eGBrIlZhZjiAff6qfQwau
         lzDq7wVFVMsX+3dU9cjgkf+vzLqD14BZqZ8ph7Bn0EXkK5dig3BpEx2u/p3f/DnM54ZU
         qpCz9Jd8YboLd0EQISnC46e58miHxi1w07aqAHUNldpn9+2HtwkIfr4RRbyb0SLm+WOf
         J6a+5fe9G2v1CHHGoyC7w8MqeUcYfozO/nWEvX/nlk30xhEEGeu1XgqUVlALJZ+Be0Gu
         OEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=p1ZLUxj1iCEV1AF736l5M9fwgyBEkxAok2VvgcXEwCA=;
        b=aYazvxcPsPIemmhkR4A46qvl1DSl7x5XRlquxvOZoFBvyL04PKueCtYmfsWEiwdSPf
         q4WlySxKgS/XViiL+8XTGZapgKCaSlE0gf/0+DCz3JQAT5kb8M+yhwz+2pbs9Ck8ncXy
         5O4bFFNwDCiMRRXx9vwu+/oLeAAoZ9Ccz88t0r2qfEuxWAC65HDDm2UE87O9nHavuZQD
         ZR7/f6hRI3g/+TB0smAkvAdzMMhGtHWIdfTJP6jUgWR8hyl/GlIEfYfUibXE5GEmstrm
         TyXlCGJVQu7F9Jveu0QfihHYi8Ffo0ImfJpxBRcCxZi2ZK8I/4OQO7SeAixauIVIdADP
         JLDg==
X-Gm-Message-State: AOPr4FWaApTxplK1T8Q8COuIa68dAugDYDq7pPPjAQZlcXlYkTG0GqCnhlAu+iFEcyUn3Q==
X-Received: by 10.50.134.131 with SMTP id pk3mr10321131igb.88.1463523831391;
        Tue, 17 May 2016 15:23:51 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id h125sm1754457ioa.20.2016.05.17.15.23.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 May 2016 15:23:50 -0700 (PDT)
In-Reply-To: <xmqqr3dhfuo9.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294919>

On Wed, 2016-05-04 at 13:13 -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > Later on when we introduce the version 2 transport protocol, the
> > capabilities will not be transported in one lone string but each
> 
> s/lone/long/, I think.
> 
> > capability will be carried in its own pkt line.
> > 
> > To reuse existing infrastructure we would either need to join the
> > capabilities into a single string again later or refactor the
> > current
> > capability parsing to be using a data structure which fits both
> > versions of the transport protocol. We chose to implement the
> > later.
> > 
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  builtin/receive-pack.c | 15 ++++++---
> >  connect.c              | 82 +++++++++++++++++++++++---------------
> > ------------
> >  connect.h              |  2 +-
> >  upload-pack.c          | 13 ++++++--
> >  4 files changed, 58 insertions(+), 54 deletions(-)
> 
> I am not sure if the churn is make a right tradeoff here.
> 
> A loop to concatenate each segment into a strbuf before passing it
> to parse_feature_request would be at most 5 lines long, no?

I started looking at this again briefly today, and I actually think
that string manipulation of this sort is a mistake.  String
manipulation is error-prone, and having an interface defined in terms
of strings makes it hard for a reader to see what sorts of input are
valid and invalid.   (It's also often somewhat less efficient).  So I
think it is a good idea to improve the interface while we're already
changing code in this area.
