From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: document behavior of --ref and --notes DWIMery
Date: Tue, 22 Sep 2015 13:40:25 -0700
Message-ID: <xmqq8u7y2nnq.fsf@gitster.mtv.corp.google.com>
References: <1442953476-24537-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:40:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUMc-0007HI-CI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934644AbbIVUk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:40:29 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35890 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934247AbbIVUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:40:27 -0400
Received: by pacbt3 with SMTP id bt3so653534pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Zz1ulXmw7tPd1zuAFfgnC5DxhjpVcwuiTIOI9fKKerU=;
        b=EoL8BDwl6L34hr5jD8c6T7RaN+F1jMnt68Ns7UyeeMgswYP3U4S83WQN7bUqAhhc+A
         7fHRhGTuKNp2qaaMqcW8x8/jTlr7d21ENk0p0a2FaqKnjCQ4yTtc2RrtvkFhE2K+9nrX
         i/hbwEHn5nWYsgwnaOp7aTKeBSrqWhRH58mr2pZWvxyVZZDl1/WdcV+2yRxG52gNBkmf
         IIjWKDYQ7nBKZJTBQJ4YhHBQhagmaM5CNroXuWohN+kxoelVnSrXq5QJMxGxKhAn1Cpy
         uWIRPQeMCV6jkxOlOrQkNoYVQLMrReUIX4Yu3xscZ6kMZXJSvS6ZrVBFjyUzAHfGZmPs
         +5kg==
X-Received: by 10.68.166.196 with SMTP id zi4mr33058986pbb.83.1442954427245;
        Tue, 22 Sep 2015 13:40:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id zf5sm3930820pbc.36.2015.09.22.13.40.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 13:40:26 -0700 (PDT)
In-Reply-To: <1442953476-24537-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Tue, 22 Sep 2015 13:24:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278432>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The --notes and --ref parameter for selecting which notes ref to operate
> on are based off of expand_notes_ref functionality. The documentation
> mentioned that an unqualified ref argument would be taken as under
> `refs/notes/`. However, this does not clearly indicate that
> `refs/heads/master` will expand to `refs/notes/refs/heads/master`, so
> document this behavior.
>
> Add a further test for the expected behavior of git notes --ref
> refs/heads/master get-ref as well, to ensure future patches do not break
> this assumption.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Looks OK to a cursory read, but I find "even if it is qualified
under some other location" a bit tiring to read without adding much
value.  To readers who consider "other" in that phrase to be clear
enough (i.e. "location other than refs/notes"), it is totally
redundant.  To other readers who feel "other" in that phrase to be
under qualified (i.e. "location other than what???"), it is not
informative enough.  Middle-ground readers who would not know if
"refs/a" is inside or outside some "other" location, it is confusing.

After all, "a/b" is qualified under some location (i.e. a/) other
than "refs/notes/", and it does mean "refs/notes/a/b".

How about phrasing it totally differently?

	The ref specifies the full refname when it begins with
	`refs/notes/`; otherwise `ref/notes/` is prefixed to form a
	full name of the ref.

I think that would remove the need to illustrate with concrete
examples like refs/heads/blah.
