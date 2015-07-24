From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] pseudorefs: create and use pseudoref update and delete functions
Date: Fri, 24 Jul 2015 12:25:53 -0700
Message-ID: <xmqqbnf1mk72.fsf@gitster.dls.corp.google.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
	<1437713129-19373-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 21:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIibZ-0003QU-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbbGXTZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:25:57 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35338 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbGXTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:25:55 -0400
Received: by pdrg1 with SMTP id g1so17855032pdr.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=86dk/u9p9Y0veqqnF5jsX7/nkIFHIK7+qkdVv84itBM=;
        b=V+88UnlJgJhFPKS4+aCkZ57lf2Lskn2SVcOnBn2m5qhQrCWYMVwQApgrs3LLmDL6hE
         Kr4r30Y1pN5cClgLY1mjQCybHEGr81HKCR3cE/YcMXPboRHCqCwc9uQ4ut6p6l1V/V4y
         W46+feiqGIAkoOeCezWQ+jiI2dWQKxSeeNX0M9i3/f6BBJxj/tnd66zvscXEmzizxAz9
         AC8Ci4Tu1FtbqMS1W/65U1fHxfEH0uLNEvQeoXQ2sv5X9U8ihzJi81FDOmDQstXZzohW
         /OaPSstD0/j5frOcuAJHoBr9HygFQYi5c+FFSJr4yrl/YXxVvCARAQvB525YEGkJFz9W
         VqTQ==
X-Received: by 10.66.119.105 with SMTP id kt9mr34937977pab.86.1437765955140;
        Fri, 24 Jul 2015 12:25:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id ra10sm16047399pab.19.2015.07.24.12.25.54
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 12:25:54 -0700 (PDT)
In-Reply-To: <1437713129-19373-7-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 24 Jul 2015 00:45:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274591>

David Turner <dturner@twopensource.com> writes:

> Pseudorefs should not be updated through the ref API, because the ref
> API is for real refs.  Instead, use a dedicated pseudoref API.
>
> This patch changes writes to CHERRY_PICK_HEAD, REVERT_HEAD, and ORIG_HEAD.

This feels somewhat backwards, and it makes me wonder if it is a
better approach to teach update_ref() about the naming rules, so
that the callers do not have to say the same thing twice "This is
not a ref and I am giving all-caps name, by the way I am also not
calling update_ref() because that is only for real refs".
