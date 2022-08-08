Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D247C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 03:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiHHD1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHHD1q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 23:27:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA27E002
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659929265; x=1691465265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CXaGHBZIMhmoqJAS7XWLl0dzbdPXRGjjUcopFX30EBk=;
  b=hM1pWbCBjnQHprLCDoWFIddKe1nnmILYk6wjnGzQVLylS4MjE+04Sc0b
   NeXnbuHocZdJRthHSdyKW1dghAajz6axf1UzugPQoD9juKf7G93BozrBX
   pLZzGLmzw9A+OcXdWdLSPHJiHju9J0sRDFB3TaAZUmEJcnVKgpI9tivgy
   jxwkn/FOJDB11Ii52GoQHh8cl/cRcDtwW0CNB1mL9EgAnylYnRt43jo4J
   oddAczvjhOJdQZHnkxwovbeKGxEwtl9k4Et19zbD2L99AUiS+4vRvnwqn
   1JrLMwYZ0H5AdGumi/AxesorM/WfJHbYhyvI2HKwLNJwEktEAVwzx8fbC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270878139"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="270878139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:27:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="632708380"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.212.63]) ([10.238.212.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:27:44 -0700
Message-ID: <002aad57-9389-abfd-207a-3c02b47cdbf0@intel.com>
Date:   Mon, 8 Aug 2022 11:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [Question]: Question about "cherry-pick" internal
Content-Language: en-US
To:     Chris Torek <chris.torek@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <e564b1e3-0f34-dce3-400d-439a40ec4d48@intel.com>
 <CAPx1Gvd9xLdJaWiTN1MrktyEMfKmAjTx9zxOVcOnRv7r9n_ZiQ@mail.gmail.com>
From:   "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <CAPx1Gvd9xLdJaWiTN1MrktyEMfKmAjTx9zxOVcOnRv7r9n_ZiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You solved my problem, many thanks!

BR,
Lei

On 8/8/2022 12:48 AM, Chris Torek wrote:
> On Wed, Aug 3, 2022 at 6:42 PM Wang, Lei <lei4.wang@intel.com> wrote:
>> I heard that cherry-pick is just a kind of merge, the difference between
>> it and the traditional merge is that it treats the parent commit of the
>> commit you want to cherry-pick as the merge-base ...
> This is indeed the case.
>
>> [During merging:] If the [two] diff[s] modified the same
>> line, then a conflict occurs.
> This is also true—but it's not the whole story.
>
>> If the above is true, but why when I cherry-picked a commit, a conflict
>> occurs even the 2 diffs didn't modify the same line, they modified the
>> two consecutive lines (line n and line n + 1), so what can be the
>> potential reason for this?
> In any merge, if the two sides modify *adjacent* lines—as is the
> case here—that, too, is considered a conflict (at least Git considers
> it as one; not all merge algorithms do that).
>
> Note that if the two diffs modify the same line(s) in the *same way*—
> e.g., both add the same text or delete the same text—Git will take
> only *one copy* of the change, without calling it a conflict. In some
> cases this may be incorrect: consider. e.g., merging the debits and
> credits in a series of accounting records, where the dollar amounts
> are identical, but the transactions are different.  If Alice spent $5
> and Bob spent $5, the correct result is not that "$5 total was spent"
> but rather $10.
>
> Still, for the kinds of tasks *Git* is asked to merge, this is normally
> the correct result, so it is the result Git produces.
>
> Git is a tool—or rather, a set of tools—and its automated work is
> never a substitute for expert evaluation.  You, the user, must do
> some work here as well, to make sure that what Git did is in fact
> correct for your particular situation.
>
> Chris
