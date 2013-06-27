From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lib-rebase: use write_script
Date: Thu, 27 Jun 2013 11:37:31 -0700
Message-ID: <7va9mbs8lw.fsf@alter.siamese.dyndns.org>
References: <1372357825-21824-1-git-send-email-andrew@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 20:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsH4c-0006XO-P1
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab3F0Shf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 14:37:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796Ab3F0She (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 14:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A7EB29864;
	Thu, 27 Jun 2013 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xxSkOXqD6YYFBchuYl2r+9AnxO4=; b=rQq8Fn
	FAXKM/0mlARurnRw0anWP2slY3VCombzeZ8g+TTRk+516P2AfLfkBnO3kTtLG67M
	px+biXbf8ydCUEUWkYBhsZHRC4t3oWuNI1ogl7E+XNvNIiyXyLlo3oeuivRITUvO
	aTSCOoLafNpbp7Sc9XFkzPlZ5ZYlKB2rbm32s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSTZudgP7rmQgr2fpsv5wvKaMKi1yzHj
	PXBF2oUxZiB2Y1stADTl5LAxrhPf2eOprwCZPXYXIet9tuFbIqcCsXGKfI/oYHTP
	dyKehqelIWbnJBIw9nr7PSJuaEPGANa9N1w7Y/XihgSFSli9QzA5ez1UdVKsY5iS
	zynfFksi9to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F6829863;
	Thu, 27 Jun 2013 18:37:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5126B29861;
	Thu, 27 Jun 2013 18:37:33 +0000 (UTC)
In-Reply-To: <1372357825-21824-1-git-send-email-andrew@pimlott.net> (Andrew
	Pimlott's message of "Thu, 27 Jun 2013 11:30:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1743DC2-DF58-11E2-8EE6-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229142>

Andrew Pimlott <andrew@pimlott.net> writes:

> Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
> ---
>  t/lib-rebase.sh |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 0b41155..7b42199 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -24,8 +24,7 @@
>  #   ">" -- Add a blank line.
>  
>  set_fake_editor () {
> -	echo "#!$SHELL_PATH" >fake-editor.sh
> -	cat >> fake-editor.sh <<\EOF
> +	write_script fake-editor.sh <<\EOF
>  case "$1" in
>  */COMMIT_EDITMSG)
>  	test -z "$EXPECT_HEADER_COUNT" ||
> @@ -65,7 +64,6 @@ cat "$1"
>  EOF
>  
>  	test_set_editor "$(pwd)/fake-editor.sh"
> -	chmod a+x fake-editor.sh
>  }
>  
>  # After set_cat_todo_editor, rebase -i will write the todo list (ignoring

Thanks, but it should probably be

	write_script fake-editor.sh <<-\EOF
        case "$1" in
        ...
        EOF

        test_set_editor ...

if the aim is to modernize this part.
