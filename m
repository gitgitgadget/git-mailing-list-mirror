From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname
 already be normalized
Date: Wed, 27 Apr 2016 16:10:32 -0400
Organization: Twitter
Message-ID: <1461787832.11504.1.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
	 <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:10:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVnM-00053M-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcD0UKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:10:35 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34997 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbcD0UKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:10:34 -0400
Received: by mail-qg0-f51.google.com with SMTP id f74so21906205qge.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Ss+rQttDYvgiMC8n2C00SdIZC1fa5WJq90OhSVGeCoo=;
        b=CAjZAvPIo4LdGDjzkGsZapRSMwdhug6mKFZTxwJYVLSYjXkVXW+QmQ3QP/8ZyWktmB
         zmTuH9FDFHngezaResIl3ARRkNnicYTTzErNL43kzqXBJNDgABmvv0HanEKVvZNDaSv1
         MOtqNY0/z/kBSuzK+nDKSoDggIcokEsR8N9uqzVAbQ5W67hawXZLHvwhfs2cti5kWK+L
         ryf4uSL5JAkJo4KHM8BxP3GpgsltlHT5aBfPVGZFfPPPCy2XpbjeenraFuWBlOxgK/sj
         GXMqpkJ8T8Fo9X0MTmk/cKXbsDCpKkHLOxHsDs0ZmgpqCKult5RWZrUJpct8RassD5hi
         Q+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ss+rQttDYvgiMC8n2C00SdIZC1fa5WJq90OhSVGeCoo=;
        b=DwVBzCxujdjN3/X2tPRgoCAB1COhO+duDs8ksp5JE2Pm9VX/V/ZcNtVVVcz/d0NXUp
         KzVtAHmmgRiaRsxGSEjAT+LBEoYiV08BueLXrFpslnh3sIxkO+cCEIYymkTX0jtP+Y1W
         eP5nKjq6/6H2dyfAW8bQO7vuGm6/2RQX5uAJ33i6FRbq+lj5gmbek4s+prgFKoYLyg4t
         Kqksm3wyF7ePFlvdxuthY+QQIAtoC9Qtni+6dsAdJ1BfyXyvpm0fhYVJ2NwrcWXSVzzz
         NNNeCqwflPxkXybTpI0QTfo5ZpnqOdymYdnOERSsKbEImO9oAj1b41N3oTPCR2yjdDzy
         wpLw==
X-Gm-Message-State: AOPr4FXNI8FvjYb1E//JBGakpleso33iccME+GJ4u3dNlMyW2LGMfFRmKptReDoeAVDxKw==
X-Received: by 10.140.167.137 with SMTP id n131mr10610276qhn.73.1461787833546;
        Wed, 27 Apr 2016 13:10:33 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h83sm1731793qhh.4.2016.04.27.13.10.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:10:32 -0700 (PDT)
In-Reply-To: <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292810>

On Wed, 2016-04-27 at 10:59 -0700, Junio C Hamano wrote:

> There is another call to refname_is_safe() in resolve_ref_unsafe(),
> which applies the sanity check to the string from a symref.  We seem
> to allow
> 
>     $ git symbolic-ref refs/heads/SSS refs/heads//master
> 
> and we end up storing "ref: refs/heads//master" (or make a symbolic
> link with doubled slashes), but the current code considers the
> resulting symbolic link as "dangling".  Again, this change moves the
> rejection a bit earlier in the codepath, without changing the end
> result, I'd think.

I think we should disallow that -- refname_is_safe should probably call
(or be replaced with calls to) check_refname_format.  
