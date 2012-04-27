From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ref-format checking regression
Date: Fri, 27 Apr 2012 08:25:04 -0700
Message-ID: <xmqqipgl9oz3.fsf@junio.mtv.corp.google.com>
References: <20120427115000.GA8126@sigill.intra.peff.net>
	<xmqqr4v99pu5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 17:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNn2r-0004P8-4p
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 17:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760588Ab2D0PZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 11:25:09 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:59033 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760556Ab2D0PZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 11:25:05 -0400
Received: by ghbz15 with SMTP id z15so89757ghb.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=EFzx+PVoK7FiAM9S9k8o1w9Ze+aSVuRnxN4IdsC8ldo=;
        b=SbHgnwEsCecG6p2fPRpNJCjTK+wVasLJ70ABU3w+addtgY7Pbhn/DjBRX+BJHSzoZ3
         2zo+k1uXvvkc9GYoDZN/ikZ1JgqcQ9XtDe9KAClPjMhz3mi5aYtzJHiL/1XpqfM6lFFe
         n7kuUCRU/tmjMUozu4GVUYBfiO4qYIoBlh46RCa77+B4a/wyeNRYYQlpc0xQUrK+8q/+
         cV0+4kG0M0n9hi3vh2dJxh2zRMEE/ilsijLkezwvZiTPey5/sFjGvVC1MKr8mTQWTYKt
         tzxfSJYySrDD7MWK0ub/G3RL8/k4Vuzih7aLf6k+Pb2uqjHl33N+YIUVaVrg15FakeHi
         Dbvg==
Received: by 10.236.153.5 with SMTP id e5mr14517163yhk.5.1335540305224;
        Fri, 27 Apr 2012 08:25:05 -0700 (PDT)
Received: by 10.236.153.5 with SMTP id e5mr14517140yhk.5.1335540305158;
        Fri, 27 Apr 2012 08:25:05 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r32si1114611ano.1.2012.04.27.08.25.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 08:25:05 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 0FBA510118F;
	Fri, 27 Apr 2012 08:25:05 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id AE7A0E125C; Fri, 27 Apr 2012 08:25:04 -0700 (PDT)
In-Reply-To: <xmqqr4v99pu5.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 27 Apr 2012 08:06:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkcEBQM/CX8XhlMpSZ1+xe/ZNOzHBxAbJ6TolJFvbG92LjQK5I8cycL9RI4YdKZxFBlkIWEvczez3Em1p+bK7svltKeHZpaNzq98fDVDVQ2g7amM4/Znzly7y0t3DRjXdDsVhD1VNtoDxbZLsstDaI9H4XR7UMU8O/Y8/Sxfjy2y4SPmqk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196477>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I upgraded git on a machine recently, and it created problems for a repo
>> with a bogus character in a ref name.  Older versions of git never
>> complained about it. Newer ones, containing your dce4bab ("add_ref():
>> verify that the refname is formatted correctly") do. That's fine; it's
>> bogus and git _should_ complain about it.
>> 
>> However, recovering from the situation is unnecessarily hard, ...
>> ...
>> I seem to recall discussing this format-tightening and trying to be sure
>> that users were left with a way forward for fixing their repos. But I
>> can't find the discussion, and I don't recall any conclusion we came to.
>
> I haven't dug the archive but I do recall ...

A few...

  http://thread.gmane.org/gmane.comp.version-control.git/185564
  http://thread.gmane.org/gmane.comp.version-control.git/184382/focus=185483
