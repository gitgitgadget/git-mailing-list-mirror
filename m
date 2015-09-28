From: Junio C Hamano <gitster@pobox.com>
Subject: Re: broken racy detection and performance issues with nanosecond file times
Date: Mon, 28 Sep 2015 10:38:57 -0700
Message-ID: <xmqqbncme95a.fsf@gitster.mtv.corp.google.com>
References: <5605D88A.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:39:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgcOH-0004RJ-9B
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934454AbbI1RjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:39:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35979 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540AbbI1Ri7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:38:59 -0400
Received: by pablk4 with SMTP id lk4so83234278pab.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IZNYgE9YeSqz44gbuoCQux48p98lpPf66FDGFjbnBwk=;
        b=x5mga1AQjG0TkfAORvRaMdnZON+m389fz69R8O7DplT6jXbnp/5OlYJNZole1qia46
         iu7rtgsPc7EBv2WLhGo5weyWNVPBjm2G36+vTbg9T4trzj2edyTf6pdugzr8zH+527dD
         q99PFfsbooHkSGh1nI2N90GKXGDs7bp5BVa8veJJEz1oQl+gRoSDr42HeeHE7YmYMOZM
         2OPnAq4CxbDnPOUEalpO48s+OnLodAna035AIflBmP9ZUPeyFq6IA7i0y4dtLhTpAXdW
         WeYPJFHLvF/kL6A8+cOtv4LzUF9+c334sGSn6ONjgYC91ouMqQQvQfLFUbK5giq1rs/G
         YMfw==
X-Received: by 10.66.155.9 with SMTP id vs9mr27459465pab.63.1443461939172;
        Mon, 28 Sep 2015 10:38:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id o3sm20711574pap.37.2015.09.28.10.38.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 10:38:58 -0700 (PDT)
In-Reply-To: <5605D88A.20104@gmail.com> (Karsten Blees's message of "Sat, 26
	Sep 2015 01:28:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278733>

Karsten Blees <karsten.blees@gmail.com> writes:

> Problem 1: Failure to detect racy files (without USE_NSEC)
> ==========================================================
>
> Git may not detect racy changes when 'update-index' runs in parallel
> to work tree updates.
>
> Consider this (where timestamps are t<seconds>.<nanoseconds>):
>
>  t0.0$ echo "foo" > file1
>  t0.1$ git update-index file1 &  # runs in background

I just wonder after looking at the ampersand here ...

> Please let me know what you think of this...maybe I've completely
> screwed up and can no longer see the forest for all the trees.

... if your task would become much simpler if you declare "once you
give Git the control, do not muck with the repository until you get
the control back".
