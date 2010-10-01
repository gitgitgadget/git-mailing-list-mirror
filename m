From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: prepare grep for submodules
Date: Fri, 01 Oct 2010 09:26:29 -0700
Message-ID: <4CA60BB5.4080202@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>	<1285792134-26339-3-git-send-email-judge.packham@gmail.com>	<AANLkTik3bvJneak9gjG8O1A=LZeivPkFc6MF5_T7nbWo@mail.gmail.com>	<4CA4D820.5040100@gmail.com> <AANLkTikH+sd2kPAraGSTB-ik-Toz3s2nTLoLVOj86oSm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jens.Lehmann" <Jens.Lehmann@web.de>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 18:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1iR8-0000yT-FM
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 18:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab0JAQ0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 12:26:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65529 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0JAQ0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 12:26:12 -0400
Received: by pzk34 with SMTP id 34so809811pzk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sZnIhFztviYejkjI7r+sapugCy4UNmi27MksPGPMaGk=;
        b=CMc+lalnZ7VMYMPQ1yDOQrs6ROGmnJL4/z8s1COw33FR27EymvePt7NI9Y39E1Vajo
         0dNSR1oqFvv8MtGtzIjnuxWtSOF6sMBctGJvmEAZXibG0bNqdQTgKtBPBrpgTEDDFJCY
         S6TlIqPGIMzi8pq4cSsv7b0rYQfAdtuyiEmgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x70DqSq/XLD6hWQJzPZBL3l07KUrOVD+VBc224lwfe5t21mJoIG8YkmLLlSgjScH64
         CaC6MjFY4yOW/ZkJqXx/HT6jKedWI/ME2oc9ujX/02NPnwRAYaSlo0RATnXuRE0UDafT
         hcXYCpmvkrUhVjU1fLvGhbiFaP89M2fYXfbrg=
Received: by 10.114.88.18 with SMTP id l18mr6488061wab.92.1285950370993;
        Fri, 01 Oct 2010 09:26:10 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm2146799wam.4.2010.10.01.09.26.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 09:26:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTikH+sd2kPAraGSTB-ik-Toz3s2nTLoLVOj86oSm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157761>

On 01/10/10 07:37, Nguyen Thai Ngoc Duy wrote:
> On 10/1/10, Chris Packham <judge.packham@gmail.com> wrote:
>>  > You can make setup_explicit_git_dir() realize that situation (cur=
rent
>>  > working directory outside $GIT_WORK_TREE), then calculate and sav=
e the
>>  > submodule prefix in startup_info struct. Then "git grep" or any
>>  > commands can just read startup_info to find out the submodule pre=
fix.
>>
>>
>> Here's my first naive attempt at implementing what you describe. Nee=
ds
>>  tests, more comments, sign-off etc.
>=20
> Thanks.
>=20
>>  One situation that could be handled better is when the cwd is a
>>  subdirectory of the specified worktree. At the moment this ends up
>>  giving the full path to the worktree, the output would look much ni=
cer
>>  if it gave the relative path (e.g. ../../).
>=20
> Hmm.. if cwd is inside a worktree, prefix (the 3rd parameter in
> cmd_grep) should be correctly set and "git grep" should also show
> relative path. Or are you talking about another command?

I was testing this with grep but also with my submodule changes. I
should probably move this to its own topic branch and get it working
then rebase my grep changes on top of it.

