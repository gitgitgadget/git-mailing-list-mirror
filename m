From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 18/44] refs: move transaction functions into common
 code
Date: Tue, 13 Oct 2015 18:21:41 -0400
Organization: Twitter
Message-ID: <1444774901.18742.6.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-19-git-send-email-dturner@twopensource.com>
	 <561CEB28.3090907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm7x6-0007La-83
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 00:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbbJMWVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 18:21:44 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35775 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbJMWVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 18:21:43 -0400
Received: by qkap81 with SMTP id p81so15246070qka.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 15:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=qCzG8YLmGvWwJQPpXiwLX5O7OpfvXX0AcMa0tFKW320=;
        b=TmYjDdl84Wv7k3nBQ2F2TsmuY681pkVn/NOoUjJRrYfpr7eTRUjiS9kSS1WAQ178y2
         3lPr+kr/zFQqS8wbmmFeB16H2zjRa1rmI6jcvk4uxUqliY2yhSiIu8fxw0RnIz8OC17t
         +tdfqPWEXU9q+7tdyFHStyWH1P9x+fM4GXbY/OFrzTd+zSaGj7vJUIkPkCSj5sBXCw2z
         Nc/2JftsmuqwI2M+n2R5nPIuQOIfAR1YIvvUFcm+PlAGWzW6SkfA+z0bC5aOEDGYHCSu
         n/HT9N2HpHE7EgB0pWB9TEU2s0BRYe8EsXv4u6rinTKFH4Iiqj3nLv6G/T//Q37dR3Qr
         rF4Q==
X-Gm-Message-State: ALoCoQnUxPW+W1wX48LmVHWuyTEKacVq5B491ynkSka0TS0m1z28Xp3KJ+PDTKR5ZRUWjHjay9f/
X-Received: by 10.55.41.93 with SMTP id p90mr41236311qkh.14.1444774902721;
        Tue, 13 Oct 2015 15:21:42 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id f129sm1375102qhe.45.2015.10.13.15.21.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 15:21:41 -0700 (PDT)
In-Reply-To: <561CEB28.3090907@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279526>

On Tue, 2015-10-13 at 13:29 +0200, Michael Haggerty wrote:
> I reviewed the patches up to here pretty carefully, and aside from the
> comments I already sent, they look good.
> 
> I like the new approach where the ref_transaction-building code is
> shared across backends.
> 
> It seems to me that a good breaking point for the first batch of patches
> would be here, just before you start creating the VTABLE in commit
> [19/44]. The patches before this point all have to do with moving code
> around and a little bit of light refactoring. They cause a lot of code
> churn that will soon conflict with other people's work (e.g., [1]), but
> I think they are pretty uncontroversial.
> 
> After this you start making a few important design decisions that
> *could* be controversial. Therefore, by making a cut, you can maximize
> the chance that the earlier patches can be merged to master relatively
> quickly, after which the cross section for future conflicts will be much
> smaller.
> 
> Ideally, you would include a few later patches in the "pre-VTABLE" patch
> series. It looks like the following patches also mostly have to do with
> moving code around, and would fit logically with the "pre-VTABLE" changes:
> 
> [24] refs.c: move refname_is_safe to the common code
> [25] refs.h: document make refname_is_safe and add it to header
> [26] refs.c: move copy_msg to the common code
> [27] refs.c: move peel_object to the common code
> [28] refs.c: move should_autocreate_reflog to common code
> [32] initdb: move safe_create_dir into common code
> [36] refs: make files_log_ref_write functions public
> [37] refs: break out a ref conflict check
> 
> I tried rebasing those commits on top of your patch 18 and it wasn't too
> bad. The result is on branch "refs-backend-pre-vtable" on my GitHub repo
> [2], including my suggested changes to those eight patches (which
> therefore became seven because I squashed the first two together).

Thanks.  I started from that, and made the changes that you suggested 
in reviews that were not yet in there.

I also added Jeff's extension patch, since it seems uncontroversial to
me, and since we'll need it sooner or later anyway.

I put the result on my github at:
https://github.com/dturner-tw/git
on the refs-backend-pre-vtable branch 
