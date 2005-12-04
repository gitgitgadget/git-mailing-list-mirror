From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Sun, 04 Dec 2005 14:31:31 -0800
Message-ID: <7vr78sebp8.fsf@assigned-by-dhcp.cox.net>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>
	<43935A9E.2060602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 23:32:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej2OP-0006Xn-4M
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 23:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVLDWbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 17:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVLDWbe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 17:31:34 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62125 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932359AbVLDWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 17:31:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204223052.KUDR20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 17:30:52 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43935A9E.2060602@zytor.com> (H. Peter Anvin's message of "Sun,
	04 Dec 2005 13:07:42 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13194>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Jason Riedy wrote:
>> +
>> +int gitsetenv(const char *name, const char *value, int replace)
>> +{
>> +...
>> +	envstr = malloc((namelen + valuelen + 2) * sizeof(char));
>> +...
>> +	out = putenv(envstr);
>> +
>> +	free(envstr);
>> +	return out;
>> +}
>
> Wouldn't this be a good case for using alloca()?

Oops.  Isn't the patch itself wrong, so is using alloca()?

putenv(3) says

	int putenv(char *string);

	The string pointed to by string becomes part of the environment,
	so altering the string changes the environment.

which tell sme that whatever we pass to putenv() we should *not*
free.
