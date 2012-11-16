From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 18:21:11 +0100
Message-ID: <CAMP44s3rwUw1QaADgm0xVOK3ebPNVSa06QdN5voNniD2acsz0g@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAFj1UpGmoEiLeHPh8LaUGLktV55YbTthi1wMNjLDn6vFMSdMwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:21:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZPba-0000hP-P4
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 18:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab2KPRVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 12:21:13 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50930 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2KPRVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 12:21:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3002927obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=inKBWtVaRBH+Ka1yBQav9W9lc0WO0yasHPxJfPb608w=;
        b=KWBSaWt3ffbZJOdpK/3MXaxXVAwu/ToXDqbbhKbVfPYCllFfKoKJLWloLRzaHLsLih
         xy+CHm+7SOkcszWEolEJSL8xRBolaqgaafgdxRbuyjTUK7FU2plUsCX2FbsmtC2UmWoN
         0qtRgQ4zjLxJK4NQnnatUj5KAVuc6lY29JlSFoef3kTkcvgZPWhZWJbLkgDZ/+G4CkJh
         vQZhFb8JoHZuYcT3RkhNusqkUXjDfPFhvIulFIZcbS9BI+60+LlJjph69GTjPmtFKLPL
         zb1mpvzSd5tXEf1DjWeWRu/B619paAx5s7hDmt7A4ozNsDQG3ro7azpezpOGKYx4jabI
         m7jg==
Received: by 10.60.32.19 with SMTP id e19mr4572441oei.9.1353086471584; Fri, 16
 Nov 2012 09:21:11 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 09:21:11 -0800 (PST)
In-Reply-To: <CAFj1UpGmoEiLeHPh8LaUGLktV55YbTthi1wMNjLDn6vFMSdMwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209886>

On Fri, Nov 16, 2012 at 5:12 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:

> diff --git a/contrib/completion/git-completion.tcsh
> b/contrib/completion/git-completion.tcsh
> new file mode 100644
> index 0000000..76395f9
> --- /dev/null
> +++ b/contrib/completion/git-completion.tcsh
> @@ -0,0 +1,63 @@
> +#!tcsh
> +#
> +# tcsh completion support for core Git.
> +#
> +# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
> +# Distributed under the GNU General Public License, version 2.0.
> +#
> +# When sourced, this script will generate a new script that uses
> +# the git-completion.bash script provided by core Git.  This new
> +# script can be used by tcsh to perform git completion.
> +# The current script also issues the necessary tcsh 'complete'
> +# commands.
> +#
> +# To use this completion script:
> +#
> +#    1) Copy both this file and the bash completion script to ${HOME}.
> +#       You _must_ use the name ${HOME}/.git-completion.bash for the
> +#       bash script.
> +#       (e.g. ~/.git-completion.tcsh and ~/.git-completion.bash).
> +#    2) Add the following line to your .tcshrc/.cshrc:
> +#        source ~/.git-completion.tcsh
> +
> +set __git_tcsh_completion_original_script = ${HOME}/.git-completion.bash
> +set __git_tcsh_completion_script = ${HOME}/.git-completion.tcsh.bash
> +
> +cat << EOF > ${__git_tcsh_completion_script}
> +#!bash
> +#
> +# This script is GENERATED and will be overwritten automatically.
> +# Do not modify it directly.  Instead, modify the git-completion.tcsh
> +# script provided by Git core.
> +#
> +
> +source ${__git_tcsh_completion_original_script}
> +
> +# Set COMP_WORDS in a way that can be handled by the bash script.
> +COMP_WORDS=(\$1)
> +
> +# The cursor is at the end of parameter #1.
> +# We must check for a space as the last character which will
> +# tell us that the previous word is complete and the cursor
> +# is on the next word.
> +if [ "\${1: -1}" == " " ]; then
> +       # The last character is a space, so our location is at the end
> +       # of the command-line array
> +       COMP_CWORD=\${#COMP_WORDS[@]}
> +else
> +       # The last character is not a space, so our location is on the
> +       # last word of the command-line array, so we must decrement the
> +       # count by 1
> +       COMP_CWORD=\$((\${#COMP_WORDS[@]}-1))
> +fi
> +
> +# Call _git() or _gitk() of the bash script, based on the first
> +# element of the command-line
> +_\${COMP_WORDS[0]}
> +
> +IFS=\$'\n'
> +echo "\${COMPREPLY[*]}"
> +EOF
> +
> +complete git  'p/*/`bash ${__git_tcsh_completion_script}
> "${COMMAND_LINE}" | \sort | \uniq`/'
> +complete gitk 'p/*/`bash ${__git_tcsh_completion_script}
> "${COMMAND_LINE}" | \sort | \uniq`/'

This looks good to me. Except that maybe the sort and uniq can be
moved to inside the script.

-- 
Felipe Contreras
