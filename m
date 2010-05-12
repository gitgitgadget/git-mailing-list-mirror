From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v2] autocrlf: Make it work also for un-normalized repositories
Date: Wed, 12 May 2010 08:33:22 +0200
Message-ID: <75EA5FF3-4F82-4261-AF2A-D6E7182EECE5@gmail.com>
References: <20100511223757.GB16974@pvv.org> <20100512061646.GL14069@dpotapov.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 08:40:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC5cQ-00087w-EC
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 08:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab0ELGk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 02:40:28 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:54030 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab0ELGk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 02:40:27 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2010 02:40:27 EDT
Received: by ewy8 with SMTP id 8so1677863ewy.28
        for <git@vger.kernel.org>; Tue, 11 May 2010 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=bi+vHJKsV8ERUcpa6SPse9nZS/buCSE+gYfYkc/miQ4=;
        b=nOFYvzlh162k3Ndpou/bzOdV8I64XicvVjSfUc/xalyBfTchLK4mAJL4FXOK2nwFgi
         lQ5AyuADWszmWLEIzXjCWvlTNp0F5e+auYtpkiQIfW21ur+iOYSqomsZV/HS7/HNwCMq
         A9SnhiU+kkDEaUdWO+oDA6icMw762yZY2MdPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=UvXcjFYeEB//S6I+D/jw8Y9tEl1UQDx77h0O5t+x0OW/q7ThWmdMbSJ3+8KKL00x9f
         MNMA1+0AJfU+77ljDgjT4mrAreiXEbcAcG0aVcvyXhQchZ6g/qeSBh7foNbjmk8qdR27
         3b9rjebCN9VPXtjZV1EEQt4wKTu8SJjL9k0vM=
Received: by 10.213.52.201 with SMTP id j9mr2937281ebg.87.1273645954051;
        Tue, 11 May 2010 23:32:34 -0700 (PDT)
Received: from [77.16.251.138] (77.16.251.138.tmi.telenormobil.no [77.16.251.138])
        by mx.google.com with ESMTPS id 16sm3571811ewy.3.2010.05.11.23.32.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 23:32:33 -0700 (PDT)
In-Reply-To: <20100512061646.GL14069@dpotapov.dyndns.org>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146924>

On 12. mai 2010, at 08.16, Dmitry Potapov <dpotapov@gmail.com> wrote:

> On Wed, May 12, 2010 at 12:37:57AM +0200, Finn Arne Gangstad wrote:
>> @@ -203,6 +247,11 @@ static int crlf_to_worktree(const char *path,  
>> const char *src, size_t len,
>>        return 0;
>>
>>    if (action == CRLF_GUESS) {
>> +        /* If we have any CR or CRLF line endings, we do not touch  
>> it */
>> +        /* This is the new safer autocrlf-handling */
>> +        if (stats.cr > 0 || stats.crlf > 0)
>> +            return 0;
>> +
>>        /* If we have any bare CR characters, we're not going to  
>> touch it */
>>        if (stats.cr != stats.crlf)
>>            return 0;
>
> If there is no CR then there is no CRLF and certainly no bare CR
> characters. So, all above checks can be replaced with one:
>
>        if (stats.cr > 0)
>            return 0;
>
> Other than that, I really like your patch.

Keeping the tests separate helps merging with my patch. The idea is to  
not do the "safe autocrlf" test when crlf=auto, so in that case the CR  
test is still needed.
-- 
Eyvind
