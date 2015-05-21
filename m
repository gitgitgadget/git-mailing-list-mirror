From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v10 1/5] command-list: prepare machinery for upcoming
 "common groups" section
Date: Thu, 21 May 2015 15:55:39 +0200
Message-ID: <555DE3DB.1000406@gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>	<1432213989-3932-2-git-send-email-sebastien.guimmara@gmail.com> <CAPig+cTV2pm5+76H_jh0WBJ-NeOOP=aMOAwg7kmdp_dqO1LV+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 21 15:55:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQwv-00017J-Us
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbbEUNzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:55:45 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36014 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbbEUNzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:55:43 -0400
Received: by wgbgq6 with SMTP id gq6so86609875wgb.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g/iH9/rtnc0EtsjoowmE3PzSFU/I/3b0Ygb2mJZtTzo=;
        b=KZ6dM5611r1FRvD3ECkSlu36+XvHJ0qgpwFe1ocH/iYugDB/Ld10T6CCLQEd5m/Aln
         252buvD5QGn2qY+cVKwb2raQTH0tWbYPrQ/yeL9T60N1Y2nj4fNxARMOFZvV2jsGO+W8
         ZLQrKI7LLKq/bXcXA52Cbih3c83vzrFoKQKqb26x/0erJXJB7wjihm5I7Nq6eo0fiWLN
         x0VyqZyID6wQivcWK6gTxuc201t7eIYJUDewAYTbcg4bAhYft2WLrEPUgszEBFcZQxRj
         dMOJBklx0uoivQ3BZrgtaSrBRupd0jkrm298EZKiRBC+i4mfKB3uRPB1gvpStGFwCH6i
         MFqA==
X-Received: by 10.180.101.105 with SMTP id ff9mr6605666wib.64.1432216541832;
        Thu, 21 May 2015 06:55:41 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fw3sm2998609wic.13.2015.05.21.06.55.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 06:55:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cTV2pm5+76H_jh0WBJ-NeOOP=aMOAwg7kmdp_dqO1LV+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269593>



On 05/21/2015 03:48 PM, Eric Sunshine wrote:
> On Thu, May 21, 2015 at 9:13 AM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> From: Eric Sunshine <sunshine@sunshineco.com>
>>
>> The ultimate goal is for "git help" to classify common commands by
>> group. Toward this end, a subsequent patch will add a new "common
>> groups" section to command-list.txt preceding the actual command lis=
t.
>> As preparation, teach existing command-list.txt parsing machinery, w=
hich
>> doesn't care about grouping, to skip over this upcoming "common grou=
ps"
>> section.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.pe=
rl
>> index 04f9977..5aa73cf 100755
>> --- a/Documentation/cmd-list.perl
>> +++ b/Documentation/cmd-list.perl
>> @@ -38,6 +38,10 @@ sub format_one {
>>          }
>>   }
>>
>> +while (<>) {
>> +       last if /^### command list/;
>> +}
>> +
>>   my %cmds =3D ();
>>   for (sort <>) {
>>          next if /^#/;
>> diff --git a/Documentation/howto/new-command.txt b/Documentation/how=
to/new-command.txt
>> index d7de5a3..6d772bd 100644
>> --- a/Documentation/howto/new-command.txt
>> +++ b/Documentation/howto/new-command.txt
>> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>>   that categorizes commands by type, so they can be listed in approp=
riate
>>   subsections in the documentation's summary command list.  Add an e=
ntry
>>   for yours.  To understand the categories, look at git-commands.txt
>> -in the main directory.
>> +in the main directory.  If the new command is part of the typical G=
it
>> +workflow and you believe it common enough to be mentioned in 'git h=
elp',
>> +map this command to a common group in the column [common].
>
> I think you meant to squash the documentation update into patch 2/5
> where the "common groups" block is actually introduced. It doesn't
> really belong in this patch which is about updating machinery in
> preparation for the new block.

I don't mind squashing it with another commit, but in this case, wouldn=
't it
make more sense to squash it with 4/5, when the 'common' tag is removed=
 and the
file is in its final form ?

>
> Also, it's now spelled "### common groups" rather than "[common]".
>

actually, this [common] is not the one I added in a previous series,
but the one that was already present:

# command name      category [deprecated] [common]

>>   7. Give the maintainer one paragraph to include in the RelNotes fi=
le
>>   to describe the new feature; a good place to do so is in the cover
>> diff --git a/Makefile b/Makefile
>> index 323c401..655740d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2455,7 +2455,7 @@ check-docs::
>>                  esac ; \
>>                  test -f "Documentation/$$v.txt" || \
>>                  echo "no doc: $$v"; \
>> -               sed -e '/^#/d' command-list.txt | \
>> +               sed -e '1,/^### command list/d' -e '/^#/d' command-l=
ist.txt | \
>>                  grep -q "^$$v[  ]" || \
>>                  case "$$v" in \
>>                  git) ;; \
>> @@ -2463,7 +2463,8 @@ check-docs::
>>                  esac ; \
>>          done; \
>>          ( \
>> -               sed -e '/^#/d' \
>> +               sed -e '1,/^### command list/d' \
>> +                   -e '/^#/d' \
>>                      -e 's/[     ].*//' \
>>                      -e 's/^/listed /' command-list.txt; \
>>                  $(MAKE) -C Documentation print-man1 | \
>> diff --git a/command-list.txt b/command-list.txt
>> index 54d8d21..181a9c2 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,4 +1,4 @@
>> -# List of known git commands.
>> +### command list (do not change this line)
>>   # command name                          category [deprecated] [com=
mon]
>>   git-add                                 mainporcelain common
>>   git-am                                  mainporcelain
>> --
>> 2.4.0.GIT
