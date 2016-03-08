From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Wed, 9 Mar 2016 06:02:10 +0700
Message-ID: <CACsJy8BFK64rzJwQxB8M3=uA_g9s6N70vjNyLOnroZc28soiAQ@mail.gmail.com>
References: <20160307221539.GA24034@sigill.intra.peff.net> <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net> <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
 <20160308132524.GA22866@sigill.intra.peff.net> <20160308133041.GA9465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 00:02:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adQeM-00066J-3B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 00:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbcCHXCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 18:02:43 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36551 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbcCHXCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 18:02:42 -0500
Received: by mail-lb0-f181.google.com with SMTP id x1so40162754lbj.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dgZdyuS7zh1LAf1f/ESQwzX5aQDSuM5m1zTLcdeahPM=;
        b=aLSnsQ3TXgLlCXMuK2jsT5UlC0vXhStAInmFXVI1l+wrrYrS6luF+PjccH7d31W/eB
         qaDjD3poBAvGIkR6dPlzc8n1arokoF+jIACmGu+ove3JUF8NX8OaDSDgr/sk/jUqUzBS
         UZiyf99rfXe1DnK3aRe8bHoji3jGIDdLsiHbnks7nNwXLyYL2U9OpfIPDCljvhb7Xe3t
         /UdlAVw1q9ijVuyEfwCSZ86tJkuT2izmHZx0SJphXKkdbIItD/8cAbTCFlj9UysKTw0/
         0WQRu+kCmhn2g6jaNpiR+NvPYwRaFOXFyS5DbkyDkLwtd/ppm1a9WQA1HKCFAumLxczq
         pKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dgZdyuS7zh1LAf1f/ESQwzX5aQDSuM5m1zTLcdeahPM=;
        b=OEW1wmUhbYp8uOpPOwhJe12brmXkm6v+uwNkEII4gWkYRAvzDozJ9NkEetPqH2nx0/
         leOCRwCN0tgW7DB/D3mI4otDvN6axnOAdbi1jWxIIZc/WQ1gVMtWh9zEw5i+IB8LTr9W
         T+kKEzX/K2JA20i5sEGPkVS4bdvkJN2hf3jvMxJDGY66cZhw1YwX53Yy88MSrMeoZ1Xy
         4Mz7JcfoLFtstTdvKZ0+oSu/JQu8xK86BeORIGBA/drnYcED0KkOlwz78jMhj87omtiW
         8hu3huoArbUjSy8HGNcmr6vc7r6HuHt30fmwu4HVpcD/bW7pjcgdEdQIiiiyUySEDGlt
         rDUw==
X-Gm-Message-State: AD7BkJL/eH+1NpyVt1aopVVLY9Zp8xQIfL/efQcJjXVMvMoiczNBFNdyq76495VnsbvAYTgE7+MtKeSoRPPfGg==
X-Received: by 10.25.24.100 with SMTP id o97mr6608718lfi.112.1457478160610;
 Tue, 08 Mar 2016 15:02:40 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Tue, 8 Mar 2016 15:02:10 -0800 (PST)
In-Reply-To: <20160308133041.GA9465@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288457>

On Tue, Mar 8, 2016 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 08, 2016 at 08:25:24AM -0500, Jeff King wrote:
>
>> > Good news. We have the mechanism in place, I think.
>> > get_shallow_commits_by_rev_list() (from 'pu') will produce the right
>> > shallow points for sending back to the client if you pass "--not
>> > <current shallow points>" to it. It's meant to be used for
>> > --shallow-exclude and --shallow-since, but if neither is given (nor
>> > --depth) I guess we can run it with current shallow points. I wonder
>> > if we can detect some common cases and avoid commit traversing this
>> > way though.
>>
>> I tried that, but I couldn't quite get it to work. I don't think we need
>> any special rev-list, though; we can just find the boundary points of
>> that traversal and mark them as new shallows.
>
> By the way, I found a bug during my initial attempts with
> get_shallow_commits_by_rev_list().

Hehe. Thanks. Will check why tests missed it and reroll with Ramsay's
fix once -rc period is over.
-- 
Duy
