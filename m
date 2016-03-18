From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Fri, 18 Mar 2016 07:15:48 +0700
Message-ID: <CACsJy8Dm3_w6TT6FP-my9fsRJ8F+StK8dBPid9zxQv4OzoZfcw@mail.gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
 <1458219254-16343-1-git-send-email-pclouds@gmail.com> <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Durham Goode <durham@fb.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 01:16:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agi5Y-0004E1-F5
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 01:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967344AbcCRAQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 20:16:21 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34586 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbcCRAQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 20:16:19 -0400
Received: by mail-lb0-f178.google.com with SMTP id k12so78483817lbb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B1YRMYv5kYW3W75AIuPy34K/eJTiNvFFQeE/oLeZF4A=;
        b=LO7HmQG3QKhigz6hIS9VgMd8bhac/sflHVjBA2L444VD5WCb7B44biFDaoDSrTDU+x
         RJZsrEELKLG3XsAJx0mewoyyBiPK/xYqQPP7ChzxKZKtmgixJThV1qeNfzeFvLeUJrD7
         t7qFSVDw3p5VgOee+gWu2M0DuIwWnjI8R7pq35CsfCGG15DTnldWRJsCHYMPqCy8Cq42
         PiwJp8acG/kMoAOsIdKLD3xhGIFr6Dj9kjEEJ7JNr3U6ytW19XxbFYybq1JIcJQdCBNB
         VPdUfV90T7vCQYj6LZKRdHnZdUA1Qd7wKIk5EG3LZDOlOjocba8FU8A3FOIgsXGZ/UIj
         OUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B1YRMYv5kYW3W75AIuPy34K/eJTiNvFFQeE/oLeZF4A=;
        b=dJtuh9C4tjG1eNGhqOcBxbL5rD/ZUhDt6PDlDsyALH1IGG90VGmPT1cEf6+6TlTPP5
         UqoESXySSobLHTTCA0GzSdlKdn4kbefysBNgtH4NyHToEgAq7TdB0F76WBMmdF29nRal
         0+vsFqAY8ylp7DZLC/KrQWkfmbVYbctqHYRiin11osr3eP+tFyOi6IuWPY7ZTaOFlIN2
         OwDKb1z3HVcZvhxUJnnFGcaHYuSpPapUVnUFJD+3z64/a3QzUOiID6DqYYy1/DlqObDB
         YpvU9EqWHxSHp/qHc5IHOazoU4FrUAvWaIRloqWmNtOduvOSjnyEtcLznvarqIN+uosb
         rkmA==
X-Gm-Message-State: AD7BkJLfsIshU8oCXUqMPwlJ5tx5MblDHMzAXU4jVp4qiyad35GgXCWmw6Xew/AFp+pDK4Kpvu9sltHZ8zlkJA==
X-Received: by 10.112.140.129 with SMTP id rg1mr4962282lbb.80.1458260178244;
 Thu, 17 Mar 2016 17:16:18 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 17:15:48 -0700 (PDT)
In-Reply-To: <xmqqfuvoy89q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289174>

On Fri, Mar 18, 2016 at 6:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks for these 5 patches, two of which need to be discarded ;-).
> I think you can pick either one of 1/2, pick the one that says
> "non-NULL" (as opposed to "something") in the log message for 2/2.

Sorry, I did "git send-email ... 00*" and it picked up *.patch~ as
well. non-NULL is the non-backup version.

> Durham, does it fix your issues if you apply the 1/2 and 2/2 (but
> not 3/2) on top of 2.8-rc?
>
> Duy, how comfortable are you with the idea of including this two in
> 2.8 final?  We have long passed the final -rc, and while it is
> probably OK to prolong the cycle and do another -rc, we cannot keep
> going like "oops, there is another thing discovered by somebody new"
> forever.

The fix is well understood. I did feel unsure about that "continue;"
when I first wrote it and should have given it more thought. No other
"unsure" feelings, so we're probably good from now on.
-- 
Duy
