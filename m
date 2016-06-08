From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 54/94] builtin/apply: make parse_chunk() return a
 negative integer on error
Date: Wed, 8 Jun 2016 17:14:11 +0200
Message-ID: <CAP8UFD0Fow4HEp65D3Vbf=J4OtdeqxHZFDnnUABuyYkDJ3iXyg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <20160511131745.2914-55-chriscool@tuxfamily.org> <CAPig+cQkKijp_Mg0Ho0wAFSxmLin0EPA_a5PwV9DaHkHLJKNMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAfBT-0006c2-0B
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 17:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcFHPOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 11:14:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34506 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbcFHPOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 11:14:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so3782964wmn.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rbR+O6Zr6fFbaGkFB2YaahPeg3eIFBVmNJzzfJ1ICh8=;
        b=Ah4XbkJYtVpeCLscFxLWctK1G72VzaB++6+B2/KNUUGw0hfEvIVLY2OJvn8ZK35RQt
         U7BE7iScijzz4y1qbXtdLA+iMfSDbhazc065tUdFn8mWHLLLEtCqTU7QB/Zfl8DhwYbd
         zjNPSYBZ6gCIw2taTKTjlKK+2a0k9QeyOVIOHtLWzEat4fGYEom/60p1lXx3N109dF7A
         2UFyVzyEiZ2mE+Z+O2nbuc8JIhqGXtoSdrFSr0lcfZzQKkGIp98iKnhcfhVae1KgkE1+
         HSuGffogyCvlkgaJdEcE02ZylOeEa3ClpfqwSrPWSQLeNeeRLG/Hd5LkFvp9iqfk/bHT
         aqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rbR+O6Zr6fFbaGkFB2YaahPeg3eIFBVmNJzzfJ1ICh8=;
        b=QRbXD4fj8RsicsiifupC7LAfh9SE/0SiybabygsaxlJtPljTuYjx7kIqE/Ahq5A8D6
         k1Cn+oXQoOvp8ye6YFupE4Kd/DJBTmykTFT7PEIN9+J8ZPXPXesso5Q7Xqswab9ugPJJ
         IX5q0Y3umVGF6/o+s8ye5LbxXNIc2rdyqi/577dOZ6/iF88AOvWZ0eQdehoXpVtybKit
         bikUx1bpgWYlvyXFHvmrSIiXTVD2mWSJ1rCvcHcxnQPn9KBJpNcV4d8h8YLY8YCoJ7Lk
         P7sAW6JlbYWpGfzg2f/oG852hGEL7QQnEP0lHJHJ+XOlk1RRvOSB80nqQ6ApJUIV+WM+
         Il/g==
X-Gm-Message-State: ALyK8tIBV4EB6WALo9b8rFNUBdTz7lUqjcYy2rs2U4jaZLyuvo3wMzaMzkLskfTu79xl6JpPxA6nIrrhSdzHyQ==
X-Received: by 10.194.109.4 with SMTP id ho4mr5052510wjb.78.1465398852445;
 Wed, 08 Jun 2016 08:14:12 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 08:14:11 -0700 (PDT)
In-Reply-To: <CAPig+cQkKijp_Mg0Ho0wAFSxmLin0EPA_a5PwV9DaHkHLJKNMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296802>

On Mon, May 16, 2016 at 5:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To libify `git apply` functionality we have to signal errors to the
>> caller instead of die()ing or exit()ing.
>>
>> To do that in a compatible manner with the rest of the error handling
>> in builtin/apply.c, find_header() should return -1 instead of calling
>> die() or exit().
>
> Why is this talking about making find_header() return -1? Didn't that
> happen in the previous patch?

Yeah, it should be parse_chunk() not find_header().

This is fixed in my current branch.

Thanks,
Christian.
