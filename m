Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA082C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350631AbhKYM7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 07:59:41 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:37019 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345928AbhKYM5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 07:57:39 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mqEGg-000C1J-7o; Thu, 25 Nov 2021 12:54:26 +0000
Message-ID: <f63ed861-1109-d892-597e-25949b08b8cf@iee.email>
Date:   Thu, 25 Nov 2021 12:54:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
 <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
 <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
 <bf9b547d-f421-49f7-9dc5-cc1f81187127@iee.email> <xmqqk0gx1gmz.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqk0gx1gmz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/11/2021 19:46, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> On 24/11/2021 11:14, Ævar Arnfjörð Bjarmason wrote:
>>> I'm not concerned that you didn't research this change well enough, I
>>> just find it a bit iffy to introduce semantics in git around FS
>>> operations that don't conform with that of POSIX & the underlying OS. My
>>> *nix system happily accepts an "rm -rf" or an "rmdir" of the directory
>>> I'm in, I'd expect git to do the same.
>> Isn't this the same, conceptually, as trying to remove the root
>> directory, but from a Git perspective?
>>
>> i.e. Something along the lines of
>> https://superuser.com/questions/542978/is-it-possible-to-remove-the-root-directory
>> (their answer is 'no' without a special option, default since 2006)
>>
>> If I read the arguments correctly, Elijah is saying that Git shouldn't
>> delete it's own root (cwd) directory, and that it is already implicit
>> within the current Git code.
> I do not think it is about protecting "root"; the series wants
>
>     cd t/ && git rm -r ../t
>
> to leave an empty directory at 't/', because "git rm" was started in
> that directory.
My point was about where the conceptual 'root' (for Git and it's rm
command) was deemed to be.

For instance, can/should we be able to elevate ourselves into a super
project for the deletion? I did notice that a regular `cd / && cd
../../` will happily recycle itself at `/`, rather than bugging out.

Whichever way is decided (cwd, GIT_WORK_TREE, or higher), ensuring that
the documentation is plain and clear , and not just the code, is
important for future readers, to help avoid future confusions.

Philip
