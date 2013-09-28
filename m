From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: Add --version parameter
Date: Sat, 28 Sep 2013 10:54:36 +0200
Message-ID: <5246994C.3020709@googlemail.com>
References: <1380162409-18224-10-git-send-email-pclouds@gmail.com> <1380184349-26380-1-git-send-email-stefanbeller@googlemail.com> <CACsJy8BjTQhA6rDWk6FboxU-b6d93Jn+ZNvQ0DJYXehgrpSmwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 10:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPqIH-0003PE-CW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab3I1IyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:54:25 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:47879 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3I1IyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:54:23 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so1616749eek.6
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1FH3GTcq/q5QRdcT1RXfVN7eeiJ+gXU6joTA/T+v1iY=;
        b=xEvRykxZsvMXAiQOQEAAE56RK4UwzZ45MtU++K+IegsBlrEFzO7tYHIqrFNNPpHsZ+
         L44QHI+1UMvSwFA+hv3nAkZowWt2kdjiMli/dto5Ri/ebGcBW8aUia64+9xGQ+fJYwca
         ykxU6pR/VsUuNTxymqMTCCLNzsttac85XfvpuYG/DJHl/gOU+H1wbOU+qCCYN7KUpBKJ
         Q448QataFBMyhPWnQgmyPhQdsqJrAGs+yiC4XxwuYk+L/Ty1LxP1F/KHNr3HSzULXF+7
         D2wCZyXjYF8kj/5kvK28GVrw5z4hAO/Qe1fg+hXErXl7/Ynw+SH0DSJdYnpEhwD4WVaW
         X+VQ==
X-Received: by 10.14.214.136 with SMTP id c8mr17599919eep.6.1380358462628;
        Sat, 28 Sep 2013 01:54:22 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id b45sm25472582eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 01:54:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CACsJy8BjTQhA6rDWk6FboxU-b6d93Jn+ZNvQ0DJYXehgrpSmwg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235500>

On 09/26/2013 01:42 PM, Duy Nguyen wrote:
> On Thu, Sep 26, 2013 at 3:32 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> This is just a direct translation of
>> http://article.gmane.org/gmane.comp.version-control.git/235396
>> So I don't consider this is ready for inclusion.
>>
>> Some notes:
>> We need to have more error checking, repack shall be 0, 2 or 4 but
nothing
>> else. If 0 is given, no argument is passed to pack-objects, in case of
>> 2 or 4 --version=<n> is passed.
>
> It's not that bad. If you don't catch it, pack-objects will.

Ok, noted.

>
>>
>> Do we really want to call it "--version"? This parameter sounds so much
>> like questioning for the program version, similar to
>>         git --version
>>         1.8.4
>> So I'd rather use "--repack-version".
>
> Hmm.. I think it's "git repack --pack-version"? Or if you meant "git
> pack-objects --version", I drop the "pack-" out because there's
> already "pack" in "pack-objects". But I'm OK renaming --version to
> --pack-version too. Maybe later.
>
>> @@ -22,6 +23,9 @@ static int repack_config(const char *var, const
char *value, void *cb)
>>                 delta_base_offset = git_config_bool(var, value);
>>                 return 0;
>>         }
>> +       if (!strcmp(var, "core.preferredPackVersion")) {
>> +               pack_version = git_config_int(var, value);
>> +       }
>>         return git_default_config(var, value, cb);
>
> In np/pack-v4 series (not the one on 'pu' yet) git_default_config will
> do this and save the value in core_default_pack_format. So you don't
> need to set it here.
>
>> @@ -220,6 +226,8 @@ int cmd_repack(int argc, const char **argv, const
char *prefix)
>>                 argv_array_push(&cmd_args,  "--quiet");
>>         if (delta_base_offset)
>>                 argv_array_push(&cmd_args,  "--delta-base-offset");
>> +       if (pack_version)
>> +               argv_array_pushf(&cmd_args, "--version=%u",
pack_version);
>
> but then you may need "if (!pack_version) pack_version =
> core_defaul_pack_format;" before this "if".

The reason I put the pack_version not here is for structural clarity.
("All config is done in either the parse_options section or in the
repack_config function"). This may help having a the actual core logic
easier and more understandable?
If you feel otherwise, I'd change it to your proposal.

Thanks,
Stefan
