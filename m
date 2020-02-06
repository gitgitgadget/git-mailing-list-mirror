Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C9C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BBA20838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6yX9Sjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBFPP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:15:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgBFPPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 10:15:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so7642888wru.7
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 07:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4eOyr8WHefCXSFPQvSyoY++PuE9shR4BCI8l815oeNc=;
        b=i6yX9SjmZeI5yArEbctLY2/PPXQ04qLAkBKruA1qFAVlPLKx8ozvXOfSYEtRgQsMkV
         1i7G2T120Q/1oPmZYkyDw2//tjdxKAYosUQ1zBtdk1H8ScHBwyvJh1V56+1ANLp1OwBY
         7IgKT7H3FTU2RF7s7vlfjYZ3wIV8UKtzyAhOvLNLjUYGRTkh8/wiijTKFcCtMR4+IKBt
         c/4mbDtnjsKacqQodXcVAbM1y69wOkQICZLJZDO5c943QpUKCADuVR0ZvcKCBIEH3y5e
         2TY/8qOaxy4QiFPKEGMPZbkbfgifhZoTqYfkrWKNjepnCeIQntlMk6CHGXgNug07I6Ul
         cVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4eOyr8WHefCXSFPQvSyoY++PuE9shR4BCI8l815oeNc=;
        b=oGvpPpRPH3iO/SHwhDooLvnk7AjhIG35kaCLLVk91MdeoDpxLbkqob2J/NNhjxBGBz
         Jf1taZ0RI+0M3e+cOQj5vZqhm1utG+xvotBfjuY0KjBiDJ1LB1MiIT+aHy+d8QIRg/nr
         D0UD6YOG0GKpLqGCCCc0ODh1/3Yh+MzbsM8LmY4asDMevtXrFReUMXbJDmFBDUsWN6gW
         oNidOABc29kgScyOGqkdIY7+BmK/X12vKQLON7VuQZp6AhoIE3RdZiCGR0M76lcfEC9M
         lazVee7+pq6zOH8DBE6V50kQeLFphy6oCzbVHoFWj4MxqS9BK9RGzTs0en8aEtfL74Iv
         CRLw==
X-Gm-Message-State: APjAAAWdzoz17n2U+d02atoOvwvFysz+EK9cHZ85hXwm6GNNnPGhiMs9
        0N5eD5yUn7bRo5yCr9K60TBMnSgX
X-Google-Smtp-Source: APXvYqxkfLx6+jNhK6sjiXHDgs7vxERBL+VBiT6Ay67x+IksmorbpDe6YXqaJCNPObzkJwatDpMWPQ==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr4213036wrs.420.1581002150663;
        Thu, 06 Feb 2020 07:15:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm4058942wmd.20.2020.02.06.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:15:49 -0800 (PST)
Message-Id: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
References: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:15:43 +0000
Subject: [PATCH v3 0/5] git-p4: add hook p4-pre-edit-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our company's workflow requires that our P4 check-in messages have a
specific format. A helpful feature in the GIT-P4 program would be a hook
that occurs after the P4 change list is created but before it is displayed
in the editor that would allow an external program to possibly edit the
changelist text.

v1:My suggestion for the hook name is p4-pre-edit-changelist.

It would take a single parameter, the full path of the temporary file. If
the hook returns a non-zero exit code, it would cancel the current P4
submit.

The hook should be optional.

v2:Instead of a single hook, p4-pre-edit-changelist, follow the git
convention for hook names and add the trio of hooks that work together,
similar to git commit.

The hook names are: 

 * p4-prepare-changelist
 * p4-changelist
 * p4-post-changelist

The hooks should follow the same convention as git commit, so a new command
line option for the git-p4 submit function --no-verify should also be added.

