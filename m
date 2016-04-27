From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname
 already be normalized
Date: Wed, 27 Apr 2016 16:34:53 -0400
Organization: Twitter
Message-ID: <1461789293.11504.5.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
	 <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
	 <1461787832.11504.1.camel@twopensource.com>
	 <20160427201512.GA8073@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:35:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWAn-00043D-As
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbcD0Ue5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:34:57 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33750 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbcD0Ue4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:34:56 -0400
Received: by mail-qk0-f169.google.com with SMTP id n63so23875295qkf.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ba/MpqNeXbLa++tPgS/ZGdtKVd47215PoFlzhRFZ9aY=;
        b=kzets8PJLYDWHD0lEr4cDoeRRsWg2DLALt1j4wBWsUWlBaEEcwzupurc9AdkYXFGkf
         bQL+pF4oihif7ik19aOTychy9WkW8z1Q0L4neEzpIqCNCl6PbIKYnWnU8FCY+d8Nl6VI
         XlyaDk0IDM/Opb0vvZXDo6aoucdVvEA1CQDv014Bh8sV+wo5HC6a9I7LTmEbexQFps+h
         sYLJfQ2ADrXakF1W8uGgtSp2EZr5O3AXhNAxOCLOJ3MEUBRaxq6QVpetb1Wlw2T2KHzr
         KfEL2uHxHwauEFNherJjQiMal+RRdgsgj6jBQQLVxvnPLWTdp//o2K0GpDmZvcSlf+Oj
         Yb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ba/MpqNeXbLa++tPgS/ZGdtKVd47215PoFlzhRFZ9aY=;
        b=ZFR4/tH/tc7U/Glf1JxM/weh0gGdkltCKS48ZS1UyRg4nM1ghudbfo3y//op57uWt1
         iuKltkYbNOSee0aHvP8PCIfKAdDh3BWiR9nSmF2d3cqVg8LtyZ/mxr5W3F+SJUJOgpHr
         2uTkCPLGRA+dyLeEe2lpDh4Ndi8uXCdNKsx3g0njT0QSyoDydo1xdGu7olRpBF6ZXv3N
         c/FI/nxnA0AWtZViQImTOrQOs1KpY1FVlc1h+4Z+MOzmd9m9tMKRmnRAVHdgXOU4qHph
         l8wNGXCS7kMVU2PhClWSNgbWAx7Ak2A54Gq2B49fYvTrRIdqYiRxVLk25oT+AOGlMfb6
         135A==
X-Gm-Message-State: AOPr4FU4eq9BOfcvNdOVr6Wyis3qcwAhPJVQj/a/iTS68q35CP5QnSaCxAVM3qzb6+Vorg==
X-Received: by 10.55.117.10 with SMTP id q10mr11450123qkc.103.1461789295334;
        Wed, 27 Apr 2016 13:34:55 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a142sm1755046qha.12.2016.04.27.13.34.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:34:54 -0700 (PDT)
In-Reply-To: <20160427201512.GA8073@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292818>

On Wed, 2016-04-27 at 16:15 -0400, Jeff King wrote:
> On Wed, Apr 27, 2016 at 04:10:32PM -0400, David Turner wrote:
> 
> > On Wed, 2016-04-27 at 10:59 -0700, Junio C Hamano wrote:
> > 
> > > There is another call to refname_is_safe() in
> > > resolve_ref_unsafe(),
> > > which applies the sanity check to the string from a symref.  We
> > > seem
> > > to allow
> > > 
> > >     $ git symbolic-ref refs/heads/SSS refs/heads//master
> > > 
> > > and we end up storing "ref: refs/heads//master" (or make a
> > > symbolic
> > > link with doubled slashes), but the current code considers the
> > > resulting symbolic link as "dangling".  Again, this change moves
> > > the
> > > rejection a bit earlier in the codepath, without changing the end
> > > result, I'd think.
> > 
> > I think we should disallow that -- refname_is_safe should probably
> > call
> > (or be replaced with calls to) check_refname_format.  
> 
> I thought the point is that one is a lesser check than the other, and
> we
> need different rules for different situations. So we might allow
> deletion on a refname that does not pass check_refname_format(), but
> we
> must make sure it is not going to cause any mischief (e.g., escaping
> ".git" and deleting random files).
> 
> But anything writing a _new_ refname (whether the actual ref, or
> referencing it via a symref) should be using check_refname_format()
> before writing.

Unfortunately, neither check is lesser -- refname_is_safe allows
refs/heads//foo but not a/b while check_refname_format allows a/b but
not refs/heads//foo.  So sometimes we need both, while other times we
just need one :(
