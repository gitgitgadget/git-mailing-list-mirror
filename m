From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Mon, 17 Aug 2015 12:42:54 -0700
Message-ID: <xmqqk2std7lt.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-8-git-send-email-dborowitz@google.com>
	<xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTnJPc+Nh6dck0_Zx9vnyn5YVMCmy3E=7vr8bTpRSppAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:43:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQJA-0004Bd-R4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbbHQTm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:42:56 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34881 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbHQTm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:42:56 -0400
Received: by pacgr6 with SMTP id gr6so114820286pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7VsbkiXYyPsII0nzxPc7taPqwh5pIhSvCIuM/KwH3n8=;
        b=sGVIAIniMrPkxYMTlDQKFWkBeCYnfIthbY5vCrmBWJZsTCNA94YBCYA4mxWXDeQ46V
         MfLSatiUH7Dvha30cn0sIVJTAgB8FYlZNuxeVb3ShsuwJ9e/G905JU/KBMMoYnc1Iskb
         +Hhh0nOkaim41wCWX8ss/sndnEm5B6DCfei8Sgqd5G5QAho3fS+GUcMd2j0gYjCudojb
         nfSMBytTaaiOJFk+PZhwz3H5lwqCcHKUSeU7aodrN6VXc4NxCYg8dhIpin2pFnPRu1xm
         0FDvu9fnjRnrm2pU/9W17ZUCKAPo4UOw+ngH8vN9U4T7226SWSPJgUqrB9Jwg7oTDOho
         Gtbw==
X-Received: by 10.68.190.10 with SMTP id gm10mr5565390pbc.5.1439840575775;
        Mon, 17 Aug 2015 12:42:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id kn8sm15564438pdb.67.2015.08.17.12.42.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:42:55 -0700 (PDT)
In-Reply-To: <CAD0k6qTnJPc+Nh6dck0_Zx9vnyn5YVMCmy3E=7vr8bTpRSppAA@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 17 Aug 2015 14:22:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276082>

Dave Borowitz <dborowitz@google.com> writes:

> The issue is that if both _ALWAYS and _IF_POSSIBLE are set,
> git_transport_push interprets it as _ALWAYS. But, we are also supposed
> to prefer explicit command-line options to config values.
>
> Suppose we parsed config first, then options. If the user has
> push.signed = always and and passes --signed-if-possible, then the end
> result is (_ALWAYS | _IF_POSSIBLE), aka always,...

Doesn't that merely suggest that the option parsing is implemented
incorrectly?  Why is --signed-if-possible just ORing its bits into
the flag, instead of clearing and setting?
