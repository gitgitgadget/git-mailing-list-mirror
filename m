From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] generate-cmdlist: parse common group commands
Date: Thu, 14 May 2015 17:05:26 -0400
Message-ID: <CAPig+cTrDd3eYXo1WPoWRk5XSuLyH_m_VU1JsnP8pjkM=n6O2Q@mail.gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431608351-9413-4-git-send-email-sebastien.guimmara@gmail.com>
	<xmqq617ukhal.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0Jy-0003ND-At
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934115AbbENVF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 17:05:29 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33102 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933970AbbENVF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2015 17:05:27 -0400
Received: by igbpi8 with SMTP id pi8so19177431igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qneIfibJmsMKE83OUrzrJEt1GlNvRTtvpSzYj3JS9RE=;
        b=MM21L4IdK7T81n+KA6sMx2MPoQliC7sjYKssSjBr4zu0oXb3Opul4OrEtbZ+U3Yvqg
         uPO0jkMw38UiK8sdcN6FIO3XFVy9aJ+mbqrAzq5OGkLuvgcNHNxG6djrVX3OugTCByr9
         ZNUuPV+HoO92nPYOejfnUrnu/YbhAOy288T/9ByOZ/vd1C33QSNSaIgdtt25BKE7ULeH
         VdF/4Q2KDdsDTsChFwPjBWtPDQuhqQJRAhj2QURWEtP+JznTrJJzBAA6z2zhAIXATVQz
         khstv6ZMMpdZ34GnCysc7q/lu+AXOPG+X+JsOjHz2KosEAQnKpQ1mfd7dPNuezf6WFHD
         K+yw==
X-Received: by 10.42.67.80 with SMTP id s16mr2641180ici.25.1431637526577; Thu,
 14 May 2015 14:05:26 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 14 May 2015 14:05:26 -0700 (PDT)
In-Reply-To: <xmqq617ukhal.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: SDLxhv1-p9NZ4ChGmHLbmTiBxKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269095>

On Thu, May 14, 2015 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>> From: Eric Sunshine <sunshine@sunshineco.com>
>>
>> Parse the [common] block to create the array of group descriptions:
>>
>> static char *common_cmd_groups[] =3D {
>>     N_("starting a working area"),
>>     N_("working on the current change"),
>>     N_("working with others"),
>>     N_("examining the history and state"),
>>     N_("growing, marking and tweaking your history"),
>> };
>>
>> then map each element of common_cmds[] to a group via its index:
>>
>> static struct cmdname_help common_cmds[] =3D {
>>     {"add", N_("Add file contents to the index"), 1},
>>     {"branch", N_("List, create, or delete branches"), 4},
>>     {"checkout", N_("Checkout a branch or paths to the ..."), 4},
>>     {"clone", N_("Clone a repository into a new directory"), 0},
>>     {"commit", N_("Record changes to the repository"), 4},
>>     ...
>> };
>>
>> so that 'git help' can print those commands grouped by theme.
>>
>> Only commands tagged with an attribute from [common] are emitted to
>> common_cmds[].
>>
>> [commit message by S=C3=A9bastien Guimmara <sebastien.guimmara@gmail=
=2Ecom>]
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>
> I seem to be getting an empty common_cmds[] list after this step
> (with GNU Awk 4.0.1, ICIM).

Indeed. I haven't had a chance to look at this version of the series
yet, but a quick glance shows that this is because patch 2/5 uses
"common-" as a prefix rather than as a standalone tag. That is, lines
in patch 2/5 like this:

    git-add  mainporcelain  common-worktree

should be:

    git-add  mainporcelain  common worktree

as proposed here[1]. And, then patch 4/5 should drop the standalone
"common" tag rather than the "common-" prefix.

[1]: http://article.gmane.org/gmane.comp.version-control.git/268756
