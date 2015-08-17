From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Mon, 17 Aug 2015 09:53:21 -0700
Message-ID: <xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Doug Kelly <dougk.ff7@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRNf6-0007NE-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 18:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbbHQQxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 12:53:24 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36438 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbbHQQxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 12:53:23 -0400
Received: by pawq9 with SMTP id q9so14516909paw.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yYgD4WObEkVaI86GQRKiPAdWLoafIZrMtgIUrRtQyuE=;
        b=V7yGXXxebOOhaHmUkkwQVAT0QUJlUsqgM8X3ZoPQ7cJGi5prtBtPJwj2TeD5fuh4Le
         QH8edq170xhuAXv5vMF+IRJT2ehzykW2xpAJt3t07ZAKPzAsSeWOXoxjSVTLMnIEaD+i
         QWUTGS7EwwTLSaUU+T3q8OEYQgorUp8C/Dr51mHebupvIDca9mumUpGeyn/wHORwrn+3
         7VF9iBPDvj1HgYwZqnw5n4cOhCGiHyffm2DEnN9h0LkwG5GKttldhtY5IPj72Nf8mIxv
         yXaLU1mek7PSq9H/03v6CKeFs22WmmUKsv6kNZyvrC9GYgZGFmY6XjWPt2wfcLAy9beZ
         lIYw==
X-Received: by 10.66.102.41 with SMTP id fl9mr4307950pab.93.1439830403214;
        Mon, 17 Aug 2015 09:53:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id pg5sm14573517pdb.81.2015.08.17.09.53.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 09:53:22 -0700 (PDT)
In-Reply-To: <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 13 Aug 2015 14:46:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276058>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -static void real_report_garbage(const char *desc, const char *path)
>> +const char *bits_to_msg(unsigned seen_bits)
>
> If you don't expect other callers outside this file, then this should
> be declared 'static'. If you do expect future external callers, then
> this should be declared in a public header file (but renamed to be
> more meaningful).

I think this can be private to this file.  The sole point of moving
this logic to this file is to make it private, after all ;-)  Thanks
for sharp eyes.

Together with the need for a description on "why", this probably
deserves a test or two, probably at the end of t5304.

Thanks.
