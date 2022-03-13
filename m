Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34374C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiCMT6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCMT6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:58:43 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2A7CDEC
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:57:35 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nTULN-000BxO-3u;
        Sun, 13 Mar 2022 19:57:33 +0000
Message-ID: <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
Date:   Sun, 13 Mar 2022 19:57:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Sean Allred <allred.sean@gmail.com>, rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        sallred@epic.com, grmason@epic.com, sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <87r175amw2.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 15:21, Sean Allred wrote:
> <rsbecker@nexbridge.com> writes:
>> I have another reluctant suggestion, but it depends on your industry,
>> regulations, and other factors. In some sectors, there is a
>> requirement to keep only some period of time worth of history. In
>> fact, in some settings, keeping user identifying information beyond,
>> say 7 years, actually is problematic. Pruning your history may be not
>> only an option but required. An alternative is to use filter-branch to
>> essentially tokenize the identities of past authors and keep those in
>> a electronic vault somewhere. I have customers who are interpreting
>> GDPR-like rules just such as situation, where employees gone 7 years
>> ago and cannot be retained, by name, in the repos. I am not personally
>> happy about that, because my own repo-OCD demands that I know exactly
>> who did what until the end of time, but according to them, it actually
>> violates the local regulations. I'm sure you have had conversations
>> with lawyers, yes? ☹
> I don't believe we've involved our legal team here (I'll follow up with
> them internally), but that might be a spin-off discussion for folks who
> know they're affected.  It would seem that the design of Git makes
> purging history on an ongoing basis problematic -- you would always have
> at least one unresolvable reference to a parent commit.  If this is a
> real requirement from GDPR-like laws, either 'reasonable' VCS metadata
> needs to be a specific carve-out in those laws -- but who the heck knows
> what is 'reasonable' -- or as a project, Git needs to have an answer to
> this situation and an ability to truncate history without otherwise
> altering it.
>
> It's also worth noting that even in the last five years, at our scale,
> we've definitely run into the email-recycling problem already.
>
> Being based in the U.S. and not having seen pitchforks about this yet,
> I'd like to assume for the purpose of this discussion that we're keeping
> all our history.
>
> I think if the topic of legal implications of keeping history in
> perpetuity is valuable to continue, we should spin it off into a
> separate thread.  Personally I'm not seeing what we (Git) could
> realistically do about it other than provide recommendations and paths
> forward -- which might require considerable development.
>
>
The GDPR isn't as onerous as some suggest, as it isn't a set of black
and white rules, rather in cases like these you need to have a real
strong reason for why data is retained etc, such as being part of the
verification and validation of the commit data. There have been various
discussions around this in many of the technical journals.

It maybe that your internal Git version could disable the particular
`format` option ('%ae'?) for the original name, so only the designated
('redacted') mailmap entry is shown to casual users (assumes the repo is
inside the corporate firewall). This would avoid invalidating the repos
validation capability, while meeting the needs of GDPR type regulations.

In the same vein, a local Git version could, being open source, add
allowances for your extra mailmap entry details, such as adding a post
fix " % <approxidate>" limits for the use of the particular name/email
combo to allow date ranges to emerge.

I noted that all the .mailmap examples in the man page have ">" as the
final character, but I haven't looked to see if the code always requires
that the last element of the entry is an <email> address, or whether it
currently barfs on extra elements.

--
Philip
