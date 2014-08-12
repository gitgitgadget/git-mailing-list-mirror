From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when we see --shallow lines
Date: Tue, 12 Aug 2014 22:13:03 +0700
Message-ID: <CACsJy8AQ4vC4QKR_y62h_Gjd619QfBg-rDB2F6HFj2fvJj41tg@mail.gmail.com>
References: <20140812043452.GA11784@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHDlc-0006UE-2B
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 17:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbaHLPNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 11:13:35 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:44423 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbaHLPNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 11:13:34 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so7000073igc.12
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Gf0ZxOXVPcPxssUzDM/B2oAIu6ynslJ43WSi/O57mG4=;
        b=Nq2dFVf4Y7p8yIwxcUG52nYP3Ic7hysbsh5tVebq+apyC6gJ8CqaCJzFo05fM7BwOq
         SW3yUbN0JI1nEEoGFp3JrSpSAgL2bCcgR+MIzhJLmBsQo2CyVrheTTc7Z/CIef7iA8IT
         2F79McWNYS0KuO2gvOdY/JMESFEIg5EOaTzK5i9KvFuLxOf2gA6E06fPmNIB6yr+KJk4
         fu5+ejsAmgEmLUyo1JyVLRChhbcpdv9Rc4c5DT9HWC/WoWiLEpSc/YBgU5scKjwOJ9MY
         8331SBBBr3aO0ufmhmhJ3jDqTtub246OsReDgwlKww4aW92qld2qBTuq86zmp2XT0B7W
         y2nA==
X-Received: by 10.43.129.74 with SMTP id hh10mr40585048icc.48.1407856413493;
 Tue, 12 Aug 2014 08:13:33 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 12 Aug 2014 08:13:03 -0700 (PDT)
In-Reply-To: <20140812043452.GA11784@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255148>

On Tue, Aug 12, 2014 at 11:34 AM, Jeff King <peff@peff.net> wrote:
> Arguably is_repository_shallow should return 1 if anybody has registered
> a shallow graft, but that wouldn't be enough to fix this (we'd still
> need to check it again _after_ reading the --shallow lines). So I think
> this fix is fine here. I don't know if any other parts of the code would
> care, though.

It's getting too subtle (is_repository_shallow fails to return 1).
register_shallow() is used elsewhere too, luckily pack bitmap's use is
still limited in pack-objects (I think).I prefer (in future) to teach
is_repository_shallow about register_shallow and move it to right
before get_object_list_from_bitmap() is called, and some sort of
mechanism to say "hey I'm all set, never change shallow repo status
again from now on, or just die if you have to do it" to protect us
from similar bugs. But for now your fix is good (and simple).
-- 
Duy
