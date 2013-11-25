From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 12:35:57 -0800
Message-ID: <20131125203557.GP4212@google.com>
References: <878uwc2r7c.fsf@thomasrast.ch>
 <89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
 <20131125201200.GN4212@google.com>
 <87wqjw1bm5.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2tA-00008E-BO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab3KYUgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:36:09 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:56562 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3KYUgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:36:06 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so3303226yha.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BJaYWoUfh18ZJGuPmlRMt3CECRtlU1ImodI0A1qrWqA=;
        b=MVaNqfEvxEQYNOkyT9mRC1OmdGz5NpFJNf8reQy4CWRT3DT7F88qTg7sGN4CX+nF/+
         UqHsPEhcv27Z8rqh9wwi+xUdtRezVnADSOJu/x7ln3bnX88LWWl2YMscWCqsy40zvGGr
         KFllcQ6N3hWPxAnVZSxUxJ8b/dlUqXvgkAoiDa6YeaUALynccwKmKlMKd9g8bRPSC6bc
         5zFIskvXVqHsAQdNbnBQWYGK+k9lwqafgVIFK27iZ4dRmzFCUWJ3Ea6/V6wJulG4GTt+
         64cXoHNcAZntiI5K5VmFCbUdWPxcKhh4gQnZOxE6lxWSR2vejnWdP+hLpLYSSQCGZn8T
         E3uQ==
X-Received: by 10.236.91.201 with SMTP id h49mr92344yhf.96.1385411761285;
        Mon, 25 Nov 2013 12:36:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm77893792yhg.8.2013.11.25.12.35.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:36:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87wqjw1bm5.fsf@thomasrast.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238345>

Thomas Rast wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Thomas Rast wrote:

>>> This shuts up compiler warnings about unused functions.
>>
>> If that is the only goal, I think it would be cleaner to use
>>
>> 	#define MAYBE_UNUSED __attribute__((__unused__))
>>
>> 	static MAYBE_UNUSED void init_ ...
>>
>> like was done in the vcs-svn/ directory until cba3546 (drop obj_pool,
>> 2010-12-13) et al.
>>
>> I haven't thought carefully about whether encouraging inlining here
>> (or encouraging the reader to think of these functions as inline) is a
>> good or bad change.
>
> Hmm.
>
> I actually had this idea after seeing the same trick in khash.h.  Is
> __atribute__((__unused__)) universal?  If so, maybe we could apply the
> same also to khash?  If not, I'd rather go with the inline.

The khash functions are very small, so it very well may make sense for
them to be inline.

git-compat-util.h (or compat/msvc.h) defines __attribute__(x) to an
empty sequence of tokens except on HP C and gcc.  Attribute unused has
existed at least since GCC 2.95.

Unfortunately HP C doesn't support attribute __unused__. :(
http://h21007.www2.hp.com/portal/download/files/unprot/aCxx/Online_Help/pragmas.htm#Attributes

On the bright side, it would be easy to work around using a
conditional definition of MAYBE_UNUSED for the sake of HP C.  From
August 2010 until March 2011 nobody noticed.

Jonathan
