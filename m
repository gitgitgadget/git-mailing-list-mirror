Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A49EEAA69
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 19:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjINTfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjINTfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 15:35:39 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501E26AB
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1694720089; x=1695324889; i=l.s.r@web.de;
 bh=ODVbxDD18Tls6oavEwj6A+NXDusz022LiJ8yUElP3rY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NWBgXhjJJCsOJ78+lxYbSEnc+MRr5xOEZ9kyHTKML/Acevk1/cYCzBNoq+yyv5x9uX2sCQ5wAc7
 +/60wM8g4sXOVM4RAzC+Nm9enA2vFF8J0AzzfLPArjeAbJGONpXWl3eJ6zXwJKrShHk8+YhVxcS6v
 Mv7KEaLDLmCc0knpTRYQA1aSKXJW7qhg2eA8yXY/BD5ISbkR37yQIynw8LTzD6L8ffAOOfgdLj5N9
 7+5QV6/aX7/vz0xx2w4r0nmikhkb5y415OR1a/M1Ak3mtYVOkxa3Hiss7uerB+JrGJxENRXs4jZr6
 yS8hotEscLuHRUYjQek1FJNso7q+kpzYLnOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1r5rD22XSX-00PfWU; Thu, 14
 Sep 2023 21:34:49 +0200
Message-ID: <9203cd46-6a81-38e4-f191-da0b51e238c1@web.de>
Date:   Thu, 14 Sep 2023 21:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com> <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com> <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
 <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de> <xmqq1qf2lxrm.fsf@gitster.g>
 <20230913094638.GA535@redhat.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230913094638.GA535@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbGaJ9EDarpZmFsECj4n6QT48rzsKtDSJMlsihlHfkjxMv0UfMI
 MEbtk3JncdDf2I++YKlbIA0zoNos5+Rk0WjDBnmh/3bpm0VSLwJnmKoDPMObcd0pbJxBFbk
 u++EJVyHzaQck1DJcOO5laHVGYdgnJ1r6q+AbYsr47G+40WY6jFZJt7BX0961Cyo6l+n1IN
 gJJF6Ylf6HCxQMh+ryBzQ==
UI-OutboundReport: notjunk:1;M01:P0:jDBZYUeVpjY=;XL6vO12UVVSHW66Tt9UPk7GUMx1
 MoU62xpbQjgfgJ6i6vZTU7VQC+HxlDkjxhylE96yv6X/gSjYCo+Yk4W+hfjzq9PK7mWQFUzoO
 RE68+mj9pufhRVN1bUX6rvxZKryX0aQ7pDTEeKM47GFXZ9zLV42UILqHXcpK0iMCpsAXW8E7j
 jTyQUW4it/auLnH0PWMarjSw99QkjsYjY1UFPBEJe7vBaLwDGM0sbwKMMXpq2vH9mLws+T0Yn
 6rLuYWjQqz+OpKos5EbuFGgIojUVEEdjKQsZLpGfpNgJF4iunYzT4NHp+dou3XYlJUrP2Giks
 gUqkOwdRJ8jqHC7TTq68YzPJWvrtgVzzfbsVO9C8L4TLjN2bUk7H1AafNLaUuRH+L3XiRjokd
 +PKO5OkQTXQB6UazA8N7G/Jpsw8EIqqs1Pj23amKMFnius4OSzD4xubsQgRchE5G8d6quGnSP
 w3VsNtlbPJXZXJY4E6APKYWRTK0Ix4E8H2VyFqNGua7I6rwKcvg40nccj58iuWnOFtDevGFNw
 aOMex3ihoi/t/9JmAXkk/BCoCPhdfbps9q6YU546l2mrM6LUJZQ7mPMUyoyLY258XukKbifso
 kZoptiAZr5bKMSlXNjPAFnJJWQZp1JwA+74dIewCwLw1+5iZIIm1/teuJnTsYVxlEAaGVTX/6
 ostICpwKfXOh2KSAtbFGZr/DH0Hn7xoThFD7TM6yHCjRTfUXYJpRdDQ+2SK/VJPHF627aej2j
 WziR5RtZrXWj1Oh3jsvvgtbHJTEfyw8MGwExQP9kFeBAqIPUXpdTYxuj7pIhlZz3Z6gkBXTRt
 wrQPi+gS8+ut/yFJ3GsvetqVPidz13kLKXOZhQMc/7Lhppngb3zzhZcDRPomnfitUkpjAor2R
 uyb4Fo+yjLDrDZroLrzjJ+1yLp5KjGjU5OKDEh4HKfwHEpfAAmB8kDWoVDDvv7A1cmj4oUBrH
 00GkhA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.23 um 11:46 schrieb Oleg Nesterov:
