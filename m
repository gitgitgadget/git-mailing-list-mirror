From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: Use libc strlcpy on OSX >= 10.2
Date: Sat, 24 Jan 2009 11:42:10 -0800
Message-ID: <7v8wp0o5il.fsf@gitster.siamese.dyndns.org>
References: <7f978c810901241101h227c5437p88ca7c9cc54abc9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQoQI-0004zn-Gz
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZAXTmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbZAXTmS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:42:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZAXTmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:42:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96DA5933AE;
	Sat, 24 Jan 2009 14:42:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9931C933AC; Sat,
 24 Jan 2009 14:42:12 -0500 (EST)
In-Reply-To: <7f978c810901241101h227c5437p88ca7c9cc54abc9a@mail.gmail.com>
 (Benjamin Kramer's message of "Sat, 24 Jan 2009 20:01:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A54B0D6-EA4F-11DD-866E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106998>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> OSX supports strlcpy(3) since 10.2 so we don't need
> to use our own. This revised also patch checks the darwin
> version. 10.0 is darwin v1.3; 10.1 is darwin v1.4.

What does the output from "uname -r" and "uname -s" look like on your box
(and older OSX boxes)?

> @@ -643,7 +643,9 @@ ifeq ($(uname_S),Darwin)
>  	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
>  		OLD_ICONV = UnfortunatelyYes
>  	endif

This existing one says "If 'uname -r' output does not begin with two
characters '9.' (nine and dot), then set OLD_ICONV".

> -	NO_STRLCPY = YesPlease
> +	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)

And this new one says "If 'uname -r' output begins with two characters
'1.' (one and dot), then set NO_STRLCPY".

> +		NO_STRLCPY = YesPlease
> +	endif

I am guessing that 'uname -r' says 9.X in "Darwin 9.X" (which is OSX
10.5), and existing conditional says that versions before 9.X needs
OLD_ICONV but later ones do not need it.

Does 1.X stand for OSX 10.2?  A quick googling finds a handful pages that
say that OSX 10.2 = Darwin 6.x and OSX 10.3 = Darwin 7.x, and I am not
sure where you are getting that "begins with one-and-dot" from....

>  	NO_MEMMEM = YesPlease
>  	THREADED_DELTA_SEARCH = YesPlease
>  endif
> -- 
> 1.6.1.285.g3454
