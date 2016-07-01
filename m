Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C272018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcGARYa (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:24:30 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35483 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbcGARY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:24:29 -0400
Received: by mail-io0-f175.google.com with SMTP id f30so105848337ioj.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 10:24:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7VryZoT7fsJcDoM3Hey72eoGsvpUDBhoyaJWSSyxvmY=;
        b=GlZvXQbb27oZFpI88epd2gybVZaAyI1lXaLIk3EINd2ygZG7J4ni9A0jeR3aGVAObY
         gQlqf2CFUSsFvZ7zWUCxy3Pzxq+Yz01Ctf274YsF5eDu7SVZ4GS4dPur2tZM+41m2lR7
         HMeuGpnIk8DII76uIVb09zxTiCkiwgpe3xPzeYu3pnn7kWD8wKmmFx50fwemIbh3W5ZX
         IMioqQVvsFjTdQ/qTUKtbsuKoJKIR8XkdjfxSbu9EqDSZtIKnww65kLbtEcwHcJ/VvHK
         8aYngtzdpNJVZI9ekT8So45NcrztXKPZH/fJxcfuMPZTxHnh43Iso3xhiWiGTbNMQJPK
         SlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7VryZoT7fsJcDoM3Hey72eoGsvpUDBhoyaJWSSyxvmY=;
        b=DkvLaPR1REZot3SQTnE0lWyCsrsBqkMGH6Vd+95IMc899YOuVR9GHvo5d09N0IbuyY
         k6Q25ApHi1eiv1435+gp+TCVdCx7IReh9yrXiRSmBco6Fb5UV9C9A6BS62LKnnKW6Dxs
         gmxN9R8PdwlpLddSPtd3qP+J+sFYY1aUjUkGe2ZTrp6fIBUyU/EoYranQWW0p3UEVt6R
         KCXOhwfo6AQuG91g09fFngIPmekB44VLLL39OqPSIBYbWjCSnKUGkbo5MFCq6rE7OUFn
         qaYjIbo3C3ZXiTvuCP9F/R3CwAPFy2MZUc8tRUp36cNhsGvM4trsLZfPXra/EA6kt+oU
         gp9A==
X-Gm-Message-State: ALyK8tKL7Q/6JaK+FwZoPoosNJThseP5cOwBEkto5R8gFCdV0792x+GFMNe4NTcqjfPXSSgC0fTvVv5Rjhq/sdAp
X-Received: by 10.107.144.86 with SMTP id s83mr19828483iod.165.1467393868762;
 Fri, 01 Jul 2016 10:24:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 1 Jul 2016 10:24:28 -0700 (PDT)
In-Reply-To: <xmqqh9c9z3kf.fsf@gitster.mtv.corp.google.com>
References: <20160630005951.7408-1-sbeller@google.com> <20160630005951.7408-3-sbeller@google.com>
 <xmqqh9c9z3kf.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 1 Jul 2016 10:24:28 -0700
Message-ID: <CAGZ79kZxqRs=c-Fxe=uyCiPAw_R79gVtpyMn0OYc3OFrdev-hQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static const char *stream_push_options_to_file()
>> +{
>> +     static const char *fname = "push-options-XXXXXX";
>> +     char *ret = xmallocz(strlen(fname));
>> +     int fd;
>> +     memcpy(ret, fname, strlen(fname));
>> +     fd = mkstemp(ret);
>
> Probably
>
>         char *ret;
>         int fd;
>
>         ret = xstrdup("push-options-XXXXXX");
>         fd = xmkstemp(ret);
>

That is way better to read!
Also I did not know we also have a wrapper for mkstemp;
Maybe I should check for any new syscall if we wrap that.

> or use mkstemp but check the return value and "goto fail".
>
>> +     for (;;) {
>> +             char *line;
>> +             int len;
>> +
>> +             line = packet_read_line(0, &len);
>> +
>> +             if (!line)
>> +                     break;
>> +
>> +             if (write_in_full(fd, line, len) < 0 ||
>> +                 write_in_full(fd, "\n", 1) < 0)
>> +                     goto fail;
>> +     }
>> +
>> +     return ret;
>> +fail:
>> +     close(fd);
>> +     free(ret);
>> +     return NULL;
>> +}
>> +
>>  static const char *parse_pack_header(struct pack_header *hdr)
>>  {
>>       switch (read_pack_header(0, hdr)) {
>> @@ -1767,6 +1808,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>>               const char *unpack_status = NULL;
>>               const char *push_options_file = NULL;
>>
>> +             if (use_push_options)
>> +                     push_options_file = stream_push_options_to_file();
>> +
>>               prepare_shallow_info(&si, &shallow);
>>               if (!si.nr_ours && !si.nr_theirs)
>>                       shallow_update = 0;
