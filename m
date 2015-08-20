From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Thu, 20 Aug 2015 06:59:53 +0200
Message-ID: <55D55EC9.6050002@web.de>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com> <1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: luke@diamand.org, pw@padd.com, torarvid@gmail.com,
	ksaitoh560@gmail.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 07:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSHxi-0004U7-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 07:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbbHTFAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 01:00:22 -0400
Received: from mout.web.de ([212.227.17.12]:62972 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbbHTFAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 01:00:21 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MBCJd-1ZZkDa0BOf-00AIeE; Thu, 20 Aug 2015 07:00:15
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:kgzDfsEankUbxXcK1Ne84lYIbxZGkQmu1ZAdrb6SP7ktPbh/oqK
 tT1FTIxd3LEmS8lHOLoqzTIS45zvOpjz5vpjwHK158pQeeNyngK3JTBrJzQqHMX5VMfhmn1
 WblT3FNSiNFAph19fp9IcsiGJ7xgPalnqAkOwl3ZURRB6MZNx5nobvyE9p0iYzm5hHzZKK3
 h8jizYnAnKTZ6cVtBhY7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wGDB8XrxzWQ=:vsoponxA0htT1PiRUYHbrP
 2Q+JhvuYIl3WnnL54PaOvsRyha5cwZMgXdpkAe1pXkwSwrRa+f4jFHbDBtMi8/TtRESU5zn5N
 z7G6nc445cVmkPURu2sNTgltQkOCfYzG9z7fawHXLNtZEfl8o93XltntL9gcnA0J/46ujt/WS
 POKzjzaXjK3HgeRgZwDgNthNfJrSapzrZ7tyyO2P/mD4M2qlD2cZDgDLu3z0Z4FWQV/86QU6K
 Fqt2qK7W/ql3xgne4vH3fVEmjbULsg5cU91htwCYUnGm3zK0tj5dpdsDEMm346IJyOo8k6QsZ
 ksqghGQ/4vcu5Z37jf31oMun7O+lhV07kUKpJfRY6MD7jWMCWm57O3uHR3bzNREGjGUnjTIi0
 DHqZe5deZpas6fcc7WqqaAoWZfYUM6IQkyu9MVkvogv6iZyUW/JKXCFzJGMbfdLoucnCZtKQS
 cN3wIv7O9gqLVnoaa7qF6VJd8AaFIdd91SWPG/oFsAvORslPeSTF0O0a9a5NM2GrGB4WAzUpd
 SN+XG4Cyk9Wm87nox3Gf/Jip1Mfq014Rjb4eqcNCRa2LhYSy+u8XeDSEqqw34QB8qAa25SZU0
 EOLC77b+zzi1wt+hatDP9SCQYP4rKsaW09g2FlZBNCGgVX71jrrNi0aiDPI7HI84dN7p6sdzz
 RpxOFdjqaSza08QDabS/oz0TrdWX6rKrGXurnIp7HgB+FrUZf+6U9lyn4I9RSInYwpz4v89Bv
 gq31ULt6fdltonVafz0yJ5THlKTA5eFBTSa1kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276230>

Some nit-picking below:
On 08/19/2015 10:04 PM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> PROBLEM:
> We run P4 servers on Linux and P4 clients on Windows. For an unknown
> reason the file path for a number of files in P4 does not match the
> directory path with respect to case sensitivity.
>
> E.g. `p4 files` might return
> //depot/path/to/file1
> //depot/PATH/to/file2
>
> If you use P4/P4V then these files end up in the same directory, e.g.
> //depot/path/to/file1
> //depot/path/to/file2
>
> If you use git-p4 then all files not matching the correct file path
> (e.g. `file2`) will be ignored.
>
> SOLUTION:
> Identify files that are different with respect to case sensitivity.
This may be confusing:
It's the "file names" that differ, not the file content.
And in the rest of the patch the term "path" is used.
How about this:

Identify path names that are different with respect to case sensitivity.


> If there are any then run `p4 dirs` to build up a dictionary
> containing the "correct" cases for each path. It looks like P4
> interprets "correct" here as the existing path of the first file in a
> directory. The path dictionary is used later on to fix all paths.
>
> This is only applied if the parameter "--fix-paths" is passed to the
> git-p4 clone command.
The "fix-path" doesn't tell a user what exactly is fixed.
Something like "fix-path-case" may be more self-explaining,
but I would simply use "--ignore-case", which is more in line
with Git. (But this is debatable)
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py                         | 83 +++++++++++++++++++++++++++++++++--
>   t/t9821-git-p4-path-variations.sh | 91 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 170 insertions(+), 4 deletions(-)
>   create mode 100755 t/t9821-git-p4-path-variations.sh
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..a21809d 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1931,7 +1931,7 @@ class View(object):
>                   (self.client_prefix, clientFile))
>           return clientFile[len(self.client_prefix):]
>
> -    def update_client_spec_path_cache(self, files):
> +    def update_client_spec_path_cache(self, files, fixPathCase = None):
>           """ Caching file paths by "p4 where" batch query """
>
>           # List depot file paths exclude that already cached
> @@ -1950,6 +1950,8 @@ class View(object):
>               if "unmap" in res:
>                   # it will list all of them, but only one not unmap-ped
>                   continue
> +            if fixPathCase:
> +                res['depotFile'] = fixPathCase(res['depotFile'])
>               self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
>
>           # not found files or unmap files set to ""
> @@ -1987,6 +1989,7 @@ class P4Sync(Command, P4UserMap):
>                                        help="Maximum number of changes to import"),
>                   optparse.make_option("--changes-block-size", dest="changes_block_size", type="int",
>                                        help="Internal block size to use when iteratively calling p4 changes"),
> +                optparse.make_option("--fix-paths", dest="fixPaths", action="store_true"),
>                   optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
>                                        help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
>                   optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
> @@ -2017,6 +2020,7 @@ class P4Sync(Command, P4UserMap):
>           self.maxChanges = ""
>           self.changes_block_size = None
>           self.keepRepoPath = False
> +        self.fixPaths = False
>           self.depotPaths = None
>           self.p4BranchesInGit = []
>           self.cloneExclude = []
> @@ -2049,7 +2053,8 @@ class P4Sync(Command, P4UserMap):
>           files = []
>           fnum = 0
>           while commit.has_key("depotFile%s" % fnum):
> -            path =  commit["depotFile%s" % fnum]
> +            path = commit["depotFile%s" % fnum]
> +            path = self.fixPathCase(path)
>
>               if [p for p in self.cloneExclude
>                   if p4PathStartsWith(path, p)]:
> @@ -2113,7 +2118,9 @@ class P4Sync(Command, P4UserMap):
>           branches = {}
>           fnum = 0
>           while commit.has_key("depotFile%s" % fnum):
> -            path =  commit["depotFile%s" % fnum]
> +            path = commit["depotFile%s" % fnum]
> +            path = self.fixPathCase(path)
> +
>               found = [p for p in self.depotPaths
>                        if p4PathStartsWith(path, p)]
>               if not found:
> @@ -2240,6 +2247,10 @@ class P4Sync(Command, P4UserMap):
>               if marshalled["code"] == "error":
>                   if "data" in marshalled:
>                       err = marshalled["data"].rstrip()
> +
> +        if "depotFile" in marshalled:
> +            marshalled['depotFile'] = self.fixPathCase(marshalled['depotFile'])
> +
>           if err:
>               f = None
>               if self.stream_have_file_info:
> @@ -2314,6 +2325,7 @@ class P4Sync(Command, P4UserMap):
>
>               # do the last chunk
>               if self.stream_file.has_key('depotFile'):
> +                self.stream_file['depotFile'] = self.fixPathCase(self.stream_file['depotFile'])
>                   self.streamOneP4File(self.stream_file, self.stream_contents)
>
>       def make_email(self, userid):
> @@ -2371,7 +2383,8 @@ class P4Sync(Command, P4UserMap):
>                   sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
>
>           if self.clientSpecDirs:
> -            self.clientSpecDirs.update_client_spec_path_cache(files)
> +            self.clientSpecDirs.update_client_spec_path_cache(
> +                files, lambda x: self.fixPathCase(x))
>
>           self.gitStream.write("commit %s\n" % branch)
>   #        gitStream.write("mark :%s\n" % details["change"])
> @@ -2835,6 +2848,63 @@ class P4Sync(Command, P4UserMap):
>               print "IO error with git fast-import. Is your git version recent enough?"
>               print self.gitError.read()
>
> +    def fixPathCase(self, path):
> +        if self.caseCorrectedPaths:
> +            components = path.split('/')
> +            filename = components.pop()
> +            dirname = '/'.join(components).lower() + '/'
> +            if dirname in self.caseCorrectedPaths:
> +                path = self.caseCorrectedPaths[dirname] + filename
> +        return path
> +
> +    def generatePathCaseDict(self, depotPaths):
> +        # Query all files and generate a list of all used paths
> +        # e.g. this files list:
> +        # //depot/path/to/file1
> +        # //depot/PATH/to/file2
> +        #
> +        # result in this path list:
> +        # //depot/
> +        # //depot/PATH/
> +        # //depot/path/
> +        # //depot/PATH/to/
> +        # //depot/path/to/
> +        p4_paths = set()
> +        for p in depotPaths:
> +            for f in p4CmdList(["files", p+"..."]):
> +                components = f["depotFile"].split('/')[0:-1]
> +                for i in range(3, len(components)+1):
> +                    p4_paths.add('/'.join(components[0:i]) + '/')
> +        p4_paths = sorted(list(p4_paths), key=len)
> +
> +        if len(p4_paths) > len(set([p.lower() for p in p4_paths])):
> +            print "ATTENTION: File paths with different case variations detected. Fixing may take a while..."
> +            found_variations = True
> +            while found_variations:
> +                for path in p4_paths:
> +                    found_variations = False
> +                    path_variations = [p for p in p4_paths if p.lower() == path.lower()]
> +
> +                    if len(path_variations) > 1:
> +                        print  "%i different case variations for path '%s' detected." % (len(path_variations), path)
> +                        # If we detect path variations (e.g. //depot/path and //depot/PATH) then we query P4 to list
> +                        # the subdirectories of the parent (e.g //depot/*). P4 will return these subdirectories with
> +                        # the correct case.
> +                        parent_path = '/'.join(path.split('/')[0:-2])
> +                        case_ok_paths = [p["dir"] + '/' for p in p4CmdList(["dirs", "-D", parent_path + '/*'])]
> +
> +                        # Replace all known paths with the case corrected path from P4 dirs command
> +                        for case_ok_path in case_ok_paths:
> +                            pattern = re.compile("^" + re.escape(case_ok_path), re.IGNORECASE)
> +                            p4_paths = sorted(list(set([pattern.sub(case_ok_path, p) for p in p4_paths])), key=len)
> +
> +                        found_variations = True
> +                        break
> +            return dict((p.lower(), p) for p in p4_paths)
> +        else:
> +            if self.verbose:
> +                print "All file paths have consistent case"
> +            return None
>
>       def run(self, args):
>           self.depotPaths = []
> @@ -3006,6 +3076,11 @@ class P4Sync(Command, P4UserMap):
>
>           self.depotPaths = newPaths
>
> +        if self.fixPaths:
> +            self.caseCorrectedPaths = self.generatePathCaseDict(self.depotPaths)
> +        else:
> +            self.caseCorrectedPaths = None
> +
>           # --detect-branches may change this for each branch
>           self.branchPrefixes = self.depotPaths
>
> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
> new file mode 100755
> index 0000000..ede772f
> --- /dev/null
> +++ b/t/t9821-git-p4-path-variations.sh
> @@ -0,0 +1,91 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories with path case variations'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d with case folding enabled' '
> +	start_p4d -C1
> +'
> +
> +test_expect_success 'Create a repo with path case variations' '
> +	client_view "//depot/... //client/..." &&
> +	cd "$cli" &&
> +
> +	mkdir -p One/two &&
> +	> One/two/File2.txt &&
Minor remark: To be more Git-style, please no space after '>':

