From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify
 worktrees by basename
Date: Thu, 2 Jun 2016 16:40:35 +0700
Message-ID: <CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com>
 <20160530104939.28407-3-pclouds@gmail.com> <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com> <xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 11:41:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8P7p-0001Nc-11
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 11:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbcFBJlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 05:41:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34600 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440AbcFBJlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 05:41:06 -0400
Received: by mail-io0-f196.google.com with SMTP id l9so5820784ioe.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GI79fdOE///CsBNiWi6vm5WTphDrFDGSihDOTylA8LQ=;
        b=LFVaCexnJT7d2WjjAidbeDr77lMiC/lnF3bX+Qc/vme8MUx+o+mkcEuQ1aunMht3AQ
         nDx9qxMKp/jbNWJEmJ9EpkE0PvKJKDDUZdqOMY/jB4TeoMR/6FQdu/vHLiKe9bWPvuEp
         TeZqxOh41U4mEhMyAGkMIWus62osivpHwd2ZdwbKdlSmpVUWBC8GjY+w3SotIvnyDUsH
         b11gmOObuNkWfiolB+oNZsoJK4uubZChWrRWL7BUOCCsN1lu32aO6qU3h1tNY1Ru2nm7
         +lgMvL1NIcJb+p1Z/dhBmxh7s8yycYrl9YkTNKyP99gq2ysBDQMibrCtmdFVgEUFLwxP
         8ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GI79fdOE///CsBNiWi6vm5WTphDrFDGSihDOTylA8LQ=;
        b=R1G/nJBBMiha9SjWsGJj0c+7UrvNFlIHJLuEzU/wfEVZWBHn0eBkj8XZhxLVvrvb2b
         GOKzNSY+O308iUS8s/Cm+luTPm2AIUo2GBQ/Hn6oIneDw3ITU1yfDht+RyqGyo55IbRE
         GGtJVg7JwpTXj0mz3fnA8ejZJamFscucJr71umBzEZTS5GazVGUUyNhHnLhizbUm1h0T
         lzdN1+ic9+5WOujRS/gvv+xBzHWMFMB/6ZXZnKmpPTym8eq/08lE+XO/YxTwdKOH/Z3q
         3NE+/8PKqx5xoIsdR/KEU4VddygcvMNqHX6d112136H603Gb46MsOOaM32qeopvzwxmB
         cODg==
X-Gm-Message-State: ALyK8tJdh5ETrg3wPp/5uDxbT5Bp9KaGp7+dt2BFuvStZMlv3js9QtQ78SB12/jPa0jHzTOeyMp6xVigIeqh5Q==
X-Received: by 10.107.22.131 with SMTP id 125mr2015415iow.128.1464860465055;
 Thu, 02 Jun 2016 02:41:05 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 02:40:35 -0700 (PDT)
In-Reply-To: <xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296191>

On Thu, Jun 2, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> We would
>> need to convert or match both '/' and '\' in "to/foo" case because of
>> Windows, so it's not much easier than basename().
>
> I never said "easier to implement".  But can this codepath get
> backslashed paths in the first place?  I somehow thought that
> normalization would happen a lot before the control reaches here.
>
> You'll be calling into fspathcmp() anyway; shouldn't the function
> know that '/' and '\' are equivalent on some platforms, or is it
> legal to only call fspathcmp() on a single path component without
> directory separator?

We still need to calculate the length to compare, which could be
problematic when utf-8 is involved, or some other encoding. If we
always split at '/' boundary though (e.g. "abc/def/ghi", "def/ghi" or
"ghi" but never "ef/ghi") then it should be ok.
-- 
Duy