v3:2-Feb-2020 This version reorganizes the commits to be easier to read. The
function for running the git hook has been rewritten to include suggestions.
This version no longer restricts the executable supported by windows for the
hook. It will first look for a file with the hook name without an extension
and if found, it will pass it to sh.exe (Git for Window's MINGW shell)
Otherwise it will take the file with the lowest alphabetical extension and
ask Windows to execute the program.

Ben Keene (5):
  git-p4: rewrite prompt to be Windows compatible
  git-p4: create new function run_git_hook
  git-p4: add --no-verify option
  git-p4: restructure code in submit
  git-p4: add p4 submit hooks

 Documentation/git-p4.txt   |  45 +++++++-
 Documentation/githooks.txt |  51 ++++++++-
 git-p4.py                  | 226 ++++++++++++++++++++++++++++---------
 3 files changed, 264 insertions(+), 58 deletions(-)


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v3
Pull-Request: https://github.com/git/git/pull/698

Range-diff vs v2:

 1:  585bdd51b2 = 1:  8881d76c46 git-p4: rewrite prompt to be Windows compatible
 2:  f1f9fdc542 ! 2:  85918a7edb git-p4: create new method gitRunHook
     @@ -1,22 +1,22 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: create new method gitRunHook
     +    git-p4: create new function run_git_hook
      
          This commit is in preparation of introducing new p4 submit hooks.
      
          The current code in the python script git-p4.py makes the assumption
     -    that the git hooks can be executed by subprocess.call() method. However,
     -    when git is run on Windows, this may not work as expected.
     +    that the git hooks can be executed by subprocess.call() function.
     +    However, when git is run on Windows, this may not work as expected.
      
     -    The subprocess.call() does not execute SH.EXE implictly under Windows,
     -    so the scripts may fail. In other words, the hooks do not execute under
     -    windows because the shell interpreter is not automatically loaded.
     +    The subprocess.call() does not cover all the use cases for properly
     +    executing the various types of executable files on Windows.
      
     -    Add a new function, gitRunHook, that takes 2 parameters:
     -    * the filename of an optionally registered git hook
     +    Prepare for remediation by adding a new function, run_git_hook, that
     +    takes 2 parameters:
     +    * the short filename of an optionally registered git hook
          * an optional list of parameters
      
     -    The gitRunHook function will honor the existing behavior seen in the
     +    The run_git_hook function will honor the existing behavior seen in the
          current code for executing the p4-pre-submit hook:
      
          * Hooks are looked for in core.hooksPath directory.
     @@ -28,15 +28,32 @@
            return True.
          * If the hook returns a non-zero exit code, the function returns False.
      
     -    Add new conditional behavior for Windows:
     -    * Check for an evironment variable 'EXEPATH' which should be set by
     -      git when git-p4.py is envoked.
     -    * If EXEPATH is None - treat it as an empty string.
     -    * If EXEPATH is set, look for sh.exe in the bin/ directory located
     -      in EXEPATH.
     -    * If EXEPATH is not set, attempt to resolve against "bin/sh.exe"
     -    * Add a new test for Windows that checks to see of sh.exe can be
     -      located. If not, return True.
     +    Add the following additional functionality if git-p4.py is run on
     +    Windows.
     +    * If hook file is not located without an extension, search for
     +      any file in the associated hook directory (from the list above) that
     +      has the same name but with an extension.
     +    * If the file is still not found, return True (the hook is missing)
     +
     +    Add a new function run_hook_command() that wraps the OS dependent
     +    functionality for actually running the subprocess.call() with OS
     +    dependent behavior:
     +
     +    If a hook file exists on Windows:
     +    * If there is no extension, set the launch executable to be SH.EXE
     +      - Look for SH.EXE under the environmental variable EXEPATH in the
     +        bin/ directory.
     +      - If %EXEPATH%/bin/sh.exe exists, use this as the actual executable.
     +      - If %EXEPATH%/bin/sh.exe does not exist, use sh.exe
     +      - Execute subprocess.call() without the shell (shell=False)
     +    * If there is an extension, execute subprocess.call() with teh shell
     +      (shell=True) and consider the file to be the executable.
     +
     +    The return value from run_hook_command() is the subprocess.call()
     +    return value.
     +
     +    These functions are added in this commit, but are only staged and not
     +    yet used.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
     @@ -44,10 +61,18 @@
       --- a/git-p4.py
       +++ b/git-p4.py
      @@
     -     "unshelve" : P4Unshelve,
     - }
     + import zlib
     + import ctypes
     + import errno
     ++import glob
       
     -+def gitRunHook(cmd, param=[]):
     + # support basestring in python3
     + try:
     +@@
     +         if response in choices:
     +             return response
     + 
     ++def run_git_hook(cmd, param=[]):
      +    """Execute a hook if the hook exists."""
      +    if verbose:
      +        sys.stderr.write("Looking for hook: %s\n" % cmd)
     @@ -57,25 +82,65 @@
      +    if len(hooks_path) <= 0:
      +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
      +
     -+    hook_file = os.path.join(hooks_path, cmd)
     -+    if isinstance(param,basestring):
     ++    if not isinstance(param, list):
      +        param=[param]
      +
     ++    # resolve hook file name, OS depdenent
     ++    hook_file = os.path.join(hooks_path, cmd)
      +    if platform.system() == 'Windows':
     -+        exepath = os.environ.get("EXEPATH")
     -+        if exepath is None:
     -+            exepath = ""
     -+        shexe = os.path.join(exepath, "bin", "sh.exe")
     -+        if os.path.isfile(shexe) \
     -+            and os.path.isfile(hook_file) \
     -+            and os.access(hook_file, os.X_OK) \
     -+            and subprocess.call([shexe, hook_file] + param) != 0:
     -+            return False
     ++        if not os.path.isfile(hook_file):
     ++            # look for the file with an extension
     ++            files = glob.glob(hook_file + ".*")
     ++            if not files:
     ++                return True
     ++            files.sort()
     ++            hook_file = files[0]
     ++
     ++    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
     ++        return True
      +
     -+    else:
     -+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file] + param) != 0:
     -+            return False
     -+    return True
     ++    return run_hook_command(hook_file, param) == 0
     ++
     ++def run_hook_command(cmd, param):
     ++    """Executes a git hook command
     ++       cmd = the command line file to be executed. This can be
     ++       a file that is run by OS association.
     ++
     ++       param = a list of parameters to pass to the cmd command
     ++
     ++       On windows, the extension is checked to see if it should
     ++       be run with the Git for Windows Bash shell.  If there
     ++       is no file extension, the file is deemed a bash shell
     ++       and will be handed off to sh.exe. Otherwise, Windows
     ++       will be called with the shell to handle the file assocation.
     ++
     ++       For non Windows operating systems, the file is called
     ++       as an executable.
     ++    """
     ++    cli = [cmd] + param
     ++    use_shell = False
     ++    if platform.system() == 'Windows':
     ++        (root,ext) = os.path.splitext(cmd)
     ++        if ext == "":
     ++            exe_path = os.environ.get("EXEPATH")
     ++            if exe_path is None:
     ++                exe_path = ""
     ++            else:
     ++                exe_path = os.path.join(exe_path, "bin")
     ++            cli = [os.path.join(exe_path, "SH.EXE")] + cli
     ++        else:
     ++            use_shell = True
     ++    return subprocess.call(cli, shell=use_shell)
     ++
     ++
     + def write_pipe(c, stdin):
     +     if verbose:
     +         sys.stderr.write('Writing pipe: %s\n' % str(c))
     +@@
     +     "unshelve" : P4Unshelve,
     + }
       
     +-
       def main():
           if len(sys.argv[1:]) == 0:
     +         printUsage(commands.keys())
 -:  ---------- > 3:  b538ad08b6 git-p4: add --no-verify option
 3:  1bdcdc4c18 ! 4:  662b864d70 git-p4: add hook p4-pre-edit-changelist
     @@ -1,23 +1,38 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: add hook p4-pre-edit-changelist
     +    git-p4: restructure code in submit
      
     -    Add an additional hook to the git-p4 command to allow a hook to modify
     -    the text of the changelist prior to displaying the p4editor command.
     +    In preparation for adding new hooks to the submit method of git-p4,
     +    restructure the applyCommit function in the P4Submit class.  Make the
     +    following changes:
      
     -    This hook will be called prior to checking for the flag
     -    "--prepare-p4-only".
     +    * Move all the code after the definition of submitted = False into the
     +      Try-Finally block. This ensures that any error that occurs will
     +      properly recover.  This is not necessary with the current code because
     +      none of it should throw an exception, however the next set of changes
     +      will introduce exceptional code.
      
     -    The hook is optional, if it does not exist, it will be skipped.
     +      Existing flow control can remain as defined - the if-block for
     +      prepare-p4-only sets the local variable "submitted" to True and exits
     +      the function. New early exits, leave submitted set to False so the
     +      Finally block will undo changes to the P4 workspace.
      
     -    The hook takes a single parameter, the filename of the temporary file
     -    that contains the P4 submit text.
     +    * Make the small usability change of adding an empty string to the
     +      print statements displayed to the user when the prepare-p4-only option
     +      is selected.  On Windows, the command print() may display a set of
     +      parentheses "()" to the user when the print() function is called with
     +      no parameters. By supplying an empty string, the intended blank line
     +      will print as expected.
      
     -    The hook should return a zero exit code on success or a non-zero exit
     -    code on failure.  If the hook returns a non-zero exit code, git-p4
     -    will revert the P4 edits by calling p4_revert(f) on each file that was
     -    flagged as edited and then it will return False so the calling method
     -    may continue as it does in existing failure cases.
     +    * Fix a small bug when the submittedTemplate is edited by the user
     +      and all content in the file is removed. The existing code will throw
     +      an exception if the separateLine is not found in the file. Change this
     +      code to test for the separator line using a find() test first and only
     +      split on the separator if it is found.
     +
     +    * Additionally, add the new behavior that if the changelist file has
     +      been completely emptied that the Submit action for this changelist
     +      will be aborted.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
     @@ -28,17 +43,126 @@
               tmpFile.write(submitTemplate)
               tmpFile.close()
       
     -+        # Run the pre-edit hook to allow programmatic update to the changelist
     -+        hooks_path = gitConfig("core.hooksPath")
     -+        if len(hooks_path) <= 0:
     -+            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     +-        if self.prepare_p4_only:
     +-            #
     +-            # Leave the p4 tree prepared, and the submit template around
     +-            # and let the user decide what to do next
     +-            #
     +-            print()
     +-            print("P4 workspace prepared for submission.")
     +-            print("To submit or revert, go to client workspace")
     +-            print("  " + self.clientPath)
     +-            print()
     +-            print("To submit, use \"p4 submit\" to write a new description,")
     +-            print("or \"p4 submit -i <%s\" to use the one prepared by" \
     +-                  " \"git p4\"." % fileName)
     +-            print("You can delete the file \"%s\" when finished." % fileName)
     +-
     +-            if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
     +-                print("To preserve change ownership by user %s, you must\n" \
     +-                      "do \"p4 change -f <change>\" after submitting and\n" \
     +-                      "edit the User field.")
     +-            if pureRenameCopy:
     +-                print("After submitting, renamed files must be re-synced.")
     +-                print("Invoke \"p4 sync -f\" on each of these files:")
     +-                for f in pureRenameCopy:
     +-                    print("  " + f)
     +-
     +-            print()
     +-            print("To revert the changes, use \"p4 revert ...\", and delete")
     +-            print("the submit template file \"%s\"" % fileName)
     +-            if filesToAdd:
     +-                print("Since the commit adds new files, they must be deleted:")
     +-                for f in filesToAdd:
     +-                    print("  " + f)
     +-            print()
     +-            return True
     +-
     +-        #
     +-        # Let the user edit the change description, then submit it.
     +-        #
     +         submitted = False
     + 
     +         try:
     ++
     ++            if self.prepare_p4_only:
     ++                #
     ++                # Leave the p4 tree prepared, and the submit template around
     ++                # and let the user decide what to do next
     ++                #
     ++                submitted = True
     ++                print("")
     ++                print("P4 workspace prepared for submission.")
     ++                print("To submit or revert, go to client workspace")
     ++                print("  " + self.clientPath)
     ++                print("")
     ++                print("To submit, use \"p4 submit\" to write a new description,")
     ++                print("or \"p4 submit -i <%s\" to use the one prepared by" \
     ++                      " \"git p4\"." % fileName)
     ++                print("You can delete the file \"%s\" when finished." % fileName)
      +
     -+        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
     -+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
     -+            for f in editedFiles:
     -+                p4_revert(f)
     -+            return False
     ++                if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
     ++                    print("To preserve change ownership by user %s, you must\n" \
     ++                          "do \"p4 change -f <change>\" after submitting and\n" \
     ++                          "edit the User field.")
     ++                if pureRenameCopy:
     ++                    print("After submitting, renamed files must be re-synced.")
     ++                    print("Invoke \"p4 sync -f\" on each of these files:")
     ++                    for f in pureRenameCopy:
     ++                        print("  " + f)
     ++
     ++                print("")
     ++                print("To revert the changes, use \"p4 revert ...\", and delete")
     ++                print("the submit template file \"%s\"" % fileName)
     ++                if filesToAdd:
     ++                    print("Since the commit adds new files, they must be deleted:")
     ++                    for f in filesToAdd:
     ++                        print("  " + f)
     ++                print("")
     ++                sys.stdout.flush()
     ++                return True
     ++
     +             if self.edit_template(fileName):
     +                 # read the edited message and submit
     +                 tmpFile = open(fileName, "rb")
     +@@
     +                 tmpFile.close()
     +                 if self.isWindows:
     +                     message = message.replace("\r\n", "\n")
     +-                submitTemplate = message[:message.index(separatorLine)]
     ++                if message.find(separatorLine) <> -1:
     ++                    submitTemplate = message[:message.index(separatorLine)]
     ++                else:
     ++                    submitTemplate = message
      +
     -         if self.prepare_p4_only:
     -             #
     -             # Leave the p4 tree prepared, and the submit template around
     ++                if len(submitTemplate.strip()) == 0:
     ++                    print("Changelist is empty, aborting this changelist.")
     ++                    sys.stdout.flush()
     ++                    return False
     + 
     +                 if update_shelve:
     +                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
     +@@
     +                 submitted = True
     + 
     +         finally:
     +-            # skip this patch
     ++            # Revert changes if we skip this patch
     +             if not submitted or self.shelve:
     +                 if self.shelve:
     +                     print ("Reverting shelved files.")
     +                 else:
     +                     print ("Submission cancelled, undoing p4 changes.")
     ++                sys.stdout.flush()
     +                 for f in editedFiles | filesToDelete:
     +                     p4_revert(f)
     +                 for f in filesToAdd:
     +                     p4_revert(f)
     +                     os.remove(f)
     + 
     +-        os.remove(fileName)
     ++            if not self.prepare_p4_only:
     ++                os.remove(fileName)
     +         return submitted
     + 
     +     # Export git tags as p4 labels. Create a p4 label and then tag
 4:  3d34dd042e ! 5:  e34c377066 git-p4: add p4 submit hooks
     @@ -4,19 +4,11 @@
      
          The git command "commit" supports a number of hooks that support
          changing the behavior of the commit command.  The git-p4.py program only
     -    has one existing hook, "p4-p4-pre-submit".  This command occurs early
     -    in the process.  There are no hooks in the process flow for modifying
     +    has one existing hook, "p4-pre-submit".  This command occurs early in
     +    the process.  There are no hooks in the process flow for modifying
          the P4 changelist text programmatically.
      
     -    Adds 3 new hooks and 1 new option to git-p4.py to the submit option.
     -
     -    The new command line option --no-verify:
     -
     -    Add a new command line option "--no-verify" to the Submit command of
     -    git-p4.py.  This option will function in the spirit of the existing
     -    --no-verify command line option found in git commit. It will cause the
     -    P4 Submit function to ignore the existing p4-pre-submit and the new
     -    p4-changelist hooks.
     +    Adds 3 new hooks to git-p4.py to the submit option.
      
          The new hooks are:
          * p4-prepare-changelist - Execute this hook after the changelist file
     @@ -34,62 +26,16 @@
            executed regardless of the --no-verify option.  It's return value will
            not be checked.
      
     -    Change the execution of the existing trigger p4-pre-submit to honor the
     -    --no-verify option. Before exiting on failure of this hook, display
     -    text to the user explaining which hook has failed and the impact
     -    of using the --no-verify option.
     -
     -    Move all the code after creating the submitTemplate text into the
     -    try-finally block in the applyCommit() method.  By restructuring the
     -    code, the P4 workspace is protected against otherwise unhandled
     -    exceptions and other early exits.
     -
          The calls to the new hooks: p4-prepare-changelist, p4-changelist,
          and p4-post-changelist should all be called inside the try-finally
          block.
      
     -    Existing flow control can remain as defined - the if-block for
     -    prepare-p4-only sets the local variable "submitted" to True and exits
     -    the function. All other early exits, leave submitted set to False so the
     -    Finally block will undo changes to the P4 workspace.
     -
     -    Make the small usability change of adding an empty string to the
     -    print statements displayed to the user when the prepare-p4-only option
     -    is selected.  On Windows, the command print() may display a set of
     -    parentheses () to the user when the print() function is called with no
     -    parameters. By supplying an empty string, the intended blank line will
     -    print as expected.
     -
     -    Fix a small bug when the submittedTemplate is edited by the user
     -    and all content in the file is removed. The existing code will throw
     -    an exception if the separateLine is not found in the file.  Change this
     -    code to test for the separator line using a find() test first and only
     -    split on the separator if it is found.
     -
     -    Additionally, add the new behavior that if the changelist file has been
     -    completely emptied that the Submit action for this changelist will be
     -    aborted.
     -
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
       diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
       --- a/Documentation/git-p4.txt
       +++ b/Documentation/git-p4.txt
      @@
     -     been submitted. Implies --disable-rebase. Can also be set with
     -     git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
     - 
     --Hook for submit
     --~~~~~~~~~~~~~~~
     -+Hooks for submit
     -+----------------
     -+
     -+p4-pre-submit
     -+~~~~~~~~~~~~~
     -+
     - The `p4-pre-submit` hook is executed if it exists and is executable.
     - The hook takes no parameters and nothing from standard input. Exiting with
     - non-zero status from this script prevents `git-p4 submit` from launching.
       
       One usage scenario is to run unit tests in the hook.
       
     @@ -128,10 +74,9 @@
      +git p4 submit action.
      +
      +
     -+
     + 
       Rebase options
       ~~~~~~~~~~~~~~
     - These options can be used to modify 'git p4 rebase' behavior.
      
       diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
       --- a/Documentation/githooks.txt
     @@ -194,24 +139,18 @@
       --- a/git-p4.py
       +++ b/git-p4.py
      @@
     -                                      "work from a local git branch that is not master"),
                       optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
                                            help="Skip Perforce sync of p4/master after submit or shelve"),
     -+                optparse.make_option("--no-verify", dest="no_verify", action="store_true",
     +                 optparse.make_option("--no-verify", dest="no_verify", action="store_true",
     +-                                     help="Bypass p4-pre-submit"),
      +                                     help="Bypass p4-pre-submit and p4-changelist hooks"),
               ]
               self.description = """Submit changes from git to the perforce depot.\n
     --    The `p4-pre-submit` hook is executed if it exists and is executable.
     --    The hook takes no parameters and nothing from standard input. Exiting with
     --    non-zero status from this script prevents `git-p4 submit` from launching.
     --
     --    One usage scenario is to run unit tests in the hook."""
     -+    The `p4-pre-submit` hook is executed if it exists and is executable. It
     -+    can be bypassed with the `--no-verify` command line option. The hook takes
     -+    no parameters and nothing from standard input. Exiting with a non-zero status
     -+    from this script prevents `git-p4 submit` from launching.
     -+
     -+    One usage scenario is to run unit tests in the hook.
     +     The `p4-pre-submit` hook is executed if it exists and is executable. It
     +@@
     +     from this script prevents `git-p4 submit` from launching.
     + 
     +     One usage scenario is to run unit tests in the hook.
      +
      +    The `p4-prepare-changelist` hook is executed right after preparing the default
      +    changelist message and before the editor is started. It takes one parameter,
     @@ -234,137 +173,26 @@
      +    The `p4-post-changelist` hook is invoked after the submit has successfully
      +    occured in P4. It takes no parameters and is meant primarily for notification
      +    and cannot affect the outcome of the git p4 submit action.
     -+    """
     +     """
       
               self.usage += " [name of git branch to submit into perforce depot]"
     -         self.origin = ""
      @@
     -         self.exportLabels = False
     -         self.p4HasMoveCommand = p4_has_move_command()
     -         self.branch = None
     -+        self.no_verify = False
     - 
     -         if gitConfig('git-p4.largeFileSystem'):
     -             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
     -@@
     -         applyPatchCmd = patchcmd + "--check --apply -"
     -         patch_succeeded = True
     - 
     -+        if verbose:
     -+            print("TryPatch: %s" % tryPatchCmd)
     -+
     -         if os.system(tryPatchCmd) != 0:
     -             fixed_rcs_keywords = False
     -             patch_succeeded = False
     -@@
     -                 print("Retrying the patch with RCS keywords cleaned up")
     -                 if os.system(tryPatchCmd) == 0:
     -                     patch_succeeded = True
     -+                    print("Patch succeesed this time")
     - 
     -         if not patch_succeeded:
     -             for f in editedFiles:
     -@@
     -         tmpFile.write(submitTemplate)
     -         tmpFile.close()
     - 
     --        # Run the pre-edit hook to allow programmatic update to the changelist
     --        hooks_path = gitConfig("core.hooksPath")
     --        if len(hooks_path) <= 0:
     --            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     --
     --        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
     --        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
     --            for f in editedFiles:
     --                p4_revert(f)
     --            return False
     --
     --        if self.prepare_p4_only:
     --            #
     --            # Leave the p4 tree prepared, and the submit template around
     --            # and let the user decide what to do next
     --            #
     --            print()
     --            print("P4 workspace prepared for submission.")
     --            print("To submit or revert, go to client workspace")
     --            print("  " + self.clientPath)
     --            print()
     --            print("To submit, use \"p4 submit\" to write a new description,")
     --            print("or \"p4 submit -i <%s\" to use the one prepared by" \
     --                  " \"git p4\"." % fileName)
     --            print("You can delete the file \"%s\" when finished." % fileName)
     --
     --            if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
     --                print("To preserve change ownership by user %s, you must\n" \
     --                      "do \"p4 change -f <change>\" after submitting and\n" \
     --                      "edit the User field.")
     --            if pureRenameCopy:
     --                print("After submitting, renamed files must be re-synced.")
     --                print("Invoke \"p4 sync -f\" on each of these files:")
     --                for f in pureRenameCopy:
     --                    print("  " + f)
     --
     --            print()
     --            print("To revert the changes, use \"p4 revert ...\", and delete")
     --            print("the submit template file \"%s\"" % fileName)
     --            if filesToAdd:
     --                print("Since the commit adds new files, they must be deleted:")
     --                for f in filesToAdd:
     --                    print("  " + f)
     --            print()
     --            return True
     --
     --        #
     --        # Let the user edit the change description, then submit it.
     --        #
               submitted = False
       
               try:
      +            # Allow the hook to edit the changelist text before presenting it
      +            # to the user.
     -+            if not gitRunHook("p4-prepare-changelist", [fileName]):
     ++            if not run_git_hook("p4-prepare-changelist", [fileName]):
      +                return False
     -+
     -+            if self.prepare_p4_only:
     -+                #
     -+                # Leave the p4 tree prepared, and the submit template around
     -+                # and let the user decide what to do next
     -+                #
     -+                submitted = True
     -+                print("")
     -+                print("P4 workspace prepared for submission.")
     -+                print("To submit or revert, go to client workspace")
     -+                print("  " + self.clientPath)
     -+                print("")
     -+                print("To submit, use \"p4 submit\" to write a new description,")
     -+                print("or \"p4 submit -i <%s\" to use the one prepared by" \
     -+                      " \"git p4\"." % fileName)
     -+                print("You can delete the file \"%s\" when finished." % fileName)
     -+
     -+                if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
     -+                    print("To preserve change ownership by user %s, you must\n" \
     -+                          "do \"p4 change -f <change>\" after submitting and\n" \
     -+                          "edit the User field.")
     -+                if pureRenameCopy:
     -+                    print("After submitting, renamed files must be re-synced.")
     -+                    print("Invoke \"p4 sync -f\" on each of these files:")
     -+                    for f in pureRenameCopy:
     -+                        print("  " + f)
     -+
     -+                print("")
     -+                print("To revert the changes, use \"p4 revert ...\", and delete")
     -+                print("the submit template file \"%s\"" % fileName)
     -+                if filesToAdd:
     -+                    print("Since the commit adds new files, they must be deleted:")
     -+                    for f in filesToAdd:
     -+                        print("  " + f)
     -+                print("")
     -+                sys.stdout.flush()
     -+                return True
     -+
     + 
     +             if self.prepare_p4_only:
     +                 #
     +@@
     +                 return True
     + 
                   if self.edit_template(fileName):
      +                if not self.no_verify:
     -+                    if not gitRunHook("p4-changelist", [fileName]):
     ++                    if not run_git_hook("p4-changelist", [fileName]):
      +                        print("The p4-changelist hook failed.")
      +                        sys.stdout.flush()
      +                        return False
     @@ -372,64 +200,11 @@
                       # read the edited message and submit
                       tmpFile = open(fileName, "rb")
                       message = tmpFile.read()
     -                 tmpFile.close()
     -                 if self.isWindows:
     -                     message = message.replace("\r\n", "\n")
     --                submitTemplate = message[:message.index(separatorLine)]
     -+                if message.find(separatorLine) <> -1:
     -+                    submitTemplate = message[:message.index(separatorLine)]
     -+                else:
     -+                    submitTemplate = message
     -+
     -+                if len(submitTemplate.strip()) == 0:
     -+                    print("Changelist is empty, aborting this changelist.")
     -+                    sys.stdout.flush()
     -+                    return False
     - 
     -                 if update_shelve:
     -                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
      @@
       
                       submitted = True
       
     -+                gitRunHook("p4-post-changelist")
     ++                run_git_hook("p4-post-changelist")
               finally:
     --            # skip this patch
     -+            # Revert changes if we skip this patch
     +             # Revert changes if we skip this patch
                   if not submitted or self.shelve:
     -                 if self.shelve:
     -                     print ("Reverting shelved files.")
     -                 else:
     -                     print ("Submission cancelled, undoing p4 changes.")
     -+                sys.stdout.flush()
     -                 for f in editedFiles | filesToDelete:
     -                     p4_revert(f)
     -                 for f in filesToAdd:
     -                     p4_revert(f)
     -                     os.remove(f)
     - 
     --        os.remove(fileName)
     -+                os.remove(fileName)
     -         return submitted
     - 
     -     # Export git tags as p4 labels. Create a p4 label and then tag
     -@@
     -             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
     -                      (len(commits), num_shelves))
     - 
     --        hooks_path = gitConfig("core.hooksPath")
     --        if len(hooks_path) <= 0:
     --            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
     --
     --        hook_file = os.path.join(hooks_path, "p4-pre-submit")
     --        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
     --            sys.exit(1)
     -+        if not self.no_verify:
     -+            if not gitRunHook("p4-pre-submit"):
     -+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
     -+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
     -+                    "however,\nthis will also skip the p4-changelist hook as well.")
     -+                sys.exit(1)
     - 
     -         #
     -         # Apply the commits, one at a time.  On failure, ask if should

-- 
gitgitgadget
