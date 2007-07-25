From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Wed, 25 Jul 2007 11:38:01 +0200
Message-ID: <e5bfff550707250238i4fd7926en4c924a0debbb9a3c@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vabtlf7tf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 12:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDdiL-0004Hm-AI
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 12:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719AbXGYKD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 06:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbXGYKD0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 06:03:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:19427 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757456AbXGYKDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 06:03:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so149775wah
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 03:03:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OCL6D9dlwcpG6pTJcH/m5KZC4sJz0JJoeH4/8YKhZR8+RPLwB1jsmYzZmOpcw6Dy0i1Vr6INLW9l7zBhlg12fxDS3zmwOr8fmoii0Fz2kMywK6hOWENnx88xY4ix+/K/MX5bE7dbQh1UhCM8b2qZBBAQHAJ+OeuCwTnrAMknj6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BkZhfRrmK6rUeXLMjNSleBukK5PpTKgGEY0D79PBfwe2WuDaPuHhTlwkPieSj0YD5+kiAGl4VjkflGXE2Yt8KerRqAl8nA4rapOFX2cwkqJjlyemo7FaeEj64cuK21bkjHqZeBAg+34T1rgQ7btr15QzSaBzNdUcyIJ7BBU7wTI=
Received: by 10.114.144.1 with SMTP id r1mr470297wad.1185356281368;
        Wed, 25 Jul 2007 02:38:01 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 25 Jul 2007 02:38:01 -0700 (PDT)
In-Reply-To: <7vabtlf7tf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53677>

On 7/25/07, Junio C Hamano <gitster@pobox.com> wrote:
> I've been re-reviewing recent patches, and this is one of them.

Thanks for pushing to pu. Please tell me if you want me to send you a
patch to update to what we have discussed, specifically using "length
unknown" and changing the name to --show-lengths.

> However, I am wondering if this is an intended behaviour...
>
> : git.git master; ./git-log --log-size --abbrev-commit --pretty=oneline \
>   ko/master..master
> 9d468ac... log size 47
> Add --log-size to git log to print message size
> ca193cf... log size 40

Well, the patch should be used to speedup the parsing by tools because
you can skip big part of the record and jump directly to the beginning
of the next one. So IMHO I don't see a lot of sense in using it
together with --pretty=oneline.

Anyway only default options should be guaranteed to behave correctly
with all the other options. In general, responsibility for what you
see on the screen it's on the tips of user's fingers. IMHO
responsibility of git is of not crashing and do not show incorrect
info, not that the info should be useful.

Paul, I don't know gitk and Tcl to being able to answer myself, but I
would like to know if this new option could be useful also for gitk.

This option, after the first line, gives the size of the following
part of the record. Does this allow you to delay the parsing of the
biggest part of the commit record?

Author name, date, log title, log message could be read only when it's
needed, so that after reading the first couple lines of a commit you
can point directly to the beginning of the next one skipping the rest.

Marco
