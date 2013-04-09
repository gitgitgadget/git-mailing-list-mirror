From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: --immediate skips cleanup commands for failed
 tests
Date: Tue, 09 Apr 2013 12:16:56 -0700
Message-ID: <7vli8rqztj.fsf@alter.siamese.dyndns.org>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
 <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
 <20130407193415.GB13708@ruderich.org> <20130407223200.GF19857@elie.Belkin>
 <20130409131802.GA25673@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:17:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPe2S-0003Ex-5z
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935754Ab3DITQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 15:16:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761556Ab3DITQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B3E15EB5;
	Tue,  9 Apr 2013 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qVuvZneQluoEy4Ldm6geySyV7I=; b=ifgQAo
	FKfqjnjI95zKr1jb84Pealhpd/lCUGiDXUEebIu5zQuPIvc3vZmNLq7mJSmqFNXd
	8hz0wc3hLxrt8QjTKniAxE1Di14lklf7DssTmJiI/2oe6DAfoSLZRZKkdQTcAe53
	leXd7WRlimlvpvuapOgWRPX3J1P6K15kh6XUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ql7nwY3cvbgWFzczBrvUMm+R37Q8zjYE
	p3l5Ek9X7bFdDfua3zs/HFse5XDQ2WNaR+yT35cUfhfp5UUlQYkBGCVfxUoKToQE
	X1owCKjWwAACRDD56roFq8IgLWI4riJKC9AvUNgXXEaXv0Izi71mUHn5KQDH+Z2P
	n5soalHNWTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5B815EB4;
	Tue,  9 Apr 2013 19:16:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D169815EB1; Tue,  9 Apr
 2013 19:16:57 +0000 (UTC)
In-Reply-To: <20130409131802.GA25673@ruderich.org> (Simon Ruderich's message
 of "Tue, 9 Apr 2013 15:18:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C30238A-A14A-11E2-8341-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220619>

Simon Ruderich <simon@ruderich.org> writes:

> On Sun, Apr 07, 2013 at 03:32:00PM -0700, Jonathan Nieder wrote:
>>> I'm not sure if it's better to use test_when_finished with rm or
>>> just && rm -rf tmp at the end of the test in case someone wants
>>> to look at the output.
>>
>> test_when_finished is better here, since it means later tests can
>> run and provide useful information about how bad a regression is.
>> Cleanup commands requested using test_when_finished are not run when a
>> test being run with --immediate fails, so you can still inspect output
>> after a failed test.
>
> Hello Jonathan,
>
> Thanks for the explanation.
>
> I couldn't find this documented in t/README, the following patch
> adds it.
>
> -- 8< --
> Subject: [PATCH] t/README: --immediate skips cleanup commands for failed tests
>
> ---

Sign-off?

>  t/README | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/README b/t/README
> index 9b41fe7..e5e7d37 100644
> --- a/t/README
> +++ b/t/README
> @@ -86,7 +86,8 @@ appropriately before running "make".
>  
>  --immediate::
>  	This causes the test to immediately exit upon the first
> -	failed test.
> +	failed test. Cleanup commands requested with
> +	test_when_finished are not executed if the test failed.

Perhaps adding "... to keep the state for inspection by the tester
to diagnose the bug" or something is in order?

>  
>  --long-tests::
>  	This causes additional long-running tests to be run (where
> -- 
> 1.8.2.481.g0d034d4
>
> -- 8< --
>
> Regards
> Simon
