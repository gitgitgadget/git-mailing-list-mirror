From: "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 7 Apr 2016 20:58:09 +0200
Message-ID: <5706ADC1.7030709@jupiterrise.com>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:59:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoF9M-0004OA-6T
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbcDGS7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:59:20 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:33500 "EHLO
	homiemail-a16.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509AbcDGS7S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2016 14:59:18 -0400
X-Greylist: delayed 2387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Apr 2016 14:59:18 EDT
Received: from homiemail-a16.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a16.g.dreamhost.com (Postfix) with ESMTP id 170B0401F321;
	Thu,  7 Apr 2016 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
	:to:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=jupiterrise.com; bh=z
	xq6S3gDF5aI39PBTv9Pg5KOj2E=; b=jL8X0V7ARdPux/fXNjJkm3pGFwd2janPp
	Oq1f0ajqj58M9CRKhuHEJROzJPE7Q1eLBBo3Aq2jHAyRG41lztiLu0DnO5yW39lW
	RYIr2mzCNQbxlGrVNmfFEvhc6UX1JpQ6duNZRS9/yniuZB9oQAu66hezxon93v7k
	51zOsq5fco=
Received: from localhost6.localdomain6 (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tgc99@jupiterrise.com)
	by homiemail-a16.g.dreamhost.com (Postfix) with ESMTPSA id 44C68401F33E;
	Thu,  7 Apr 2016 11:58:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u37Iw9iC008892;
	Thu, 7 Apr 2016 20:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290948>

On 07/04/16 20:32, Junio C Hamano wrote:
> "Tom G. Christensen" <tgc@jupiterrise.com> writes:
>
>> The reason for the crash is simple, a null value was passed to the 's'
>> format for the *printf family of functions.
>> ...
>> Passing a null value to the 's' format is explicitly documented as
>> giving undefined results on Solaris, even on Solaris 11(2).
>
> Do you mean
>
> 	*printf("...%.*s...", ..., 0, NULL, ...)
>
> i.e. you saw a NULL passed only when we use %.*s with width=0?
>

Maybe? Not sure what you're asking exactly.

I'm seing what is in the backtrace from gdb and that is prefix is NULL 
(0x0) which ends up being printed using some variant of '%s' after going 
through the various wrappers.

I hacked around it in run_builtin() as a proof and have also made some 
experiments with working around it in setup_git_directory_gently() which 
got me a bit further but it looks like there are places that do 
if(prefix) which now does not behave as expected because prefix is not NULL.

-tgc
