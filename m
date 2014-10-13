From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo =
 bar"
Date: Mon, 13 Oct 2014 14:31:32 -0700
Message-ID: <20141013213132.GA32245@google.com>
References: <20141010060636.GA15057@peff.net>
 <20141010061114.GB15277@peff.net>
 <20141013161022.GA20520@google.com>
 <20141013211524.GB15969@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:31:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnDW-0003OV-RC
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbaJMVbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:31:43 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32893 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaJMVbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:31:42 -0400
Received: by mail-pa0-f51.google.com with SMTP id lj1so6521076pab.10
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+oeefQClfvlqtvv669G2t/jpnDDCRk2L603aslecAJE=;
        b=IKeP380ECgLBl9SZa4F/dG6PNnMbYDobuDZ7G5c0kj3nSYP+bhsanbgIpaOOHeW9pc
         p3T+04ho4590gX0yjnCFlwNPTvNbQ7BTwSNHOndifOYfTIM4LrcqEUOG4i6PfioMpdD8
         5R/vAQZAyZLwv4dwOPPnaDRHZpsDYQUT7bJGNvIKymGF0jlw9kqD4Cz4mhDrzj2FcCGv
         OWc0QgDMq3KsDsyF8XtITAxhr8AT1Ov334f78Dq5cFLtRHlGNpw7/6LIaaAjdPB2myiI
         ZYiRNB3gumf1AVjerxSDbRKtE31wYn6rStJ7sIGUH6UErky4dC3HIolAcIHeKAyxTWgX
         ooRQ==
X-Received: by 10.66.66.229 with SMTP id i5mr361030pat.137.1413235901437;
        Mon, 13 Oct 2014 14:31:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8888:f50:ddbf:ae59])
        by mx.google.com with ESMTPSA id fk10sm12233588pab.29.2014.10.13.14.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Oct 2014 14:31:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141013211524.GB15969@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 13, 2014 at 09:10:22AM -0700, Jonathan Nieder wrote:

>> There's another downside to that construct: it loses the exit
>> status from some_cmd.
>
> Yes, although I think in many cases it's not a big deal. For example,
> here we lose the exit code of count-objects, but it also is very
> unlikely to fail _and_ produce our expected output.

It could segfault after producing the good output, but sure,
count-objects code doesn't change very often.

[...]
> One of my goals was to provide a more generic helper so that we don't
> have to make little helpers like this for every command. So I'd much
> rather something like:
>
>   test_output () {
> 	printf "%s\n" "$1" >expect &&
> 	shift &&
> 	"$@" >output &&
> 	test_cmp expect output
>   }

I agree with the principle in general.

Unfortunately that wouldn't help here --- the "$@" is a command with a
pipe to sed in it and we still lose the exit status from
count-objects.

Hoping that clarifies,
Jonathan
