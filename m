From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv11 02/11] receive-pack.c: die instead of error in case of
 possible future bug
Date: Tue, 6 Jan 2015 11:46:22 -0800
Message-ID: <20150106194621.GS29365@google.com>
References: <20150105212523.GN29365@google.com>
 <1420573247-10250-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	sunshine@sunshineco.com, mhagger@alum.mit.edu,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:47:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8a5L-0008Bj-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916AbbAFTq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:46:26 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59462 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbbAFTqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:46:25 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so4622193iec.10
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=APFwCoiW0O4qGXnyAMbhuPWjKq4zluT7+iLf0khz2Ms=;
        b=C1JxSuh4hr5ibDwQFO2sLpkH4JGkoOzUUsONakTysvIFHMzUkJFuOmnAZra41UQ64g
         t/i/rrdMKGHbjaXq0A6Em5s2ofOCKc3lw+p5QADPqqFc4m0o7wEIwcMV+VBNAOVY4ASM
         sLZ+XMoSkl10hTL0LBBw8RymqZXccb6ncOXcI12f+VlwJ3sWorG8/odF7/iA6Jl7Chth
         gEF8i+WiD0jdLfXI5r1yuMXuRBAbh9OBM9lBQSX/WPxEdq4Fq8ztF5rJJqMdsH1rF7wh
         QdaiJhP0lS/hMMqNjJi+dLfI7ZE4QnwrEhl2BKqqin0280OtNFL5e3dSFjQEEdnwrv0o
         TeCA==
X-Received: by 10.107.132.210 with SMTP id o79mr87595264ioi.50.1420573584612;
        Tue, 06 Jan 2015 11:46:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:505b:b74a:9ab8:7af7])
        by mx.google.com with ESMTPSA id hi15sm5391740igb.19.2015.01.06.11.46.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 11:46:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420573247-10250-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262098>

Stefan Beller wrote:

> +++ b/builtin/receive-pack.c
> @@ -1061,9 +1061,8 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
>  		}
>  	}
>  	if (!checked_connectivity)
> -		error("BUG: run 'git fsck' for safety.\n"
> -		      "If there are errors, try to remove "
> -		      "the reported refs above");
> +		die("BUG: run 'git fsck' for safety.\n"

This advice is still inaccurate.

If the idea is that the user should ensure the connectivity check is
run, why don't we run the check ourselves here?

If the idea is instead that something unexpected has happened and we
don't have enough information to go further, why do we ask the user
to run 'git fsck'?

Hope that helps,
Jonathan

> +		    "BUG: connectivity check skipped???");
