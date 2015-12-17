From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Wed, 16 Dec 2015 21:31:21 -0500
Organization: Twitter
Message-ID: <1450319481.11927.0.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
	 <20151217010013.GC6594@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 03:31:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9OMF-0004VX-O1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 03:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbbLQCbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 21:31:25 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37293 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbbLQCbY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 21:31:24 -0500
Received: by mail-ig0-f176.google.com with SMTP id to18so1809751igc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 18:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=rv9VncSGekoC0K8E6ebonJ8R0hDKcwioHARpSBeY5nM=;
        b=FqxA82U47ZGavJ7LMV0GM6jyxdgIz/J8uDfaRgW9MgPRag+nMF4yEBP8zwu+gvp+wH
         9w1j26vhGLifxxTKH8igwwJNqtbb+YSFD9Gydj0ycTRHwqpE0Eb4BEdmDvz5DJq1zyUM
         flOkT11hnwqNQGo+j8zB+BLzhi4wNoRrOS5XG5DRbg3mWF692qVabq9cZX2NnzJxH8jF
         PDcDnIFnspCdFqOXxfx66lCFScAV4lsfwGnXGnCj6URwL+8k8nSqkbQVU1U5tREHGBtm
         ci3lBKGDl72HuOJs/GOLeFEFbWpcTj7BQn/tDYfYXKEj34l8r0x/08KrvPUq8f2Kps25
         s/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rv9VncSGekoC0K8E6ebonJ8R0hDKcwioHARpSBeY5nM=;
        b=TiJGSdagi5Xf00g6WCnN4eFMSpKFt9BJdLqUWPVzYebfno0MFe1PBl/gGeZ4LLevdp
         as4ED9zIyU1hrcnQ5CMolMrBR0GF+oF7TrhaHhdrym8HsHDMzfL70g9tA0M68S/Ru3Mi
         yGDYDuE/x05PrJUjChQApAgefKXE3nG/mkR3y120rxvklqDqbPKE3RXAXUDDYIH7IN8d
         8tOfWj38Ohxk89zEaLyw4N+Y6Pmu8s/Tod+j/4BbuGd4kRBRQbRA8PZkd80DT+uQxuaR
         19EnBpftLSLwD89A8ln6RdZyyZEByyuYA8RhB/xDDabaWfIuHDmA1Q/Xpy8u7D1B920q
         uxqw==
X-Gm-Message-State: ALoCoQk7UTopycKckDLxfkczw7hT48wbwAspKytAYJjNq1a5BOkQEc+PxW7MRsXvryFoXA0RHGx4cXl01ExdP6Iul6yFRdAEew==
X-Received: by 10.50.43.229 with SMTP id z5mr1162342igl.35.1450319483471;
        Wed, 16 Dec 2015 18:31:23 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id l5sm3919731ioa.17.2015.12.16.18.31.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Dec 2015 18:31:22 -0800 (PST)
In-Reply-To: <20151217010013.GC6594@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282631>

On Wed, 2015-12-16 at 17:00 -0800, Jonathan Nieder wrote:
> David Turner wrote:
> 
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -496,6 +496,13 @@ core.repositoryFormatVersion::
> >  	Internal variable identifying the repository format and
> > layout
> >  	version.
> >  
> > +core.refsBackendType::
> > +	Type of refs backend. Default is to use the original files
> > +	based backend. Set to 'lmdb' to activate the lmdb database
> > +	backend.  If you use the lmdb backend,
> > +	core.repositoryFormatVersion must be set to 1, and
> > +	extensions.refBackend must be set to 'lmdb'.
> 
> If core.refsBackendType names one backend and extensions.refBackend
> names another, which wins?

I've simplified this to just use extensions.refsBackendType for
everything.  Will re-roll once I finish getting comments on the rest of
this series.
