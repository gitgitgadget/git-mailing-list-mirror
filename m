From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Aug 2009, #04; Sun, 23)
Date: Mon, 24 Aug 2009 19:35:17 -0500
Message-ID: <si8ZJkqdFsO4XRM_8BlHbWAkdCptmCxCpXpvpVJRmxHJxLhqx5gCyw@cipher.nrlssc.navy.mil>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0908232117460.6044@xanadu.home> <YE4QMh4rA1r2X3ZG5TvGJZspm0UdCWyP-r6KFthp8PuFewAhHPJ3GQ@cipher.nrlssc.navy.mil> <7vy6p86f9y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 02:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfk0j-0002Ju-Js
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 02:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZHYAfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 20:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbZHYAfc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 20:35:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36682 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbZHYAfb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 20:35:31 -0400
Received: by mail.nrlssc.navy.mil id n7P0ZIex025192; Mon, 24 Aug 2009 19:35:18 -0500
In-Reply-To: <7vy6p86f9y.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Aug 2009 00:35:17.0526 (UTC) FILETIME=[EB491360:01CA251B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126985>

Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>> Nicolas is right, the code compiles and executes correctly on Solaris as-is.
>>
>> Here is the state of the two unsubmitted optimization patches:
>>
>>   1) Change things like __i386__ to __i386 since GCC defines both, but
>>      SUNWspro only defines __i386.
>>
>>      This works correctly in my testing.  I'm assuming that a test for
>>      __amd64 is not necessary and expect that __x86_64 is set whenever
>>      __amd64 is set.
>>
>>   2) Set __GNUC__ on SUNWspro v5.10 and up.
>>
>>      This compiles correctly and passes the test suite, but produces
>>      warnings for __attribute__'s that sun's compiler has not implemented.
>>      This produces a very noisy compile.
>>
>> I've wanted to do some performance testing to see whether this actually
>> produces an _improvement_.  I'll try today.
> 
> Thanks.
> 
> I agree (1) would be a reasonable thing to do.
> 
> (2) feels very iffy/hacky.  As far as I can see, by defining __GNUC__,
> Solaris would also use builtin-alloca in compat/regex/regex.c, which may
> or may not be what you want.
> 
> It might be cleaner to do:
> 
> 	#if __GNUC__ || SUNWspro > 5.10
>         #define GCC_LIKE_INLINE_ASM
>         #define GCC_LIKE_STMT_EXPR
>         #endif
> 
> and use them, instead of __GNUC__, to enable the inline assembly used in
> the block sha1 codepath.

Yes, this sounds saner, but alas it will have to be tomorrow...

-brandon
