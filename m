From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 8/8] t5520: check reflog action in fast-forward merge
Date: Thu, 21 May 2015 10:29:13 -0700
Message-ID: <xmqqk2w1kffa.fsf@gitster.dls.corp.google.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
	<1431955978-17890-9-git-send-email-pyokagan@gmail.com>
	<8e51ff8168d050cb2f8fedd4464b2f7b@www.dscho.org>
	<CACRoPnRHAA7w8iJ-GQGPt11Hnm29o6wgP5bEG_q531XmcK-P1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUHY-0001ph-PB
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbbEUR3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:29:16 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35365 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbEUR3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:29:16 -0400
Received: by iesa3 with SMTP id a3so13576131ies.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3F1bqYUjH1GAOceSRwF3ZUUnTlKnVXLHzPiOeFv1EoY=;
        b=UiwA+9V/qULQ+gvFSCI3DR2BnNcA5RqaMkODvr8eoEukgxDUtuFzwCBENINebxWZuj
         BF6T682rXdKemX70KgA14L7hoUs1Vr7bC/YS5KD8zNhVCl0YxdZcnl0MKgOjxAQtEubH
         CH/bkVvmgAnCJua49+2PL+KzuHecoL3nxcLzC+95YP+0IjPway9jLDXdHU7E1eUKHK7y
         eK+L4QQmTigHwG614wb5gfKGARPSQRoC1J5893j95gNrTf8YLEEfEYToBv7BV12GGnK+
         3mYQfnGO8k0uuifGTKUzaEed2bwBq2GCtHOOXbjDkTvplggt+bIaQGCtYRHFqJ1KsHk0
         saGA==
X-Received: by 10.43.76.195 with SMTP id zf3mr4499932icb.62.1432229355561;
        Thu, 21 May 2015 10:29:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id h128sm15327420ioh.38.2015.05.21.10.29.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 10:29:14 -0700 (PDT)
In-Reply-To: <CACRoPnRHAA7w8iJ-GQGPt11Hnm29o6wgP5bEG_q531XmcK-P1Q@mail.gmail.com>
	(Paul Tan's message of "Thu, 21 May 2015 16:07:05 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269619>

Paul Tan <pyokagan@gmail.com> writes:

> On Mon, May 18, 2015 at 11:20 PM, Johannes Schindelin
> ...
>>> +     sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
>>
>> Actually, let's use "s/^[0-9a-f]*/OBJID/" instead: you only want to
>> replace the first few characters.
>
> Did you mean "s/^$_x05[0-9a-f]*/OBJID/"? (with "$_x05" expanding to
> '[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' from test-lib.sh). If not,
> then it would match even if there was no SHA1 hash.
>
> But yes, without the "^" there will very likely be false positives.
> Thanks for catching.

I think the suggestion was more about "do we guarantee that there
would always be at least five?"  It might happen to be the case with
our current default, but these tests do not fundamentally rely on
that default staying the same.  s/^[0-9a-f][0-9a-f]*/OBJECTNAME/g is
probably the right balance between cautiousness (you do not want to
match an empty string) and future-proofing (you do not want to rely
on us having at least five).

Thanks.
