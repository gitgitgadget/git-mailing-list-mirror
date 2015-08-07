From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 14:32:46 -0700
Message-ID: <xmqq614qyebl.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:32:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNpG5-0004R0-0M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 23:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946280AbbHGVcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 17:32:51 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36202 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946184AbbHGVcv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 17:32:51 -0400
Received: by pacrr5 with SMTP id rr5so60484945pac.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oM/vzRR3kgldAxWCZFy9cMat0gKWaylMCSKhgzSdKh8=;
        b=p4xB0C01fFjC8iiZulXW49MbrbK5crMFyx2rnfQBJi3/i09qHlSADYBwJry+XMtQkM
         ukYIeaYeMRE88DvpBKM8JZC5dlAkIIgE59BYx41D8BhLxU6Kma4XusJobM3ySeLS9q4o
         7Wh3yDCpgHpoVUO2LYIfpFIdPX754z248REa4RnU+Ucy9tGZuZrgKxr72IuLBW2oxF26
         E2/fJ+CMDZa+7lKhsAYg3dl6FzAFaAqoD0+3USmOGiTS5Efvqe4Ipbrw4zq9TpS95PcY
         6RfpyZEZzaYzLvM6EILT9+SJj/pRO7d0haEQurTf00+fnep2zXEPIwAj4DvknGusWKtb
         kn8Q==
X-Received: by 10.66.231.69 with SMTP id te5mr18727451pac.98.1438983167843;
        Fri, 07 Aug 2015 14:32:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id ym6sm11247934pac.32.2015.08.07.14.32.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 14:32:47 -0700 (PDT)
In-Reply-To: <CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 7 Aug 2015 14:21:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275492>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 7, 2015 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>> ...
>>> We can drop that hunk as it only uses the new method
>>> `submodule_name_for_path` but doesn't change functionality.
>>> So if you want to keep Heikos work, I'll just resend the patch
>>> without that hunk.
>>
>> Does such a result even make sense?  Note that I wasn't talking
>> about textual conflict.
>>
>> If we followed what you just said, that patch will try to directly
>> read the data in config_name_for_path string list, which is removed
>> by Heiko's series, if I am reading it right.

By the way, the above is more important part of the message you are
responding to.  The result does not simply link, because your
unsorted_string_list_lookup() will no longer have the string list in
the first place X-<.

>>> 2) Come up with a good thread pool abstraction
>>>    (Started as "[RFC/PATCH 0/4] parallel fetch for submodules" )
>>>    This abstraction (if done right) will allow us to use it in different places
>>>    easily. I started it as part of "git fetch --recurse-submodules" because
>>>    it is submodule related and reasonably sized
>>
>> I personally think this gives the most bang-for-buck.  Write that
>> and expose it as "git submodule for-each-parallel", which takes the
>> shell scriptlet that currently is the loop body of "while read mode
>> sha1 stage sm_path" in update and clone.  You will have immediate
>> and large payback.
>
> You said that before. I feel like this is a bit to narrow.

That depends on how good a design you make for the internal
"parallel execution" engine.  If it is made to take an arbitrary C
function with list of arguments to call it with, for-each-parallel
would be just a degenerate and narrow case where that arbitrary C
function happens to be exec'ing a shell and feed a shell scriptlet
to it.

The internal parallel execution engine would be reusable without any
change to call C native functions, allowing you to do everything
inside the process in the future.  And the "narrow" case is a good
first step to validate your design actually _works_.
