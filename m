From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 10:32:38 +0200
Message-ID: <CAHGBnuOuFYvf=CSyCLbhn7pyq4jsqH+p+xV9rxAtU1y3r+qjzw@mail.gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
	<1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
	<xmqqtwixz6i4.fsf@gitster.mtv.corp.google.com>
	<A6FD8E93-63E8-49EE-838D-2AF3FD3910D4@gmail.com>
	<xmqqh9exz4xq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 10:32:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asnZ4-00024o-AP
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 10:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbcDTIcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 04:32:41 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34495 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcDTIcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 04:32:39 -0400
Received: by mail-vk0-f45.google.com with SMTP id e185so50429656vkb.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=byi4tktHuo/4P6BCIf3pPruS4K5QeGbhoM4LjIK0lbo=;
        b=LsZX4DooUsRcnr2NiLLRvd3oXd9ilgLFFPEgCfT9AxH9YX2p31qDxtDcA8qyLl4rW2
         mtr6V0XITNFjoNJkAxe+8XSnpWWw4IHmPVQLkGytOsigiCLSHXc0VfAqZKwCaUXFQRPq
         wcGub7IYnwtvRR2mc5+xyauFr/TxKXhmOF3zjvUgQ/VvfLqrs/mP9qY6DjOjbknSMb6w
         Zbtxg723+IFVPxARKPCPZdCld6gr7214huu5kJXiZHaXYz6qRsVCcThsb8ycwdrMFJa8
         2yTct8ClmAVBo6Y54rGPgXFGHbg1H59ajxXtiHL5RlIJ6mCJD/ZEisRIB9Z0B9UiMTBi
         K1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=byi4tktHuo/4P6BCIf3pPruS4K5QeGbhoM4LjIK0lbo=;
        b=Atz8Y/zfQvVEaRulbjDhGM0kTYomiX+Dlqf2BlYatZLxlGWReCjrIg+JnLCy5bx2d/
         UpgtJKj5NEH+kkvFrUUCCnualjveQmBq+YIP+ZaIkUnYreUaf4cMR5tmt1Z+jgabyonG
         H3u6zOfzyGxYYDTuKpyktL3pujpuYzjOOTAtpC5x6Ad07/ubkZZ8Dn0HZLldIUnilGe/
         diO1IIdgHCo2KegZdNCBWFdM6GGx2cuPFhNEQalhZPUhWFbD7uInfNpVUnTsF1FhzDzd
         M9zq4Ke/8BAsGAuVFD0rtYO+u5+PPrhcg2WKIdRPrB5ebrF40JvIZuxKHEfdaf7+Ozzq
         HJYQ==
X-Gm-Message-State: AOPr4FVQqHAZ7xzMNS4MlntrTgcJI886qAsdE4n0Jl4Gvy6rcr8i2XwMqvWOxoNnD9T7LVDevZkMB4OVf/hNfg==
X-Received: by 10.31.9.20 with SMTP id 20mr4064374vkj.109.1461141158273; Wed,
 20 Apr 2016 01:32:38 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Wed, 20 Apr 2016 01:32:38 -0700 (PDT)
In-Reply-To: <xmqqh9exz4xq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291994>

On Tue, Apr 19, 2016 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I dropped the support for the older version to keep the code as
>> simple as possible (plus it would be cumbersome to test with an
>> outdated Git LFS version). Since it is probably a niche feature I
>> thought that might be acceptable.
>
> It is bad enough that clients need to be adjusted at all in the
> first place, but I would have found it very troubling if the
> problematic change to LFS thing were made in such a way that it
> makes backward compatible adjustment on the client code impossible.

If clients rely on output targeted at human consumption it's not
surprising that these clients need to be adjusted from time to time.
What's troubling is not the change to git-lfs, but the very un-generic
way git-p4 is implemented.

-- 
Sebastian Schuberth