>One/two/File2.txt &&


> +	p4 add One/two/File2.txt &&
> +	p4 submit -d "Add file2" &&
> +	rm -rf One &&
> +
> +	mkdir -p one/TWO &&
> +	> one/TWO/file1.txt &&
Same here
> +	p4 add one/TWO/file1.txt &&
> +	p4 submit -d "Add file1" &&
> +	rm -rf one &&
> +
> +	mkdir -p one/two &&
> +	> one/two/file3.txt &&
and here
> +	p4 add one/two/file3.txt &&
> +	p4 submit -d "Add file3" &&
> +	rm -rf one
> +'
> +
> +test_expect_success 'Clone the repo and WITHOUT path fixing' '
> +	client_view "//depot/One/... //client/..." &&
> +	git p4 clone --use-client-spec --destination="$git" //depot/one &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
The cd command should be in a subshell:

     (
         cd $git &&
         test -f xxxx &&
         test_this_and_that
     )


Writing shell scripts isn't easy,
there is some information in
Documentation/CodingGuidelines
and
t/README

> +		find . | grep two/File2.txt &&
Should we make sure that two/File2.txt exist?
Then the "find | grep" feels like overkill.
The line
test -f  two/File2.txt &&
could do the same (or do I miss something ?)
> +		git ls-files > lines &&
and here
> +		test_line_count = 1 lines
> +	)
> +'
> +
> +test_expect_success 'Clone the repo WITH path fixing' '
> +	client_view "//depot/One/... //client/..." &&
> +	git p4 clone --fix-paths --use-client-spec --destination="$git" //depot/one &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		find . | grep TWO/file1.txt &&
> +		find . | grep TWO/File2.txt &&
> +		find . | grep TWO/file3.txt &&
Not sure about the find | grep here either.
> +		git ls-files > lines &&
> +		test_line_count = 3 lines
> +	)
> +'
> +
> +# It looks like P4 determines the path case based on the first file in
> +# lexicographical order. Please note the lower case "two" directory for all
> +# files triggered through the addition of "File0.txt".
> +test_expect_success 'Add a new file and clone the repo WITH path fixing' '
> +	client_view "//depot/... //client/..." &&
> +	cd "$cli" &&
> +
> +	mkdir -p One/two &&
> +	> One/two/File0.txt &&
> +	p4 add One/two/File0.txt &&
> +	p4 submit -d "Add file" &&
> +	rm -rf One &&
> +
> +	client_view "//depot/One/... //client/..." &&
> +	git p4 clone --fix-paths --use-client-spec --destination="$git" //depot/one &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		find . | grep two/File0.txt &&
> +		find . | grep two/file1.txt &&
> +		find . | grep two/File2.txt &&
> +		find . | grep two/file3.txt &&
> +		git ls-files > lines &&
> +		test_line_count = 4 lines
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> --
>
