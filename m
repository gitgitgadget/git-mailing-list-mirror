From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Fri, 3 Apr 2015 15:24:09 -0700
Message-ID: <CDAB9DBC-0F59-4176-BD9F-620A124EA300@gmail.com>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com> <20150330221635.GB25212@peff.net> <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c> <20150403012430.GA16173@peff.net> <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com> <20150403220821.GB11220@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Yi, EungJun" <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeA0f-0006eM-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbDCWYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:24:13 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33721 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbDCWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:24:12 -0400
Received: by pdbnk13 with SMTP id nk13so54001462pdb.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=CL2tkCcKUS9OP0MJ0W5uohJ8mcqKhx75XekuRKRswMg=;
        b=1BUBUidua38YZkFTBgzDbyM6cmFSNaSPil7khqG2EQiaYZHedV+ypuGbaay7J8rUgK
         NWlaV0rchO1H0aO1gP/6msr72swT2l6CvHnA05qTyTMnmsL09CoAsELTobW+TA2VUJkX
         EuStA7RuEgxxpr9fPo9LuHAyYxdhL8lXCEsfpMGdgAgl9tO4QwA2JbEGT+Nig6LXYsSC
         PgMptc6ZPUR9UXOeYr2uOiGgpDhj9tyEUive1uczrEzl8yfNaXHxrvIDQ3Iaxogio8Fl
         03y19L/Pu73zYpHVwV1KNCv8WuG5Yi7GX+tW5TjCFyUVgFITKq6i1uxF3QEpB3xQdJhO
         n4Rg==
X-Received: by 10.66.149.106 with SMTP id tz10mr7603489pab.90.1428099852340;
        Fri, 03 Apr 2015 15:24:12 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id o6sm9074305pds.38.2015.04.03.15.24.11
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 Apr 2015 15:24:11 -0700 (PDT)
In-Reply-To: <20150403220821.GB11220@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266742>

On Apr 3, 2015, at 15:08, Jeff King wrote:
> Doing:
>
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff- 
> highlight/diff-highlight
> index 08c88bb..1c4b599 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -165,7 +165,7 @@ sub highlight_pair {
> sub split_line {
> 	local $_ = shift;
> 	return map { /$COLOR/ ? $_ : (split //) }
> -	       split /($COLOR*)/;
> +	       split /($COLOR+)/;
> }
>
> sub highlight_line {
>
> gives me a 25% speed improvement, and the same output processing
> git.git's entire "git log -p" output.
>
> I thought that meant we could also optimize out the "map" call  
> entirely,
> and just use the first split (with "*") to end up with a list of  
> $COLOR
> chunks and single characters, but it does not seem to work. So maybe I
> am misreading something about what is going on.

I think our emails crossed in flight...

Using just the first split (with "*") produces useless empty elements  
which I think ends up causing problems.  I suppose you could surround  
it with a grep /./ to remove them but that would defeat the point of  
the optimization.

-Kyle
