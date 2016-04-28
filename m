From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 15/29] ref_transaction_create(): disallow recursive
 pruning
Date: Thu, 28 Apr 2016 13:48:38 -0400
Organization: Twitter
Message-ID: <1461865718.4123.4.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <615204c877610855b02b21ce14efa5b7342182bc.1461768689.git.mhagger@alum.mit.edu>
	 <xmqq60v2anyo.fsf@gitster.mtv.corp.google.com>
	 <1461788637.11504.3.camel@twopensource.com>
	 <xmqqh9em93xo.fsf@gitster.mtv.corp.google.com>
	 <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:48:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avq3T-0006XC-Fl
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcD1Rsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:48:42 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34393 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcD1Rsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:48:41 -0400
Received: by mail-qg0-f45.google.com with SMTP id 90so17263870qgz.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=t/ULfiVnTq4j9eVhsqxoSVUT34wcB5Tth0qU3wFGQH4=;
        b=NuG+0fTZgbMx9DWdGL0rYowLHfH0Mm9EZP1NwNHpZ/4qDlFQY2FlvIp9iJUeuhJkvV
         KEEZYK+DKOLNPE+WXg3fspDC95Gy9jEBbE2QnUml8vjyDvfVYW7cP/dbs3BxxIEfEzSO
         fYWc0FCXx5QvYLVjPbGeAb+1Mve3E3NZYf+vHWpMSM8cLFZfMftgWWdgAaApHhm6wFvg
         k4CIkuhP+ncxdrhzYdyqzdLuwGGocFltx5Xzyk0vCSbLajUUq61axZ4r9EPPF6yQUShB
         9xtKA7eTv7KZHEzb5YGftV26ZZjlThUXzA7pLEQaQMGDd22tf2YHRBMWv0Am/vkeK9TM
         WZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=t/ULfiVnTq4j9eVhsqxoSVUT34wcB5Tth0qU3wFGQH4=;
        b=JHiz/SSZsCoQSeV4p+BkoZdbYpm1CqWAPZ1ggFh8yBEGI4yGuXTSbaliWHYuI/IIpt
         ggF5LbObCt6+siJCaDIocwjcOpPmNM0KkDBAcYY8Nm/1jtanzhjOlBkcREzoUaI3LFt/
         vWxn20u01Z1vdmyL9hOIjVLEUmiPuhaAOIM0PaksF7CNwxNuUK7ZrS8cLTCnJO+Xidrh
         ME+61IYhEdqCwfPK1MItg3ESu6O3di3N5DbKdGZCwkLxjuOJL4/kAZNWfE2WCNBVvClk
         IzXlTWBljux8tnmXdUUKraKvioEYhvVCPDFjzAxoV1P39lE2PsmTedhZkXJ+9mOvQbd9
         +Y9w==
X-Gm-Message-State: AOPr4FVUrIJE1ZhYGISGgfe4ni4+aAcXqhCuXEbtq1iSLZTMwAkvFOmUO8VHvV62a/F0Sw==
X-Received: by 10.140.85.133 with SMTP id n5mr15237492qgd.32.1461865720501;
        Thu, 28 Apr 2016 10:48:40 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x202sm3132204qhx.30.2016.04.28.10.48.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 10:48:39 -0700 (PDT)
In-Reply-To: <xmqqvb327nyz.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292931>

On Wed, 2016-04-27 at 14:15 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If a casual reader sees this code:
> > 
> >     ref_transaction_delete(transaction, r->name, r->sha1,
> > 			   REF_ISPRUNING | REF_NODEREF, NULL, &err)
> > 
> > it gives an incorrect impression that there may also be a valid
> > case
> > to make a "delete" call with ISPRUNING alone without NODEREF, in
> > other codepaths and under certain conditions, and write an
> > incorrect
> > 
> >     ref_transaction_delete(transaction, refname, sha1,
> > 			   REF_ISPRUNING, NULL, &err)
> > 
> > in her new code.  Or a careless programmer and reviewer may not
> > even
> > memorize and remember what the new world order is when they see
> > such
> > a code and let it pass.
> > 
> > As I understand that we declare that "to prune a ref from set of
> > loose refs is to prune the named one, never following a symbolic
> > ref" is the new world order with this patch, making sure that
> > ISPRUNING automatically and always mean NODEREF will eliminate the
> > possibility that any new code makes an incorrect call to "delete",
> > which I think is much better.
> 
> ... but my understanding of the point of this patch may be flawed,
> in which case I of course am willing to be enlightened ;-)

Since there is a manual check for that case, the code will fail at test
time.

But I don't have strong feelings and am happy to go either way on this.
