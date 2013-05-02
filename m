From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/9] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 21:13:49 +0530
Message-ID: <CALkWK0=eC2M6b5Dh9kR8TZEXRGYnYQtrpb5PUed4nDSStOCTpw@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
 <1367501974-6879-8-git-send-email-artagnon@gmail.com> <CALkWK0=FbbCferG+q4qymvsm-t_rfSBRZfp7t3kO=z-EF5QYuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 17:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXvgQ-0000Ci-05
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab3EBPoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:44:30 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44587 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab3EBPo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:44:29 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so821060iea.18
        for <git@vger.kernel.org>; Thu, 02 May 2013 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bPfFBANtmVn6OmMmwa3Ov6PCIYTUTWGViTxdRxXyups=;
        b=VJl8yHrQP2JwSixQKGfXHpnaGi+HlU0op0a4Bs7ZnQLRwKjuyPUDhiZpPZnsgeipMU
         8bFrKJh34hoaIZ39lz5FJqHotBEy0CtNdNoI6GsVDRrfjiiO8GKInC2bbTJwFbLNAA9j
         +fgGdcYIHwcT2yH96b0d/X887N9AdkdF1LN1uq5UeN7UlrkyShFfibiocWTeX3A2fbXt
         P1V+quDSP/n8teLvo4l3q5mVeDjm7rMVXJb15brsSrq/A7yyAIgkbQtN8e4EyL6UBsmH
         G4tMjxrqs5lwaYUJ2potBbpxWG4Yp2KZKtcabe4U/8xBMjMIHW8u8k2pxsJSM2xnJoC+
         UYag==
X-Received: by 10.50.57.116 with SMTP id h20mr8944663igq.49.1367509469228;
 Thu, 02 May 2013 08:44:29 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 08:43:49 -0700 (PDT)
In-Reply-To: <CALkWK0=FbbCferG+q4qymvsm-t_rfSBRZfp7t3kO=z-EF5QYuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223214>

Ramkumar Ramachandra wrote:
> So sorry about this, but this breaks some tests in t1507
> (rev-parse-upstream).  I'm looking into this now.
>
> In the meantime, reviewers can focus on the commit message.

So, it turns out that some callers expect it to read_config().

If we're still adamant about not touching branch_get(), the
alternative is to call resolve_ref_unsafe() before the branch_get()
call in interpret_branch_name().  We'll still retain the H@{u}, but
we'll lose the 'git branch -u ram/master M'.
