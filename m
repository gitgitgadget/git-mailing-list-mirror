From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 13:14:03 -0400
Message-ID: <CAHcr6HYA=gpMTaJ5WOOmtEp+J4wBMz9D59fbByzsdBkPRf4CZQ@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212827.GC25757@peff.net>
	<CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
	<20150616171005.GB18667@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4uR8-000653-UY
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbbFPROH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:14:07 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38778 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbbFPROE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:14:04 -0400
Received: by wibdq8 with SMTP id dq8so26363283wib.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j9ahqSczx8ikyuhCy7gfoacPMAKwYlIKAr0701GFgfs=;
        b=PNMkz6ZRLaoJELkau6ltbkWrAys9AnGT9kDd2QjHvnzLhU6x7L6V8FTsFdk6rRXdV5
         aQXB3+zP5p3K2ueZ/L1TdQOtat2PePHGAFIR+Wzob7CCBnAWuwhcnfz7I/THaiGUqCCo
         0ghaOkE+1N4lavc4M15DgMM7uWgHJWc8xYg1dgJlG5vW75wUUpjzTHKn7E1+n56HldRd
         SgbrvAGh7sxz0yZA2t48luI+02A8W23VTwpuBvawXG0ZoC9143JZO7bViUCsuLVq1d9s
         oKikM2tXEm8ujbU4YvkqgiamXULUXuJlwnVSjgKuYTG+invaglg1GNHhoSMbNgTwIZfu
         nmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=j9ahqSczx8ikyuhCy7gfoacPMAKwYlIKAr0701GFgfs=;
        b=F28RFKKOB1uH9Z+je56GTywjiAqUJrNIUVMjBs628vMKFztgrEbOJVgI6ztcF94yF0
         SSUT1a8wT/OGs1WcXiuhEgS/fORH06q1jBWBFZxFSQzCmWUsogWnaRrPdiSBZFDhwuLi
         HC6/8ZCzSGu+SorHDDQJjO67FteDkLFz3Ehp33CGd/nDgc78ZxFQFiq9XvKqgENmJe5h
         uMiUop/ZcbAlh7v3WNIODHnWo1fYX5J7D3W53hJ5xFw/v4OKDiHZ3Ryqd1y99yyjDpXn
         bhQ0QH1v/CfC2x93lqn+cfw+hg1EfUSGFEkVCdrOqfat0hIFqphdZznzbLxpsL1FhaKO
         9nqg==
X-Gm-Message-State: ALoCoQn0g2jS6b9el/roYHIR6x+vUv9gbsJn/qJt1EZNt4I5QLHrAmTVGs+ATHVeW4ieZcF+jeCW
X-Received: by 10.180.89.231 with SMTP id br7mr45203115wib.60.1434474843853;
 Tue, 16 Jun 2015 10:14:03 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Tue, 16 Jun 2015 10:14:03 -0700 (PDT)
In-Reply-To: <20150616171005.GB18667@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271781>

On Tue, Jun 16, 2015 at 1:10 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 16, 2015 at 11:38:41AM -0400, Augie Fackler wrote:
>
>> > We already have a GIT_TRACE_PACKET mechanism for tracing
>> > packets. Let's extend it with GIT_TRACE_PACK to dump the
>> > verbatim packfile.
>>
>> FWIW, this also works for me - I have no preference between my patches
>> and Jeff's. I suspect yours are much better given that you have a clue
>> about git internals ;).
>
> I like mine better than yours, if only because it hooks into the
> existing tracing mechanism. But I am sad that neither of our proposals
> works for tracing pushed packs (something that is useful for the
> opposite situation: you have a sane git server, and some unknown
> misbehaving _client_ is sending you bogus packs).

Yeah, not having it for the push side is a slight bummer, but in
general I haven't had problems debugging git clients pushing bogus
data in the same way that I've had problems with weirdness in new
server features.

>
> Here's a rough cut at the "trace stdin" idea I mentioned earlier (which
> is essentially an internal "tee"). You can collect the incoming pack
> like:

Neat, but not sure I like the extra overhead of having to grab the
full trace and then reconstruct some arguments to be able to diagnose
the pack. Having the verbatim pack just land on disk is really handy,
because then any existing tools one has cooked up (my team has a few
weird one-off ones by now) just work without extra fussing or looking
up steps to reconstruct the whole file.
