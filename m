From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 15:02:55 +0530
Message-ID: <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
	 <4933A922.7080300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:34:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L75AT-0004xD-N4
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYLAJc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYLAJc5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:32:57 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:49465 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYLAJc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:32:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2381332rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 01:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Z2MIiF2GWOfZ/0SNb/9gW6RTB2hUlggkb/L5aVWHLbw=;
        b=v70i+SFbQWmtzXz9pY8Vz7tHpx+Gek6uj1W/3nq8uueL79Z8/kW+oHdL/FITAFij5b
         up53jlrTqZ65DxOkAf4o7UjpX1679hV2/vZSBgvCC8wYB7gfH3v3GCwD0UC5upRAZWpy
         zatZyO/L7azSL0GWoMfagU6O+M1vsOVg+q/MA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jNrHUuTiXynunhLnySR+UpvP2+2QtRYuL866c60ieIHNSvbEC7jzNrbVe2vuJLsRfH
         Wq67dPUeqorFgvqnJglMeYmwhuWkcfrN1fqI27MqlyD897h4QWyFn5nl7Gx7pMbRtNHi
         I58yxdoT9hZz+HlAMpp+ku6S+TzP1qyditZZ8=
Received: by 10.142.14.18 with SMTP id 18mr4440713wfn.215.1228123975824;
        Mon, 01 Dec 2008 01:32:55 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 01:32:55 -0800 (PST)
In-Reply-To: <4933A922.7080300@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102011>

On Mon, Dec 1, 2008 at 2:36 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> dhruva schrieb:
>> Hello,
>>  I build git on msys environment regularly. With the recent changes to
>> add cache preload facility (commit ID:
>> 671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on
>> pthreads. This is not available in the msys distribution which was
>> part of the git build distro. I installed libpthread for mingw to get
>> the related headers and libraries. I had to make some minor changes to
>> libpthread installation. I copied the 'setjmp.h' from my other mingw
>> installation and had to had edit it to remove some mingw specific
>> macros.
>>
>> @:/e/users/dhruva/stub/repo/git/git
>> [520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h
>> --- /e/tools/gnu/include/setjmp.h       Sun Oct  5 04:01:15 2008
>> +++ /mingw/include/setjmp.h     Sun Nov 30 16:18:00 2008
>> @@ -36,7 +36,7 @@
>>   * The function provided by CRTDLL which appears to do the actual work
>>   * of setjmp.
>>   */
>> -_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf);
>> +int __cdecl _setjmp (jmp_buf);
>>
>>  #define        setjmp(x)       _setjmp(x)
>>
>> @@ -44,7 +44,7 @@
>>   * Return to the last setjmp call and act as if setjmp had returned
>>   * nVal (which had better be non-zero!).
>>   */
>> -_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int)
>> __MINGW_ATTRIB_NORETURN;
>> +void __cdecl longjmp (jmp_buf, int);
>>
>>  #ifdef __cplusplus
>>  }
>>
>> Also,
>>  had to copy a pthread library with a dfferent name to the standard name:
>> $cp libpthreadGC2.a libpthread.a
>>
>> The build went fine and am using the new binaries.
>
> Would you please push your addition to the mob branch of
> git://repo.or.cz/msysgit.git? The push URL is repo.or.cz:/srv/git/msysgit.git
>
> (But notice that some commits are on the mob branch currently that are not
> in any other branch; hence, you better build on top of them so that they
> are not lost when you push to mob.)
>
> -- Hannes
>

I am not using git from the above repo. I am using it from:
git://git2.kernel.org/pub/scm/git/git.git

I will clone from the repo you have mentioned and push my changes,
that will take some time. I have started the clone now...

-dhruva

-- 
Contents reflect my personal views only!
