From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Thu, 3 Dec 2015 14:17:01 -0800
Message-ID: <CAGZ79kYRVDLooqTR2fRzoOVs2u2TeOubF9-wX9YVEVqHMOfT3Q@mail.gmail.com>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
	<xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
	<46311B14CC814F54AC34764F2520947A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Naewe <stefan.naewe@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 23:17:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4cBz-0005t8-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 23:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbbLCWRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 17:17:04 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34302 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbLCWRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 17:17:03 -0500
Received: by ykfs79 with SMTP id s79so104129745ykf.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3F5shR0KUBI6pDIYL7NsoHQASIQiHqMA09E4TJS1cN8=;
        b=VanQPFtQfAcwPUvf9B8wFAOvhkV4iUP+6zMulBtSJTjIJwnig/NvK1zVLhFZfwW8EZ
         IRZZ+0LH1UglpopUMrwP36+d3U3U90eXBpRX/XuTZVlGJTdq4X/13BVb41WLrnbz9Tsc
         Bo0z9FHG8+0hlhivQsV4WU8p+I/Y3vfLsrQrm1MwFpyvfXzAN7lM8nt4bzY00jWPVW2P
         qKwJ2oUMyN6Z0/EYSB7AJWmu3qHDL6+fCTuZFYlnlmrW0Dd2fh4+/kJUA009GPxPJWxe
         3SAoQSXK1/59SOMNpnmQfPIgYLoulJuAaiv6fv+jKqT6p0U2A9Ou5/HnouDdy1ug6HNt
         qH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3F5shR0KUBI6pDIYL7NsoHQASIQiHqMA09E4TJS1cN8=;
        b=OOswwlC29j1a5NoxGLiC6f33IZ7CJSzptUrhD9xVefHHoYHhW8HNqx/HNJkddLKRzs
         IDI50PThAcNBdTwu9zQRebkRnnIPUR4581YgGHHj4mDxb8aNNbSHYsWWlaQNEFh8/4xe
         s44yV8P+edFVb83Vz+E0F9rbBjCSgSH12NditDawLYdj1YSem+T0KfTglj95Nt+sSuIe
         z4bCEiAgclVF8kVluU1lt25X3DYj6sN3JNOrTlNZ16JY4f3tvI2eB/Cp4HJ8gqBfJuAb
         hJyHm05gh382pzTpiBiiXtYRM92/wsfvfwMU7u4VLRtFwubECEZv7c148j8wRrr7LRqV
         XtTA==
X-Gm-Message-State: ALoCoQkY9j0KUGRz1fzIw012PTbKmh0gXBWlDhex7+zZgb1Lzz9ZG7jjeN57L4EFOMYyCVV35NqY
X-Received: by 10.13.214.19 with SMTP id y19mr8585829ywd.63.1449181021660;
 Thu, 03 Dec 2015 14:17:01 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Thu, 3 Dec 2015 14:17:01 -0800 (PST)
In-Reply-To: <46311B14CC814F54AC34764F2520947A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281976>

On Thu, Dec 3, 2015 at 1:34 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
>>
>> Stefan Naewe <stefan.naewe@gmail.com> writes:
>>
>>> Two functions dereference a tree pointer before checking
>>
>>
>> Reading them a bit carefully, a reader would notice that they
>> actually do not dereference the pointer at all.  It just computes
>> another pointer and that is done by adding the offset of object
>> member in the tree struct.

Well compiler people want their compiler to produce the best output,
meaning the compiled code goes fast.

So if you ask a compiler-writer, this may qualify enough for
being a dereference, because it looks like a dereference.

Assuming this is a dereference, you can further reason about
upcoming

  if (pointer)

As the pointer was already dereferenced, it can be assumed not NULL.
(the pointer being NULL would be undefined behavior, in which the
compiler can do whatever it wants, i.e. that case can be ignored)

So with the strong assumption of the pointer being not NULL, you
can optimize away an

  if (pointer)

as that is "always" false.

In case the pointer is NULL, we have had undefined behavior, so
the compiler is allowed to generate wrong code.

Which is why the if(pointer) is removed from the compiled binary,
as less instructions make the code go faster.

>
> But you can't do that computation (in the error case under consideration).
> Null can't be added to anything (as far as the implications of the standards
> go). These are horrid gotchas because they go against the grain of all that
> binary arithmetic and simplifications we learnt long ago.
>
> That said, the fact that we know it can't be null does save the day, until
> that is, the compiler [via some coding of an interpretation] decides that it
> could be null and thus undefined etc etc (which one would argue as poor
> logic, but standards have no truck with such arguments;-).
>
> There were some discussion on undefined behaviour way back (2013-08-08) when
> Stephan Beller looked at STACK's checking of the Git code, see for example
> http://article.gmane.org/gmane.comp.version-control.git/231945/
> "3 issues have been discovered using the STACK tool
> The paper regarding that tool can be found at
> https://pdos.csail.mit.edu/papers/stack:sosp13.pdf" (link updated)


Yeah that tool would detect such a bug. I can see
if I can get it to run frequently and post results somewhere.
IIRC it was quite a pain to get it working correctly on Git and
then reasoning for the resulting patch.

>
> All their source code is publicly available at
> http://css.csail.mit.edu/stack/

Thanks for pointing to that tool again. :)
