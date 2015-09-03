From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 03 Sep 2015 09:27:54 -0700
Message-ID: <xmqqpp1zlb79.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
	<CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:28:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXMm-000215-HE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbbICQ15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:27:57 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34211 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbICQ14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:27:56 -0400
Received: by padfa1 with SMTP id fa1so8926163pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OJPhVSM1V1XXNeEUxPypUcYQl0wu9Sn319xajUhQMlA=;
        b=AeiDNQ8ftB2MMcBoRaYrZ2wqgiHvaJzN/MkPJkxi3Ev+EQKhuXYbP5u0YawE/rq48n
         Nwo256f+GFrthyDQe5KZvvQSQ81lh10INKV4rqnh3deKrDLyZ4hxDRhXWYgFA0RcvqGg
         yxp8H/6gaW6jcFvnO+LNKMX6EFLOiBh+j/4Y4IKykqvlZi7XopqOzKhD7730e77uuEz8
         rbtc1ke3pGNGlZLvTrIqNFs7NYv45iwX2kFDpSIoDrSeT1y14N/ku4mS7vKwJY2tOahC
         5ivRHa9XKKdTDNrxtFZFzxcDqcqqIWcFGUEq9o/il/6edy09PAAdZyeyX94fM15Eo5xd
         x4rQ==
X-Received: by 10.68.195.74 with SMTP id ic10mr68620480pbc.68.1441297676218;
        Thu, 03 Sep 2015 09:27:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id sb2sm25791431pbc.32.2015.09.03.09.27.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 09:27:55 -0700 (PDT)
In-Reply-To: <CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Sep 2015 10:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277221>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Also, if 'buf' is indeed unconditionally NUL-terminated, then the (sp
> <= buf + size) check is wasted code since the result of strstr() will
> always be either NULL or pointing somewhere within the NUL-terminated
> string.

A caller can give a buf that is NUL terminated but specify that the
only early part of the buffer to be used by giving you a shorter
size, no?  In such a case, strstr() is safe in the sense that it is
guaranteed not to go on forever, but you need to verify the location
of the string it found is within the bounds.
