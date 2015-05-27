From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 3/8] am: implement patch queue mechanism
Date: Wed, 27 May 2015 13:38:51 -0700
Message-ID: <xmqqy4k9kb6s.fsf@gitster.dls.corp.google.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-4-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxi6Q-0000UP-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbbE0Ui7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:38:59 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38378 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbbE0Uiy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:38:54 -0400
Received: by igbjd9 with SMTP id jd9so8557213igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZuYSvt+9ROkU5S/Nq96pRz/cf8DoaQaxO47HxHQNCss=;
        b=XCmU0w5plW7KsKWj3gtFeb9S0Xq37od1NKPVfx9BdDLbsJfwI4zIYwwEoe8+V7fw/O
         7oD4uECii1O01FAFOSM2JiFRlu7LHMOuwYc6hqjliXIh/CZn6pc0zeaUhWl505jHYQMa
         7WhOvvkFxkC4MOvy9VIQ5715dxP4bc4vsASwBBpZ4Nww+JCASVtZUVGl7N/EVZtyna8q
         tdlhHdI/T6XyQhKKkGiJoto7fVivIC89XbQZ1hkuBJ3tHADnYoDdWWo15Ro0jn5Br8/l
         RmwuMhTpbs+5D9ARelcTw8+22Ua0Q2L0x4B/oVxWM38TkE9PRtMbuz+JBVLljB79J5nW
         caRg==
X-Received: by 10.50.50.148 with SMTP id c20mr39451260igo.0.1432759133251;
        Wed, 27 May 2015 13:38:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id c20sm61574ioc.40.2015.05.27.13.38.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:38:52 -0700 (PDT)
In-Reply-To: <1432733618-25629-4-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 27 May 2015 21:33:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270088>

Paul Tan <pyokagan@gmail.com> writes:

>  Makefile     |   2 +-
>  builtin.h    |   1 +
>  builtin/am.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git.c        |   1 +
>  4 files changed, 170 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/am.c
>
> diff --git a/Makefile b/Makefile
> index 323c401..57a7c8c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -466,7 +466,6 @@ TEST_PROGRAMS_NEED_X =
>  # interactive shell sessions without exporting it.
>  unexport CDPATH
>  
> -SCRIPT_SH += git-am.sh

If you are building this "new am" incrementally (and for something
complex like "am", that's the only sensible way), perhaps it is a
good idea to do the "competing implementation" trick I suggested
earlier when we were discussing your "new pull" patches, to allow
you to keep both versions and switch between them at runtime.  That
way, you can run tests, both existing ones and new ones you add, on
both versions to make sure they behave the same way.
