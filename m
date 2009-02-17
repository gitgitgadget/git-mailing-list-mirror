From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 10:39:12 -0800
Message-ID: <7vvdr852nj.fsf@gitster.siamese.dyndns.org>
References: <200902171012.06176.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUs6-0001AH-Kv
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZBQSjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZBQSjS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:39:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZBQSjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:39:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 12D252B560;
	Tue, 17 Feb 2009 13:39:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D8C32B557; Tue,
 17 Feb 2009 13:39:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 480E90F6-FD22-11DD-B699-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110434>

John Tapsell <johnflux@gmail.com> writes:

> A lot of people see this message for the first time on the gitweb
> interface, where there is no clue as to what 'this file' means.
>
> Signed-off-by: John Tapsell <johnflux@gmail.com>

Thanks.

> diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
> index 93c6055..f753d28 100755
> --- a/templates/hooks--update.sample
> +++ b/templates/hooks--update.sample
> @@ -43,10 +43,11 @@ allowdeletetag=$(git config --bool hooks.allowdeletetag)
>  
>  # check for no description
>  projectdesc=$(sed -e '1q' "$GIT_DIR/description")
> -if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
> +case $projectdesc in "Unnamed repository;"*|'')
>  	echo "*** Project description file hasn't been set" >&2
>  	exit 1
> -fi
> +	;;
> +esac

"case" certainly makes it easier to read, but please start a case arm on a
fresh line, like this:

	case $projectdesc in
        "Unnamed repository;"* | '')
		echo "*** Project description ..."
		exit 1
		;;
	esac

>  # --- Check types
>  # if $newrev is 0000...0000, it's a commit to delete a ref.
> diff --git a/templates/this--description b/templates/this--description
> index c6f25e8..914a64e 100644
> --- a/templates/this--description
> +++ b/templates/this--description
> @@ -1 +1 @@
> -Unnamed repository; edit this file to name it for gitweb.
> +Unnamed repository; edit the .git/description file to name it for gitweb.

I do not have a fundamental objection to this line of changes.  If anybody
is relying on the exact wording so be it.

But ".git/description" is not typically the user has to edit to remedy
this situation, because the primary target for both gitweb and git-push is
a bare repository.  I think it is better to say "edit the 'description'
file to name it for gitweb."
