From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Tue, 16 Apr 2013 20:03:22 +0200
Message-ID: <516D926A.70106@kdbg.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com> <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org> <7v4nf7qzkd.fsf@alter.siamese.dyndns.org> <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com> <7vsj2rpj0j.fsf@alter.siamese.dyndns.org> <CABPQNSZwc8Ae_fGwvyEq84NuBNntB7-KXnJtqt9ZLowCJof9Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 16 20:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAEG-00063I-VC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163Ab3DPSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:03:29 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:13731 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936036Ab3DPSD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:03:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C18F813005A;
	Tue, 16 Apr 2013 20:03:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1DAD419F542;
	Tue, 16 Apr 2013 20:03:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CABPQNSZwc8Ae_fGwvyEq84NuBNntB7-KXnJtqt9ZLowCJof9Gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221438>

Am 16.04.2013 16:39, schrieb Erik Faye-Lund:
> On Mon, Apr 15, 2013 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> This is absolutely the right thing to do. However, stuff have changed
>>> a bit since the patch was written; this change now needs to go in
>>> config.mak.uname instead of config.mak.
>>
>> Thanks for a quick response.
>>
>> What's your preference?  I could just ignore a patch I won't be able
>> to test myself and have you guys carry it in your tree forever, but
>> I do not think that is necessary for something small like this.
> 
> I should probably clarify; conceptually, this is the right thing to
> do. Git for Windows is a Windows application, and should have CRLF as
> the native newline. I hadn't tested this patch myself, though. Our
> tree is currently way behind yours, and I tried to do a rebase, but it
> turned out much trickier than I was hoping for.
> 
> I've given it a go on top of your tree + some essential patches I'll
> need to get things to run, and it seems to do what it claims to do.
> However, I haven't been able to run the test-suite, because I need a
> bunch more patches from the msysGit-tree for that.

I have been using this patch or an equivalent one since at least one and
a half years (until a month or two ago, as I discovered today, but that
is only by accident). But I do not use any text attributes or eol
configuration, so I can only say that it does not regress this use case.

> 
>> I think this is low impact enough that it can directly go to
>> 'master' or even 'maint' if I were to apply to my tree.
>>
> 
> I agree. I don't think we need it in maint; we don't track that branch
> for msysGit.

Yes, master is good enough.

Thanks.

> 
>> Thanks.
>>
>> -- >8 --
>> From: Jonathan Nieder <jrnieder@gmail.com>
>> Date: Sat, 4 Sep 2010 03:25:09 -0500
>> Subject: [PATCH] convert: The native line-ending is \r\n on MinGW
>>
>> If you try this:
>>
>>  1. Install Git for Windows (from the msysgit project)
>>
>>  2. Put
>>
>>         [core]
>>                 autocrlf = false
>>                 eol = native
>>
>>     in your .gitconfig.
>>
>>  3. Clone a project with
>>
>>         *.txt text
>>
>>     in its .gitattributes.
>>
>> Then with current git, any text files checked out have LF line
>> endings, instead of the expected CRLF.
>>
>> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Cc: Johannes Sixt <j6t@kdbg.org>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  config.mak.uname | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index 9080054..d78fd3d 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -507,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>                 compat/win32/dirent.o
>>         EXTLIBS += -lws2_32
>>         PTHREAD_LIBS =
>> +       NATIVE_CRLF = YesPlease
>>         X = .exe
>>         SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
>>  ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>> --
>> 1.8.2.1-542-g3613165
>>
> 
> Looks fine to me.
> 
