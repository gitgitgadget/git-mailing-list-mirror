From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Mon, 24 Aug 2015 11:51:33 +0200
Message-ID: <24F604FE-6052-4250-80CD-3C366FE5D8DC@gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 11:51:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZToPn-0003tF-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 11:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbbHXJvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 05:51:39 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37646 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbHXJvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 05:51:37 -0400
Received: by widdq5 with SMTP id dq5so66749403wid.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/MjuVEBih8Hh0IcDUsASHQ/qDNl4x7+igzUsJ/H9y38=;
        b=ESUW+xR2va7MlIf3cJSHB/LJfos5YbYPj7Fuf6f2yMZrgHnNGhY9Eirtu+Nt3hPDgZ
         6j4/OwNxsyOW2Uuhafp/d5vOOZ+pE2c44Ly2mQZ2cGnLgaQwckwL/yBzzvj5rqzDrIiT
         aU7eJiblxqIeSjM8HE8iS9ijmwIEvYZ12aToYx1knpltyv5yWAvgdqgJBMKVjNmu8qnw
         +MHH7McgpIUW4EpVrQWSHVQyBa24vOHHgY1rAVmbiMeaaT3VNVxJkRXsXDUgTv2TAdQm
         TkhMB/fvxYcWIbHgQgFZCWWVlUO4IN1Uw5j85kWeY4wkYYUjrfyWYN4ctwAOojVpxnYU
         M7UQ==
X-Received: by 10.180.86.138 with SMTP id p10mr28204353wiz.39.1440409896184;
        Mon, 24 Aug 2015 02:51:36 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ho10sm22319528wjb.39.2015.08.24.02.51.34
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Aug 2015 02:51:35 -0700 (PDT)
In-Reply-To: <CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276442>


> Lars - thanks for persisting with this!
>=20
> I'm still trying to fully understand what's going on here - can you
> point out where I've got it wrong below please!
Your welcome + sure :)


> The server is on Linux, and is case-sensitive. For whatever reason
> (probably people committing changes on Windows in the first place)
We have many P4 servers. Some run on Linux and some on Windows. The Lin=
ux ones are executed with =93-C1=94 flag to "Force the server to operat=
e in case-insensitive mode on a normally case-sensitive platform.=94. I=
 did that in the test case, too.


> we've ended up with a P4 repo that has differences in path case that
> need to be ignored, with all upper-case paths being mapped to
> lower-case.
You are correct with =93P4 repo that has differences in path case=94. B=
ut it can be any path case variation. Not only all upper-case. I just r=
ealized that all my examples and tests show all upper-case. I will fix =
that. Consider these files in P4:

//depot/Path/File1
//depot/PATH/File2
//depot/pATH/File3

P4 would sync them on a case insensitive filesystem to:

$CLIENT_DIR/Path/File1
$CLIENT_DIR/Path/File2
$CLIENT_DIR/Path/File3

=85 and this is how they should end up in Git.


> e.g. the *real* depot might be:
>=20
> //depot/path/File1
> //depot/PATH/File2
>=20
> git-p4 clone should return this case-folded on Windows (and Linux?)
>=20
> $GIT_DIR/path/File1
> $GIT_DIR/path/File2
Correct. Although the correct path might be the following too:
$GIT_DIR/PATH/File1
$GIT_DIR/PATH/File2


> (Am I right in thinking that this change folds the directory, but not
> the filename?)
Correct.


> I don't really understand why a dictionary is required to do this
> though - is there a reason we can't just lowercase all incoming paths=
?
The result is not necessarily all lowercase. Even though the case doesn=
=92t matter as we are talking about case-insensitve filesystems I want =
to use the case that P4 would pick (see example above).


> Which is what the existing code in p4StartWith() is trying to do. Tha=
t
> code lowercases the *entire* path including the filename; this change
> seems to leave the filename portion unchanged. I guess though that th=
e
> answer may be to do with your finding that P4 makes up the case of
> directories based on lexicographic ordering - is that the basic
> problem?
Correct.


> For a large repo, this approach is surely going to be really slow.
True. But we use git-p4 as a one time operation to migrate our repos fr=
om P4 to Git. Therefore correctness is more important than speed. Plus =
it is not enabled by default. You need to pass a parameter switch to gi=
t-p4.


