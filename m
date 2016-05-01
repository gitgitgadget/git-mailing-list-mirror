From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 54/83] builtin/apply: make parse_chunk() return a negative
 integer on error
Date: Sun, 1 May 2016 21:51:56 +0200
Message-ID: <CAP8UFD0U1eBGYsVdNovhAGJzc1L=svDpkunTmTGboKmxhFF5Ow@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-55-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cQbF_Xq2oB5ALQkj_Zdw8VR8kyVyinq_K24zGGK7Xundw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 01 21:52:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awxPO-0001Z2-Sa
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 21:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcEATv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 15:51:58 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38660 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcEATv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 15:51:57 -0400
Received: by mail-wm0-f49.google.com with SMTP id g17so113647649wme.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7ezptzzWb5BFb5+iD53mOG86G7g2q2VYXeM4XuokNpY=;
        b=R9O9Sxp3KDaBA56vmUpR8UaEFiZqixlDXZIPV3L2MXMuYGUnmgp0/dpo3m+mfeHJH7
         a5Ry3u2pRyUeWZm9p1hheqQMImKaKTheTruf0t8jWdMHf3Df1sANTvSGZbT52H9CL/oq
         a0w4vkh4gOVyeJ6fA6iIkVdNpvoGaK0XQlqWFa5gxH37MO8crorlZ8wc30UmHY44XTBX
         ExaCk6mSRY8oDBr8J+XERkQyeG2D4OfYqPW4htDBuN6yO+YdeobewBSj8WGUXPH5vppO
         exL744rAXR+Bx83FbJpLFDCn2RJlvKXaGn3uYFQHObj+d2EkgpDF34DD06g9D0+Zy82r
         bPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7ezptzzWb5BFb5+iD53mOG86G7g2q2VYXeM4XuokNpY=;
        b=PTao272pZqEBfDib4DjCFGCFXnSspiDrKKFqalgDqnCCNyumEq6G92rgESH0rtJ1NO
         DWWp3tiRJZpilSUGsI+xnCuqpcCLDS8IUehHBlwcKkPrxHTWaps8ieMdbbVpFrYP3E6L
         XgggFZVTQQkhMA03a31asBromhSwjG0LoGGlO2NIXoHD4LZa+FGucpN75/hkIQ5s29sw
         XJBJcIHb/yqFCBC+2E4BADxoWqhCn3M/OEhjjyu01lXxT9K2NGxwYY5AJOEMKRwjCu+8
         DtsEvFHL2p4Z8dK2VOX2AviOYUVY/wHLXuyw6flNf3ycHRdH5M7jqJEQVeiquPX45u06
         N9ew==
X-Gm-Message-State: AOPr4FWIYuXjhKMvuhBXGV1UyVlCo0B27FYfF1umeiV+PKkIenDLmEUHeFWYg2DP4fRGp0eK5jt3ZXVK0GZT9w==
X-Received: by 10.28.158.79 with SMTP id h76mr14513695wme.79.1462132316570;
 Sun, 01 May 2016 12:51:56 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 12:51:56 -0700 (PDT)
In-Reply-To: <CAPig+cQbF_Xq2oB5ALQkj_Zdw8VR8kyVyinq_K24zGGK7Xundw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293212>

On Sun, May 1, 2016 at 9:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> This negative number can be -2 if no patch header has been found,
>> otherwise it is -1.
>>
>> As parse_chunk() is called only by apply_patch() which already
>> returns -1 when an error happened, let's make it return -1 when
>> parse_chunk() returns -1.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4566,6 +4567,8 @@ static int apply_patch(struct apply_state *state,
>>                 nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
>>                 if (nr < 0) {
>>                         free_patch(patch);
>> +                       if (nr == -1)
>> +                               return -1;
>
> Same comment as 51/83 about this leaking 'list', 'buf', and 'fn_table'.

Ok, thanks!
