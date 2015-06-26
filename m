From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Fri, 26 Jun 2015 11:47:03 -0700
Message-ID: <xmqqoak2tihk.fsf@gitster.dls.corp.google.com>
References: <20150616193102.GA15856@peff.net>
	<20150616193716.GC15931@peff.net> <20150616194907.GA15988@peff.net>
	<20150616212039.GA11353@peff.net>
	<CACsJy8DaJOOu7PA8jL+Mu3HQua-TRmzN378Mek1HuWVmRzT+ww@mail.gmail.com>
	<20150617191023.GA25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Augie Fackler <augie@google.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Yee-000276-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 20:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbbFZSrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 14:47:07 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36809 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbFZSrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 14:47:06 -0400
Received: by igbiq7 with SMTP id iq7so19077394igb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hsSvD8HWIPPIv8deq3OBlYQV6WD58Io0iDOhPDqHMrE=;
        b=uZ/7RVkEdzqvRj1+XnoV4m/eMdOVErvQxnykXYagJ+iC4x6x0UQizeaAAVrBwzAkm6
         jEAtyuiXUXLpYb3pqATkm1NdPtI+x4jyRoY5R01HBivpDiPoRF6NPa4EHLTxUdfwBUaK
         zRJUr7d5u3T0L5v+DIPovkwaDw8bZAkWAD3SH11wdeBakBOzmPMT7qdUYU687pgdcCJ4
         1bc55/FL1xwC9Qngly7fWyXHw8BszRKvjAXZIGB9NM4Gh8aqb78Vb2EWeTKeWiAQjik3
         BtyMOEWUSx+MYlweSDyijN7rgUntBxhtRV97G2LzXgYTDmbe2b+zYFxJ55FFcNeJNpZd
         JjKA==
X-Received: by 10.50.141.164 with SMTP id rp4mr5418804igb.2.1435344425760;
        Fri, 26 Jun 2015 11:47:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id g18sm206849iod.5.2015.06.26.11.47.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 11:47:04 -0700 (PDT)
In-Reply-To: <20150617191023.GA25304@peff.net> (Jeff King's message of "Wed,
	17 Jun 2015 15:10:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272812>

Jeff King <peff@peff.net> writes:

> My other motive for trace.* was that we could have something like
> "trace.prune", and have git-prune provide verbose debugging information.
> We have custom patches like that on GitHub servers, which we've used to
> debug occasional weirdness (e.g., you find that an object is missing
> from a repo, but you have no clue why it went away; was it never there,
> did somebody prune it, did it get dropped from a pack?).
>
> I can send those upstream, but it would be nice not to introduce a
> totally separate tracing facility when trace_* is so close. But it
> needs:
>
>   1. To be enabled by config, not environment.
>
>   2. To support some basic output filename flexibility so the output can
>      be organized (we write the equivalent of GIT_TRACE_FOO to
>      $GIT_DIR/ghlog_foo/YYYY-MM-DD/YYYY-MM-DDTHH:MM:SS.PID).
>
> For (1), we could just load trace.* in git_default_config; you couldn't
> use it with any "early" tracing that happens before then, but I think in
> practice it would be fine for most traces.
>
> For (2), I think we could accomplish that with %-placeholders (like my
> earlier patch), and the ability to write relative paths into $GIT_DIR
> (again, you couldn't do this for "early" traces, but you could for other
> stuff).

Both sounds like a sensible compromise to me.

Thanks, all, for an interesting discussion.