> Additionally, could you update your patch to add some words to
> Documentation/git-p4.txt please?
I will do that!


> On 21 August 2015 at 18:19,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> PROBLEM:
>> We run P4 servers on Linux and P4 clients on Windows. For an unknown
>> reason the file path for a number of files in P4 does not match the
>> directory path with respect to case sensitivity.
>>=20
>> E.g. `p4 files` might return
>> //depot/path/to/file1
>> //depot/PATH/to/file2
>>=20
>> If you use P4/P4V then these files end up in the same directory, e.g=
=2E
>> //depot/path/to/file1
>> //depot/path/to/file2
>>=20
>> If you use git-p4 then all files not matching the correct file path
>> (e.g. `file2`) will be ignored.
>=20
> I'd like to think that the existing code that checks core.ignorecase
> should handle this. I haven't tried it myself though.
core.ignorecase doesn=92t help. I added a test case to prove that.

>=20
>=20
>>=20
>> SOLUTION:
>> Identify path names that are different with respect to case sensitiv=
ity.
>> If there are any then run `p4 dirs` to build up a dictionary
>> containing the "correct" cases for each path. It looks like P4
>> interprets "correct" here as the existing path of the first file in =
a
>> directory. The path dictionary is used later on to fix all paths.
>>=20
>> This is only applied if the parameter "--ignore-path-case" is passed=
 to
