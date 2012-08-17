From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 02/12] git p4 test: use p4d -L option to suppress log
 messages
Date: Fri, 17 Aug 2012 07:07:51 +0100
Message-ID: <502DDFB7.2010408@diamand.org>
References: <1345160114-27654-1-git-send-email-pw@padd.com> <1345160114-27654-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:09:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Fjv-0006Bx-VF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab2HQGIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:08:54 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42746 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab2HQGIx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 02:08:53 -0400
Received: by wibhr14 with SMTP id hr14so1345047wib.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 23:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=JQJcDg4+etlGLGFsDu0OiVYnqs09DWYEvXTRtbVGrzg=;
        b=Ap7brflk1yx5oeLQSDRKud3m8bj4H1ZkQUbUllfipgSVb8pxA9xdCsw1xL5WJ34sF/
         MIcaGKS5wloZ78x1njuuN5GzaNpVSqBA8V5OGbLkH+MeAcrFYwLCx0F8oUmhITexr07P
         JrIi7FVrfxbjGSVyUoxXcm/tgodwggvHwoYzhgDlvhlqy1wtS0o7YrH2x3t5XT3CeptO
         uNvmGWRXI/BbLkgro4VOzHVcKPBJ8MIRiPndvdCPUDGz+YqeXQUS8TMiZ+v/4fOA8RLd
         a7htfFjiJtnq054hy6K5jcEC2mwBpOkIcT4vUSWS/dfALZwQSJzQL/6BIjkIohig4LZ7
         hQ7g==
Received: by 10.180.95.193 with SMTP id dm1mr2191034wib.10.1345183731881;
        Thu, 16 Aug 2012 23:08:51 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id k2sm11895360wiz.7.2012.08.16.23.08.51
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 23:08:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1345160114-27654-3-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQnXT1Iel1mO2UMPD5getqFX9tQ0GiYxsQjYWzOLXCQhlOMB2sWEMBwPEYsUXzL0t0P4eSE7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/12 00:35, Pete Wyckoff wrote:
> Send p4d output to a logfile in the $TRASH_DIRECTORY.
> Its messages add no value to testing.

I'm not totally sold on this; I still fairly frequently see weird errors 
from p4d and these help me work out what's going on. For example, at the 
moment if you run a test too quickly after the last one, then it won't 
start up (or something like that).

The problem with hiding the error messages is that I don't think I will 
think to look in this log file if tests start failing.

>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   t/lib-git-p4.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 482eeac..edb4033 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -35,12 +35,13 @@ db="$TRASH_DIRECTORY/db"
>   cli=$(test-path-utils real_path "$TRASH_DIRECTORY/cli")
>   git="$TRASH_DIRECTORY/git"
>   pidfile="$TRASH_DIRECTORY/p4d.pid"
> +logfile="$TRASH_DIRECTORY/p4d.log"
>
>   start_p4d() {
>   	mkdir -p "$db" "$cli" "$git"&&
>   	rm -f "$pidfile"&&
>   	(
> -		p4d -q -r "$db" -p $P4DPORT&
> +		p4d -q -r "$db" -p $P4DPORT -L "$logfile"&
>   		echo $!>"$pidfile"
>   	)&&
>