> I think I should trim CC to not spam the people who are not
> interested in this discussion...
>
> On 09/12, Junio C Hamano wrote:
>>
>> Documentation may not match the behaviour, but do we know what the
>> behaviour we want is?  To me, the last example that shows the same
>> line twice (one as a real hit, the other because of "-p") looks a
>> bit counter-intuitive for the purpose of "help me locate where the
>> grep hits are".  I dunno.
>
> I have another opinion. To me the 2nd "=3D..." marker does help to
> understand the hit location. But this doesn't matter.

You see it as another layer of information, as an annotation, an
additional line containing meta-information.  I saw them as context
lines, i.e. lines from the original file shown in the original order
without duplication, like - lines, with the only place for meta-
information being the marker character itself.

> Let me repeat: scripts.
>
> I tried to explain this in 0/1 and in my other replies, but lets
> start from the very beginning once again.
>
> I've never used git-grep with -p/-n and most probably never will.
> But 3 days ago my text editor (vi clone) started to use "grep -pn".
>
> 	$ cat -n TEST.c
>
> 	     1	void func1(struct pid *);
> 	     2
> 	     3	void func2(struct pid *pid)
> 	     4	{
> 	     5		use1(pid);
> 	     6	}
> 	     7
> 	     8	void func3(struct pid *pid)
> 	     9	{
> 	    10		use2(pid);
> 	    11	}
>
>
> when I do
>
> 	:git-grep --untracked -pn pid TEST.c
>
> in my editor it calls the script which parses the output from git-grep
> and puts this
>
> 	<pre>
> 	<a href=3D"TEST.c?1">TEST.c                  </a>    1 <b>             =
           </b> void func1(struct <i>pid</i> *);
> 	<a href=3D"TEST.c?3">TEST.c                  </a>    3 <b>             =
           </b> void func2(struct <i>pid</i> *<i>pid</i>)
> 	<a href=3D"TEST.c?5">TEST.c                  </a>    5 <b>func2        =
           </b> use1(<i>pid</i>);
> 	<a href=3D"TEST.c?8">TEST.c                  </a>    8 <b>             =
           </b> void func3(struct <i>pid</i> *<i>pid</i>)
> 	<a href=3D"TEST.c?10">TEST.c                  </a>   10 <b>func3       =
            </b> use2(<i>pid</i>);
> 	</pre>
>
> html to the text buffer which is nicely displayed as
>
> 	TEST.c                      1                          void func1(struc=
t pid *);
> 	TEST.c                      3                          void func2(struc=
t pid *pid)
> 	TEST.c                      5 func2                    use1(pid);
> 	TEST.c                      8                          void func3(struc=
t pid *pid)
> 	TEST.c                     10 func3                    use2(pid);
>
> and I can use Ctrl-] to jump to the file/function/location.
>
> And this script is very simple, it parses the output line-by-line. When
> it sees the "=3D" marker it does some minimal post-processing, records t=
he
> function name to display it in the 3rd column later, and goes to the nex=
t
> line.
>
> But without my patch, in this case I get
>
> 	TEST.c                      1                          void func1(struc=
t pid *);
> 	TEST.c                      3                          void func2(struc=
t pid *pid)
> 	TEST.c                      5                          use1(pid);
> 	TEST.c                      8                          void func3(struc=
t pid *pid)
> 	TEST.c                     10                          use2(pid);
>
> because the output from git-grep
>
> 	$ git grep --untracked -pn pid TEST.c
> 	TEST.c:1:void func1(struct pid *);
> 	TEST.c:3:void func2(struct pid *pid)
> 	TEST.c:5:       use1(pid);
> 	TEST.c:8:void func3(struct pid *pid)
> 	TEST.c:10:      use2(pid);
>
> doesn't have the "=3D..." markers at all.

Sure, that's a problem.  You could easily check whether a match is also
a function line according to the default heuristic (does the line start
with a letter, dollar sign or underscore?), e.g. with a glob like
"*:*:[a-zA-Z$_]*".  If git grep uses more sophisticated rules then it
becomes impractical -- there are some impressive regexes in userdiff.c
and the script would have to figure out which language the file is
configured to be for Git in the first place.

