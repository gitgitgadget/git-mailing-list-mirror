Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873632027C
	for <e@80x24.org>; Sun, 16 Jul 2017 14:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbdGPOU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 10:20:56 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:22275 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdGPOUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 10:20:53 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id WkPjdtWcUQ527WkPjdR1D0; Sun, 16 Jul 2017 15:20:51 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=1XWaLZrsAAAA:8 a=7awFl41OL69WIC32ksUA:9 a=wPNLvfGTeEIA:10
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <B205A43E908A4EE3873F81CFEB7B58DA@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>
Cc:     "Stefan Beller" <sbeller@google.com>
References: <20170711010639.31398-1-sbeller@google.com> <B998F81875C940B1B7D4D26764B44B04@PhilipOakley>
Subject: Re: [PATCH] RFC: A new type of symbolic refs
Date:   Sun, 16 Jul 2017 15:20:49 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170716-0, 16/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDurQ7HZCp6qwvMQFHgJNYQUnFK9x604uWB6v21jUs0ko/6J5WMbZFeVawYQ91O0wgZttXSziV8nkYILDNgAHuaBGfPn/l8myT2gwvriLd7rzCnenjiZ
 /1Covr75K/WsQbKXNr98wla+P831aKsXwNYkrQgKxyEGHZ3LeAjW1s709qHcyMefH94IHTaPYpdl/2eWYUkpKLZKbQjhURS4KBUHEulDhCKdoU81q9HB5eTb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Stefan Beller" <sbeller@google.com>
> Sent: Tuesday, July 11, 2017 2:06 AM
>>A symbolic ref can currently only point at (another symbolic) ref.
>> However are use cases for symbolic refs to point at other things
>> representing a commit-ish, such as gitlink entries in other
>> repositories.  In this use case we can use such a symbolic link
>> to strengthen the relationship between a submodule and a superproject.
>> Examples:
>
> If I understand this correctly, the new type is the 'starts_with(buf, ))'.

Oops, my mistaken message prep accidently removed the "repo:" from the 
above.

>
> It just wasn't obvious from the text that the new type is "repo:" as you 
> never spell it out in the commit message. Should it be included in the 
> message?
>
> Have I understood correctly?
>
> --
> Philip
> [I'll be off-line till Friday, so will pick up then]
>
>>
>> 1) It makes it easier to explain when we recurse into submodules and
>>   to which sha1 the submodule is updated.
>>
>>   Currently a submodule (or any repo) is either on a branch (i.e.
>>   HEAD is a symbolic ref) or is in 'detached HEAD' state (HEAD is
>>   a direct ref).
>>   For submodules it is wrong to be on its own branch if it wants to be
>>   controlled by the superproject as being on its own branch signals that
>>   the submodule is independent and can move the HEAD freely.
>>   Being in 'detached HEAD' state is the alternative to that and was
>>   chosen when git-submodule was implemented, but it is equally wrong;
>>   the lesser of two evils.
>>
>>   Semantically the correct way to state a submodule is part of the
>>   superproject is by pointing its HEAD to the superproject.
>>
>>   We do have "reset/checkout --recurse-submodules" now, but it is
>>   hard to explain what actually happens there (Which submodules are
>>   updated? All of them! -- But I want a subset only!)
>>
>>   With this new mode of symbolic refs, any submodule that tracks the
>>   superproject, would 'automatically follow' the superproject as the
>>   submodules HEAD moves when the superproject changes.
>>
>> 2) "git -C submodule commit" would behave the same as it would on branch
>>   nowadays: It would make the commit in the submodule and then change
>>   the target of the symbolic ref which would be the index of the
>>   superproject! That implies that you do not need to 'git add' the
>>   submodule to the superproject, but have it done automatically.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> cache.h              |  2 ++
>> refs/files-backend.c | 10 ++++++++++
>> submodule.c          | 40 ++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 52 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 71fe092644..4f79d23202 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -2029,4 +2029,6 @@ void sleep_millisec(int millisec);
>>  */
>> void safe_create_dir(const char *dir, int share);
>>
>> +extern int read_external_symref(struct strbuf *from, struct strbuf 
>> *out);
>> +
>> #endif /* CACHE_H */
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 0404f2c233..f56f7b87ce 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -713,6 +713,16 @@ static int files_read_raw_ref(struct ref_store 
>> *ref_store,
>>  goto out;
>>  }
>>
>> + if (starts_with(buf, "repo:")) {
>> + if (read_external_symref(&sb_contents, referent)) {
>> + *type |= REF_ISBROKEN;
>> + ret = -1;
>> + goto out;
>> + }
>> + *type |= REF_ISSYMREF;
>> + ret = 0;
>> + }
>> +
>>  /*
>>  * Please note that FETCH_HEAD has additional
>>  * data after the sha.
>> diff --git a/submodule.c b/submodule.c
>> index da2b484879..7297f90485 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2037,3 +2037,43 @@ int submodule_to_gitdir(struct strbuf *buf, const 
>> char *submodule)
>> cleanup:
>>  return ret;
>> }
>> +
>> +int read_external_symref(struct strbuf *from, struct strbuf *out)
>> +{
>> + struct child_process cp = CHILD_PROCESS_INIT;
>> + const char *repo, *gitlink;
>> + int hint, code;
>> + struct strbuf **split = strbuf_split(from, 0);
>> + struct strbuf cmd_out = STRBUF_INIT;
>> +
>> + if (!split[0] || !split[1])
>> + return -1;
>> +
>> + repo = split[0]->buf + 5; /* skip 'repo:' */
>> + gitlink = split[1]->buf;
>> +
>> + argv_array_pushl(&cp.args,
>> + "ignored-first-arg",
>> + "-C", repo,
>> + "ls-tree", "-z", "HEAD", "--", gitlink, NULL);
>> +
>> + /*
>> + * 17 accounts for '160000 commit ',
>> + * the \t before path and trailing \0.
>> + */
>> + hint = 17 + GIT_SHA1_HEXSZ + split[1]->len;
>> + code = capture_command(&cp, &cmd_out, hint);
>> +
>> + strbuf_release(split[0]);
>> + strbuf_release(split[1]);
>> +
>> + if (!code) {
>> + strbuf_reset(out);
>> + strbuf_add(out, cmd_out.buf + strlen("160000 commit "),
>> +    GIT_SHA1_HEXSZ);
>> + } else
>> + return -1;
>> +
>> + return 0;
>> +}
>> +
>> -- 
>> 2.13.2.695.g117ddefdb4
>>
> 

