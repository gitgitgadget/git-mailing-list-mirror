From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 3/5] generate-cmdlist: parse common group commands
Date: Fri, 15 May 2015 16:40:04 +0200
Message-ID: <55560544.3090705@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>	<1431608351-9413-4-git-send-email-sebastien.guimmara@gmail.com>	<xmqq617ukhal.fsf@gitster.dls.corp.google.com> <CAPig+cTrDd3eYXo1WPoWRk5XSuLyH_m_VU1JsnP8pjkM=n6O2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 16:40:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGmb-00043d-3H
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbbEOOkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 10:40:08 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34344 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbbEOOkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:40:07 -0400
Received: by wguv19 with SMTP id v19so53287019wgu.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=UiX1VaapEvVOaiGhEhUUVIEV2uTv6Cig0dTjPHPOfSw=;
        b=iRp//nkTzIc8oeMd53J0Ej0aYQ0wdKFUH3rPBrj1sjm7v7/ABLOsv1uBkR688aBATJ
         oLDWftJybj6LoZaEOk6ATuhiyY8gfJKGMsW3Ld50b7kofQ0ZCN//tvLcEyrhlNVQnE8I
         xI5wJvQ8CCNHeoqDVUC849hDOUSwlTqdIkuhyTb9GgjnteUEDsmV6FeZoqp2xwk+JETa
         dP5c/l5v6edPY89QoDJUUGv2bJz4DPC9FosA9gVIIPb74LEscTRdG64GWRDKZ9GmHruk
         H9jxeFGJ/x/U3wkeLg5E9NYbMP4U5u3rRg/AUe9Bop2xMgI727DTMNI4yQmn+FMrm7vn
         XuhA==
X-Received: by 10.194.209.168 with SMTP id mn8mr18042836wjc.49.1431700805959;
        Fri, 15 May 2015 07:40:05 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id k2sm3245792wix.4.2015.05.15.07.40.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 07:40:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cTrDd3eYXo1WPoWRk5XSuLyH_m_VU1JsnP8pjkM=n6O2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269147>

On 05/14/2015 11:05 PM, Eric Sunshine wrote:
> On Thu, May 14, 2015 at 4:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>>> From: Eric Sunshine <sunshine@sunshineco.com>
>>>
>>> Parse the [common] block to create the array of group descriptions:
>>>
>>> static char *common_cmd_groups[] =3D {
>>>      N_("starting a working area"),
>>>      N_("working on the current change"),
>>>      N_("working with others"),
>>>      N_("examining the history and state"),
>>>      N_("growing, marking and tweaking your history"),
>>> };
>>>
>>> then map each element of common_cmds[] to a group via its index:
>>>
>>> static struct cmdname_help common_cmds[] =3D {
>>>      {"add", N_("Add file contents to the index"), 1},
>>>      {"branch", N_("List, create, or delete branches"), 4},
>>>      {"checkout", N_("Checkout a branch or paths to the ..."), 4},
>>>      {"clone", N_("Clone a repository into a new directory"), 0},
>>>      {"commit", N_("Record changes to the repository"), 4},
>>>      ...
>>> };
>>>
>>> so that 'git help' can print those commands grouped by theme.
>>>
>>> Only commands tagged with an attribute from [common] are emitted to
>>> common_cmds[].
>>>
>>> [commit message by S=C3=A9bastien Guimmara <sebastien.guimmara@gmai=
l.com>]
>>>
>>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>
>>> ---
>>
>> I seem to be getting an empty common_cmds[] list after this step
>> (with GNU Awk 4.0.1, ICIM).
>
> Indeed. I haven't had a chance to look at this version of the series
> yet, but a quick glance shows that this is because patch 2/5 uses
> "common-" as a prefix rather than as a standalone tag. That is, lines
> in patch 2/5 like this:
>
>      git-add  mainporcelain  common-worktree
>
> should be:
>
>      git-add  mainporcelain  common worktree
>
> as proposed here[1]. And, then patch 4/5 should drop the standalone
> "common" tag rather than the "common-" prefix.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/268756
>

Indeed, I misread your description. Thanks for pointing that out,
I will correct this.
