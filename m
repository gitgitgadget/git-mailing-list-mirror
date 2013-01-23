From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 21:17:06 +0100
Message-ID: <51004542.8010708@web.de>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com> <CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6lK-0008Us-AE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3AWURN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:17:13 -0500
Received: from mout.web.de ([212.227.17.12]:55783 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab3AWURM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:17:12 -0500
Received: from [192.168.178.41] ([91.3.166.4]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LmcRH-1UYGms2Ikd-00a2uM; Wed, 23 Jan 2013 21:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:tNQltmDT+LnWhCZm1MIl59VZDvElgX24hA7UkU2ZKqR
 TeuohyOJKvgnWVilR1mDoxRDizOm8KD/ZbMK/J/OEYN+IJkG78
 cXUv0XLPnhrfpWzrDLGO4bzC6jghWnofOm/8TbNzaqQ/1vM8im
 DUmtSon/LylWTRCYwaANb/hEp/nTO9/GlewoLDMQyXdmWSIWIO
 KncR+ZcJBL3n5aqzzBL1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214357>

Am 23.01.2013 09:55, schrieb Duy Nguyen:
> On Wed, Jan 23, 2013 at 3:12 PM, Lars Hjemli <hjemli@gmail.com> wrote:
>> +NAME
>> +----
>> +git-all - Execute a git command in multiple repositories
> 
> I agree with Junio "git-all" is too generic.

+1

>> +static int get_repo_state()
>> +{
>> +       const char *diffidx[] = {"diff", "--quiet", "--cached", NULL};
>> +       const char *diffwd[] = {"diff", "--quiet", NULL};
>> +
>> +       if (run_command_v_opt(diffidx, RUN_GIT_CMD) != 0)
>> +               return DIRTY;
>> +       if (run_command_v_opt(diffwd, RUN_GIT_CMD) != 0)
>> +               return DIRTY;
>> +       return CLEAN;
>> +}
> 
> Perhaps we could add the subrepo's object data to the in-memory object
> database of git-all, then do the diff without launching new commands?

You could do that for the "--cached" case, but not for the plain diff.
But I think forking a "git status --porcelain -uno" and testing if it
produced any output should do the trick with a single fork.
