From: Arjun Sreedharan <arjun024@gmail.com>
Subject: Re: [PATCH] fix calloc() and xcalloc() argument ordering
Date: Wed, 3 Sep 2014 12:00:39 +0530
Message-ID: <CAJFMrCFq3sdrdEYEPEPfp4xzZ2n_rbYR9cmMus0Dy5J1WX76Dg@mail.gmail.com>
References: <1409381663-9532-1-git-send-email-arjun024@gmail.com> <xmqqegvt27ac.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 08:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP45y-0008NO-G2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 08:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbaICGbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 02:31:01 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35546 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaICGbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 02:31:00 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so7914970qgd.9
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GMl1e7Zd/GL98h438ikR817JHPaziSSda0fVroVVsDM=;
        b=iiajjJYl2hfK68KzMV0y2h4fkSWrknG/zcz8ICq03zdmn3EqSwv2La703SfC++7aUd
         c+BydcPuG3QvHTEjGX9bfdxyNiMc4raaMVWwUdiVkkCtv3KKztNiMIpHCY0lE8qzljp/
         75c/Px7SPG0kDV81Yi1QPSQ2tuvMheJK7gs4si4xdgsVFCrSZY0YhvG3swtKyR3Wfdq8
         yOjNxRQzna5C3Dnj96/toCL43gHs7U7IeCGP8ZBrzC7eV+6V8eBWCqSXeATzWMrbINnc
         CJ0eMbA6JYOjLqaNSwVepewN0Z1g3oFf9/P3EWHHSUBuTz4GSZfDdqjJsdm/LYR3eLDH
         UnCA==
X-Received: by 10.140.101.86 with SMTP id t80mr59461197qge.91.1409725859457;
 Tue, 02 Sep 2014 23:30:59 -0700 (PDT)
Received: by 10.140.255.215 with HTTP; Tue, 2 Sep 2014 23:30:39 -0700 (PDT)
In-Reply-To: <xmqqegvt27ac.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256382>

On 3 September 2014 00:12, Junio C Hamano <gitster@pobox.com> wrote:
> Arjun Sreedharan <arjun024@gmail.com> writes:
>
>> @number first, @size second argument.
>>
>> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
>> ---
>>  builtin/for-each-ref.c        |  2 +-
>
> Thanks.  compat/regex/ being borrowed code, I'd prefer not to touch
> them, though.
>

Ok. should i resend?

