From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Fix a critical bug in git-cvsexportcommit.perl
Date: Wed, 24 Sep 2014 12:20:44 +0200
Message-ID: <54229AFC.6080704@gmail.com>
References: <wq8tquzz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Luke Lee <luke.yx.lee@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 12:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWjgn-0008SZ-19
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 12:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbaIXKUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 06:20:46 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:38074 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbaIXKUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 06:20:44 -0400
Received: by mail-we0-f176.google.com with SMTP id w61so5023361wes.21
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=gN9/LdLjQExQfatCQb4CHpYOfx8BcqaydjS6GsCVsas=;
        b=uCVR3FmGgmclltMQQoJDR3fv5mv2TMYTtTnjtWmvNReiDPkWyf8pP9G6J9NOD/3n1A
         q5GDl/+V9B9Q/wE5vFFX1zn6i+I7bDU7IWJQsqDaRvd6ZCSkaGUzT3HPsabhmMPZaTr0
         SdFIf+/OC1/2HAmP/3T2UODopxW+WVvTg/dZG3iVWoKnMdx4N6PPZ2zXf+7QgORLGhKC
         5BmNSDU16NuZbskQzdkpqO9FHJCa3hQy1tfPlbZ5CGZ6iARqPsFzJbt0RMYwWB+E6fLS
         Gu2k4tN8rC4yYwRPyj1DiSX+vv9triHLL8vCGN73jk7wHT39UNWfyFKLXxeufoiQUwvZ
         DRoQ==
X-Received: by 10.180.86.195 with SMTP id r3mr29909098wiz.8.1411554043078;
        Wed, 24 Sep 2014 03:20:43 -0700 (PDT)
Received: from [192.168.1.7] (p5B095D86.dip0.t-ipconnect.de. [91.9.93.134])
        by mx.google.com with ESMTPSA id ba3sm5272448wib.10.2014.09.24.03.20.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2014 03:20:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <wq8tquzz.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257456>

On 24.09.2014 10:32, Luke Lee wrote:
> I fixed a long standing bug in git-cvsexportcommit.perl script which
> corrupt my Perl code several times. This time I figure it out. It's
> about keyword expansion. Take a simple example, a Perl code like this:
> 
>     printf "Perl/Tk $Tk::Version ($Tk::platform)\n";
> 
> will be incorrectly unexpand by git-cvsexportcommit.perl to:
> 
>     printf "Perl/Tk $Tk$Tk::platform)\n";
> 
> This happens when I try to export a git commit to a CVS working
> directory *with keyword expansion turned off*. git-cvsexportcommit will
> try to simulate what CVS does on unexpanding keywords. However, it *DOES
> NOT* realize only valid keywords should be unexpanded. Please help apply
> this patch.
> 
> Thanks.
> Luke Lee

Thanks for sending a patch. :)

> 
> From a33096156e376924d3a7ac2b5a42877f9aedee58 Mon Sep 17 00:00:00 2001
> From: Luke Lee <luke.yx.lee@gmail.com>
> Date: Wed, 24 Sep 2014 14:38:17 +0800
> Subject: [PATCH] Fix a critical bug in git-cvsexportcommit.perl about
>  unexpanding keywords which incorrectly delete codes that are not expanded
>  keywords.

Please have a look at Documentation/SubmittingPatches,
also found online at
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Specially look at section "(2) Describe your changes well."
So the headline could be shorter and then in the body of the commit
message you may want to be more descriptive

Also look at section "(5) Sign your work"
This is to make sure you're legally allowed to send in the patch,
i.e. you're doing it on your own time or your employer allowed you to
send code here to the mailing list.


> 
> ---
>  git-cvsexportcommit.perl | 2 +-
>  1 file changed, 1 insertions(+), 1 deletion(-)
> 
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index d13f02d..bf41a72 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -309,7 +309,8 @@ foreach my $f (@files) {
>  	while (<FILTER_IN>)
>  	{
>  	    my $line = $_;
> -	    $line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$$1\$/g;
> +	    $line =~ s/\$(Author|Date|Header|Id|Locker|Log|RCSfile|Revision|Source|State):[^:\$][^\$]+\$/\$$1\$/g;
>  	    print FILTER_OUT $line;
>  	}
>  	close FILTER_IN;
> --
> 2.1.1.303.ga330961.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
