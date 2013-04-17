From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 01/14] dir.c: git-status --ignored: don't drop ignored
 directories
Date: Wed, 17 Apr 2013 02:31:01 +0200
Message-ID: <516DED45.2050600@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <516C4F6F.5020708@gmail.com> <CALkWK0=0MbKnEWc+uLkbynJZXYYiRyfJ539HjtPTajHotB4q9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 02:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USGHW-0002kk-4s
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 02:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab3DQAbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 20:31:22 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:56181 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab3DQAbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 20:31:03 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so498902eek.21
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Kpxp0hmi9UU9xXwdlQ27YIAa2y3JegaBoRy9n95t6tQ=;
        b=hSEpJh+FmRrbvTMsGQ1jKMgt2zca7VrMXNBkg3R42WE6VS28SVvPsb/Pye9dvW7zho
         +erHFJoLzclSI0IFo1X5zwNdSxjDoUHo+UHfd/S+lIEj+ec7kokc1HAjsLZbngOAKTtX
         j288x/BZSknvDktGXcBkXNEihB+aW0DmZc9kPZo2hjwKOvBsiVEY4RkwuNiU0p3BcWYM
         Zqs1DplE9Ccg7EgEH2/foMbSr3RpQ22EmwRHISc4452ORIG2iPcP3dgolyarYMTG+NBQ
         TwbPeGIr4y2hbkigL6MYIwnmbu9m2aydLG4ulrDHwRK9e+NIaubiqAz9/Dv5ZrcAxEB+
         eQ8Q==
X-Received: by 10.15.41.2 with SMTP id r2mr11976421eev.20.1366158661837;
        Tue, 16 Apr 2013 17:31:01 -0700 (PDT)
Received: from [10.1.100.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id a41sm5590093eei.4.2013.04.16.17.30.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 17:31:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0=0MbKnEWc+uLkbynJZXYYiRyfJ539HjtPTajHotB4q9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221493>

Am 16.04.2013 19:33, schrieb Ramkumar Ramachandra:
> Firstly, great work on the series! I've just started looking into it,
> so please don't take my comments too seriously: some of them may be
> queries, and others may be minor suggestions, but I can't say I
> understand the area you're patching.  I know Junio doesn't like me
> mixing queries in reviews, but I don't fully agree with his policy.
> 
> Karsten Blees wrote:
>> 'git-status --ignored' drops ignored directories if they contain untracked
>> files in an untracked sub directory.
> 
> Wait, ignored directories will always contain untracked
> subdirectories, unless you add -f them, right?  Why are you saying
> untracked files in an _untracked_ subdirectory?  We don't track

IIRC i mentioned untracked subdirectory explicitly because the problem doesn't occur if the subdirectory is tracked (i.e. contains a tracked file).

> directories anyway, and I would call a directory "tracked" if there's
> atleast one file inside it is tracked.  So, my understanding of this
> is:
> 
>     quux/
>        bar
>         baz/
>              foo
> 
> In this example, if quux is ignored and untracked, git status
> --ignored currently shows quux/.  If quux/bar is tracked (say with add
> -f), but baz/ is untracked, git status --ignored doesn't show me
> anything.  What exactly is the bug you're fixing?

With your example, you get this:

1) git-status --ignored -uall: quux/baz/foo
2) git-status --ignored -unormal: <empty>

Without the untracked directory 'baz' between 'quux' and 'foo':

	quux/
		bar
		foo

you get this:

3) git status --ignored -uall: quux/foo
4) git status --ignored -unormal: quux/

The bug is in case (2), this should be:

2) git-status --ignored -unormal: quux/

I.e. ignored directories with untracked files in untracked sub directories should be listed as ignored, because they contain ignored files. Currently these directories are not listed. I realize this sounds pretty much like the original commit message, but I don't know how to describe it any better.

> I'll try to look at
> the tests to infer this, but your commit message could probably be
> clearer.
> 
> Nit: please s/git-status/git status/

