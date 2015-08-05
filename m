From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule: implement `module_name` as a builtin helper
Date: Wed, 5 Aug 2015 12:55:30 -0700
Message-ID: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
	<1438733070-15805-2-git-send-email-sbeller@google.com>
	<55C25EBB.2000304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN4mo-0006hh-8I
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbHETzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 15:55:32 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33915 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbHETzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 15:55:31 -0400
Received: by ykax123 with SMTP id x123so44998305yka.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pnfm8b0kcnpf6IIAMPYQ84ptTzK2PLz35f2CmFssGwU=;
        b=LVRlQIcm4zJsxym8NESBPpk4FAWKVQLwy2dcED0PBO73hdyIYd/VpPgFLmXRIJtWEL
         ob95hO1Uso6hCBXoU2y06ZKE1beQDqNHzLPsxfXPk9eFO71SKn8w7143nHLS3IjNyvST
         db34FKTvjwj0B0wuFskNZ4JuKGRTnj2BSHjOyARxNX6jLtSbs5PBkAr888BfgLQZ5KPJ
         Tu4fZZvqNIAZF70G60qWjzxoYYiWRpmJiqRnhYoHalD8Wz5e1wo2lkCJ4Jy65uAIra8s
         5euf2VAHZ+2zV5w1E+VoEZ/tmIAyANu83YBYHNasEuOccWcJyPk7Q3oDsKlxjHwQ5ZAq
         C1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pnfm8b0kcnpf6IIAMPYQ84ptTzK2PLz35f2CmFssGwU=;
        b=BMRPNRtv4XEk/dwyVUE6COGmT9FEkg2c/foDOBKIitnJ3qG8i4/5tXqU1Xcous3x1F
         WkgF2VYp30OloEsdBZdtrTJHD/SoCuguhmNf14pZLqi0Nhm0uVX2C7Quc8l3iiwamG2+
         1FZXSTjmEmDag3k7G5TFuLjzjRBHyUgifkpXi0mWPiQhrddEaz8rfXWfmeLqb6SGkL3O
         rdLNA1AgGMTX8fGcNmotiHNiehsYB+ElYWdfVh3oeH+pNzTebRJa1qlyt4e6LNJJ5Bnl
         PTZRHqcZzmM2iRBSGVcyxnDhA0oS6YCV00Wsn5uaHsERxAo2H+UU+f+/R414el/0R41I
         JKxA==
X-Gm-Message-State: ALoCoQkqdGw2GNpzg0DNUxHJy6H2bQitBHbJ4OyX+FJBYnL/WseWInIp3UvyvVJCEtSlE2QVrBZM
X-Received: by 10.13.238.71 with SMTP id x68mr11430826ywe.129.1438804530499;
 Wed, 05 Aug 2015 12:55:30 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Wed, 5 Aug 2015 12:55:30 -0700 (PDT)
In-Reply-To: <55C25EBB.2000304@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275390>

On Wed, Aug 5, 2015 at 12:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 05.08.2015 um 02:04 schrieb Stefan Beller:
>>
>> The goal of this series being rewriting `git submodule update`,
>> we don't want to call out to the shell script for config lookups.
>>
>> So reimplement the lookup of the submodule name in C.
>
>
> Cool. This brings down the duration of the test suite from 3:13
> to 3:12 for me (best of three).
>
> You might wanna have a look into submodule.c: after initially
> calling gitmodules_config() one can lookup the submodule name
> in the static "config_name_for_path" string_list. If you'd add
> a public method to submodule.c which accesses that string_list
> and returns the name for the given path, you won't need your
> two new functions ... or am I missing something?

Yes I just realized there is already lots of submodule related code
written in C, so I wanted to look at that as the next step and see what
can be reused and maybe redo the patches reusing code.
