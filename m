From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions
Date: Fri, 6 May 2016 08:23:23 +0100
Organization: OPDS
Message-ID: <1C7D96C1B53D45CCAA8658C9DBB1AAB5@PhilipOakley>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org><1462483733-3496-2-git-send-email-philipoakley@iee.org> <xmqqk2j89n9y.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"git-for-windows" <git-for-windows@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aya6j-0000Yh-38
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 09:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbcEFHXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 03:23:25 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:21425 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcEFHXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 03:23:25 -0400
Received: from PhilipOakley ([92.22.48.52])
	by smtp.talktalk.net with SMTP
	id ya6caVUyQeSy4ya6cagj7F; Fri, 06 May 2016 08:23:23 +0100
X-Originating-IP: [92.22.48.52]
X-Spam: 0
X-OAuthority: v=2.2 cv=bsEOPwSi c=1 sm=1 tr=0 a=m5ih4TOYTMf86O/ibL3axQ==:117
 a=m5ih4TOYTMf86O/ibL3axQ==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=r2TvoERgIaZJQNkGoH8A:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfM8KYZncWEqZBtqWKC7jvFIEHlmxJVrsc9mSlcW7QUrMaoz7XSYMCtijGwkMedO3LjDM5S91iqCmj6Y6oNlyzfihJPuR4dQ3up+hA1RqNVD3gdSfkDFL
 bm89rLtv4yS210mE1Ck5KwMRfYhFgmkg5erVBkwo5GFYPP+lZJ6DLW00zKeqkOzkxth3vdQk1WJogAKyQFThrVgo1ITYSF7Iy+ANiPwHT9g8rcrFWVwKoQii
 ugskyAQOfvZd9NygulNvSfavd1lZhykHEkvy6rHf+JE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293750>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The short and sweet PREFIX can be confused when used in many places.
>>
>> Rename both usages to better describe their purpose.
>>
>> Noticed when compiling Git for Windows using MSVC/Visual Studio which
>> reports the conflict beteeen the command line definition and the
>> definition in sideband.c
>
> Good eyes.
>
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Makefile   | 2 +-
>>  exec_cmd.c | 4 ++--
>>  sideband.c | 6 +++---
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 33b0f76..bcdd3ec 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1973,7 +1973,7 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
>>  exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
>>  '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
>>  '-DBINDIR="$(bindir_relative_SQ)"' \
>> - '-DPREFIX="$(prefix_SQ)"'
>> + '-DEXEC_PREFIX="$(prefix_SQ)"'
>
> I am not entirely happy with this name as the name can be easily
> confused with GIT_EXEC_PATH.
>
> This is a fallback used under RUNTIME_PREFIX option, if I am reading
> the code correctly, so the name should hint the linkage between the
> "runtime prefix" mechanism and this variable.
>
> Perhaps RUNTIME_PREFIX_FALLBACK?  Used at only two places, that
> should not be an overlong name.

Perhaps EXEC_CMD_PREFIX, for that is what it is? And it's got a 2-way 
difference from the GIT_EXEC_PATH. I wasn't seeing it as a fallback, rather 
just a different way the OS uses to get to the path. If anything 
RUNTIME_PREFIX feels a bit long for a flag.

>
> DISPLAY_PREFIX is OK, as it is an entirely a local thing to
> sideband.c, but with the externally visible PREFIX fixed to be a
> more appropriate name that hints its relation with the "runtime
> prefix" mechanism, it may be better not to even touch it.
>
>>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
>>  builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = 
>> \
>> diff --git a/exec_cmd.c b/exec_cmd.c
>> index 9d5703a..2a79781 100644
>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
>> @@ -12,7 +12,7 @@ char *system_path(const char *path)
>>  #ifdef RUNTIME_PREFIX
>>  static const char *prefix;
>>  #else
>> - static const char *prefix = PREFIX;
>> + static const char *prefix = EXEC_PREFIX;
>>  #endif
>>  struct strbuf d = STRBUF_INIT;
>>
>> @@ -27,7 +27,7 @@ char *system_path(const char *path)
>>      !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
>>      !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
>>      !(prefix = strip_path_suffix(argv0_path, "git"))) {
>> - prefix = PREFIX;
>> + prefix = EXEC_PREFIX;
>>  trace_printf("RUNTIME_PREFIX requested, "
>>  "but prefix computation failed.  "
>>  "Using static fallback '%s'.\n", prefix);
> 
