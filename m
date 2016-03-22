From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 07:10:37 +0100
Message-ID: <CAP8UFD0tSffjJJ-kDdN6aWC6bTP3LJWjtAAFP-1s0qVH_wVx1g@mail.gmail.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 07:10:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiFWh-0007x2-KG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 07:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbcCVGKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 02:10:40 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35593 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcCVGKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 02:10:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so137147800wml.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kHCeDPg2AB0D4+3dZxCuIXiw5BDReODHG3X91RyE9Ds=;
        b=M+Qq2oKpUfKRdGXF/giR1A2AINS4hNVDIl1dVuVdjYlo7mHBA2QcntDup3jAn2Q6ql
         yP8OKn6ZBZOmRR+hcAz7xTx3tjDTh9Mt1sPkG8vb0BvGYQGGQ7Ad+u69UofM0lE8og1Q
         lmrKQ5KJ38XuXXjs4MhkFyy+wMMkAIPQ2ADuYXyj6BYiLbtGSPgvLL6rTcADI++/8LJ3
         nNXEvV8aNQ7UAXPrYDgIUyuEd+lxLv9SxuH2eCFG7G75Fq235hvy61btVlXl6Z3mcUBv
         QqgfMhqg9JukmwGmjh7r7wWxuZW1S1Qtqg1WxqYYr+0wTBB0n975k7BdL6rChhAgS7Q6
         gHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kHCeDPg2AB0D4+3dZxCuIXiw5BDReODHG3X91RyE9Ds=;
        b=ajnYBclDSilWRZXhKcWZku5kjWdMdCUwcFQMb2oXl683c7+MZEFxCWWQmKKzeyrH7z
         3iIW9mhL09vhjBoOfYLPoISfu6AV5KfYOnjvL4fZBB+qA7sQSJlKxIRocOFlmyFLfviL
         tqfvvPtXIQWNmINbcKl6y4M7tPsrCVaWf+GKtReK0HWHmnjtjc4GvYaUo7o3S94TIgvI
         RzdFZk5ZuLImi7MEIIjonMnzgx3f64O8N8W5fstfWr7CgQnTrmSTyvAb2b9J4uaNdlku
         1tijIT7qSuGC4BYVcBFw6ga/VL51j5F2pY4TvFEIIfmJazSp4lOJy3y5HmkKDhPH3dKp
         hwOg==
X-Gm-Message-State: AD7BkJLZaDRokgO/H9avPNXM8/q/gCO8eJdhTGuKeb0rhO/Na3Ufy1a2cpsW1/wN6hIq2uMR5uf/yI40b/pGmg==
X-Received: by 10.28.180.9 with SMTP id d9mr18897628wmf.62.1458627037670; Mon,
 21 Mar 2016 23:10:37 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Mon, 21 Mar 2016 23:10:37 -0700 (PDT)
In-Reply-To: <CAGZ79kZveu07h_vERFpJekp4ayJwytwoNVG0LbhiaCnt4u-jRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289487>

On Tue, Mar 22, 2016 at 1:28 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Mar 21, 2016 at 12:00 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Convert the code literally without changing its design even though it
>> seems that its obscure as to the use of comparing revision to different bisect
>> arguments which seems like a problem in shell because of the way
>> function arguments are handled.
>
> How would I use the C version instead of the shell version now?

Hint: one can look at how other functions in builtin/bisect--helper.c are used.

> I'd imagine you'd want to change calls in git-bisect.sh from
>     check_term_format <term> <bad/new>
> to be:
>     git bisect--helper check_term_format <term> <bad/new>

Hint: to get a good idea of how the call should be, one can look at
the way "git-bisect.sh" already calls "git bisect--helper".

> and "git bisect--helper" would then call the new static method?
> Once you have the C version working (do we need additional tests
> or can we rely on the test suite being enough for now?),
> you can also delete the shell version.
