From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 6 Mar 2014 10:17:50 +0100
Message-ID: <CAP8UFD0JFWG3g2L1DNp+omE4unajjDW36qse-aE-MgbJFj3CDg@mail.gmail.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<53183506.5080002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 10:17:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLURD-0002Ul-1j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 10:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbaCFJRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 04:17:54 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:52533 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCFJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 04:17:50 -0500
Received: by mail-ve0-f171.google.com with SMTP id cz12so2305605veb.16
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=i/J2xsy40DK5FZASBJZPZmy1y8pEPNEvAcbkEa7WTSU=;
        b=FrdHpnLU5neA9d9+Os8Q8ykj7WWimQ0b+fc54UwOJZiscsOgh5IXvHfVuY+DPzoQkf
         JSTaIF41LUjvn2OKH4kyCHG8bucWq0SkhB4/HFHE/rISqOIwXkAJCT+7Ng03fKZ87BWu
         Se74dffyziWbsnbtV/1QeBzdLx+fd+ShX1BSxhCj4uLSE7XPVqbDuIvv274gXYzna1pH
         F1O9nYktpd1ll7c2H4ZAehMEQWeOqKVChX1PUy1IomUzF+G14ikP4g/I04YnzlpGx4aJ
         k5gVk1leDOH3+IyauAgYzqJEBpt2KE02YbmV9PcFjjFn4vprR5rb0+0967lXC33t5nPY
         z49Q==
X-Received: by 10.52.241.106 with SMTP id wh10mr7201422vdc.16.1394097470134;
 Thu, 06 Mar 2014 01:17:50 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Thu, 6 Mar 2014 01:17:50 -0800 (PST)
In-Reply-To: <53183506.5080002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243506>

On Thu, Mar 6, 2014 at 9:42 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/05/2014 08:18 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Wed, Mar 05, 2014 at 10:49:24AM -0800, Junio C Hamano wrote:
>>>
>>>> ... the plan, at least in my mind, has always been exactly that: grafts
>>>> were a nice little attempt but is broken---if you really wanted to
>>>> muck with the history without rewriting (which is still discouraged,
>>>> by the way), do not use "graft", but use "replace".
>>>
>>> I certainly had in the back of my mind that grafts were a lesser form of
>>> "replace", and that eventually we could get rid of the former. Perhaps
>>> my question should have been: "why haven't we deprecated grafts yet?".
>>
>> Given that we discourage "grafts" strongly and "replace" less so
>> (but still discourage it), telling the users that biting the bullet
>> and rewriting the history is _the_ permanent solution, I think it is
>> understandable why nobody has bothered to.
>
> Replace objects are better than grafts in *almost* every dimension.  The
> exception is that it is dead simple to create grafts, whereas I always
> have to break open the man pages to remember how to create a replace
> object that does the same thing.
>
> So I think a helpful step towards deprecating grafts would be to offer a
> couple of convenience features to help people kick the "grafts" habit:
>
> * A tool that converts grafts (i.e., the grafts read from
> $GIT_DIR/info/grafts) into the equivalent replacements.

Yeah, I sent a kind of rough draft of a script to do that last year to
the mailing list, but I didn't take the time to convert it to a real
script or command.

> * A tool that creates a new replacement object that is the equivalent of
> a graft.  I.e., it should do, using replace references, the equivalent
> of the following command:
>
>       echo SHA1 [PARENT1...] >>$GIT_DIR/info/grafts

Yeah, maybe it can be a "git create-replace-ref command" and it could
have a --convert-graft-file option to convert an existing graft file.

There have been discussions about such a command already some time ago.

> These features could be added to "git replace" or could be built into a
> new "git grafts" command.

I think Junio previously said that it was better if such features were
not part of "git replace". But maybe I misunderstood his subtle
saying.

And I don't think "git grafts" is a good name. It looks too much like
we are encouraging people to use grafts.

Thanks,
Christian.
