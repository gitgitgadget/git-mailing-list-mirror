From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 15:40:38 -0400
Message-ID: <CAPig+cQUJPWiz7OzQTwaDp3aeq5Gu6rWezYNfq8nuK_h+n48DA@mail.gmail.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jim Hill <gjthill@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 21:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunNe-0000DC-5l
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbbESTkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:40:39 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32970 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbESTkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:40:39 -0400
Received: by igbpi8 with SMTP id pi8so115652424igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+vHSD3XSrt8/n0f0+i6piF3a4ZFZ069MuRUPWD5pUAk=;
        b=hQ7+IIXwr8L1BbCx0a+PCEJuSqSRnSVJQIcaCgVH5N4ZabVUgDSE2ry9KXSy1hQzbX
         sK848n9h1R7RnnE2QuMkf4fEGGVqMaGGcoPRjyElSETykrWrqePhfNZqlTSu9XmLBQrK
         fiH9kYPHSxtmo6CC+5WjVoP4Xux47ChGh1JmEgUrwqxhQukxMW/xxk8MgrXdGWWn5hRw
         E2jXEE8tgFK9B+/wIw2+6X0vCGwBRNW/39Qpwhm/ek8H5HF1emrZWHpfCcF94SOMCAa7
         D35SKT7OqeSczKIeJ+fLsOkEU5uRuRqUBPpnTNy6XwNh5whp8MuMqUnmzRYnSkIN2WKA
         JxZA==
X-Received: by 10.42.146.202 with SMTP id k10mr42836070icv.34.1432064438437;
 Tue, 19 May 2015 12:40:38 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 19 May 2015 12:40:38 -0700 (PDT)
In-Reply-To: <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: _XfZtM4kOyU1NQw2TPSz5JB1aPo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269393>

On Tue, May 19, 2015 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] copy.c: make copy_fd() report its status silently
>
> When copy_fd() function encounters errors, it emits error messages
> itself, which makes it impossible for callers to take responsibility
> for reporting errors, especially when they want to ignore certaion

s/certaion/certain/

> errors.
>
> Move the error reporting to its callers in preparation.
>
>  - copy_file() and copy_file_with_time() by indirection get their
>    own calls to error().
>
>  - hold_lock_file_for_append(), when told to die on error, used to
>    exit(128) relying on the error message from copy_fd(), but now it
>    does its own die() instead.  Note that the callers that do not
>    pass LOCK_DIE_ON_ERROR need to be adjusted for this change, but
>    fortunately there is none ;-)
>
>  - filter_buffer_or_fd() has its own error() already, in addition to
>    the message from copy_fd(), so this will change the output but
>    arguably in a better way.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
