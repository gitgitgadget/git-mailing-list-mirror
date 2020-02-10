Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F71C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F59820733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMvJKi4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBJQVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:21:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45807 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgBJQVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 11:21:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so5507917qte.12
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jeSubTcLi3/dQk3Fba1Aj+KxWc96dVjTQdaCNhZB6hM=;
        b=MMvJKi4QeooVUfAtNunvqVYW1/ocLaJg4SmvKk/jX/99qagWNUN7KhmAIVlpNbFE5H
         XHip+qQpqazbvC3GZFOdnf4J3r0tG93LAljbtPm8XHw9zYF+WNu/sGeqkseFHmLk9X7s
         JTCYuykVzZoBjr/oAn/ZjLW32pYSTtMZuvCTWDK4V0bNdWVEOH2iK9t9Kf3B1haNwW8j
         RJ6akhhbEUG6MuX2pGxdY6oM7alwewn632Dh0yVsQJSzNCUGnyKdSUOY49bwCwYr6xbl
         YDKeOIk7AWSMNml7bvbESX8GbAul1FIbD1PYntqTzv4KDJs54DP2gF0lAbrZj4RtFyp8
         +b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jeSubTcLi3/dQk3Fba1Aj+KxWc96dVjTQdaCNhZB6hM=;
        b=G2qK2lCmZ+/pUphzGNXGhsRDBpl1O36Wt+D+XoXUbrnb0VY/NaneuZo0q/k0oeh5Z/
         ToVGeGZaYJarBorlCBrj0zogOepWGKgThzmOusQ9kpZqihTj97A99Pr0d2FNFAWUnzGw
         3HOAVLX06s7h8nCO55AuGKvXWzIoqhD7Jps5fUvR8dD50cekFxs9CnpL16LQeTMUq1aI
         eNJLMPT9fVV11OMV+DzzdtWem6EAepa66dO6mxqDp7m5J8ODMWiJv9nVNeAVOBhwpOKN
         WpQhjYBfsnpq6gX5k+VXfKHgX07C2XxGg9asITCnn89KV5Mpra79GaDW8CWi0VKpL0LX
         nlsg==
X-Gm-Message-State: APjAAAUgo55wFKIsc3ilb2MsNGCxzIvAAqrIe8D2oafoKnW7L2CPGym4
        eLGrL+FEBFjm24UXB4ojj/U+hwA8sCY=
X-Google-Smtp-Source: APXvYqy/doB9M6qkWwlN2DSXstzXAzmEtbKWdpamIYWR8twPBcIlWnYMM3dQuhy62odHhNaEQWkkeg==
X-Received: by 2002:ac8:3482:: with SMTP id w2mr10555664qtb.192.1581351665600;
        Mon, 10 Feb 2020 08:21:05 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id s48sm388940qtc.96.2020.02.10.08.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 08:21:05 -0800 (PST)
Subject: Re: [PATCH v3 3/5] git-p4: add --no-verify option
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
 <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
 <b538ad08b6f931cab27f084364669583743e4839.1581002149.git.gitgitgadget@gmail.com>
 <xmqqpnerec4v.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <6706dad2-125b-89b4-ff2f-02a166bd4365@gmail.com>
