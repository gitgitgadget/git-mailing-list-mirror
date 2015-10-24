From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Sat, 24 Oct 2015 20:08:02 +0200
Message-ID: <F77F291C-89D1-48B6-9E9F-AD7220CE0141@gmail.com>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com> <56273197.3010505@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 20:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq3F3-0005KF-CW
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 20:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbbJXSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 14:08:22 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34776 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbJXSIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2015 14:08:05 -0400
Received: by wikq8 with SMTP id q8so114818668wik.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VNhLCOsEltnKpTHBVvX/4VEUEeCW+GrcmJFBWezlNFM=;
        b=c/xrNiOEWgCRQQmfazR2KhbVkPcUtHk9j9P2CX9Evwt/RqQfvOAGe+J0a0LPWh8Oaw
         CoaymqOGBMRfLjcog5xFFtB9BJc5dT1dCEsDmOLMEMwrOuZ/73xJCerzzB24WKFgd59M
         PaMXtTHw+YTnle77bTOLkJ980SyauXr/rt22lqeuZL8BkmSkphtjgQKo/IYPuBkYx7uc
         GeMMf0V7jd+lrc/BXfbmbNVv7CS6PriSz0dafpFc+L4FU9Vuh7EfEJi1ElOrTA6X2iey
         rVoub5dBMnchkKaBaYJVxzIWc+5G9VhqZLSnEIFkz4L0x1lhjyBVgE5LU5/4uFFYtP+2
         IVuQ==
X-Received: by 10.194.62.15 with SMTP id u15mr12454166wjr.18.1445710083513;
        Sat, 24 Oct 2015 11:08:03 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB60EA.dip0.t-ipconnect.de. [93.219.96.234])
        by smtp.gmail.com with ESMTPSA id bd4sm29292757wjb.15.2015.10.24.11.08.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 11:08:02 -0700 (PDT)
In-Reply-To: <56273197.3010505@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280131>


On 21 Oct 2015, at 08:32, Luke Diamand <luke@diamand.org> wrote:

> On 19/10/15 19:43, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> A changelist that contains only excluded files (e.g. via client spec or
>> branch prefix) will be imported as empty commit. Add option
>> "git-p4.ignoreEmptyCommits" to ignore these commits.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  Documentation/git-p4.txt               |   5 ++
>>  git-p4.py                              |  41 ++++++++-----
>>  t/t9826-git-p4-ignore-empty-commits.sh | 103 +++++++++++++++++++++++++++++++++
>>  3 files changed, 133 insertions(+), 16 deletions(-)
>>  create mode 100755 t/t9826-git-p4-ignore-empty-commits.sh
>> 
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 82aa5d6..f096a6a 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -510,6 +510,11 @@ git-p4.useClientSpec::
>>  	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>>  	This variable is a boolean, not the name of a p4 client.
>> 
>> +git-p4.ignoreEmptyCommits::
>> +	A changelist that contains only excluded files will be imported
>> +	as empty commit. To ignore these commits set this boolean option
>> +	to 'true'.
> 
> s/as empty/as an empty/
> 
> Possibly putting 'true' in quotes could be confusing.
OK. Will fix.

> 
>> +
>>  Submit variables
>>  ~~~~~~~~~~~~~~~~
>>  git-p4.detectRenames::
>> diff --git a/git-p4.py b/git-p4.py
>> index 0093fa3..6c50c74 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
>>          filesToDelete = []
>> 
>>          for f in files:
>> -            # if using a client spec, only add the files that have
>> -            # a path in the client
>> -            if self.clientSpecDirs:
>> -                if self.clientSpecDirs.map_in_client(f['path']) == "":
>> -                    continue
>> -
>>              filesForCommit.append(f)
>>              if f['action'] in self.delete_actions:
>>                  filesToDelete.append(f)
>> @@ -2368,18 +2362,33 @@ class P4Sync(Command, P4UserMap):
>>          if self.verbose:
>>              print "commit into %s" % branch
>> 
>> -        # start with reading files; if that fails, we should not
>> -        # create a commit.
>> -        new_files = []
>> -        for f in files:
>> -            if [p for p in self.branchPrefixes if p4PathStartsWith(f['path'], p)]:
>> -                new_files.append (f)
>> -            else:
>> -                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
>> -
>>          if self.clientSpecDirs:
>>              self.clientSpecDirs.update_client_spec_path_cache(files)
>> 
>> +        def inClientSpec(path):
> 
> This seems to be adding a new function in the middle of an existing function. Is that right?
That is true. I could move these functions into the P4Sync class if you don't like them here. I added them right there because it is the only place where they are used/useful.


> 
>> +            if not self.clientSpecDirs:
>> +                return True
>> +            inClientSpec = self.clientSpecDirs.map_in_client(path)
>> +            if not inClientSpec and self.verbose:
>> +                print '\n  Ignoring file outside of client spec' % path
>> +            return inClientSpec
> 
> Any particular reason for putting a \n at the start of the message?
I did this because "sys.stdout.write("\rImporting revision ..." (line 2724) does not add a newline. However, I agree that this looks stupid. I will remove the "\n" and fix the "Import revision" print. Speaking of that one: this is only printed if "not self.silent". Is there a particular reason to have "self.silent" and "self.verbose"? Should we merge the two? 


