From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Tue, 16 Jun 2015 10:32:10 -0700
Message-ID: <xmqqr3pb5zl1.fsf@gitster.dls.corp.google.com>
References: <1434440167-1046-1-git-send-email-pastith@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Panagiotis Astithas <pastith@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4uif-0006Gq-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbbFPRcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:32:13 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33769 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbbFPRcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:32:12 -0400
Received: by iebgx4 with SMTP id gx4so17645355ieb.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1jzcNiY1HuGSHiIW2r8nYLojCocNzreXJ1N7Ou6RfUY=;
        b=D4lO0zGJmY7VkeIeqPT9qqfPCY91b9JgZtVMw/JfybtUmbQyngl9FYmEzhtVT7qgaF
         1CqNSrqkXaj3k+Gw+AoyZiKD9TjsMSKBo7P+YuEXfEBxS9gRhof9pgMHy2C/242kLxk2
         izXUhQteJr8tTkl3YHkvn2sDUat780D5hN8lFOPkxe5THPuZnenfS9m+CygpY1KzKZtp
         zN+VNavyB5n4qZDwDlV4iPwM4ppX79jk97DyLOCBAfSHR3QYzvVcG/3RZZJXIukCuU7r
         ibSEqLynbgT/XnmxQNB6P/6kGvtNYpIaUXl3tR0k3FOIz+GAGFIT/SghmWRhCSa7e4q4
         Jbvw==
X-Received: by 10.107.37.69 with SMTP id l66mr2086342iol.76.1434475931657;
        Tue, 16 Jun 2015 10:32:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id o9sm918954ioe.35.2015.06.16.10.32.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 10:32:11 -0700 (PDT)
In-Reply-To: <1434440167-1046-1-git-send-email-pastith@gmail.com> (Panagiotis
	Astithas's message of "Tue, 16 Jun 2015 10:36:07 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271785>

Panagiotis Astithas <pastith@gmail.com> writes:

> The output of "pmset -g batt" changed at some point from
> "Currently drawing from 'AC Power'" to the slightly different
> "Now drawing from 'AC Power'". Starting the match from "drawing"
> makes the check work in both old and new versions of OS X.
>
> Signed-off-by: Panagiotis Astithas <pastith@gmail.com>
> ---

Hmph, is there any difference between this one and the original one
that I already queued several days ago?

>  contrib/hooks/pre-auto-gc-battery | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
> index 9d0c2d1..6a2cdeb 100755
> --- a/contrib/hooks/pre-auto-gc-battery
> +++ b/contrib/hooks/pre-auto-gc-battery
> @@ -33,7 +33,7 @@ elif grep -q "AC Power \+: 1" /proc/pmu/info 2>/dev/null
>  then
>  	exit 0
>  elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt |
> -	grep -q "Currently drawing from 'AC Power'"
> +	grep -q "drawing from 'AC Power'"
>  then
>  	exit 0
>  fi
