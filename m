From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 14:19:46 -0700
Message-ID: <xmqq617liq6l.fsf@gitster.dls.corp.google.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
	<CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:19:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXsg-0000Ji-4N
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564AbbEUVTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:19:50 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36436 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbbEUVTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:19:49 -0400
Received: by iepj10 with SMTP id j10so18032886iep.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Htp0t42fK0HXa3i4HyOcuU7td2TMHcuR53iCrZw1CNE=;
        b=0Lg0xTDFkWAmkASeuP20dti43RjaGrlC/6C1G+yREpMrNtFHiUJLa4LDqxR6qfpqeA
         pCZOTWLfY532BcdUhORIQR99qc82ObGr5vvXYegxd5ThK4IEqBCoRnFx3IdxvyxQiORO
         YN70hf4OmzGAGmAm9cjmb87SCXdQX82selor3IbpCW+Z7UcOZK7f+3jAtx60mXmvdj3J
         22PJWYpbKXTrlZlEwzsUu0D0AcM3/cS2Fh6/ntwqFIqr4N6GoJkSlJobzQLLWLQt9iun
         ifPgYyt2cXS5vMGcl8WXUW1jnjyIX8s5La5vg+wef++qcF8nquzzEwuMKKjQjJSSDMBX
         cl/A==
X-Received: by 10.42.132.6 with SMTP id b6mr877828ict.8.1432243188397;
        Thu, 21 May 2015 14:19:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id cy11sm2230383igc.14.2015.05.21.14.19.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 14:19:47 -0700 (PDT)
In-Reply-To: <CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
	(Allen Hubbe's message of "Thu, 21 May 2015 16:48:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269663>

Allen Hubbe <allenbh@gmail.com> writes:

> The diff doesn't show enough context to include this comment:
>
> my %parse_alias = (
>         # multiline formats can be supported in the future
> ...
>
> I can't be sure the author's intent, but my interpretation is such.
> The parsers do not support multiline, even though the format might
> allow it by definition.  Another interpretation could be, no multiline
> formats allowed, or, the first person to add a multiline format should
> remove this comment.

I think that comment were only meant to apply to the first one, mutt.

In any case, you should read it this way:

    Some formats may support multi-line; this parser back when the
    comment was written did not support an alias file that uses such
    a feature, but it is OK to make it support them in the future. 

After all, these subs are slurping from $fh and doing the parsing
themselves, so they are free to do multi-line if they wanted to.
It's not like there is a calling function that feeds input line by
line after splitting a logically continued line into two (and if
that were the case, supporting multi-line format may become harder
or even impossible).

And as I said, it is OK not to support ones that have folded lines.

All I was saying was that we should not SILENTLY fail or do a wrong
thing when we find something we do not support.
