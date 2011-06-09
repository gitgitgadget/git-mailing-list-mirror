From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of remote helpers
Date: Thu, 9 Jun 2011 14:45:40 +0200
Message-ID: <BANLkTikuAjchuACmdHYG6giy=3s2RkQxhw@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com> <20110608192850.GF27715@elie>
 <BANLkTi=-roQ5DH6RQ75+EwfDr9LutU0jrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 14:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUed3-0001WK-N4
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 14:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558Ab1FIMqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 08:46:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:65229 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490Ab1FIMqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 08:46:21 -0400
Received: by qyg14 with SMTP id 14so798393qyg.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7TS8mq3ULumdaYpDWzi4ml6TctWs8M7DeHvh15fRmt0=;
        b=MdizOsDLGgCcWkXT4ikktRRJBu6RKq1kzKvCDyWEOHj0wWoIkoCe1+EfX4xbtlhflr
         bp/qIRpMH+TdfnYA3T+znUGZZ9Fqi28LhX3vYTIKOhStlqqMItfN+cR/LRMYTgT3l5wq
         6zdi8iG946/zt6ZxUjLRG9dsH8ctH4Mf1pKjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VcOU+XQkQAhW6OqazYKy0yRdZuoyS/uP33/7Sh0iZRlgGptfKdnY726zYV0jKXLchz
         pXlHJybJRXj8boOztKYN1Z1MszwiVem07NpjsOx+DL0myD/8Dxz0Zcfar2i5AV34EppH
         7pP3PGkAcRQydxc+o6YsMuqxO62cBmUhF0HDQ=
Received: by 10.229.127.105 with SMTP id f41mr537573qcs.15.1307623580196; Thu,
 09 Jun 2011 05:46:20 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 05:45:40 -0700 (PDT)
In-Reply-To: <BANLkTi=-roQ5DH6RQ75+EwfDr9LutU0jrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175520>

Heya,

On Wed, Jun 8, 2011 at 23:13, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> I was going to test this, but it seems there's a problem with my
> series. Peff, if you want to look into it, (if not I'll try to look at
> it tomorrow) it's up at my github fork [0].

Turns out this was caused by the sloppy implementation of [PATCH
15/19] transport-helper: update ref status after push with export.
After implementing it properly the breakage is fixed although I'm not
entirely sure the output is (always) correct.

Follows are the test results (ran with GIT_TRACE=1 GIT_DEBUG_TESTGIT=1):


expecting success:
       (cd clone &&
        git tag -a -m "example tag" example-tag &&
        git push origin tag example-tag
       ) &&
       compare_refs clone example-tag server refs/tags/example-tag

