From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in a non-bash shell
Date: Fri, 6 Aug 2010 23:31:38 +0200
Message-ID: <201008062331.38279.j6t@kdbg.org>
References: <4C50B005.1030004@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"solsTiCe d'Hiver" <solstice.dhiver@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUW3-0002Gr-BU
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762082Ab0HFVbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 17:31:43 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46583 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759331Ab0HFVbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:31:41 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2010 17:31:41 EDT
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9DEDE10013;
	Fri,  6 Aug 2010 23:31:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5FCBD19F5C6;
	Fri,  6 Aug 2010 23:31:38 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <4C50B005.1030004@pileofstuff.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152819>

On Donnerstag, 29. Juli 2010, Andrew Sayers wrote:
> Detect whether the shell supports process substitution with <()
> Shells that fail the test will not be able to load git-completion.bash
>
> If a bad shell is found, print a warning which gives the user as much
> debugging information as possible.

This cannot work the way you implemented it:

> +$( 
> +	exec 2>/dev/null
> +	$(exec < <( ))
> + )

Any shell that does not support the <() syntax will have exited at this time 
with a syntax error and never get to print something.

This could work:

  (eval : '$(exec < <( ) )' 2>/dev/null)

> +if [[ 0 -ne $? ]]

Of course, you must not use unportable [[ ]] syntax here, either.

> +then
> +	cat <<EOF
> ...

-- Hannes
