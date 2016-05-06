From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-for-windows] [PATCH] exec_cmd.c, sideband.c, Makefile: avoid multiple PREFIX definitions
Date: Fri, 6 May 2016 08:31:17 +0100
Organization: OPDS
Message-ID: <1F2FA999624B417EB2EC2FF7F2EA3828@PhilipOakley>
References: <1462483733-3496-1-git-send-email-philipoakley@iee.org> <1462483733-3496-2-git-send-email-philipoakley@iee.org> <572C3723.8010508@kdbg.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"git-for-windows" <git-for-windows@googlegroups.com>
To: "Johannes Sixt" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 06 09:31:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayaEO-0005Ik-RE
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 09:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916AbcEFHbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 03:31:21 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24007 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbcEFHbU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 03:31:20 -0400
Received: from PhilipOakley ([92.22.48.52])
	by smtp.talktalk.net with SMTP
	id yaEHaVVppeSy4yaEHagjIQ; Fri, 06 May 2016 08:31:18 +0100
X-Originating-IP: [92.22.48.52]
X-Spam: 0
X-OAuthority: v=2.2 cv=bsEOPwSi c=1 sm=1 tr=0 a=m5ih4TOYTMf86O/ibL3axQ==:117
 a=m5ih4TOYTMf86O/ibL3axQ==:17 a=IkcTkHD0fZMA:10 a=A9qS8gIqAAAA:8
 a=umzJTlx7EUpHSCjmAOUA:9 a=H28RkzuXznr5akrmL4QT:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAteL6n75/Q+rm46Cm/kc9EuBACKO7dE9lE/nVxYjYSSfpzwhOB9IFxg6fZKelqkoYw39y3Y9196qYSTtdBKgdMS8w6rmRipoRuFphW7mO7FjY1QYPVf
 OLJCWBjreR8L8wPY4gwsobix3pzc6zXFgog2K8wUG/Nuzg7p+LgoaB5HIOVL6hDaZ+AVaGrF5iFAD3f5sP+dReCvVFInP9fUj7XatVmcyMzzE5UYfGE5NVh6
 5M1rZzSCmBlUupa0gc0wvbIWCZQtVTbrI0xwnCSIt7UMif/nrHzbu7eZORPxH59o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293751>

From: "Johannes Sixt" <j6t@kdbg.org>
> Am 05.05.2016 um 23:28 schrieb Philip Oakley:
>> The short and sweet PREFIX can be confused when used in many places.
>>
>> Rename both usages to better describe their purpose.
>>
>> Noticed when compiling Git for Windows using MSVC/Visual Studio which
>> reports the conflict beteeen the command line definition and the
>> definition in sideband.c
>
> You should describe the circumstances better under which you notice a 
> conflict, because there is no conflict when Git is built with the Makefile 
> and 'make':

I haven't dug deep into the G4W make results so I can't say either way 
regarding the make on G4W, but it does show when creating the Git.sln 
project via the contrib process. It is specific to the Windows OS and how it 
generates the path to the exe (You will know far more than me).

see below regarding commit message

>
>> diff --git a/Makefile b/Makefile
>> index 33b0f76..bcdd3ec 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1973,7 +1973,7 @@ exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
>>   exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
>>   '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
>>   '-DBINDIR="$(bindir_relative_SQ)"' \
>> - '-DPREFIX="$(prefix_SQ)"'
>> + '-DEXEC_PREFIX="$(prefix_SQ)"'
>
> Notice that PREFIX is set only for a small subset of .c files. sideband.c 
> is not among them.

The issue is in the libgit sub-project, where both reside side by side, and 
when sideband.c is being compiled, the PREFIX has also been declared on the 
command line, thus giving the unexpected conflict.

I'll bring more of the explanation into the commit message.

--
Philip 
