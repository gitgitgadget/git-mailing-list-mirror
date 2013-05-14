From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 02/10] remote-hg: get rid of unused exception checks
Date: Tue, 14 May 2013 15:16:15 -0500
Message-ID: <51929b8fc1e2_13a8f89e1815dd@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLgS-0004Et-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963Ab3ENUSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:18:49 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:51638 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:18:48 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so1225899oag.15
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=Qs14bcgHMYdRjjdeamoxn832hGz4B1byZbvo+oocnFc=;
        b=hZe1RDI9BW1G6JlSNP30WgRX9QBUuJTO59OTYvxmuX9FW1P3n9wqq4fZx/4wHZAmiw
         Ms42TMIB+ontUCGCB/LJuwuzPVZuAimCu6ox9is+opuIZE5BWY5nynnaccIO6XQBI8My
         WOvqxzhMe8tK71GEwFc6+47M65/1MiMD3lGM/RzYICQnxUAnpessjQSLypsPHuU23mGM
         d/yMJOcvdzEPUN1KFVKslzQo3iFDgPmjXhXz8pQ/XWb+PGo+2nX/n3ZnGKfcnFYwtEi+
         Vfvn7QwgMLxMnMqdhkdj+oJwMQaywyz6hGa+qOk+XNJLYB7pIqBA3e8Vc27ToKRwXfs1
         Jc0w==
X-Received: by 10.60.162.70 with SMTP id xy6mr7851248oeb.117.1368562728116;
        Tue, 14 May 2013 13:18:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm23175091obc.2.2013.05.14.13.18.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:18:47 -0700 (PDT)
In-Reply-To: <1368486720-2716-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224334>

This is removing an exception check and since that exception is thrown by
check_output() but not Popen(), this doesn't change anything.

Felipe Contreras wrote:
> We are not calling check_output() anymore.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index d33c7ba..9d6940b 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -327,11 +327,8 @@ def get_repo(url, alias):
>      myui.setconfig('ui', 'interactive', 'off')
>      myui.fout = sys.stderr
>  
> -    try:
> -        if get_config('remote-hg.insecure') == 'true\n':
> -            myui.setconfig('web', 'cacerts', '')
> -    except subprocess.CalledProcessError:
> -        pass
> +    if get_config('remote-hg.insecure') == 'true\n':
> +        myui.setconfig('web', 'cacerts', '')
>  
>      try:
>          mod = extensions.load(myui, 'hgext.schemes', None)
> @@ -910,16 +907,13 @@ def main(args):
>      track_branches = True
>      force_push = True
>  
> -    try:
> -        if get_config('remote-hg.hg-git-compat') == 'true\n':
> -            hg_git_compat = True
> -            track_branches = False
> -        if get_config('remote-hg.track-branches') == 'false\n':
> -            track_branches = False
> -        if get_config('remote-hg.force-push') == 'false\n':
> -            force_push = False
> -    except subprocess.CalledProcessError:
> -        pass
> +    if get_config('remote-hg.hg-git-compat') == 'true\n':
> +        hg_git_compat = True
> +        track_branches = False
> +    if get_config('remote-hg.track-branches') == 'false\n':
> +        track_branches = False
> +    if get_config('remote-hg.force-push') == 'false\n':
> +        force_push = False
>  
>      if hg_git_compat:
>          mode = 'hg'
> -- 
> 1.8.3.rc1.579.g184e698

-- 
Felipe Contreras