Date:   Mon, 10 Feb 2020 11:21:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqpnerec4v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/6/2020 2:42 PM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Add new command line option --no-verify:
>>
>> Add a new command line option "--no-verify" to the Submit command of
>> git-p4.py.  This option will function in the spirit of the existing
>> --no-verify command line option found in git commit. It will cause the
>> P4 Submit function to ignore the existing p4-pre-submit.
>>
>> Change the execution of the existing trigger p4-pre-submit to honor the
>> --no-verify option. Before exiting on failure of this hook, display
>> text to the user explaining which hook has failed and the impact
>> of using the --no-verify option.
>>
>> Change the call of the p4-pre-submit hook to use the new run_git_hook
>> function. This is in preparation of additional hooks to be added.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> ---
>>   Documentation/git-p4.txt   | 10 ++++++++--
>>   Documentation/githooks.txt |  5 ++++-
>>   git-p4.py                  | 30 +++++++++++++++++++-----------
>>   3 files changed, 31 insertions(+), 14 deletions(-)
> Nicely done.  If your strategy is to "add a feature and use it in
> the same patch as the feature is added", which is what is done for
> the new "no-verify" feature that is applied to existing p4-pre-submit
> hook, then the code that runs p4-pre-submit in the original should
> be changed to use run_git_hook() in the previous step, which added
> the new run_git_hook() feature.
Thank you and and I'll resubmit the commits with these additional
suggestions.
>
> I see new print() that is not protected with "if verbose:"; is it
> debugging cruft added during development, or is it a useful addition
> for end-users to see under --verbose mode?  I suspect it is the
> latter.
The print statement has been changed to:
print("Patch succeesed this time with RCS keywords cleaned")
and will be submitted as a separate commit so that it can be discussed
on its own. However, the rationale for it is that the current flow
reports to the user that the patch has failed and that it will attempt
to re-run the patch after cleaning up the RCS keywords. Since the
program told the user that it failed, I felt they should also be told
of the success at the same level of verbosity.
>
> Thanks.
>
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 3494a1db3e..362b50eb21 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -374,14 +374,20 @@ These options can be used to modify 'git p4 submit' behavior.
>>       been submitted. Implies --disable-rebase. Can also be set with
>>       git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
>>   
>> -Hook for submit
>> -~~~~~~~~~~~~~~~
>> +Hooks for submit
>> +----------------
>> +
>> +p4-pre-submit
>> +~~~~~~~~~~~~~
>> +
>>   The `p4-pre-submit` hook is executed if it exists and is executable.
>>   The hook takes no parameters and nothing from standard input. Exiting with
>>   non-zero status from this script prevents `git-p4 submit` from launching.
>> +It can be bypassed with the `--no-verify` command line option.
>>   
>>   One usage scenario is to run unit tests in the hook.
>>   
>> +
>>   Rebase options
>>   ~~~~~~~~~~~~~~
>>   These options can be used to modify 'git p4 rebase' behavior.
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index 50365f2914..8cf6b08b55 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -520,7 +520,10 @@ p4-pre-submit
>>   
>>   This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
>>   from standard input. Exiting with non-zero status from this script prevent
>> -`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
>> +`git-p4 submit` from launching. It can be bypassed with the `--no-verify`
>> +command line option. Run `git-p4 submit --help` for details.
>> +
>> +
>>   
>>   post-index-change
>>   ~~~~~~~~~~~~~~~~~
>> diff --git a/git-p4.py b/git-p4.py
>> index d4c39f112b..b377484464 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1583,13 +1583,17 @@ def __init__(self):
>>                                        "work from a local git branch that is not master"),
>>                   optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
>>                                        help="Skip Perforce sync of p4/master after submit or shelve"),
>> +                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
>> +                                     help="Bypass p4-pre-submit"),
>>           ]
>>           self.description = """Submit changes from git to the perforce depot.\n
>> -    The `p4-pre-submit` hook is executed if it exists and is executable.
>> -    The hook takes no parameters and nothing from standard input. Exiting with
>> -    non-zero status from this script prevents `git-p4 submit` from launching.
>> +    The `p4-pre-submit` hook is executed if it exists and is executable. It
>> +    can be bypassed with the `--no-verify` command line option. The hook takes
>> +    no parameters and nothing from standard input. Exiting with a non-zero status
>> +    from this script prevents `git-p4 submit` from launching.
>>   
>> -    One usage scenario is to run unit tests in the hook."""
>> +    One usage scenario is to run unit tests in the hook.
>> +    """
>>   
>>           self.usage += " [name of git branch to submit into perforce depot]"
>>           self.origin = ""
>> @@ -1607,6 +1611,7 @@ def __init__(self):
>>           self.exportLabels = False
>>           self.p4HasMoveCommand = p4_has_move_command()
>>           self.branch = None
>> +        self.no_verify = False
>>   
>>           if gitConfig('git-p4.largeFileSystem'):
>>               die("Large file system not supported for git-p4 submit command. Please remove it from config.")
>> @@ -1993,6 +1998,9 @@ def applyCommit(self, id):
>>           applyPatchCmd = patchcmd + "--check --apply -"
>>           patch_succeeded = True
>>   
>> +        if verbose:
>> +            print("TryPatch: %s" % tryPatchCmd)
>> +
>>           if os.system(tryPatchCmd) != 0:
>>               fixed_rcs_keywords = False
>>               patch_succeeded = False
>> @@ -2032,6 +2040,7 @@ def applyCommit(self, id):
>>                   print("Retrying the patch with RCS keywords cleaned up")
>>                   if os.system(tryPatchCmd) == 0:
>>                       patch_succeeded = True
>> +                    print("Patch succeesed this time")
>>   
>>           if not patch_succeeded:
>>               for f in editedFiles:
>> @@ -2400,13 +2409,12 @@ def run(self, args):
>>               sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>>                        (len(commits), num_shelves))
>>   
>> -        hooks_path = gitConfig("core.hooksPath")
>> -        if len(hooks_path) <= 0:
>> -            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>> -
>> -        hook_file = os.path.join(hooks_path, "p4-pre-submit")
>> -        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
>> -            sys.exit(1)
>> +        if not self.no_verify:
>> +            if not run_git_hook("p4-pre-submit"):
>> +                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
>> +                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
>> +                    "however,\nthis will also skip the p4-changelist hook as well.")
>> +                sys.exit(1)
>>   
>>           #
>>           # Apply the commits, one at a time.  On failure, ask if should
