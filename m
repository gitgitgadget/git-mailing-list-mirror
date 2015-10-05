From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 05 Oct 2015 10:22:05 -0700
Message-ID: <xmqqd1wtz0w2.fsf@gitster.mtv.corp.google.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
	<1441073591-639-3-git-send-email-dturner@twopensource.com>
	<5611E7B1.3090001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj9TE-0001pG-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 19:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbJERWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 13:22:09 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35644 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbJERWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 13:22:08 -0400
Received: by pacfv12 with SMTP id fv12so186148200pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ajDGN7U6PKYbrZkd2V9qFdZIpQhWf4dmcauKc0i4gZ8=;
        b=piXxR2ohQeyHAP0wFYDMl8gbWlO0dQwDGGba+bsvsGQu4NGZLwO6Wwb8piuErS40mN
         +ZfmHU9VJbDDS5R+hn/F5Wc/knt+ZxfZkDQHCNR4Q8MXUvgXSt0AT9NOnkvEZWTUK/mq
         lpAZP6l+xwnJhbrRP/CbdYAGN7Vc1YyggyEo2K/6WvXB0MMMtAkS+BEMRkDCNHdgQ5u+
         riuxQ52qnAJeYNIF5FDtoip6OnSmC1/MabmA0tICFrUp3+hwb/wUz1jO6jXvbjQwNI/i
         r65SjPwnKUrQvTZScCCzpm1ZYuYieg0dEYp4+nBKL+D9MBatWWFnAO9EWPZ3JPGx0ddh
         DUoQ==
X-Received: by 10.66.217.138 with SMTP id oy10mr40765195pac.149.1444065727092;
        Mon, 05 Oct 2015 10:22:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id gw3sm28722638pbc.46.2015.10.05.10.22.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 10:22:06 -0700 (PDT)
In-Reply-To: <5611E7B1.3090001@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 05 Oct 2015 05:00:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279061>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For this particular application, where we only have 19 strings to store,
> I suppose we could tolerate the use of approximately 64k of RAM to store
> 174 characters worth of strings *if* it would bring us big time savings.
> But I think we need some evidence of the time savings.
>
> If this lookup is really a bottleneck, I bet there are other
> alternatives that are just as fast as this trie and use less code,
> especially given that there are only 19 strings that need checking.

Very good point.  I agree that we need to know that the dumb linear
scan in the original is on the bottleneck and that any replacement
is an improvement.
