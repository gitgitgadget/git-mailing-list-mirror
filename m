From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [RFC/PATCH] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Tue, 31 May 2016 12:10:58 +0530
Message-ID: <CAFZEwPMKQ6JtaNvoexzGqWRphqEgXBXn-PSrkUaPLzs6phM4Ww@mail.gmail.com>
References: <20160530182148.18801-1-pranit.bauva@gmail.com>
	<574D122F.7080608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 31 08:41:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dMO-0003O3-GY
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbcEaGlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:41:00 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33304 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcEaGk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:40:59 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so17531724ywe.0
        for <git@vger.kernel.org>; Mon, 30 May 2016 23:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LUzs6yKKACFLh4haogmeSVnMx4C+23qt0B9J4eAH+wI=;
        b=QjsnoeC/19Uo+jf6hwDPftMfBtO8vLvAkFaE11PQHtmwyD/5PC06YgTIeSR8Uv/JVO
         yemn/zM7tBwhv3c0UVHb9OAXla0ZiQqBpsdY0RGrkrhIGteyLqTK6Zf7S4JrlO3NbdDp
         5GGQe/fJjd+qSDdzM9qSvLMrplNSlsOBfwjYVgW2/rfzmXMuq8zusvCY5+H5uPsnmHYm
         enxZ2MTwb3Gn1IV1iB5g9y9lDvx/zdsOOUC0M9xR9RzSw25nCVaRlXNlUL7n1jaUyF45
         PlrQnJiI4SUwa5z4tv51ulbvgwVfgLV6uX5IjhcLNAiLdaYo0k5mjWDFt1fqB+VkLrw6
         GFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LUzs6yKKACFLh4haogmeSVnMx4C+23qt0B9J4eAH+wI=;
        b=KeI3K6MrEjaaZzA27mS1d0yJrg+0h8AI03CGEH58Y8Ceb03h1CpoB3cynD5UTLWadM
         XvwVg8vtbDvVVr3/IVk/MCxsUrvIYfRLiW4bAEh6SigmxrVA3tYFGvtw7XJSoPBaW9nk
         u7z0MqYJYiuVQ9ZKXb5LoXXb21sGHep7MJNvLmlyNrtBIUkhHpeVxtsIEnbg3gKL7x8o
         jLvzew/kWBgnokhB6rBY7AztPKLiyfAIpWDZaTTY2Stieo0PKNBs6DdH6FYZcCshwSuo
         yF3U4jhr8Hu+rk7wsTJUGxBe7DEIzpDFEm37w30Ke5aN4L3vHD4jp3jd9JxOfOFS2ath
         1vxg==
X-Gm-Message-State: ALyK8tJZKA2BWcBnJSRviWFbyrjND1K9RJ1Zt4IYY7S8wuify9wxBkufZdSGQ4ZOsuyqAIv5soRwg2WVxn5Pyg==
X-Received: by 10.129.90.135 with SMTP id o129mr20895999ywb.20.1464676858292;
 Mon, 30 May 2016 23:40:58 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Mon, 30 May 2016 23:40:58 -0700 (PDT)
In-Reply-To: <574D122F.7080608@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295958>

Hey Michael,

On Tue, May 31, 2016 at 9:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/30/2016 08:21 PM, Pranit Bauva wrote:
>> Reimplement `bisect_clean_state` shell function in C and add a
>> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh .
>>
>> Using `bisect_clean_state` subcommand is a measure to port shell
>> function to C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by
>> bisect_reset() and bisect_start().
>>
>> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> This patch contains a bug. I have tried to identify the bug and I suppose it
>> exists in do_for_each_entry_in_dir(). I have reproduced the debugging session
>> at this link[1]. I have seen that some patches in mailing list regarding
>> iterating over refs. Will those affect this? Or is this bug fixed in those
>> patches?
>
> The problem is that it is not legal to modify references while iterating
> over them. See [1]. Your remove_bisect_ref() callback function deletes
> references, which modifies the reference cache that is being iterated over.

Thanks for explaining this. I wasn't aware about this.

> Instead I suggest that your remove_bisect_ref() add the references to a
> string_list, then call delete_refs() *after* the iteration is over.
> Alternatively, you can change remove_bisect_ref() to call
> ref_transaction_delete() to add reference deletions to a
> ref_transaction, then call ref_transaction_commit() after the iteration
> is over. See the rm() function in builtin/remote.c [2] for an example.

I have gone through the links and I think I will stick with the first
one because I don't see how the latter one would be better.

> [1]
> https://github.com/git/git/blob/f3913c2d03abc660140678a9e14dac399f847647/refs.h#L176-L184
> [2]
> https://github.com/git/git/blob/f3913c2d03abc660140678a9e14dac399f847647/builtin/remote.c#L738
>
>> [...]
>

Regards,
Pranit Bauva
