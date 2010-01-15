From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an   &quot;if&quot;
 more transparent
Date: Fri, 15 Jan 2010 08:20:27 +0100
Message-ID: <4B50173B.5030802@gnu.org>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu> <loom.20100114T164214-897@post.gmane.org> <7v8wc0fuqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 08:20:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVgUC-0002os-7d
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 08:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab0AOHUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 02:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200Ab0AOHUc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 02:20:32 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:36457 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0AOHUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 02:20:31 -0500
Received: by fxm25 with SMTP id 25so273477fxm.21
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 23:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=d7uQcwwqlBm18JMPX2d3cMRuk6WShboT4jytda+ZSnE=;
        b=Kk+ZWKDwXgk8sUvFSYPYXr6NjcC3SSWbYIUkGQ8O/RweJAhiZbyp4KMSS8S3bWOk3K
         XWHMp4aZbWh1dm1RQTRBZ5vSG9La7FLtUzTemUrrUuEiGu3smtWUXBTEgb7GnnyqGRSU
         S58vHUo0Rcq6FctTdrwmMT5WQSKmJKPEPkYUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tIq6TPDLfGfM7i981Kwfh90CKtRyel52GS2IpKDzS7TE6Fdl3wVxhT4L4K9kxdVPbi
         m8l8GayoBlqblqa9vOSv4QmZ9EhUNAoJ2NQXShPhdelgWDiPyygeUSP+WrC6Mjgd8jxV
         M1hZTgOTp/W7/9YcVXrHE9zbpqxFeeGMlogB0=
Received: by 10.223.32.206 with SMTP id e14mr2438563fad.3.1263540030125;
        Thu, 14 Jan 2010 23:20:30 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 26sm964217fks.50.2010.01.14.23.20.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 23:20:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <7v8wc0fuqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137056>

On 01/14/2010 06:42 PM, Junio C Hamano wrote:
> Eric Blake<ebb9@byu.net>  writes:
>
>> Michael Haggerty<mhagger<at>  alum.mit.edu>  writes:
>>
>>>   	current_sha1=$(git rev-parse --verify HEAD)
>>> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
>>> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
>>
>> 'test cond1 -a cond2' is not portable.  Use 'test cond1&&  test cond2'.
>
> I avoid "test -a/-o" myself without even thinking (I am from old-school),
> but at the same time I thought the progress in the world made such caution
> obsolescent.
>
> Not so.  Even though POSIX.1 lists -a/-o as options to "test", they are
> marked "Obsolescent XSI" ("Strictly Conforming POSIX Applications and
> Strictly Conforming XSI Applications shall not use obsolescent features").

The reason for this is that the precedence rules were never well 
specified, and this made many sane-looking uses of "test -a/-o" problematic.

For example, if $x is "=", these work according to POSIX (it's not 
portable, but in practice it's okay):

   $ test -z "$x"
   $ test -z "$x" && test a = b

but this doesn't

   $ test -z "$x" -a a = b
   bash: test: too many arguments

because it groups "test -n = -a" and is left with "a = b".

Similarly, if $x is "-f", these

   $ test "$x"
   $ test "$x" || test c = d

correctly adds an implicit "-n", but this fails:

   $ test "$x" -o c = d
   bash: test: too many arguments

If anybody cleans up git's usage of test -a/-o, feel free to cut'n'paste 
the above into the commit messages.

Paolo
