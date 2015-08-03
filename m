From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 03 Aug 2015 19:20:26 -0400
Organization: Twitter
Message-ID: <1438644026.7348.37.camel@twopensource.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
	 <55BC4438.8060709@alum.mit.edu>
	 <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
	 <55BC6C5C.1070707@alum.mit.edu> <1438631396.7348.33.camel@twopensource.com>
	 <CACsJy8Aab0-JQitEnxYwiepPBvkgHzZudALpQSi2VS54_x4d7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 01:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMP23-00016b-7I
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 01:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbbHCXUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 19:20:30 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33881 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbbHCXU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 19:20:29 -0400
Received: by qkfc129 with SMTP id c129so56736961qkf.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 16:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=q62R/daL/t2Jd0Gvk9Bp993zWXs6bfLjfxkynmz+AvY=;
        b=NmPtL3/Fp7hmRwH3D2Nj4m6IrSBXB3laZSzFXOIzW1xrNtGx+dxUMWUBbjWIcXJu3F
         5uUB6DiVd/KZZqqQI/DP6lufd9RRfVFETJVHEH2IF+1QxqXfbxz3WwoXj0BeSahbriMg
         pYk7sB8ebNAn/5xYW+YmFbmoFTy9SXd4Mp4xZ0CQJuR9vZno4F4mrA3GTSx1Woeko76a
         /qZgCC/XgljN6Q20QD58D6S7LowvPZngVfMkxGIcwq90zprh1c2yqQgWxWS9+4gDMm+G
         z+1RlJ4V1DRsGBPEqMKtpGz+HV75t3m5xt5spd8/T+IzCk40XiegrAjMmpc3Wc00Ecmy
         tKYA==
X-Gm-Message-State: ALoCoQkqNT+KXMPW0QAAVPPBxD6SB7dAcHKmyeGb8pnmlPIPPpYOXkVbra4I2madZochBu31lJ5M
X-Received: by 10.55.25.80 with SMTP id k77mr965500qkh.105.1438644028481;
        Mon, 03 Aug 2015 16:20:28 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id v74sm7677449qge.27.2015.08.03.16.20.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 16:20:27 -0700 (PDT)
In-Reply-To: <CACsJy8Aab0-JQitEnxYwiepPBvkgHzZudALpQSi2VS54_x4d7Q@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275228>

On Tue, 2015-08-04 at 06:09 +0700, Duy Nguyen wrote:
> On Tue, Aug 4, 2015 at 2:49 AM, David Turner <dturner@twopensource.com> wrote:
> > Simply treating refs/worktree as per-worktree, while the rest of refs/
> > is not, would be a few dozen lines of code.  The full remapping approach
> > is likely to be a lot more. I've already got the lmdb backend working
> > with something like this approach.  If we decide on a complicated
> > approach, I am likely to run out of time to work on pluggable backends.
> 
> I think you still have another option: decide that lmdb backend does
> not (yet) support multiple worktrees (which means make "git worktree
> add" reject when lmdb backend is used). That would simplify some for
> you and we can continue on at a later time.

Some of our developers are pretty excited about multiple worktrees, so I
don't really want to do that.  Also, it's easier to develop when more of
the tests pass under the LMDB backend (no need to investigate whether
worktrees are the reason for failures when there are no failures).
