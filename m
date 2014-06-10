From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Tue, 10 Jun 2014 08:04:15 +0200
Message-ID: <53969FDF.3050506@viscovery.net>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>	<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com> <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuFAa-00049b-IC
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 08:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaFJGEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 02:04:24 -0400
Received: from so.liwest.at ([212.33.55.14]:51543 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbaFJGEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 02:04:23 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WuFAO-0007qT-FF; Tue, 10 Jun 2014 08:04:16 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 03E2E16613;
	Tue, 10 Jun 2014 08:04:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251164>

Am 6/10/2014 1:05, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> David Turner <dturner@twopensource.com> writes:
>>
>>> Since Junio has picked up the first patch from previous versions of
>>> this series, I'm just going to send the second (SSE) one.  I decided
>>> not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
>>> the former convention (for instance, that's what GIT_PARSE_WITH
>>> generates).
>>
>> Yeah but NO_FROTZ is used only when FROTZ is something everybody is
>> expected to have (e.g. it's in posix, people ought to have it, but
>> we do support those who don't), isn't it?  For a very arch specific
>> stuff like sse42, I'd feel better to make it purely opt-in by
>> forcing people to explicitly say HAVE_SSE42 to enable it.
> 
> Just FYI: I am getting
> 
> compat/cpuid.h:8:12: error: 'processor_supports_sse42' defined but
> not used [-Werror=unused-function]
> cc1: all warnings being treated as errors
> 
> while building 'pu'; I'll have to rebuild 'pu' without this patch
> before I can push the day's result out.

And I get this when I compile on Windows with msysgit:

    CC abspath.o
In file included from git-compat-util.h:694,
                 from cache.h:4,
                 from abspath.c:1:
compat/cpuid.h: In function 'processor_supports_sse42':
compat/cpuid.h:11: warning: implicit declaration of function '__cpuid'
abspath.c: At top level:
compat/cpuid.h:8: warning: 'processor_supports_sse42' defined but not used
abspath.c: In function 'processor_supports_sse42':
compat/cpuid.h:11: warning: 'eax' is used uninitialized in this function
compat/cpuid.h:11: warning: 'ebx' is used uninitialized in this function
compat/cpuid.h:11: warning: 'ecx' is used uninitialized in this function
compat/cpuid.h:11: warning: 'edx' is used uninitialized in this function

Perhaps our gcc is too old?

-- Hannes
