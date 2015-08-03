From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] Testing the new code
Date: Mon, 03 Aug 2015 12:47:30 -0700
Message-ID: <xmqqoaio888d.fsf@gitster.dls.corp.google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-3-git-send-email-sbeller@google.com>
	<xmqqio8zakhv.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYBvQ9vfmDNs2_WTLU0OrHShS7_fLnjHgYxX9C29PdDsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMLhx-0008QM-Ck
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 21:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbbHCTrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 15:47:33 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32778 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbHCTrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 15:47:32 -0400
Received: by pdbnt7 with SMTP id nt7so77632324pdb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Yq+Zbm326BQvYzP8YpJ2oWjyJ9g+yWvxfr+2YZPg+7E=;
        b=MXAmgA0Qk/WdZ61KiscvW6o3+ITKnZ1EJpcLS5J9JEdwsH+DtEgo48JmEHVZI5r9wO
         sVZyAX7+HRVEWiT2opww7KhFI17J4KtXYPYH25ncYH2Qi+fJbCAUEqT4z7VBSrClO59b
         Fpdy+ixVDfvrxhkpBySIAcy7aGVrXqW9r8tZy246fdaSTHNCecjL3oL1dSYSMEy5T3CQ
         pOA+rjg8MX88fOdIM6kz39nfLgZMCNdbeLq2Tp1FnYa0DQxBAxqcmC/D5fpBDkvzlZOc
         XwdhEDhv30PrYlKhFiTY5sQikiB7+j0DC310oBTxorzdUGafboir9x3cIb0JDzxfccgA
         dV7A==
X-Received: by 10.70.103.70 with SMTP id fu6mr39772068pdb.22.1438631252052;
        Mon, 03 Aug 2015 12:47:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id nw5sm2961400pdb.33.2015.08.03.12.47.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 12:47:31 -0700 (PDT)
In-Reply-To: <CAGZ79kYBvQ9vfmDNs2_WTLU0OrHShS7_fLnjHgYxX9C29PdDsA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 3 Aug 2015 09:23:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275190>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jul 31, 2015 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> -module_list()
>>> +module_list_shell()
>>>  {
>>>       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
>>>       (
>>> @@ -187,6 +187,29 @@ module_list()
>>>       '
>>>  }
>>>
>>> +module_list()
>>> +{
>>> +     # call both the old and new code
>>> +     module_list_shell $@ >/u/git_submodule_module_list_shell 2>/u/git_submodule_module_list_shell2
>>> +     git submodule--helper --module_list $@ >/u/git_submodule_module_list 2>/u/git_submodule_module_list2
>>
>> You seem to be discarding the double-quote around $@ in both of
>> these two places.  Intended?
>
> No, not at all. This was a bit sloppy.

OK.

> This patch was rather showing off how I intend to test the previous patch.

Yeah, I can see what the code is doing, and you already saw that I
didn't disagree with the approach ;).  During a reimplementation
exercise, it often is a good idea, if the code structure allows you
to, to run both implementations and compare the results---but it can
go only so far.  It obviously is tricky to apply the trick to an
operation that is not idempotent to let two implementations to do it
twice in different ways and make sure they produce the same result.
