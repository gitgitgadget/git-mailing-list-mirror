From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] bisect: display first bad commit without forking a new
 process
Date: Thu, 28 May 2009 10:04:30 +0200
Message-ID: <4A1E458E.6050505@op5.se>
References: <20090527052354.3824.22018.chriscool@tuxfamily.org>	<200905272107.52095.chriscool@tuxfamily.org> <7veiuai33m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 10:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9abS-0007mB-Qw
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 10:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbZE1IEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 04:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbZE1IEd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 04:04:33 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:34703 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751162AbZE1IEa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 04:04:30 -0400
Received: from source ([72.14.220.155]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh5FjlPWcqlcEtg5rIPBxhaCItbX+q34@postini.com; Thu, 28 May 2009 01:04:32 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1950377fga.10
        for <git@vger.kernel.org>; Thu, 28 May 2009 01:04:29 -0700 (PDT)
Received: by 10.86.62.3 with SMTP id k3mr1233438fga.28.1243497869445;
        Thu, 28 May 2009 01:04:29 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e11sm4697793fga.1.2009.05.28.01.04.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 01:04:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7veiuai33m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120168>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>=20
>> Le Wednesday 27 May 2009, Christian Couder a =E9crit :
>>> Previously "git diff-tree --pretty COMMIT" was run using
>>> "run_command_v_opt" to display information about the first bad
>>> commit.
>>>
>>> The goal of this patch is to avoid a "fork" and an "exec" call
>>> when displaying that information.
>>>
>>> To do that, we manually setup revision information as
>>> "git diff-tree --pretty" would do it, and then use the
>>> "log_tree_commit" function.
>>>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>>  bisect.c |   30 +++++++++++++++++++++++++++---
>>>  1 files changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/bisect.c b/bisect.c
>>> index c43c120..e94a77b 100644
>>> --- a/bisect.c
>>> +++ b/bisect.c
>>> @@ -816,6 +816,31 @@ static void check_good_are_ancestors_of_bad(co=
nst
>>> char *prefix) }
>>>
>>>  /*
>>> + * This does "git diff-tree --pretty COMMIT" without one fork+exec=
=2E
>>> + */
>>> +static void show_diff_tree(const char *prefix, struct commit *comm=
it)
>>> +{
>>> +	static struct rev_info opt;
>> Oops, "static" can be removed, it's a copy-paste error, sorry.
>=20
> Is that "can" or "must"?  If the answer is the latter, shouldn't the
> function be renamed to make it clear it is a bisect specific thing?

I think he was referring to the 'static' in the variable declarations.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