> But TEST.c is just the trivial/artificial example. From 0/1,
>
> When I do
>
> 	:git-grep -pw pid kernel/sys.c
>
> in my editor without this patch, I get
>
> 	kernel/sys.c              224 sys_setpriority          struct pid *pgrp=
;
> 	kernel/sys.c              294 sys_getpriority          struct pid *pgrp=
;
> 	kernel/sys.c              952                          * Note, despite =
the name, this returns the tgid not the pid.  The tgid and
> 	kernel/sys.c              953                          * the pid are id=
entical unless CLONE_THREAD was specified on clone() in
> 	kernel/sys.c              963                          /* Thread ID - t=
he internal kernel "pid" */
> 	kernel/sys.c              977 sys_getppid              int pid;
> 	kernel/sys.c              980 sys_getppid              pid =3D task_tgi=
d_vnr(rcu_dereference(current->real_parent));
> 	kernel/sys.c              983 sys_getppid              return pid;
> 	kernel/sys.c             1073                          SYSCALL_DEFINE2(=
setpgid, pid_t, pid, pid_t, pgid)
> 	kernel/sys.c             1077 sys_times                struct pid *pgrp=
;
> 	kernel/sys.c             1080 sys_times                if (!pid)
> 	kernel/sys.c             1081 sys_times                pid =3D task_pid=
_vnr(group_leader);
> 	kernel/sys.c             1083 sys_times                pgid =3D pid;
> 	kernel/sys.c             1094 sys_times                p =3D find_task_=
by_vpid(pid);
> 	kernel/sys.c             1120 sys_times                if (pgid !=3D pi=
d) {
> 	kernel/sys.c             1144                          static int do_ge=
tpgid(pid_t pid)
> 	kernel/sys.c             1147 sys_times                struct pid *grp;
> 	kernel/sys.c             1151 sys_times                if (!pid)
> 	kernel/sys.c             1155 sys_times                p =3D find_task_=
by_vpid(pid);
> 	kernel/sys.c             1172                          SYSCALL_DEFINE1(=
getpgid, pid_t, pid)
> 	kernel/sys.c             1174 sys_times                return do_getpgi=
d(pid);
> 	kernel/sys.c             1186                          SYSCALL_DEFINE1(=
getsid, pid_t, pid)
> 	kernel/sys.c             1189 sys_getpgrp              struct pid *sid;
> 	kernel/sys.c             1193 sys_getpgrp              if (!pid)
> 	kernel/sys.c             1197 sys_getpgrp              p =3D find_task_=
by_vpid(pid);
> 	kernel/sys.c             1214                          static void set_=
special_pids(struct pid *pid)
> 	kernel/sys.c             1218 sys_getpgrp              if (task_session=
(curr) !=3D pid)
> 	kernel/sys.c             1219 sys_getpgrp              change_pid(curr,=
 PIDTYPE_SID, pid);
> 	kernel/sys.c             1221 sys_getpgrp              if (task_pgrp(cu=
rr) !=3D pid)
> 	kernel/sys.c             1222 sys_getpgrp              change_pid(curr,=
 PIDTYPE_PGID, pid);
> 	kernel/sys.c             1228 ksys_setsid              struct pid *sid =
=3D task_pid(group_leader);
> 	kernel/sys.c             1684                          SYSCALL_DEFINE4(=
prlimit64, pid_t, pid, unsigned int, resource,
> 	kernel/sys.c             1705 check_prlimit_permission tsk =3D pid ? fi=
nd_task_by_vpid(pid) : current;
>
> And only the first 5 funcnames are correct.

Well, your script turns "SYSCALL_DEFINE3(setpriority, [...]" into
"sys_setpriority" etc., so it is already knows a lot about function lines.
It could be made to take a second look at match lines, I guess.

But a general solution would require git grep to somehow report both aspec=
ts
of matching function lines.  That's easy if we allow ourselves to duplicat=
e
lines.  This is strange enough to warrant making it a new output format I
think.

Another possibility is to switch the precedence of : and =3D.  With match
coloring it would still be possible to identify most positive matches in
function interactively, but not negative matches (-v) in function lines.
Probably not the best choice, since grep is primarily about finding
matching lines; function line info comes second.

Can we use two markers, i.e. both : and =3D?  No idea what that might brea=
k.

There is a Unicode symbol named colon equals, which looks like this: =E2=
=89=94
We added the =3D, so I guess we could add that thing as well.  But is the
world prepared for Unicode output?  Not sure.  If we need to stay in the
ASCII table the same idea could be implemented with a different character
like # or ;.

> And note that this case is very simple too (I mostly use :git-grep to sc=
an
> the whole linux kernel tree), but even in this simple case I don't think=
 it
> makes sense to use "git-grep -pn" directly, the output is hardly readabl=
e
> (at least to me) with or without my patch.

So with the patch below this would look like this:

kernel/sys.c=3D218=3DSYSCALL_DEFINE3(setpriority, int, which, int, who, in=
t, niceval)
kernel/sys.c:224:       struct pid *pgrp;
kernel/sys.c=3D288=3DSYSCALL_DEFINE2(getpriority, int, which, int, who)
kernel/sys.c:294:       struct pid *pgrp;
kernel/sys.c=3D943=3DSYSCALL_DEFINE1(setfsgid, gid_t, gid)
kernel/sys.c:952: * Note, despite the name, this returns the tgid not the =
pid.  The tgid and
kernel/sys.c:953: * the pid are identical unless CLONE_THREAD was specifie=
d on clone() in
kernel/sys.c=3D958=3DSYSCALL_DEFINE0(getpid)
kernel/sys.c:963:/* Thread ID - the internal kernel "pid" */
kernel/sys.c=3D975=3DSYSCALL_DEFINE0(getppid)
kernel/sys.c:977:       int pid;
kernel/sys.c:980:       pid =3D task_tgid_vnr(rcu_dereference(current->rea=
l_parent));
kernel/sys.c:983:       return pid;
kernel/sys.c#1073#SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
kernel/sys.c:1077:      struct pid *pgrp;
kernel/sys.c:1080:      if (!pid)
kernel/sys.c:1081:              pid =3D task_pid_vnr(group_leader);
kernel/sys.c:1083:              pgid =3D pid;
kernel/sys.c:1094:      p =3D find_task_by_vpid(pid);
kernel/sys.c:1120:      if (pgid !=3D pid) {
kernel/sys.c#1144#static int do_getpgid(pid_t pid)
kernel/sys.c:1147:      struct pid *grp;
kernel/sys.c:1151:      if (!pid)
kernel/sys.c:1155:              p =3D find_task_by_vpid(pid);
kernel/sys.c#1172#SYSCALL_DEFINE1(getpgid, pid_t, pid)
kernel/sys.c:1174:      return do_getpgid(pid);
kernel/sys.c#1186#SYSCALL_DEFINE1(getsid, pid_t, pid)
kernel/sys.c:1189:      struct pid *sid;
kernel/sys.c:1193:      if (!pid)
kernel/sys.c:1197:              p =3D find_task_by_vpid(pid);
kernel/sys.c#1214#static void set_special_pids(struct pid *pid)
kernel/sys.c:1218:      if (task_session(curr) !=3D pid)
kernel/sys.c:1219:              change_pid(curr, PIDTYPE_SID, pid);
kernel/sys.c:1221:      if (task_pgrp(curr) !=3D pid)
kernel/sys.c:1222:              change_pid(curr, PIDTYPE_PGID, pid);
kernel/sys.c=3D1225=3Dint ksys_setsid(void)
kernel/sys.c:1228:      struct pid *sid =3D task_pid(group_leader);
kernel/sys.c#1684#SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, res=
ource,
kernel/sys.c:1705:      tsk =3D pid ? find_task_by_vpid(pid) : current;

It uses # for matches that happen to be function lines, and doesn't show
a previous function line for those anymore.  Usable?

Ren=C3=A9


diff --git a/grep.c b/grep.c
index fc2d0c837a..a08da5cdcb 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -1681,6 +1681,7 @@ static int grep_source_1(struct grep_opt *opt, struc=
t grep_source *gs, int colle
 			goto next_line;
 		}
 		if (hit && (opt->max_count < 0 || count < opt->max_count)) {
+			char sign =3D ':';
 			count++;
 			if (opt->status_only)
 				return 1;
@@ -1697,12 +1698,14 @@ static int grep_source_1(struct grep_opt *opt, str=
uct grep_source *gs, int colle
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
+			if (opt->funcname && match_funcname(opt, gs, bol, eol))
+				sign =3D '#';
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
 			 */
 			if (opt->pre_context || opt->funcbody)
 				show_pre_context(opt, gs, bol, eol, lno);
-			else if (opt->funcname)
+			else if (opt->funcname && sign =3D=3D ':')
 				show_funcname_line(opt, gs, bol, lno);
 			cno =3D opt->invert ? icol : col;
 			if (cno < 0) {
@@ -1715,7 +1718,7 @@ static int grep_source_1(struct grep_opt *opt, struc=
t grep_source *gs, int colle
 				 */
 				cno =3D 0;
 			}
-			show_line(opt, bol, eol, gs->name, lno, cno + 1, ':');
+			show_line(opt, bol, eol, gs->name, lno, cno + 1, sign);
 			last_hit =3D lno;
 			if (opt->funcbody)
 				show_function =3D 1;
