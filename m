From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On --depth=funny value
Date: Wed, 9 Jan 2013 11:18:30 +0700
Message-ID: <CACsJy8CA-a0=HqTY9heJBhPO4M5jyLk=tf253rRKCRuTWz5teg@mail.gmail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com> <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 05:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsn8M-00029D-FV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 05:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab3AIETB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 23:19:01 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:63611 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab3AIETA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 23:19:00 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so587946oag.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 20:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZTBl0T1X8SizKUoY5hfI32DJLlFGdoYay9A2s1YVBDE=;
        b=VW7iqYl8Ae0aX+n7kduHi8olxbps5fXOjh5wtNbfVZe34iclleZ/3zR7vpvKPVQvvT
         Xl0hKkGCo6xLKa5yODHK/wg6aCjINV7PrkttQDfwIc0jsxMNOpYSpDR8VU7IBUKMrScs
         AuDqCcyb3XCTmsaZojMI7Rg66M5tGcqfbkJu6ZDpi3E0Ct2FSslYeQVs8k2TCcY3GGP/
         UwGd1Xi+tShrzf1VojOgPd2Zy5JhMDq5eum4BQgFoOaauUj6OVIt2c/u8ce2+6A9cxLE
         8/wIgSlqyv/FDKWl7YNUfatfY8WVAkHSFhzN/eExiUKmt0mzRAVGojR0FzIkVyxFAJLF
         Za0w==
Received: by 10.60.154.169 with SMTP id vp9mr36683984oeb.109.1357705140423;
 Tue, 08 Jan 2013 20:19:00 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 8 Jan 2013 20:18:30 -0800 (PST)
In-Reply-To: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213024>

On Wed, Jan 9, 2013 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * First, let's *not* do "git fetch --depth=inf"; if you want to
>    unplug the bottom of your shallow clone, be more explicit and
>    introduce a new option, e.g. "git fetch --unshallow", or
>    something.

No problem. "Something" could be --no-depth or --no-shallow. I think
any of them is better than --unshallow.

>  * We would like to update "clone --depth=1" to end up with a tip
>    only repository, but let's not to touch "git fetch" (and "git
>    clone") and make them send 0 over the wire when the command line
>    tells them to use "--depth=1" (i.e. let's not do the "off-by-one"
>    thing).

You can't anyway. Depth 0 on the wire is considered invalid by upload-pack.

>    Instead, fix "upload-pack" (the bug is in get_shallow_commits()
>    in shallow.c, I think), so that it counts correctly.  When the
>    other end asks for a history with 1-commit deep, it should return
>    a history that is 1-commit deep, and tell the other end about the
>    parents of the returned history, instead of returning a history
>    that is 2 commmits deep.  So when talking with a newer server,
>    clients will get correct number of commits; when talkng with an
>    older server, clients will get a bit more than they asked, but
>    nothing will break.

I'll need to look at get_shallow_commits() anyway for the unshallow
patch. I'll probably do this too.
-- 
Duy
