From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Thu, 18 Dec 2008 16:35:54 -0800
Message-ID: <7v63lhf1cl.fsf@gitster.siamese.dyndns.org>
References: <87prjptfo7.fsf@jidanni.org>
 <20081219002524.GB21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTMw-0004a1-1T
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYLSAgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbYLSAgF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:36:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYLSAgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:36:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BF3411A9B5;
	Thu, 18 Dec 2008 19:36:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4E101A9B3; Thu,
 18 Dec 2008 19:35:56 -0500 (EST)
In-Reply-To: <20081219002524.GB21154@genesis.frugalware.org> (Miklos Vajna's
 message of "Fri, 19 Dec 2008 01:25:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 030F4276-CD65-11DD-9DD9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103520>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Dec 19, 2008 at 04:02:48AM +0800, jidanni@jidanni.org wrote:
>> Bug: if git-rm -n is not allowed to write all it wants to write, it
>> will leave a .git/index.lock file:
>> # git-rm -n -r . 2>&1|sed q
>> error: '.etckeeper' has changes staged in the index
>> # git-rm -n -r . 2>&1|sed q
>> fatal: unable to create '.git/index.lock': File exists
>
> Can't reproduce:
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index b7d46e5..1581691 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -251,4 +251,12 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
>  
>  '
>  
> +test_expect_success 'test from jidanni' '
> +
> +	git reset --hard &&
> +	git rm -n -r . 2>&1|sed q &&
> +	git rm -n -r . 2>&1|sed q
> +
> +'
> +
>  test_done
>
> passes here just fine. Yes, there are multiple files in the repo.

I think you need to have tons of files to cause the pipe buffer to fill up
with the "rm 'frotz'" output, triggering a SIGPIPE to kill the upstream
process of the pipe.
