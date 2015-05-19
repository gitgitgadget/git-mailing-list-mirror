From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Tue, 19 May 2015 15:10:51 +0200
Organization: gmx
Message-ID: <5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-15-git-send-email-pyokagan@gmail.com>
 <CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stephen Robin <stephen.robin@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuhIS-0002U4-BX
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbbESNKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:10:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:50777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbbESNKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:10:54 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTCDO-1YmTYA08YA-00SBEU; Tue, 19 May 2015 15:10:52
 +0200
In-Reply-To: <CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:I+lKTlNnGDEcAMbunbx70neMQmqnnF8D/gya7g1FSwX8JVsyf6H
 WuqhizPLI3v7w0O/SMzq4D3xZf1hdNPSiURGUXBZZ9k44EhttgbyOxmel6w9mbJxlzwLkzw
 2Voz0sp8NL1H8Iy7eMCruv1cPdy/wMKNfapdimxjqQRA0CgVcM7gT+Uds+uJ8++Xz8oarb/
 KpE6rea56m5SHgz0XyjAw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269351>

Hi,

On 2015-05-19 02:12, Stefan Beller wrote:
> On Mon, May 18, 2015 at 8:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> Tweak the error messages printed by die_no_merge_candidates() to take
>> into account that we may be "rebasing against" rather than "merging
>> with".
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>>  builtin/pull.c | 42 +++++++++++++++++++++++++-----------------
>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index c8d673d..15b65a0 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -474,10 +474,12 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>>         const char *remote = curr_branch ? curr_branch->remote_name : NULL;
>>
>>         if (*refspecs) {
>> -               fprintf(stderr,
>> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
>> -                       "Generally this means that you provided a wildcard refspec which had no\n"
>> -                       "matches on the remote end.\n"));
>> +               if (opt_rebase)
>> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
> 
> Is there a reason you switch to fputs, instead of fprintf?
> $grep -I -r fputs|wc -l
> 123
> $ grep -I -r fprintf|wc -l
> 689
> 
> fputs seems to be used already, though I never came across these parts
> of the code
> myself, so I wondered if we had fputs in the code base already.

My guess was that the new-line I expected and did not see in the `fputs()` call was the reason. But according to http://pubs.opengroup.org/onlinepubs/009695399/functions/fputs.html:

    The puts() function appends a <newline> while fputs() does not.

This comment concludes my review on this round of this patch series. It required quite some time to review, so it must have taken quite a bit more to actually write it: impressive work!

Ciao,
Dscho
