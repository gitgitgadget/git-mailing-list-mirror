From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Fri, 14 Aug 2015 08:56:38 -0700
Message-ID: <xmqq614hkgnd.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<1438693282-15516-1-git-send-email-Karthik.188@gmail.com>
	<xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
	<CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
	<CAOLa=ZQSVCgcuUQFsF2Mq-m+wS8im3t4Z3PSEgoAHcV0gGuvPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 17:56:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQHLa-0008A7-0O
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 17:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbbHNP4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 11:56:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35650 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbbHNP4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 11:56:41 -0400
Received: by pacgr6 with SMTP id gr6so62457942pac.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2fPYDDfCyYr3W14Mnavm7a0obRjlTepS93jOTQx10m4=;
        b=HxPgz7Gf9xK7yE5BR2tTXlnQS9W7z45tb5sIpdtPbapItAVcYT/HdhvZqjizTt+8B+
         JRGdQRMI+idFoF6FhzmqS9rasylbIadeqcoZxflM6s2dTcrQDgPFeBbKazFlxZoOeb5e
         r1nVi1ADzHt3rjBtM03hW0+ROZ+Zlk8mUpFMfdkwLNiR0EHrHNBS1RnwAHQJtCDKGZHJ
         G9QtmvQ1OpmSn5NlCtXg+fZUWDzO6wOlbK6G63fwGV3iqNkj2PnVJwMXQcf7dZQJ44lS
         tb9tLENyUKkynxlvXJBpVPWLk2ebcz9nwb8BaB7cl9vuIe+RClZjx5rjfpU5TAxtYhsr
         5jZw==
X-Received: by 10.68.138.200 with SMTP id qs8mr2282020pbb.19.1439567800590;
        Fri, 14 Aug 2015 08:56:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id y2sm6480883pdp.0.2015.08.14.08.56.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 08:56:39 -0700 (PDT)
In-Reply-To: <CAOLa=ZQSVCgcuUQFsF2Mq-m+wS8im3t4Z3PSEgoAHcV0gGuvPA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 13 Aug 2015 20:43:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275907>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Aug 13, 2015 at 5:05 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>
>>> This was taken from branch.c, I thought of using an enum instead but that
>>> would again require most of branch.c, hence it's been carried over
>>> without changing
>>> I'm thinking of changing it, any suggestions?
>>>
>>
>> What I was thinking was of having:
>>
>> #define FILTER_REFS_INCLUDE_BROKEN 0x1
>> #define FILTER_REFS_TAGS 0x2
>> #define FILTER_REFS_BRANCHES 0x4
>> #define FILTER_REFS_REMOTES 0x8
>> #define FILTER_REFS_DETACHED_HEAD 0x16
>>
>> and using these for showing ref kind also instead of separately
>> having 'REF_DETACHED_HEAD' and so on.
>>
>
> Something like this:
> https://github.com/KarthikNayak/git/commit/0ec5381420dcdfe7c62000b56168e2842d5d0063

I notice a few things in ref-filter.c in that commit (a web
interface including GitHub one is horrible in showing the things in
wider context across files, so I'll base my discussion by guessing
what the caller of this function and helpers this function calls
do):

 - Your "ALL" silently overrides others.  Is that sensible?  Perhaps
   you would instead want to define FILTER_REFS_OTHER (not needed to
   be exposed to UI) and then define FILTER_REFS_ALL as the ORed
   value of FILTER_REFS_{BRANCHES,...,OTHER}?

 - When the caller asks for "--branches --tags", you run
   ref-filter-handler twice on ref_cbdata.  Does that make sense?
   Shouldn't you iterate over all the available refs just once,
   rejecting ones that aren't in either refs/{heads,tags}/ instead?
