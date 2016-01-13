From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] lock_ref_sha1_basic: always fill old_oid while
 holding lock
Date: Tue, 12 Jan 2016 20:25:45 -0500
Message-ID: <CAPig+cRHNa8b8TdoRFsYvBBOcHbJF1VCKNgmt4SYkQsMAsJjqA@mail.gmail.com>
References: <20160112214318.GA2527@sigill.intra.peff.net>
	<20160112214439.GB2841@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 02:26:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJACg-0004ml-BI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 02:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcAMBZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 20:25:47 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35314 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcAMBZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 20:25:47 -0500
Received: by mail-vk0-f68.google.com with SMTP id i129so6859446vkb.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 17:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/m7Hwux179Nyse1OiXBqxh5OSO7ohIoHY8ocjFJMlos=;
        b=zhlL34CqGLHiQ6a7N0HSiy7F+zoXF7VYCnZPR+D4zE6UiV6pttlfHRKAOXkZn/u2GX
         zJPDm9Uxv3btiiNso98tmQNdHGKuzl0c/MPCoV4MXCHns8BIt6FwodzjeF17ztEc7Kx5
         Veyuag24l2QI1DC/sP94fFF3Cy5KJyKX1sjptcVErAnjQ0tfYqTu8X6V0NckJaFEb+cB
         Q74dzlBC88BmoAKDbkMNnt8NBA2hmesQu+5VpWCnO9wZuR9sMBDNmJ12x+fiYg3Ce1gW
         h6n1Q3oLF5XHYh9aoTiKwcMeukI86jydLwA1WSL92V2+erfRsHitFjMIv8bIn34JqKmB
         xImQ==
X-Received: by 10.31.56.18 with SMTP id f18mr83603370vka.19.1452648345928;
 Tue, 12 Jan 2016 17:25:45 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 12 Jan 2016 17:25:45 -0800 (PST)
In-Reply-To: <20160112214439.GB2841@sigill.intra.peff.net>
X-Google-Sender-Auth: mcyxZHwibbu-9XBL5ScL4Zj7RP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283867>

On Tue, Jan 12, 2016 at 4:44 PM, Jeff King <peff@peff.net> wrote:
> Our basic strategy for taking a ref lock is:
> [...]
> If these run simultaneously, we'll see a lot of lock
> contention, but each of the writes will succeed some of the
> time. The reflog may record movements between any of the
> three refs, but we would expect it to provide a consistent
> log: the "from" field of each log entry should be the same
> as the "two" field of the previous one.

s/two/to/