trace: built-in: git 'tag' '-a' '-m' 'example tag' 'example-tag'
trace: built-in: git 'push' 'origin' 'tag' 'example-tag'
trace: run_command: 'git-remote-testgit' 'origin'
'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server'
trace: built-in: git 'ls-remote' 'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'
trace: run_command: 'git-upload-pack '\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\''' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
prefix: 'refs/testgit/origin/'
Got arguments ['origin', 'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server']
Got command 'capabilities' with args ''
Got command 'gitdir' with args '.git'
Got command 'list' with args ''
? refs/heads/new
? refs/heads/master
? refs/heads/new-name
@refs/heads/master HEAD
Got command 'export' with args ''
trace: run_command: 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'refs/tags/example-tag'
trace: exec: 'git' 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'refs/tags/example-tag'
trace: built-in: git 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'refs/tags/example-tag'
trace: built-in: git 'fetch' '--quiet'
'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'
trace: run_command: 'git-upload-pack '\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\''' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: run_command: 'rev-list' '--quiet' '--objects' '--stdin' '--not' '--all'
trace: built-in: git 'update-ref' 'refs/heads/master' 'FETCH_HEAD'
trace: built-in: git 'for-each-ref' 'refs/heads'
trace: exec: 'git-fast-import' '--quiet'
'--export-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
'--import-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
trace: run_command: 'git-fast-import' '--quiet'
'--export-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
'--import-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
trace: built-in: git 'for-each-ref' 'refs/heads'
trace: built-in: git 'push' '--quiet'
'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git' '--all'
trace: run_command: 'git-receive-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-receive-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\''' 'git-receive-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: built-in: git 'receive-pack' '/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'
Everything up-to-date
trace: built-in: git 'rev-parse' '--verify' 'example-tag'
trace: built-in: git 'rev-parse' '--verify' 'refs/tags/example-tag'
fatal: Needed a single revision
not ok - 15 test pushing tags

Similar output for the following two:

<snip>
Everything up-to-date
trace: built-in: git 'rev-parse' '--verify' 'HEAD:file'
trace: built-in: git 'rev-parse' '--verify' 'refs/blobs/file'
fatal: Needed a single revision
not ok - 16 test pushing a blob

<snip>
Everything up-to-date
trace: built-in: git 'rev-parse' '--verify' ':file'
trace: built-in: git 'rev-parse' '--verify' 'refs/blobs/newfile'
fatal: Needed a single revision
not ok - 17 test pushing an updated blob

And then finally a rather different failure:

expecting success:
       (cd clone &&
        echo more >>file &&
        git commit -a -m another &&
        git push origin HEAD^0:master
       ) &&
       compare_refs clone HEAD server HEAD


trace: built-in: git 'commit' '-a' '-m' 'another'
[new-name a02c029] another
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
trace: built-in: git 'push' 'origin' 'HEAD^0:master'
trace: run_command: 'git-remote-testgit' 'origin'
'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server'
trace: built-in: git 'ls-remote' 'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'
trace: run_command: 'git-upload-pack '\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\''' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
prefix: 'refs/testgit/origin/'
Got arguments ['origin', 'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server']
Got command 'capabilities' with args ''
Got command 'gitdir' with args '.git'
Got command 'list' with args ''
? refs/heads/new
? refs/heads/master
? refs/heads/new-name
@refs/heads/master HEAD
Got command 'export' with args ''
trace: run_command: 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'HEAD^0'
trace: exec: 'git' 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'HEAD^0'
trace: built-in: git 'fast-export' '--use-done-feature'
'--export-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'--import-marks=.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/testgit.marks'
'^refs/testgit/origin/master' 'HEAD^0'
trace: built-in: git 'fetch' '--quiet'
'file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'
trace: run_command: 'git-upload-pack '\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\''' 'git-upload-pack
'\''/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server/.git'\'''
trace: run_command: 'rev-list' '--quiet' '--objects' '--stdin' '--not' '--all'
trace: built-in: git 'update-ref' 'refs/heads/master' 'FETCH_HEAD'
trace: built-in: git 'for-each-ref' 'refs/heads'
trace: exec: 'git-fast-import' '--quiet'
'--export-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
'--import-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
trace: run_command: 'git-fast-import' '--quiet'
'--export-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
'--import-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks'
fatal: Branch name doesn't conform to GIT standards: HEAD^0
fast-import: dumping crash report to /home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/.git/fast_import_crash_2016
Traceback (most recent call last):
  File "/home/sverre/code/git/git-remote-testgit", line 265, in <module>
    sys.exit(main(sys.argv))
  File "/home/sverre/code/git/git-remote-testgit", line 262, in main
    more = read_one_line(repo)
  File "/home/sverre/code/git/git-remote-testgit", line 227, in read_one_line
    func(repo, cmdline)
  File "/home/sverre/code/git/git-remote-testgit", line 164, in do_export
    changed = repo.importer.do_import(repo.gitdir)
  File "/home/sverre/code/git/t/../git_remote_helpers/build/lib/git_remote_helpers/git/importer.py",
line 54, in do_import
    check_call(args)
  File "/home/sverre/code/git/t/../git_remote_helpers/build/lib/git_remote_helpers/util.py",
line 159, in check_call
    raise subprocess.CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['git',
'--git-dir=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/.git',
'fast-import', '--quiet',
'--export-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks',
'--import-marks=/home/sverre/code/git/t/trash
directory.t5800-remote-helpers/clone/.git/info/fast-import/27c45ccde749c9cc424db9cf911f01688e75d056/git.marks']'
returned non-zero exit status 128
not ok - 18 test pushing HEAD^0

-- 
Cheers,

Sverre Rabbelier
