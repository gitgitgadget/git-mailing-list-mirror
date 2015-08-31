From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: don't rewrite shared index unnecessarily
Date: Mon, 31 Aug 2015 08:41:45 -0700
Message-ID: <xmqqio7vxy6e.fsf@gitster.mtv.corp.google.com>
References: <1440695274-12400-1-git-send-email-dturner@twopensource.com>
	<CACsJy8D=KyWBYf1LW=n928rmG=9xavSaR+1G1g+F7mMTKFCpfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 17:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWRDU-0005fH-33
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 17:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbbHaPls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 11:41:48 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35054 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbHaPlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 11:41:47 -0400
Received: by pacdd16 with SMTP id dd16so142955931pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lLRto5M/lsCaLhm5VPBS7o/6LbHYiHm+JmWVlHwPJVM=;
        b=U6d+nwtTHYUm6kbffFP3DJ+n0KhSlD5Xg8xdcs9PlnoyZfAc2LgA2jmOxq8HD5TUy7
         12HZMNVX6vQAGKZ89RQKgJxU2SUv1K/O3ns+35WqB39dXVnKfrqNRMSFB/aNRARbyGLU
         DZ8U5PsGni92kSC6P7/jpHEBk21+k0vR5oHazg5kYiLwcer8pI9xZYe5lmr89x+NyB/Z
         lLXDO2Ie4q4ehy42jY7OD9haP5HlOiNzNIPSB2GQZGP4/0YU8+f3TI6ou2KQoEWDvaQO
         G75idyCz0OYkGHAyKXKhCH4LWsII3QqYbl/ObwLlcdNiW4GzDsbDyPJE589OoJ68KzZ/
         LJMQ==
X-Received: by 10.66.147.68 with SMTP id ti4mr38287357pab.90.1441035707247;
        Mon, 31 Aug 2015 08:41:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id k10sm14979181pbq.63.2015.08.31.08.41.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 08:41:46 -0700 (PDT)
In-Reply-To: <CACsJy8D=KyWBYf1LW=n928rmG=9xavSaR+1G1g+F7mMTKFCpfg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 31 Aug 2015 17:02:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276886>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Aug 28, 2015 at 12:07 AM, David Turner <dturner@twopensource.com> wrote:
>> Remove a cache invalidation which would cause the shared index to be
>> rewritten on as-is commits.
>>
>> When the cache-tree has changed, we need to update it.  But we don't
>> necessarily need to update the shared index.  So setting
>> active_cache_changed to SOMETHING_CHANGED is unnecessary.  Instead, we
>> let update_main_cache_tree just update the CACHE_TREE_CHANGED bit.
>>
>> In order to test this, make test-dump-split-index not segfault on
>> missing replace_bitmap/delete_bitmap.  This new codepath is not called
>> now that the test passes, but is necessary to avoid a segfault when the
>> new test is run with the old builtin/commit.c code.
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>
> Ack.
>
> I made SOMETHING_CHANGED "1" for catching these cases (there were a
> few on-flight topics when this series was being cooked and I was
> afraid I could not cache all active_cache_changed sites).

Thanks.

>> ---
>>
>> I introduced this bug last year while improving the cache-tree code.
>> I guess I probably didn't notice that active_cache_changed wasn't a
>> boolean.
>
> So.. you did you split-index? Cool. Never heard anyone using it for
> real. It needs the other part to improve reading/refresh side to get
> to full potential though..

;-)
