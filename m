From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit.c: guard config parser from value=NULL
Date: Sat, 09 Feb 2008 18:57:43 -0800
Message-ID: <7vir0x5xi0.fsf@gitster.siamese.dyndns.org>
References: <5d46db230802091216h40f88f06r20ebb84de6717af6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2PC-00075i-39
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbYBJC6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbYBJC6F
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:58:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbYBJC6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:58:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D3C16E1;
	Sat,  9 Feb 2008 21:58:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EEAE916E0;
	Sat,  9 Feb 2008 21:57:55 -0500 (EST)
In-Reply-To: <5d46db230802091216h40f88f06r20ebb84de6717af6@mail.gmail.com>
	(Govind Salinas's message of "Sat, 9 Feb 2008 14:16:10 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73299>

"Govind Salinas" <govind@sophiasuchtig.com> writes:

> -	if (!strcmp(var, "user.name")) {
> +	if (value && !strcmp(var, "user.name")) {
>  		strlcpy(git_default_name, value, sizeof(git_default_name));
>  		return 0;
>  	}

This is wrong, isn't it?  When somebody says

	[user]
        	name

we should not silently ignore it, but instead say "user.name is
not a bool!" and error out.

The same comment applies to all other

	if (value && !strcmp(var, "<varname>"))

conversions.
