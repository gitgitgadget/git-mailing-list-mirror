From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname
 already be normalized
Date: Thu, 28 Apr 2016 13:44:09 -0400
Organization: Twitter
Message-ID: <1461865449.4123.2.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
	 <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
	 <1461787832.11504.1.camel@twopensource.com>
	 <20160427201512.GA8073@sigill.intra.peff.net>
	 <1461789293.11504.5.camel@twopensource.com>
	 <20160427203728.GA8364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:44:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpzF-0004cV-4q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbcD1RoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:44:19 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36067 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcD1RoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:44:17 -0400
Received: by mail-qk0-f178.google.com with SMTP id x7so35039483qkd.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DmmLcHhpd6LLEf0wIrZ02340Dqxm1WZBNdC1fg9/0jU=;
        b=b9hwwYkpM8ufmHEiFgf2g8KeG9MAfBMwv7Qb+TavA4lcIpR9l7NeCN8KOUvN9HAZ2m
         Z/WopAHiDO6w1J2O/2MqPUKgduMXkwepoW2Dlync1y9Rf8O8akj0uo1wf/0E/B9hO+Gf
         lsgXbfU86UUV9WiAtPz7i7/cdWaOEnYTay3K8nVCH1SAGB3tnekm5w6DVpAHBro/P2Qx
         kORf4mRPlgAPvBldKv7HZlDHUEP4ILDqDwCGa55aGdaR/o1ctEFMQYD9aC6t/qnnpt7s
         FtcNLUxKSeOVs4tOYlgbJe0n7rgm3mePKHxyeF2sutmujzd9SMf0nRLS+8GxuGm7LLCO
         XibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DmmLcHhpd6LLEf0wIrZ02340Dqxm1WZBNdC1fg9/0jU=;
        b=T4WiDSR7+8FC35MqDLy/KFCtGxFM0lEjkp68cB0IyaO5LQ3j/ZNJhfn8jXZTuUDr66
         f/nCVeR+wT/zny20HrDR6vIczJEfLtkuTYSy3Fic6fFRN5XUobGskvQzqFgK9TVp8k+3
         P/P64wit1mm/oNxoVCiXdOjXJjSIUDtE5Zve8ZZiCYN3pwxKQJ8SXmiAgR07U5Xd+BxH
         aOFt0+34TIvfGrkaEWxyEhkNAEeR0yiP6EDzjMEhNWRdA37ownhiMmc1QzKqRsx97TM0
         TVzfY9YwcD+VD4rHi6XrKxDffj5NY/BvRe3comORns4cOtkX/KWAItlnDI+tPtWaFmgt
         zWow==
X-Gm-Message-State: AOPr4FVMq1l23yCw0asBg+GRiTiGi6Q+JPcHE2ZSATdOOVVJ5JVrJJQikH+y9/eAyNNCVw==
X-Received: by 10.55.172.72 with SMTP id v69mr16277742qke.45.1461865451121;
        Thu, 28 Apr 2016 10:44:11 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p143sm3133747qke.38.2016.04.28.10.44.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 10:44:10 -0700 (PDT)
In-Reply-To: <20160427203728.GA8364@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292928>

On Wed, 2016-04-27 at 16:37 -0400, Jeff King wrote:
> On Wed, Apr 27, 2016 at 04:34:53PM -0400, David Turner wrote:
> 
> > > I thought the point is that one is a lesser check than the other,
> > > and
> > > we
> > > need different rules for different situations. So we might allow
> > > deletion on a refname that does not pass check_refname_format(),
> > > but
> > > we
> > > must make sure it is not going to cause any mischief (e.g.,
> > > escaping
> > > ".git" and deleting random files).
> > > 
> > > But anything writing a _new_ refname (whether the actual ref, or
> > > referencing it via a symref) should be using
> > > check_refname_format()
> > > before writing.
> > 
> > Unfortunately, neither check is lesser -- refname_is_safe allows
> > refs/heads//foo but not a/b while check_refname_format allows a/b
> > but
> > not refs/heads//foo.  So sometimes we need both, while other times
> > we
> > just need one :(
> 
> IMHO, that sounds like a bug. check_refname_format() should
> conceptually[1] be a superset of refname_is_safe(). Is there a case
> where we would want to _allow_ a refname that is not safe to look at
> on
> disk?

The only such case I can think of is the case where there is a symref
to such a bad refname, and we want to delete said symref.
