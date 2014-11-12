From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: smudge filters during checkout & crash consistency
Date: Wed, 12 Nov 2014 14:30:12 -0600
Message-ID: <CAMsgyKagoz7NU7cGuwvq61aiKc6Wq-z+w0_Fep7t9tYy90pB6w@mail.gmail.com>
References: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
	<xmqqk33046ha.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:30:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoeYa-0003qf-IE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbaKLUaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:30:17 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60222 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbaKLUaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:30:13 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so10624257obb.13
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9xRfaAFl5xF6CXtVyYn/KIVmM+uB+jV0AqZpcA5HZEI=;
        b=aHFmIoIiPqx0pGNQG7ZS5Y+a/hcoj6QyIXRkLTVjktpacCsn+zsexLZ2XRUu+tkAeq
         R931LRPWZ6p5R+pS/aFaldLWMGp83cXN2GyDVcntsMUnl6dyfE68FYVks+bRdrZ8vOLH
         Z/dudPJEuVZfPELI6RWjOeVOiHaEM2uPctYuVawWIHcCJOJQTDC1lAz+VEQqTkZpX043
         u+PG2yIMWHX6POfOifQLq26KcEvHxRSlTvGjFkSqlI9pT6MKVb5ndjLwSKNIv+t2PQHd
         KJNcVozndCuQ4DrtFXoj/mK/yi3IfrowzeuiE4PF12hadkTLVmwOCkH5Y17f4bvK1gNF
         knIQ==
X-Received: by 10.182.32.33 with SMTP id f1mr39482971obi.34.1415824212612;
 Wed, 12 Nov 2014 12:30:12 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Wed, 12 Nov 2014 12:30:12 -0800 (PST)
In-Reply-To: <xmqqk33046ha.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But if you then switch to B from that state, F will not even be
> modified (i.e. it will keep the contents you prepared for "branch
> A's instance of F").

Or: the post-commit hook used in the workaround looks up the prior
branch via @{-1}, finds all files common between @ & @{-1} that don't
share a latest commit, deletes those files and replaces them singly
with the results of git-archive using the latest commits of those
files relative to @. ("All files common between @ & @{-1}" would need
to be either all non-locally-modified files or making use of git-stash
{save,pop} to preserve local modifications.) All this assumes having
reversible $Format$ strings, so the clean filter can restore the
proper $Format$ string.

Might be worth doing just so there's at least 1 accurate and
maybe-fast "git rcs keywords substitution using smudge/clean filters"
project on github. ;) Otherwise, users of "git-keyword-substitution"
and "git-rcs-keywords" are being led astray.
