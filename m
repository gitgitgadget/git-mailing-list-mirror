From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 04 May 2007 10:17:39 -0700
Message-ID: <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
References: <463ADE51.2030108@gmail.com>
	<56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	<7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	<463AFAAE.853DEF7B@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 04 19:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk1Pf-0000dt-9f
	for gcvg-git@gmane.org; Fri, 04 May 2007 19:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbXEDRRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 13:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbXEDRRm
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 13:17:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36249 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161110AbXEDRRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 13:17:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504171741.DRUB1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 13:17:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id v5Hf1W00h1kojtg0000000; Fri, 04 May 2007 13:17:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46193>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Alex Riesen wrote:
>> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
>> > My preference is (2), (3) and then (1), but I do not have
>> > offhand a suggestion for a good metacharacter we could use.
>> 
>> "./" :)
>
> +1, without the :)
> and ../ should DWIM, too.

I think these feel more or less natural (except that we do not
say ":/fullpath" and instead say ":fullpath" which is
unfortunate).

In the hindsight, if we had the perfect vision into the future,
we would have made <path> relative to where you are when we
initially did "<something>:<path>", with obvious semantics for
things like "<something>:../<path>" and "<something>:/<path>".

We didn't.  Further, we made a mistake to make :/ to mean
something completely unrelated.  My bad.

So I think "./" is the best compromise in the meantime.

With your suggestion, we can train people's fingers to type "./"
now, and perhaps later in one of those big feature release like
the 1.5.0 was, we could switch to "default to relative".

At the same time of that big "UI correction", we could make
"<something>:/<path>" to mean "full path in commit (or
index/stage) no matter where I am".

The current ":/<string>" is about going back, looking for the
string, so it should not have used '/'; instead it should have
been "<something>:?<string>".  Maybe we could fix it by start
accepting ":?" now (in addition to ":/"), give a big fat warning
about ":/" going to mean a different thing, and encouraging
users to use the question-mark form, in preparation for the big
"UI correction".

Do people like that plan?

(soon after 1.5.2)

 - start accepting "<something>:./<path>" as "relative to where I am".

 - start accepting "<something>:?<string>" as "look back to find
   the string".

 - clearly explain the plan and prepare the users.

(a big release in the future, perhaps 1.6.0)

 - "<something>:<path>" becomes relative to where you are.
 - stop "<something>:/<string>" and start "<something>:/<fullpath>".
