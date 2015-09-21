From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Mon, 21 Sep 2015 10:52:36 -0700
Message-ID: <xmqqr3lracd7.fsf@gitster.mtv.corp.google.com>
References: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jan Viktorin <viktorin@rehivetech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:52:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze5Ge-00005H-4r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbIURwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:52:39 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35606 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbbIURwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:52:39 -0400
Received: by pacfv12 with SMTP id fv12so125099067pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HjjqQltkNoJ/wuMOLl3fpRK8FKW47Bg8YgIjLxpSt4M=;
        b=AwWbGejpItkO9ucJuAynyv8IVmGE0uSCIx4rUBAkUDVZoNuwyRSbTVVzkzHYRUtY4g
         BllrD1qMF/mXDbExkoiL2RBkE2Hhvt/LQNbUitfj+vBUkB/G05Tv1XFYriwBO+M8yfvX
         qjv1D0iSwThSQ2B4141tADf//q01iltl1WFgbI7UIk9mfesBAU2wFr5FdnqIBlc0dbLT
         0UTLoXbSiLcB1dziXk/cO3N4foTfh479E/dIBZHGtzjTVUc9Ci1TSezHdrevtrC1YyAw
         o7vJr4pMD0K/AmIzrU5FtlQd9hwxkSk7emBzUYp5OWNPI6t7d791nXchUZWB7XQ2HiWV
         4eKQ==
X-Received: by 10.68.192.9 with SMTP id hc9mr26067950pbc.57.1442857958435;
        Mon, 21 Sep 2015 10:52:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id o3sm25854510pap.37.2015.09.21.10.52.37
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:52:37 -0700 (PDT)
In-Reply-To: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
	(Brian Norris's message of "Fri, 18 Sep 2015 15:12:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278320>

Brian Norris <computersforpeace@gmail.com> writes:

> On the latest version of git-send-email, I see this error just before
> running SMTP auth (I didn't provide any --smtp-auth= parameter):
>
>   Use of uninitialized value $smtp_auth in pattern match (m//) at /usr/local/google/home/briannorris/git/git/git-send-email.perl line 1139.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Jan Viktorin <viktorin@rehivetech.com>
> Cc: Eric Sunshine <sunshine@sunshineco.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index c5a3f766f7fd..e3ff44b4d0cd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1136,7 +1136,7 @@ sub smtp_auth_maybe {
>  
>  	# Check mechanism naming as defined in:
>  	# https://tools.ietf.org/html/rfc4422#page-8
> -	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> +	if ($smtp_auth && $smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
>  		die "invalid smtp auth: '${smtp_auth}'";
>  	}

Thanks.
