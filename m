From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Thu, 3 Apr 2014 19:40:24 +0700
Message-ID: <CACsJy8DBixHTeqitcAcQRAqY3b4prkwQGgJGuw7hbT7BQAZt9w@mail.gmail.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
 <1396012689-22480-1-git-send-email-pclouds@gmail.com> <xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVgx2-0004Eb-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 14:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbaDCMkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 08:40:55 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:43163 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaDCMky (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 08:40:54 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so1736778qcx.21
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P2nrlXSeuK1q8uYzANNIodrFYkeWmD/BLiozCPuCerQ=;
        b=gg8P01S06wfwjlwfkjlXXsmmkZ2EDkBrimYCFaAoorL15ckq3FiwVGWi126WZJlu+y
         GQY3XA3xIAvPJSGFWOrrkBSivts6JdBs0L5lD+c0LWZA5ijj5t3hfC302oTg9Y8C4Z4s
         XRJSdeyJtGurMiPcHqFeqXE0iONSCXJmie1Lx69DoQAmB38a5hfcPg6oMO6GQOg/A+Ci
         L8vUOkR6dnaxX8qExrc0ajpRF0yM6M11TgNmdluqOzO+QEyaJ4dfGxMfT/jr43pjNFuv
         DU6AGQ+GfZnXh7KHasu06FZAxXVMZIDZBUCsMYNyge1bpO3hVOTDzIdpAPr00rV9Nnq5
         eO1Q==
X-Received: by 10.140.92.131 with SMTP id b3mr6650486qge.41.1396528854235;
 Thu, 03 Apr 2014 05:40:54 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Thu, 3 Apr 2014 05:40:24 -0700 (PDT)
In-Reply-To: <xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245733>

On Thu, Apr 3, 2014 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am guessing that, even though this was discovered during the
> development of list-files, is a fix applicable outside the context
> of that series.
>
> I do think the patched result is an improvement than the status quo,
> but at the same time, I find it insufficient in the context of the
> whole codepath.  What if errno were other than ENOENT and we were
> told to show_deleted (with or without show_modified)?  We would end
> up saying the path was deleted and modified at the same time, when
> we do not know either is or is not true at all, because of the
> failure to lstat() the path.
>
> Wouldn't it be saner to add tag_unknown and do something like this
> instead, I wonder?

Or even better to show an error message when the error code is
unexpected? The unkown tag '!' says "there are problems" but if it
shows up sort of permanently, '!' won't help much, I think.
-- 
Duy
