From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [msysGit] quick question about __stdcall at run-command.c mingw.c
Date: Mon, 17 Aug 2009 09:52:18 +0200
Message-ID: <4A890C32.6010507@viscovery.net>
References: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com> <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@googlemail.com>, Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcx12-0002Xb-Vl
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbZHQHwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZHQHwU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:52:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20303 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZHQHwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:52:20 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mcx0s-0007Ux-MO; Mon, 17 Aug 2009 09:52:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1404DC6C2; Mon, 17 Aug 2009 09:52:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126135>

Pat Thoyts schrieb:
> 2009/8/17 Frank Li <lznuaa@gmail.com>:
>> I am tring to clear VC build patch.
>>
>> I found __stdcall position break MSVC build.
>>
>> static __stdcall unsigned run_thread(void *data)
>>
>> MSVC require __stdcall should be between return type and function name.
>> like
>> static unsigned __stdcall run_thread(void *data)
>>
>> I think msys gcc should support MSVC format.
>>
>> Should I directly change to MSVC format or add _MSC_VER marcro like
>>
>> #if defined(__MINGW32__)
>> static __stdcall unsigned run_thread(void *data)
>> #elif defined(_MSC_VER) /*MSVC must put __stdcall between return value
>> and function*/
>> static unsigned __stdcall run_thread(void *data)
>> #endif
> 
> The win32 api prototype used for thread entry functions is declared as
> a DWORD (WINAPI *LPTHREAD_START_ROUTINE)(LPVOID) type in the mingw
> headers and WINAPI as #define WINAPI __stdcall. This is true for the
> MSVC headers as well. So gcc and msvc are happy using the same
> definition for such a function and just "static unsigned long WINAPI
> run_thread(void *)" might well be sensible.

Change the code to

	static unsigned __stdcall run_thread(void *data)

The documentation explictly says: "The routine at start_address passed to
_beginthreadex must use the __stdcall calling convention...". So __stdcall
it is.

-- Hannes
