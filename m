From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH v4] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 13:43:45 -0500
Message-ID: <CAFj1UpEMugSrGv53ajvCm=F_wOFm4qr1bnsR5NRPsvgC_fRs5Q@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAFj1UpGmoEiLeHPh8LaUGLktV55YbTthi1wMNjLDn6vFMSdMwQ@mail.gmail.com>
	<CAMP44s3rwUw1QaADgm0xVOK3ebPNVSa06QdN5voNniD2acsz0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZQtU-0002Bh-QZ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 19:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab2KPSnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 13:43:47 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:61182 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2KPSnq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 13:43:46 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1884776iay.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=peozpkx/JzjPh4CGtrKRM1h4ydZyt1hLyTXt+NmYbjs=;
        b=GF6nDoilEcAD9RGtTc1RK8TLarPYVBi8Zgyj98l/9YHsvchKIppWDLAQ6JRy/Yqhuf
         gBupKAV/X2f+ovYL0caEKZmHPP/J5FWqIFewOT3qkAZK4QoZRAHsIvmfOnf8KmuSGhix
         /x2t+EgFEyuCsFkKxS/sXJk3Axy4Vjz+SmUWvmncqVRU5YLP03iXn3fusg2pC7+qOqs6
         iLvMnvxEXrRzTGu9ClyTMYelNqGiFiNhYt2KOchMDkf4tNl8QMS5As1XBx1yV4TXNfTO
         fr44ivZOMh0wtxMFfi+nx0Kpg+5qF3evUmh9ui6xFWIsQnnpJE/xPwr1EWEtEbqoSSg0
         RmzA==
Received: by 10.50.33.232 with SMTP id u8mr4244040igi.39.1353091425890; Fri,
 16 Nov 2012 10:43:45 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 16 Nov 2012 10:43:45 -0800 (PST)
In-Reply-To: <CAMP44s3rwUw1QaADgm0xVOK3ebPNVSa06QdN5voNniD2acsz0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209892>

The current tcsh-completion support for Git, as can be found on the
Internet, takes the approach of defining the possible completions
explicitly.  This has the obvious draw-back to require constant
updating as the Git code base evolves.

The approach taken by this commit is to to re-use the advanced bash
completion script and use its result for tcsh completion.  This is
achieved by sourcing the bash script and outputting the completion
result for tcsh consumption.

Three solutions were looked at to implement this approach with (C)
being retained:

  A) Modifications:
          git-completion.bash and new git-completion.tcsh

     Modify the existing git-completion.bash script to support
     being sourced using bash (as now), but also executed using bash.
     When being executed, the script will output the result of the
     computed completion to be re-used elsewhere (e.g., in tcsh).

     The modification to git-completion.bash is made not to be
     tcsh-specific, but to allow future users to also re-use its
     output.  Therefore, to be general, git-completion.bash accepts a
     second optional parameter, which is not used by tcsh, but could
     prove useful for other users.

     Pros:
       1- allows the git-completion.bash script to easily be re-used
       2- tcsh support is mostly isolated in git-completion.tcsh
     Cons (for tcsh users only):
       1- requires the user to copy both git-completion.tcsh and
          git-completion.bash to ${HOME}
       2- requires bash script to have a fixed name and location:
          ${HOME}/.git-completion.bash

  B) Modifications:
          git-completion.bash

     Modify the existing git-completion.bash script to support
     being sourced using bash (as now), but also executed using bash,
     and sourced using tcsh.

     Pros:
       1- only requires the user to deal with a single file
       2- maintenance more obvious for tcsh since it is entirely part
          of the same git-completion.bash script.
     Cons:
       1- tcsh support could affect bash support as they share the
          same script
       2- small tcsh section must use syntax suitable for both tcsh
          and bash and must be at the beginning of the script
       3- requires script to have a fixed name and location:
          ${HOME}/.git-completion.sh (for tcsh users only)

  C) Modifications:
          New git-completion.tcsh

     Provide a short tcsh script that generates another script
     which extends git-completion.bash.  This new script can be
     used by tcsh to perform completion.

     Pros:
       1- tcsh support is entirely isolated in git-completion.tcsh
       2- new tcsh script can be as complex as needed
     Cons (for tcsh users only):
       1- requires the user to copy both git-completion.tcsh and
          git-completion.bash to ${HOME}
       2- requires bash script to have a fixed name and location:
          ${HOME}/.git-completion.bash
       3- sourcing the new script will generate a third script

Approach (C) was selected avoid any modification to git-completion.bash.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

As suggested, I put the 'sort | uniq' inside the script.
In that case, I don't need to worry about aliases since 'sort |uniq' will
be executed in bash, for which the tcsh user surely doesn't have aliases setup.

Thanks

Marc


 contrib/completion/git-completion.tcsh | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 contrib/completion/git-completion.tcsh

diff --git a/contrib/completion/git-completion.tcsh
b/contrib/completion/git-completion.tcsh
new file mode 100644
index 0000000..f0327fc
--- /dev/null
+++ b/contrib/completion/git-completion.tcsh
@@ -0,0 +1,63 @@
+#!tcsh
+#
+# tcsh completion support for core Git.
+#
+# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
+# Distributed under the GNU General Public License, version 2.0.
+#
+# When sourced, this script will generate a new script that uses
+# the git-completion.bash script provided by core Git.  This new
+# script can be used by tcsh to perform git completion.
+# The current script also issues the necessary tcsh 'complete'
+# commands.
+#
+# To use this completion script:
+#
+#    1) Copy both this file and the bash completion script to ${HOME}.
+#       You _must_ use the name ${HOME}/.git-completion.bash for the
+#       bash script.
+#       (e.g. ~/.git-completion.tcsh and ~/.git-completion.bash).
+#    2) Add the following line to your .tcshrc/.cshrc:
+#        source ~/.git-completion.tcsh
+
+set __git_tcsh_completion_original_script = ${HOME}/.git-completion.bash
+set __git_tcsh_completion_script = ${HOME}/.git-completion.tcsh.bash
+
+cat << EOF > ${__git_tcsh_completion_script}
+#!bash
+#
+# This script is GENERATED and will be overwritten automatically.
+# Do not modify it directly.  Instead, modify the git-completion.tcsh
+# script provided by Git core.
+#
+
+source ${__git_tcsh_completion_original_script}
+
+# Set COMP_WORDS in a way that can be handled by the bash script.
+COMP_WORDS=(\$1)
+
+# The cursor is at the end of parameter #1.
+# We must check for a space as the last character which will
+# tell us that the previous word is complete and the cursor
+# is on the next word.
+if [ "\${1: -1}" == " " ]; then
+       # The last character is a space, so our location is at the end
+       # of the command-line array
+       COMP_CWORD=\${#COMP_WORDS[@]}
+else
+       # The last character is not a space, so our location is on the
+       # last word of the command-line array, so we must decrement the
+       # count by 1
+       COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
+fi
+
+# Call _git() or _gitk() of the bash script, based on the first
+# element of the command-line
+_\${COMP_WORDS[0]}
+
+IFS=\$'\n'
+echo "\${COMPREPLY[*]}" | sort | uniq
+EOF
+
+complete git  'p/*/`bash ${__git_tcsh_completion_script} "${COMMAND_LINE}"`/'
+complete gitk 'p/*/`bash ${__git_tcsh_completion_script} "${COMMAND_LINE}"`/'
--
1.8.0.1.g9fe2839