Both notations (as well as just 'status') seem to be widely used. Does this justify a reroll of the entire series with changed commit messages (I believe I've used git-status / git-ls-files / git-clean consistently in all patches)?

> 
>> Fix it by getting exact (recursive) excluded status in treat_directory.
> 
> Okay, so you're patching treat_directory() in dir.c to do some
> recursive exclude handling.  Let's see what this is.
> 
>> diff --git a/dir.c b/dir.c
>> index 57394e4..ec4eebf 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1060,6 +1060,15 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
>>
>>         /* This is the "show_other_directories" case */
>>
>> +       /* might be a sub directory in an excluded directory */
>> +       if (!exclude) {
>> +               struct path_exclude_check check;
>> +               int dt = DT_DIR;
>> +               path_exclude_check_init(&check, dir);
>> +               exclude = is_path_excluded(&check, dirname, len, &dt);
>> +               path_exclude_check_clear(&check);
>> +       }
>> +
> 
> So, I'm guessing that DT_DIR refers to a value that a field in struct
> dirent can take; that value could be one of DIR (directory), REG
> (regular file?), LNK (symbolic link?).  I don't get much of this, but
> what I do get is that you're setting exclude for the rest of the code
> in this function.
> 

This simply does a recursive excluded check via is_path_excluded, because is_excluded is not good enough. The rest is just boilerplate code (i.e. initialize and clear the check structure and passing a dtype == DT_DIR because dirname obviously is a directory here). We already have similar code in treat_file (and all other places that use is_path_excluded).

> Sorry that I'm not able to do a more thorough review.
> 
>> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
>> index 0da1214..0f1034e 100755
>> --- a/t/t7061-wtstatus-ignore.sh
>> +++ b/t/t7061-wtstatus-ignore.sh
>> @@ -143,4 +143,31 @@ test_expect_success 'status ignored tracked directory and uncommitted file with
>>         test_cmp expected actual
>>  '
>>
>> +cat >expected <<\EOF
>> +?? .gitignore
>> +?? actual
>> +?? expected
>> +!! tracked/
>> +EOF
> 
> Please put these segments inside the test_expect_success block, so
> it's easy to think about those blocks in isolation.  I know you're
> just following the existing conventions existing in this test, but
> those are not necessarily good conventions.
> 

$ grep -e '^cat .*EOF$' t*.sh | wc -l
    743
$ grep -e '^    cat .*EOF$' t*.sh | wc -l
     22

Setting up expected results outside test_expect_* (i.e. unindented) seems to be the norm in git tests.

>> +test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore' '
>> +       rm -rf tracked/uncommitted &&
>> +       mkdir tracked/ignored &&
>> +       : >tracked/ignored/uncommitted &&
>> +       git status --porcelain --ignored >actual &&
>> +       test_cmp expected actual
>> +'
> 
> This is very confusing.  How is tracked a tracked directory?  Oh,
> right: some previous test git add'ed tracked/committed.  How do I know
> about that in this test?
> 

This test expands on the previous test 'status ignored tracked directory and uncommitted file with --ignore', i.e. the test just adds the 'in untracked subdir' part (and thus moves the 'uncommitted' file into a sub directory). Expanding on previous state is the whole point of putting several tests in a single t*.sh file, right? If I wanted to set up the test fixture from scratch I would have started a new t7063-whatever.sh.

> Yeah, changes to tracked ignored directories are not shown, but the
> commit message didn't tell me this.
> 
>> +cat >expected <<\EOF
>> +?? .gitignore
>> +?? actual
>> +?? expected
>> +!! tracked/ignored/uncommitted
>> +EOF
>> +
>> +test_expect_success 'status ignored tracked directory with uncommitted file in untracked subdir with --ignore -u' '
>> +       git status --porcelain --ignored -u >actual &&
>> +       test_cmp expected actual
>> +'
>> +
>>  test_done
> 
> I suppose the commit message told me about this one vaguely, but I
> think it could be much clearer overall.
> 

Note that all tests in t7061 come in pairs '--ignored' (i.e. --untracked-files=normal) and '--ignored -u' (i.e. --untracked-files=all). If '-uall' lists individual ignored files, then '-unormal' should list the ignored directory.