>> the git-p4 clone command.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> git-p4.py                         |  82 ++++++++++++++++++++++++++--
>> t/t9821-git-p4-path-variations.sh | 109 ++++++++++++++++++++++++++++=
++++++++++
>> 2 files changed, 187 insertions(+), 4 deletions(-)
>> create mode 100755 t/t9821-git-p4-path-variations.sh
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 073f87b..61a587b 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1931,7 +1931,7 @@ class View(object):
>>                 (self.client_prefix, clientFile))
>>         return clientFile[len(self.client_prefix):]
>>=20
>> -    def update_client_spec_path_cache(self, files):
>> +    def update_client_spec_path_cache(self, files, fixPathCase =3D =
None):
>>         """ Caching file paths by "p4 where" batch query """
>>=20
>>         # List depot file paths exclude that already cached
>> @@ -1950,6 +1950,8 @@ class View(object):
>>             if "unmap" in res:
>>                 # it will list all of them, but only one not unmap-p=
ed
>>                 continue
>> +            if fixPathCase:
>> +                res['depotFile'] =3D fixPathCase(res['depotFile'])
>>             self.client_spec_path_cache[res['depotFile']] =3D self.c=
onvert_client_path(res["clientFile"])
>>=20
>>         # not found files or unmap files set to ""
>> @@ -1987,6 +1989,7 @@ class P4Sync(Command, P4UserMap):
>>                                      help=3D"Maximum number of chang=
es to import"),
>>                 optparse.make_option("--changes-block-size", dest=3D=
"changes_block_size", type=3D"int",
>>                                      help=3D"Internal block size to =
use when iteratively calling p4 changes"),
>> +                optparse.make_option("--ignore-path-case", dest=3D"=
ignorePathCase", action=3D"store_true"),
>>                 optparse.make_option("--keep-path", dest=3D"keepRepo=
Path", action=3D'store_true',
>>                                      help=3D"Keep entire BRANCH/DIR/=
SUBDIR prefix during import"),
>>                 optparse.make_option("--use-client-spec", dest=3D"us=
eClientSpec", action=3D'store_true',
>> @@ -2017,6 +2020,7 @@ class P4Sync(Command, P4UserMap):
>>         self.maxChanges =3D ""
>>         self.changes_block_size =3D None
>>         self.keepRepoPath =3D False
>> +        self.ignorePathCase =3D False
>>         self.depotPaths =3D None
>>         self.p4BranchesInGit =3D []
>>         self.cloneExclude =3D []
>> @@ -2049,7 +2053,8 @@ class P4Sync(Command, P4UserMap):
>>         files =3D []
>>         fnum =3D 0
>>         while commit.has_key("depotFile%s" % fnum):
>> -            path =3D  commit["depotFile%s" % fnum]
>> +            path =3D commit["depotFile%s" % fnum]
>> +            path =3D self.fixPathCase(path)
>>=20
>>             if [p for p in self.cloneExclude
>>                 if p4PathStartsWith(path, p)]:
>> @@ -2113,7 +2118,9 @@ class P4Sync(Command, P4UserMap):
>>         branches =3D {}
>>         fnum =3D 0
>>         while commit.has_key("depotFile%s" % fnum):
>> -            path =3D  commit["depotFile%s" % fnum]
>> +            path =3D commit["depotFile%s" % fnum]
>> +            path =3D self.fixPathCase(path)
>> +
>>             found =3D [p for p in self.depotPaths
>>                      if p4PathStartsWith(path, p)]
>>             if not found:
>> @@ -2240,6 +2247,10 @@ class P4Sync(Command, P4UserMap):
>>             if marshalled["code"] =3D=3D "error":
>>                 if "data" in marshalled:
>>                     err =3D marshalled["data"].rstrip()
>> +
>> +        if "depotFile" in marshalled:
>> +            marshalled['depotFile'] =3D self.fixPathCase(marshalled=
['depotFile'])
>> +
>>         if err:
>>             f =3D None
>>             if self.stream_have_file_info:
>> @@ -2314,6 +2325,7 @@ class P4Sync(Command, P4UserMap):
>>=20
>>             # do the last chunk
>>             if self.stream_file.has_key('depotFile'):
>> +                self.stream_file['depotFile'] =3D self.fixPathCase(=
self.stream_file['depotFile'])
>>                 self.streamOneP4File(self.stream_file, self.stream_c=
ontents)
>>=20
>>     def make_email(self, userid):
>> @@ -2371,7 +2383,8 @@ class P4Sync(Command, P4UserMap):
>>                 sys.stderr.write("Ignoring file outside of prefix: %=
s\n" % f['path'])
>>=20
>>         if self.clientSpecDirs:
>> -            self.clientSpecDirs.update_client_spec_path_cache(files=
)
>> +            self.clientSpecDirs.update_client_spec_path_cache(
>> +                files, lambda x: self.fixPathCase(x))
>>=20
>>         self.gitStream.write("commit %s\n" % branch)
>> #        gitStream.write("mark :%s\n" % details["change"])
>> @@ -2835,6 +2848,62 @@ class P4Sync(Command, P4UserMap):
>>             print "IO error with git fast-import. Is your git versio=
n recent enough?"
>>             print self.gitError.read()
>>=20
>> +    def fixPathCase(self, path):
>> +        if self.caseCorrectedPaths:
>> +            components =3D path.split('/')
>> +            filename =3D components.pop()
>> +            dirname =3D '/'.join(components).lower() + '/'
>> +            if dirname in self.caseCorrectedPaths:
>> +                path =3D self.caseCorrectedPaths[dirname] + filenam=
e
>> +        return path
>> +
>> +    def generatePathCaseDict(self, clientPrefix):
>> +        # Query all files and generate a list of all used paths
>> +        # e.g. this files list:
>> +        # //depot/path/to/file1
>> +        # //depot/PATH/to/file2
>> +        #
>> +        # result in this path list:
>> +        # //depot/
>> +        # //depot/PATH/
>> +        # //depot/path/
>> +        # //depot/PATH/to/
>> +        # //depot/path/to/
>> +        p4_paths =3D set()
>> +        for f in p4CmdList(["files", clientPrefix + "..."]):
>> +            components =3D f["depotFile"].split('/')[0:-1]
>> +            for i in range(3, len(components)+1):
>> +                p4_paths.add('/'.join(components[0:i]) + '/')
>> +        p4_paths =3D sorted(list(p4_paths), key=3Dlen)
>> +
>> +        if len(p4_paths) > len(set([p.lower() for p in p4_paths])):
>> +            print "ATTENTION: File paths with different case variat=
ions detected. Fixing may take a while..."
>=20
> Does this really need "ATTENTION" in the output?
No :-) I=92ll remove it.

>=20
>> +            found_variations =3D True
>> +            while found_variations:
>> +                for path in p4_paths:
>> +                    found_variations =3D False
>> +                    path_variations =3D [p for p in p4_paths if p.l=
ower() =3D=3D path.lower()]
>> +
>> +                    if len(path_variations) > 1:
>> +                        print  "%i different case variations for pa=
th '%s' detected." % (len(path_variations), path)
>> +                        # If we detect path variations (e.g. //depo=
t/path and //depot/PATH) then we query P4 to list
>> +                        # the subdirectories of the parent (e.g //d=
epot/*). P4 will return these subdirectories with
>> +                        # the correct case.
>> +                        parent_path =3D '/'.join(path.split('/')[0:=
-2])
>> +                        case_ok_paths =3D [p["dir"] + '/' for p in =
p4CmdList(["dirs", "-D", parent_path + '/*'])]
>> +
>> +                        # Replace all known paths with the case cor=
rected path from P4 dirs command
>> +                        for case_ok_path in case_ok_paths:
>> +                            pattern =3D re.compile("^" + re.escape(=
case_ok_path), re.IGNORECASE)
>> +                            p4_paths =3D sorted(list(set([pattern.s=
ub(case_ok_path, p) for p in p4_paths])), key=3Dlen)
>=20
> Sorry, I don't quite get what this is doing.
>=20
> We're generating a list of all of the files in the depot being cloned=
=2E
Correct. Take this example:

/Path/file1.txt
/path/Something/file2.txt
/pATh/sOmething/file3.txt
/path/sOmething/ELSE/file4.txt
/path/sOmething/Else/file5.txt


> From that we get a set of all of the paths, sorted by length.
Correct. Following the example:

/Path/
/path/Something/
/pATh/sOmething/
/path/sOmething/ELSE/
/Path/sOmething/Else/

> And then we seem to repeatedly rewrite that set with a new set where
> each element has been replaced using a regular expression in a way
> that I don't quite understand=85.
I look for paths in this list that differ only in case. In the example =
the first duplicate that I would detect is =93/path/something=94. I wou=
ld use the =93dirs=94 command to figure out which case is the correct o=
ne (result here: =93/Path/Something=94). Afterwards I use the regex to =
replace items in the list that start with a case variation of this of t=
his path in the list:

/Path/
/Path/Something/
/Path/Something/
/Path/Something/ELSE/
/Path/Something/Else/

In the last step I transform the list to a set to remove duplicates

/Path/
/Path/Something/
/Path/Something/ELSE/
/Path/Something/Else/

At this point the algorithm detects another duplicate =93/path/somethin=
g/else=94. We start all over and request the correct path with =93dirs=94=
 and replace all occurrences. We end up with:

/Path/
/Path/Something/
/Path/Something/Else/

>=20
>> +
>> +                        found_variations =3D True
>> +                        break
>> +            return dict((p.lower(), p) for p in p4_paths)
>=20
> ... and then we just return a dictionary that maps every path to a
> lowercase version of itself? So couldn't we have just blindly
> lowercased all the paths in the first place?
The dictionary key is lower case. The dictionary value contains the cor=
rect case. In the example:

/path/ =97> /Path/
/path/something/ =97> /Path/Something/=20
/path/something/else/ =97> /Path/Something/Else

>=20
>=20
>> +        else:
>> +            if self.verbose:
>> +                print "All file paths have consistent case"
>> +            return None
>>=20
>>     def run(self, args):
>>         self.depotPaths =3D []
>> @@ -3006,6 +3075,11 @@ class P4Sync(Command, P4UserMap):
>>=20
>>         self.depotPaths =3D newPaths
>>=20
>> +        if self.ignorePathCase and self.clientSpecDirs:
>> +            self.caseCorrectedPaths =3D self.generatePathCaseDict(s=
elf.clientSpecDirs.client_prefix)
>> +        else:
>> +            self.caseCorrectedPaths =3D None
>> +
>>         # --detect-branches may change this for each branch
>>         self.branchPrefixes =3D self.depotPaths
>>=20
>> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path=
-variations.sh
>> new file mode 100755
>> index 0000000..90515a1
>> --- /dev/null
>> +++ b/t/t9821-git-p4-path-variations.sh
>> @@ -0,0 +1,109 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Clone repositories with path case variations'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d with case folding enabled' '
>> +       start_p4d -C1
>> +'
>> +
>> +test_expect_success 'Create a repo with path case variations' '
>> +       client_view "//depot/... //client/..." &&
>> +       (
>> +               cd "$cli" &&
>> +
>> +               mkdir -p One/two &&
>> +               >One/two/File2.txt &&
>> +               p4 add One/two/File2.txt &&
>> +               p4 submit -d "Add file2" &&
>> +               rm -rf One &&
>> +
>> +               mkdir -p one/TWO &&
>> +               >one/TWO/file1.txt &&
>> +               p4 add one/TWO/file1.txt &&
>> +               p4 submit -d "Add file1" &&
>> +               rm -rf one &&
>> +
>> +               mkdir -p one/two &&
>> +               >one/two/file3.txt &&
>> +               p4 add one/two/file3.txt &&
>> +               p4 submit -d "Add file3" &&
>> +               rm -rf one &&
>> +
>> +               mkdir -p outside-spec &&
>> +               >outside-spec/file4.txt &&
>> +               p4 add outside-spec/file4.txt &&
>> +               p4 submit -d "Add file4" &&
>> +               rm -rf outside-spec
>> +       )
>> +'
>> +
>> +test_expect_success 'Clone the repo and WITHOUT path fixing' '
>=20
> s/Clone the repo and/Clone the repo WITHOUT/
=46ixed!

>=20
>=20
>=20
>> +       client_view "//depot/One/... //client/..." &&
>> +       git p4 clone --use-client-spec --destination=3D"$git" //depo=
t &&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git" &&
>> +               # This method is used instead of "test -f" to ensure=
 the case is
>> +               # checked even if the test is executed on case-insen=
sitive file systems.
>> +               cat >expect <<-\EOF &&
>> +                       two/File2.txt
>> +               EOF
>> +               git ls-files >actual &&
>> +               test_cmp expect actual
>> +       )
>> +'
>> +
>> +test_expect_success 'Clone the repo WITH path fixing' '
>> +       client_view "//depot/One/... //client/..." &&
>> +       git p4 clone --ignore-path-case --use-client-spec --destinat=
ion=3D"$git" //depot &&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git" &&
>> +               cat >expect <<-\EOF &&
>> +                       TWO/File2.txt
>> +                       TWO/file1.txt
>> +                       TWO/file3.txt
>> +               EOF
>> +               git ls-files >actual &&
>> +               test_cmp expect actual
>> +       )
>> +'
>> +
>> +# It looks like P4 determines the path case based on the first file=
 in
>> +# lexicographical order. Please note the lower case "two" directory=
 for all
>> +# files triggered through the addition of "File0.txt".
>=20
> If that's what P4 is doing, then it's *really* nasty!
Indeed it is.

>=20
>=20
>> +test_expect_success 'Add a new file and clone the repo WITH path fi=
xing' '
>> +       client_view "//depot/... //client/..." &&
>> +       (
>> +               cd "$cli" &&
>> +
>> +               mkdir -p One/two &&
>> +               >One/two/File0.txt &&
>> +               p4 add One/two/File0.txt &&
>> +               p4 submit -d "Add file" &&
>> +               rm -rf One
>> +       ) &&
>> +
>> +       client_view "//depot/One/... //client/..." &&
>> +       git p4 clone --ignore-path-case --use-client-spec --destinat=
ion=3D"$git" //depot &&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git" &&
>> +               cat >expect <<-\EOF &&
>> +                       two/File0.txt
>> +                       two/File2.txt
>> +                       two/file1.txt
>> +                       two/file3.txt
>> +               EOF
>> +               git ls-files >actual &&
>> +               test_cmp expect actual
>> +       )
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +       kill_p4d
>> +'
>> +
>> +test_done
>> --
>> 1.9.5 (Apple Git-50.3)

While I was working on the examples for this email reply I realized tha=
t the problem is only present for paths given in a client-spec. I added=
 a test case to prove that. That means I don=92t need to request *all* =
paths. I *think* it is sufficient to request the paths mentioned in the=
 client spec which would usually be really fast. Stay tuned for PATCH v=
5.

Thanks for your review,
Lars