>>  compat/regex/regcomp.c        | 12 ++++++------
>>  compat/regex/regex_internal.c |  4 ++--
>>  compat/regex/regexec.c        | 10 +++++-----
>>  imap-send.c                   |  2 +-
>>  5 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 47bd624..69bba06 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -633,7 +633,7 @@ static void populate_value(struct refinfo *ref)
>>       unsigned long size;
>>       const unsigned char *tagged;
>>
>> -     ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
>> +     ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
>>
>>       if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
>>               unsigned char unused1[20];
>> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
>> index 06f3088..e375c50 100644
>> --- a/compat/regex/regcomp.c
>> +++ b/compat/regex/regcomp.c
>> @@ -861,7 +861,7 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
>>      if (table_size > pat_len)
>>        break;
>>
>> -  dfa->state_table = calloc (sizeof (struct re_state_table_entry), table_size);
>> +  dfa->state_table = calloc (table_size, sizeof (struct re_state_table_entry));
>>    dfa->state_hash_mask = table_size - 1;
>>
>>    dfa->mb_cur_max = MB_CUR_MAX;
>> @@ -929,7 +929,7 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
>>       {
>>         int i, j, ch;
>>
>> -       dfa->sb_char = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
>> +       dfa->sb_char = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
>>         if (BE (dfa->sb_char == NULL, 0))
>>           return REG_ESPACE;
>>
>> @@ -3072,9 +3072,9 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
>>                                                  _NL_COLLATE_SYMB_EXTRAMB);
>>      }
>>  #endif
>> -  sbcset = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
>> +  sbcset = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
>>  #ifdef RE_ENABLE_I18N
>> -  mbcset = (re_charset_t *) calloc (sizeof (re_charset_t), 1);
>> +  mbcset = (re_charset_t *) calloc (1, sizeof (re_charset_t));
>>  #endif /* RE_ENABLE_I18N */
>>  #ifdef RE_ENABLE_I18N
>>    if (BE (sbcset == NULL || mbcset == NULL, 0))
>> @@ -3619,9 +3619,9 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
>>    re_token_t br_token;
>>    bin_tree_t *tree;
>>
>> -  sbcset = (re_bitset_ptr_t) calloc (sizeof (bitset_t), 1);
>> +  sbcset = (re_bitset_ptr_t) calloc (1, sizeof (bitset_t));
>>  #ifdef RE_ENABLE_I18N
>> -  mbcset = (re_charset_t *) calloc (sizeof (re_charset_t), 1);
>> +  mbcset = (re_charset_t *) calloc (1, sizeof (re_charset_t));
>>  #endif /* RE_ENABLE_I18N */
>>
>>  #ifdef RE_ENABLE_I18N
>> diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
>> index d4121f2..9d9e986 100644
>> --- a/compat/regex/regex_internal.c
>> +++ b/compat/regex/regex_internal.c
>> @@ -1629,7 +1629,7 @@ create_ci_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
>>    reg_errcode_t err;
>>    re_dfastate_t *newstate;
>>
>> -  newstate = (re_dfastate_t *) calloc (sizeof (re_dfastate_t), 1);
>> +  newstate = (re_dfastate_t *) calloc (1, sizeof (re_dfastate_t));
>>    if (BE (newstate == NULL, 0))
>>      return NULL;
>>    err = re_node_set_init_copy (&newstate->nodes, nodes);
>> @@ -1679,7 +1679,7 @@ create_cd_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
>>    reg_errcode_t err;
>>    re_dfastate_t *newstate;
>>
>> -  newstate = (re_dfastate_t *) calloc (sizeof (re_dfastate_t), 1);
>> +  newstate = (re_dfastate_t *) calloc (1, sizeof (re_dfastate_t));
>>    if (BE (newstate == NULL, 0))
>>      return NULL;
>>    err = re_node_set_init_copy (&newstate->nodes, nodes);
>> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
>> index eb5e1d4..edfe0c6 100644
>> --- a/compat/regex/regexec.c
>> +++ b/compat/regex/regexec.c
>> @@ -2797,8 +2797,8 @@ get_subexp (re_match_context_t *mctx, int bkref_node, int bkref_str_idx)
>>           continue; /* No.  */
>>         if (sub_top->path == NULL)
>>           {
>> -           sub_top->path = calloc (sizeof (state_array_t),
>> -                                   sl_str - sub_top->str_idx + 1);
>> +           sub_top->path = calloc (sl_str - sub_top->str_idx + 1,
>> +                                   sizeof (state_array_t));
>>             if (sub_top->path == NULL)
>>               return REG_ESPACE;
>>           }
>> @@ -3362,7 +3362,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
>>        if (ndests == 0)
>>       {
>>         state->trtable = (re_dfastate_t **)
>> -         calloc (sizeof (re_dfastate_t *), SBC_MAX);
>> +         calloc (SBC_MAX, sizeof (re_dfastate_t *));
>>         return 1;
>>       }
>>        return 0;
>> @@ -3458,7 +3458,7 @@ out_free:
>>        discern by looking at the character code: allocate a
>>        256-entry transition table.  */
>>        trtable = state->trtable =
>> -     (re_dfastate_t **) calloc (sizeof (re_dfastate_t *), SBC_MAX);
>> +     (re_dfastate_t **) calloc (SBC_MAX, sizeof (re_dfastate_t *));
>>        if (BE (trtable == NULL, 0))
>>       goto out_free;
>>
>> @@ -3489,7 +3489,7 @@ out_free:
>>        transition tables, one starting at trtable[0] and one
>>        starting at trtable[SBC_MAX].  */
>>        trtable = state->word_trtable =
>> -     (re_dfastate_t **) calloc (sizeof (re_dfastate_t *), 2 * SBC_MAX);
>> +     (re_dfastate_t **) calloc (2 * SBC_MAX, sizeof (re_dfastate_t *));
>>        if (BE (trtable == NULL, 0))
>>       goto out_free;
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 524fbab..02eb3e0 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -954,7 +954,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
>>
>>       ctx = xcalloc(1, sizeof(*ctx));
>>
>> -     ctx->imap = imap = xcalloc(sizeof(*imap), 1);
>> +     ctx->imap = imap = xcalloc(1, sizeof(*imap));
>>       imap->buf.sock.fd[0] = imap->buf.sock.fd[1] = -1;
>>       imap->in_progress_append = &imap->in_progress;
