From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: definition for _attribute() in remote.c
Date: Mon, 25 Apr 2016 22:34:27 +0100
Organization: OPDS
Message-ID: <F23050BD4C62408D97A64B1D885007A8@PhilipOakley>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley> <20160425211030.GA10309@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:34:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auo9L-00064X-9i
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbcDYVea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:34:30 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:15122 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbcDYVea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:34:30 -0400
Received: from PhilipOakley ([92.22.74.182])
	by smtp.talktalk.net with SMTP
	id uo9DandlBGr60uo9DaipYz; Mon, 25 Apr 2016 22:34:27 +0100
X-Originating-IP: [92.22.74.182]
X-Spam: 0
X-OAuthority: v=2.2 cv=WYJOUApX c=1 sm=1 tr=0 a=/ihZocdjyYGcUybBdHAawQ==:117
 a=/ihZocdjyYGcUybBdHAawQ==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=NEAV23lmAAAA:8 a=eFav-oLf9bcwFWQvW7AA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfO7cRhvpdukXRd9CblT8kwYuKv1Y4wsQKXzpayqeld6r4a4kdaBuDUshZF1ajphAzN5CMcHWBHGL81fmIbHHuKSx8WdFYAOrSferVL8Z787509t7P2uk
 dA9G76i6wka53LIEUMKL2yfR6wt2xw2xqy/sy5kp9wVTD3LqQiQKqW72iS3uBESnx7hMUQwH18Xf4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292566>

From: "Jeff King" <peff@peff.net>
> On Mon, Apr 25, 2016 at 10:02:38PM +0100, Philip Oakley wrote:
>
>> I'm looking at getting Git for Windows to compile via Visual Studio
>> (https://github.com/git-for-windows/git/pull/256).
>>
>> However the use of __attribute() in remote.c at L1662
>> (https://github.com/git-for-windows/git/blob/master/remote.c#L1662) has 
>> got
>> me confused in that I can't see how the regular definition of 
>> __attribute()
>> is #included in this case. A definition is given in
>> git\compat\regex\regex_internal.h but doesn't appear to be on remote.c's
>> include path.
>>
>> The line was introduced by 3a429d0 (remote.c: report specific errors from
>> branch_get_upstream, 2015-05-21) which appears to be later than the 
>> previous
>> MSVC testers had looked at.
>
> It should be handled in git-compat-util.h, which is included by cache.h,
> which is included by remote.c.
>
> There we have:
>
>  #ifndef __GNUC__
>  #ifndef __attribute__
>  #define __attribute__(x)
>  #endif
>  #endif
>
> which should make it a noop on compilers which don't know about it. Is
> VS (or another file) setting __GNUC__?

It's not the __attribute__ definition (a Gnu C ism), rather its the 
__attribute variant, which has a definition in regex_internal.h, and is used 
in the regex code. It's that one that's used in remote.c that I can't fathom 
(i.e. how it worked in normally)

regex_internal.h#L160-164
#ifdef __GNUC__
# define __attribute(arg) __attribute__ (arg)
#else
# define __attribute(arg)
#endif

thus when the compilation get to remote.c#L1662 it fails to find that 
definition.

Should that line use the gnu extension name?

--
Philip 