>>
>>  ---8<---
>>  From: Chris Packham <judge.packham@gmail.com>
>>  Date: Thu, 30 Sep 2010 11:19:29 -0700
>>  Subject: [RFC PATCH] save the work tree prefix in startup_info
>>
>>  This is the relative path between the cwd and the worktree or the
>>  absolute path of the worktree if the worktree is not a subdirectory
>>  of the worktree.
>>  ---
>>   cache.h |    1 +
>>   dir.c   |   26 ++++++++++++++++++++++++++
>>   dir.h   |    1 +
>>   setup.c |    4 ++++
>>   4 files changed, 32 insertions(+), 0 deletions(-)
>>
>>  diff --git a/cache.h b/cache.h
>>  index e1d3ffd..f320e78 100644
>>  --- a/cache.h
>>  +++ b/cache.h
>>  @@ -1111,6 +1111,7 @@ const char *split_cmdline_strerror(int cmdlin=
e_errno);
>>   /* git.c */
>>   struct startup_info {
>>         int have_repository;
>>  +       const char *prefix;
>=20
> You should use another name here to avoid confusion with the current
> prefix, relative to worktree toplevel directory. I'm thinking of
> outer_prefix or cwd_prefix, but I'm usually bad at naming.

I couldn't come up with a better name either, that=E2=80=99s why I used
"prefix". "cwd_prefix" seems sensible enough to me.

>>   };
>>   extern struct startup_info *startup_info;
>>
>>  diff --git a/dir.c b/dir.c
>>  index 58ec1a1..2148730 100644
>>  --- a/dir.c
>>  +++ b/dir.c
>>  @@ -1036,6 +1036,32 @@ char *get_relative_cwd(char *buffer, int siz=
e,
>>  const char *dir)
>>         }
>>   }
>>
>>  +char *get_relative_wt(char *buffer, int size, const char *dir)
>>  +{
>>  +       char *cwd =3D buffer;
>>  +
>>  +       if (!dir)
>>  +               return NULL;
>>  +       if (!getcwd(buffer, size))
>>  +               die_errno("can't find the current directory");
>>  +       if (!is_absolute_path(dir))
>>  +               dir =3D make_absolute_path(dir);
>>  +       if (strstr(dir, cwd)) {
>=20
> Why not strncmp?

I actually tried strcmp first, expecting to get a number that I can
increment dir by. What I actually got was -1, maybe I just screwed up
the order of dir and cwd. I'll look into it.

>=20
>>  +               dir +=3D strlen(cwd);
>>  +               switch(*dir){
>>  +               case '\0':
>>  +                       return NULL;
>>  +               case '/':
>>  +                       dir++;
>>  +                       break;
>=20
> Yeah.
>=20
>>  +               default:
>>  +                       break;
>=20
> Should we properly handle relative path that includes ".." here too?=20

By now dir and cwd are both absolute paths. So I dn't think there is
anything to handle

>>  +               }
>>  +       }
>>  +       strncpy(buffer, dir, size);
>=20
> So if "cwd" is inside "dir", an absolute "dir" is returned? That does
> not look like a prefix to me.

That is a problem. Maybe I should be returning NULL in that case and le=
t
the existing code handle the cwd inside dir case. I think if I wrote
some tests first I could see the various permutations better.

>>  +       return buffer;
>>  +}
>>  +
>>   int is_inside_dir(const char *dir)
>>   {
>>         char buffer[PATH_MAX];
>>  diff --git a/dir.h b/dir.h
>>  index b3e2104..d3c161f 100644
>>  --- a/dir.h
>>  +++ b/dir.h
>>  @@ -81,6 +81,7 @@ extern void add_exclude(const char *string, const=
 char
>>  *base,
>>   extern int file_exists(const char *);
>>
>>   extern char *get_relative_cwd(char *buffer, int size, const char *=
dir);
>>  +extern char *get_relative_wt(char *buffer, int size, const char *d=
ir);
>>   extern int is_inside_dir(const char *dir);
>>
>>   static inline int is_dot_or_dotdot(const char *name)
>>  diff --git a/setup.c b/setup.c
>>  index a3b76de..bd9d9fd 100644
>>  --- a/setup.c
>>  +++ b/setup.c
>>  @@ -317,6 +317,7 @@ static const char *setup_explicit_git_dir(const=
 char
>>  *gitdirenv,
>>                                 const char *work_tree_env, int *nong=
it_ok)
>>   {
>>         static char buffer[1024 + 1];
>>  +       static char wtbuf[1024 + 1];
>>         const char *retval;
>>
>>         if (PATH_MAX - 40 < strlen(gitdirenv))
>>  @@ -337,6 +338,9 @@ static const char *setup_explicit_git_dir(const=
 char
>>  *gitdirenv,
>>         }
>>         if (check_repository_format_gently(nongit_ok))
>>                 return NULL;
>>  +
>>  +       startup_info->prefix=3Dget_relative_wt(wtbuf, sizeof(wtbuf)=
 - 1,
>>  +                       get_git_work_tree());
>>         retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
>>                         get_git_work_tree());
>>         if (!retval || !*retval)
>>
>> --
>>  1.7.3.1
>>
>>
>=20
>=20
