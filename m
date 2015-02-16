From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] push: allow --follow-tags to be set by config push.followTags
Date: Sun, 15 Feb 2015 22:11:21 -0800
Message-ID: <CAPc5daUX4Jb6xdmv1jLUM28KJCfYAdTCUiqqrk04pTw=89O9YQ@mail.gmail.com>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
 <20150216052049.GA5031@peff.net> <20150216054550.GA24611@peff.net>
 <20150216055422.GB24611@peff.net> <CAPc5daU6VOmuNp3VbYgoFDXJshkC2AnRsZQQdoRMArYpezZr=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEuI-0007aX-8r
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbbBPGLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:11:42 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50933 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbBPGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:11:41 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so39011792obc.0
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 22:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WvjA4AsdMSIT/jIhuLftjdwZF4Zf8ept79fyOLJ82CA=;
        b=vV/FhTtipOQ2LiIxOKoYHQPqSkiAo5xdl7CsiniZ3OEpwE223NMVw2QS3wR757MRjK
         OYOcXT/BoaiQjY7WaJBvwUV+2qFxHr56+Gtag9USe98zFce15ARACDEIGD7lkK2i6X8v
         +VMKrZM0dTPAcVrF4q5mVz39UiUNTAuJQD+my9t/n550bW+7mxSpvHtXDmDXs6jTNCzn
         hLXcuOEKr8CtxntPnecFK3S6++URwJVP6A8UvFg1ijPKU2EDQ1gxvBvyDrlpjkkVC8rn
         mpuY90GFaMoM9YhhBAXzT1U48tECmOBo4mPGc/iQ+YdHFY/NUtr4KzV6MShHSf5Vk1LM
         1/iA==
X-Received: by 10.60.84.163 with SMTP id a3mr2102335oez.55.1424067101191; Sun,
 15 Feb 2015 22:11:41 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 15 Feb 2015 22:11:21 -0800 (PST)
In-Reply-To: <CAPc5daU6VOmuNp3VbYgoFDXJshkC2AnRsZQQdoRMArYpezZr=A@mail.gmail.com>
X-Google-Sender-Auth: IaZs0DVFDbD5IFF2QHQaLiZ5DlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263877>

On Sun, Feb 15, 2015 at 10:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Sun, Feb 15, 2015 at 9:54 PM, Jeff King <peff@peff.net> wrote:
>>
>> Or alternatively, we could pull the "flags" field from cmd_push out into
>> a static global "transport_flags", and manipulate it directly from the
>> config (or if we don't like a global, pass it via the config-callback
>> void pointer; but certainly a global is more common in git for code like
>> this). Then we do not have to worry about propagating values from
>> integers into flag bits at all.
>
> Yup, that would be my preference. The largest problem I had with the
> original change was how to ensure that future new code would not
> mistakenly set the global follow_tags _without_ letting the command
> line option parser to override it. If the config parser flips the bit in the
> same flags, it would become much less likely for future code to make
> such a mistake.

Having said that, I think this version is good enough.

Unlike a global in environment.c (that is named not-so-specifically that
anybody can set by reading the configuration file) that can be overriden
only by command line parser used only for "git push", the global int and
the flags are both localized to "git push" in this version, and there is
much less chance to introduce new buggy code that forgets the command
line override.

Thanks, again.