> 
> Also, could you use python3 style print stmnts, print("whatever") ?
Sure. How do you prefer the formatting? Using "format" would be true Python 3 style I think:
print('Ignoring file outside of client spec: {}'.format(path))
OK?

> 
>> +
>> +        def hasBranchPrefix(path):
>> +            if not self.branchPrefixes:
>> +                return True
>> +            hasPrefix = [p for p in self.branchPrefixes
>> +                            if p4PathStartsWith(path, p)]
>> +            if hasPrefix and self.verbose:
>> +                print '\n  Ignoring file outside of prefix: %s' % path
>> +            return hasPrefix
>> +
>> +        files = [f for f in files
>> +            if inClientSpec(f['path']) and hasBranchPrefix(f['path'])]
>> +
>> +        if not files and gitConfigBool('git-p4.ignoreEmptyCommits'):
>> +            print '\n  Ignoring change %s as it would produce an empty commit.'
>> +            return
> 
> As with Junio's comment elsewhere, I worry about deletion here.
I believe this is right. See my answer to Junio.


>> +
>>          self.gitStream.write("commit %s\n" % branch)
>>  #        gitStream.write("mark :%s\n" % details["change"])
>>          self.committedChanges.add(int(details["change"]))
>> @@ -2403,7 +2412,7 @@ class P4Sync(Command, P4UserMap):
>>                  print "parent %s" % parent
>>              self.gitStream.write("from %s\n" % parent)
>> 
>> -        self.streamP4Files(new_files)
>> +        self.streamP4Files(files)
>>          self.gitStream.write("\n")
>> 
>>          change = int(details["change"])
>> diff --git a/t/t9826-git-p4-ignore-empty-commits.sh b/t/t9826-git-p4-ignore-empty-commits.sh
>> new file mode 100755
>> index 0000000..5ddccde
>> --- /dev/null
>> +++ b/t/t9826-git-p4-ignore-empty-commits.sh
>> @@ -0,0 +1,103 @@
>> +#!/bin/sh
>> +
>> +test_description='Clone repositories and ignore empty commits'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d' '
>> +	start_p4d
>> +'
>> +
>> +test_expect_success 'Create a repo' '
>> +	client_view "//depot/... //client/..." &&
>> +	(
>> +		cd "$cli" &&
>> +
>> +		mkdir -p subdir &&
>> +
>> +		>subdir/file1.txt &&
>> +		p4 add subdir/file1.txt &&
>> +		p4 submit -d "Add file 1" &&
>> +
>> +		>file2.txt &&
>> +		p4 add file2.txt &&
>> +		p4 submit -d "Add file 2" &&
>> +
>> +		>subdir/file3.txt &&
>> +		p4 add subdir/file3.txt &&
>> +		p4 submit -d "Add file 3"
>> +	)
>> +'
>> +
>> +test_expect_success 'Clone repo root path with all history' '
>> +	client_view "//depot/... //client/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
>> +		cat >expect <<-\EOF &&
>> +Add file 3
>> +[git-p4: depot-paths = "//depot/": change = 3]
>> +
>> +Add file 2
>> +[git-p4: depot-paths = "//depot/": change = 2]
>> +
>> +Add file 1
>> +[git-p4: depot-paths = "//depot/": change = 1]
> 
> Could you not just test for existence of these files?
Well, I assume the right files are in there as this is covered with other tests. I want to check that these particular commits are mentioned in the logs (including the commit message and the change list number).


> If the format of the magic comments that git-p4 ever changes, this will break.
I understand your reasoning. But how can I check for the correct commit messages, change list number and their order in a efficient different way?


> 
> (There's a patch out there that gets git-p4 to use git notes, so it's not as far-fetched as it sounds).
> 
> 
>> +
>> +		EOF
>> +		git log --format=%B >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>> +test_expect_success 'Clone repo subdir with all history' '
>> +	client_view "//depot/subdir/... //client/subdir/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
>> +		cat >expect <<-\EOF &&
>> +Add file 3
>> +[git-p4: depot-paths = "//depot/": change = 3]
>> +
>> +Add file 2
>> +[git-p4: depot-paths = "//depot/": change = 2]
>> +
>> +Add file 1
>> +[git-p4: depot-paths = "//depot/": change = 1]
>> +
>> +		EOF
>> +		git log --format=%B >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>> +
>> +test_expect_success 'Clone repo subdir with all history but ignore empty commits' '
>> +	client_view "//depot/subdir/... //client/subdir/..." &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		git init . &&
>> +		git config git-p4.ignoreEmptyCommits true &&
>> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
>> +		cat >expect <<-\EOF &&
>> +Add file 3
>> +[git-p4: depot-paths = "//depot/": change = 3]
>> +
>> +Add file 1
>> +[git-p4: depot-paths = "//depot/": change = 1]
>> +
>> +		EOF
>> +		git log --format=%B >actual &&
> 
> 
> A deletion test would make me feel more comfortable!
Agreed! I will add one!

Thanks,
Lars