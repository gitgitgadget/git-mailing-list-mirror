From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 23:37:50 -0800
Message-ID: <CAPc5daWnJCGPTMA0Hyg8QEAmsnF17ZQ9njGq8xVaUAfuwCRQDA@mail.gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
 <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
 <xmqqioi5ycme.fsf@gitster.dls.corp.google.com> <87sih9en65.fsf@gmail.com>
 <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com> <87mw7haxdp.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsoE1-0001B9-86
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 08:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbaKXHiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 02:38:12 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35010 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbaKXHiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 02:38:11 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so1226648pdi.3
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 23:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AwA0PjqQ8Ie6CAvlPkfetv26CAZ7uLuMU9oIMXlwBD8=;
        b=uT+CytDj/3vbDAZiKLKNfimmY2KHemIp/4cbuOYKZ3Cg7rsYmQSLMXbTkd4jQlxOSR
         b0pQEwrbv9kNz7Hr8D2xDG1sE/7QNL8whGNxm67boxcs7Gr6v3P5GGuLSH3lcEOLzDYr
         2DnPEuwdFgOoAvGGbZrQbDg1p0OUjetw5/ILZzCDinLXXvuFEp0nyhAG91G24tM+u4YW
         MIlN6CROAtBBoZOEOufIXrb3A80SPfzH6fCr9z0XNUDxUMNIQRlMAfRa0ORYMXRTVm69
         Lcx6zcbqc+4rU2fNkELt6yjxhyXGP18F/+6dPoyH0bsB/ZPOa9aiT0nlUtEHm7+27z8b
         rjJg==
X-Received: by 10.70.128.132 with SMTP id no4mr30345852pdb.125.1416814690611;
 Sun, 23 Nov 2014 23:38:10 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Sun, 23 Nov 2014 23:37:50 -0800 (PST)
In-Reply-To: <87mw7haxdp.fsf@gmail.com>
X-Google-Sender-Auth: hMueU3WhbXZIp4yN4TmD4OrHz4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260116>

[jc: added those who were mentioned but were missing back to Cc]

On Sun, Nov 23, 2014 at 11:02 PM, Alex Kuleshov <kuleshovmail@gmail.com> wrote:
>
> Junio C Hamano:
>
>>Fixing these callers are done as separate patches, that can be
>>applied either before or after this patch.
>
> How to do it better? Update this patch, fix all callers which broken and
> concat this patches to one or make separate patches?

As I said, I do not think the approach your v2 takes is better than the original
approach to pass the ownership of the returned value to the caller. I'd say that
a cleaned up v1 that makes sure it adds a necessary strdup() in the codepath
where it returns an absolute pathname given as-is, with necessary changes to
callers that do not currently free the received result to free it when they are
done, and to callers that currently do strdup() of the received result not to do
strdup(), in a single patch, would be the right thing to do.

I think I already wrote the bulk of proposed commit message for you for such
a change earlier ;-) The one that talks about changing the contract between the
system_path() and its callers.

Thanks.
