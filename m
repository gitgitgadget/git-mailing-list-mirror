From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Tue, 05 Nov 2013 06:42:19 +0100 (CET)
Message-ID: <20131105.064219.1992046444757435360.chriscool@tuxfamily.org>
References: <CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
	<xmqqfvrcyoaj.fsf@gitster.dls.corp.google.com>
	<CALKQrgcweo+B8JKH85-4-SOHsAi6SAxstnXhRWCst_qEyXYmhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com
To: johan@herland.net
X-From: git-owner@vger.kernel.org Tue Nov 05 06:42:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdZPH-0003TF-M4
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 06:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab3KEFmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 00:42:23 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:35920 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab3KEFmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 00:42:23 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 4D9EB55;
	Tue,  5 Nov 2013 06:42:20 +0100 (CET)
In-Reply-To: <CALKQrgcweo+B8JKH85-4-SOHsAi6SAxstnXhRWCst_qEyXYmhA@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237322>

From: Johan Herland <johan@herland.net>
> On Mon, Nov 4, 2013 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>>> +{
>>>> +       char *end = strchr(arg, '=');
>>>> +       if (!end)
>>>> +               end = strchr(arg, ':');
>>>
>>> So both '=' (preferred) and ':' are accepted as field/value
>>> separators. That's ok for the command-line, I believe.
>>
>> Why?
>>
>> Sometimes you have to be loose from the beginning _if_ some existing
>> uses and established conventions make it easier for the users,

The users are already used to appending "Acked-by: Joe <joe@example.com>".
So I think it makes it easier for the user to accept what they are already
used to provide.

>> but
>> if you do not have to start from being loose, it is almost always a
>> mistake to do so.  The above code just closed the door to use ":"
>> for some other useful purposes we may later discover, and will make
>> us regret for doing so.
> 
> Although I agree with the principle, I think there are (at least) two
> established conventions that will be commonly used from the start, and
> that we should support:
> 
>  - Using short forms with '=', e.g. "ack=Peff". There is already a
> convention on how we specify <name> + <value> pairs on the command
> line, e.g. "git -c foo=bar ..."
> 
>  - Copy-pasting footers from existing commit messages. These will have
> the same format as the expected output of this command, and not
> accepting the same format in its input seems silly, IMHO.

I agree. Also I think it will avoid some mistakes by the users.
Because it would require an effort for them to remember that if they
want to see "Acked-by: Joe <joe@example.com>" they have to put
"Acked-by= Joe <joe@example.com>" on the command line.

> That said, I think this applies only to the formatting on the _command
> line_.

But wouldn't it be nice if the same parsing function could be used for
both the command line and the commit message template?

> When it comes to how the resulting footers are formatted in the
> commit message, I would argue it only makes sense to use ':', and I
> think the testcase named 'with config setup and = sign' in the above
> patch is ugly and unnecessary.

I wanted to support configurations like this:

[trailer "ack"]
        value = "Acked-by= "
[trailer "bug"]
        value = "Bug #" 

because Peff said that GitHub uses '#' and while at it I suppose some
people might prefer '=' over ':'.

Thanks,
Christian.
