From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 13/20] refs: resolve symbolic refs first
Date: Thu, 04 Feb 2016 14:24:43 -0500
Organization: Twitter
Message-ID: <1454613883.5545.4.camel@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	 <1452788777-24954-14-git-send-email-dturner@twopensource.com>
	 <20160204073742.GA20162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:24:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPWO-0002WG-1C
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966181AbcBDTYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:24:47 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35424 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966176AbcBDTYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:24:46 -0500
Received: by mail-qg0-f47.google.com with SMTP id o11so50057554qge.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=gFkU+fx4XVLiBYFlz/t1EoHC91hQxDWb4jyfYvnRCYc=;
        b=xfnyrZOd66p7DQhaECT/+2kZ0hDr2URdixVLrLxvkNCijCnJCepbpk3inPYJkD9FUf
         47a4eo97kIPgeTcn1KS0aebSXZwXEXp5qkZavrhs36oN8o29ZPAEE94gofPXIy4W2Sk+
         OAW4X1mI54JzYkscqMV0Nud+IMVc/BRczLlBmmxtYJqTgx7PbtPodcMVzaY2FM7BwG9I
         ZXlfeY01v+fH2O1zzKjInBnCidWRJ+S+qm+Vn+QrvBINYynZivG3k2jigWiEJBmqEJsq
         E17Qfd/Qc63FAVvFuDkAf7gIMj3tfeO36bFhNyJrMHGKV2febFFJo1tzxi7NHdUhdiPa
         R8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=gFkU+fx4XVLiBYFlz/t1EoHC91hQxDWb4jyfYvnRCYc=;
        b=aV/YKz50olSPZLfPmX+NHfa8a0ZnsajHn3Vb3+USUuhPN4ZSlqngA1BkZ/B+2dnV60
         J/LKwgzPywFxWtaUUjror/A07ZFnR0Z5pNx8zY5LraNl3Q7fmMdNY1C4wWU8qO4Uv6lu
         rvhfCDHENeDL34H5lanVWUN8/QOUtcpqPjVL7eHEc7kCGdjU9fy/ek13DXHKfzwkra3/
         RxePXxEQAUDSAMUegTWT4fqsKC5PvkKcgx+Bu2mAJtCxINZxbX8VDCprw/nBlL/EZpDu
         cx6Hu5WSqp2PVUAGdxv/mRShev1gCfxeXuSGhBX+fO+5CaU6im5Tl2QBnLyH0C4OCp1d
         9FcQ==
X-Gm-Message-State: AG10YORUGt+rAH06i9exIqe1YDGOsE0ySfEHsm0PnXr3vRn9h7ksYBpds61YFV2bdRd+Tw==
X-Received: by 10.140.131.17 with SMTP id 17mr12095801qhd.12.1454613885300;
        Thu, 04 Feb 2016 11:24:45 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id s81sm5901582qkl.36.2016.02.04.11.24.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 11:24:44 -0800 (PST)
In-Reply-To: <20160204073742.GA20162@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285480>

On Thu, 2016-02-04 at 02:37 -0500, Jeff King wrote:
> On Thu, Jan 14, 2016 at 11:26:10AM -0500, David Turner wrote:
> 
> > +static int dereference_symrefs(struct ref_transaction
> > *transaction,
> > +			       struct strbuf *err)
> > +{
> > +	int i;
> > +	int nr = transaction->nr;
> > +
> > +	for (i = 0; i < nr; i++) {
> > +		struct ref_update *update = transaction
> > ->updates[i];
> > +		const char *resolved;
> > +		unsigned char sha1[20];
> > +		int resolve_flags = 0;
> > +		int mustexist = (update->old_sha1 &&
> > +				 !is_null_sha1(update->old_sha1));
> 
> Coverity complains about this last line, as "update->old_sha1" is an
> array. I think you want to check "update->flags & REF_HAVE_OLD"
> instead?

Yeah, that's right.  Thanks.
