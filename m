From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Fri, 29 May 2015 13:17:40 -0700
Message-ID: <xmqqwpzrb0kb.fsf@gitster.dls.corp.google.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	<xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
	<CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQiy-0001BB-10
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833AbbE2URo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 16:17:44 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35727 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbE2URm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 16:17:42 -0400
Received: by igbyr2 with SMTP id yr2so23047976igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dPaM0GgXqikO43HquSRaZ04US3KPePCdFajiZGhdQjo=;
        b=Pkc2y7Fr0jHZHQqYpnFeqcxZDXomC1DxBsXOSu17Lijz50Jemj1/XBLpl3kIPZGH8g
         OeZcuRentZ0xC0YzVCC6kj47A3XRTM9b4mK3bTEUBTORR0L72RUq1nsEMcw33cR5H65O
         BG52iS4RZzR4JiVtvMxPNTrAJ+KWPgyzbuQCi7dPCxvWhg+wi0Pi3bd9hw+2YRN3ZINJ
         kzuZyW06n4+7zHSDE6RljmLqTLRJVUoFd/aYLED4AT7M4mFABFgYllvrRZSEp+haaPjD
         qUhDZb2y8YYBuu58gfpQlwS8tB9wW0ohhy/5FX/mbAy426L6xcrZcLgrRkemUamSuw6Q
         fVkA==
X-Received: by 10.43.60.14 with SMTP id wq14mr65958icb.60.1432930662387;
        Fri, 29 May 2015 13:17:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id u35sm4922550iou.7.2015.05.29.13.17.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 13:17:41 -0700 (PDT)
In-Reply-To: <CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 May 2015 14:35:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270270>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, May 28, 2015 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Moreover, it lacks justification and explanation of why you consider
>>> the cleanup unnecessary. History [1] indicates that its application to
>>> -F but not -t was intentional.
>>>
>>> [1]: bc92377 (commit: fix ending newline for template files, 2015-05-26)
>>
>> Sorry, but the date of that commit seems to be too new to be
>> considered "history"; I do not seem to have it, either.
>
> Indeed, I somehow botched that. I meant: 8b1ae67 (Do not strip empty
> lines / trailing spaces from a commit message template, 2011-05-08)

Yeah, that was what I had in mind when I read your response.  And
that one is pretty strong in its own opinion on the "issue" that was
brought up by [PATCH 1/2] being discussed, which was:

    git-commit with -t or -F -e uses content of user-supplied file as
    initial value for commit msg in editor. There is no guarantee, that this
    file ends with newline ...

The log message of 8b1ae67 argues:

    Templates should be just that: A form that the user fills out, and forms
    have blanks. If people are attached to not having extra whitespace in the
    editor, they can simply clean up their templates.

in other words, "if your template ends with an incomplete line and
it causes you trouble, then do not do that!".

As a general principle I am OK with that.

By default, we should run clean-up after the editor we spawned gives
us the edited result.  Not adding one more LF after the template
when it already ends with LF would not hurt, but an extra blank
after the template material does not hurt, either, so I am honestly
indifferent.  If the user specified with the --cleanup option not to
clean-up the result coming back from the editor, then the commented
material needs to be removed in the editor by the user *anyway*, so
one more LF would not make that much of a difference in that case,
either.

So...
