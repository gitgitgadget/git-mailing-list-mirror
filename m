From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC 0/3] compiling git with gcc -O3 -Wuninitialized
Date: Sat, 15 Dec 2012 11:49:25 +0100
Message-ID: <50CC55B5.8000205@kdbg.org>
References: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 11:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjpJZ-0006iQ-3H
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 11:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab2LOKt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 05:49:29 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:10538 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2LOKt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 05:49:28 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 98737CDF84;
	Sat, 15 Dec 2012 11:49:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 706A519F430;
	Sat, 15 Dec 2012 11:49:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121214220903.GA18418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211528>

Am 14.12.2012 23:09, schrieb Jeff King:
> Can anybody think of a clever way to expose the constant return value of
> error() to the compiler? We could do it with a macro, but that is also
> out for error(), as we do not assume the compiler has variadic macros. I
> guess we could hide it behind "#ifdef __GNUC__", since it is after all
> only there to give gcc's analyzer more information. But I'm not sure
> there is a way to make a macro that is syntactically identical. I.e.,
> you cannot just replace "error(...)" in "return error(...);" with a
> function call plus a value for the return statement. You'd need
> something more like:
> 
>   #define RETURN_ERROR(fmt, ...) \
>   do { \
>     error(fmt, __VA_ARGS__); \
>     return -1; \
>   } while(0) \
> 
> which is awfully ugly.

Does

  #define error(fmt, ...) (error_impl(fmt, __VA_ARGS__), -1)

cause problems when not used in a return statement?

-- Hannes
