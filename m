From: Sitesh Shrivastava <siteshshrivastava@gmail.com>
Subject: Re: error: unpack failed: unpack-objects abnormal exit
Date: Tue, 5 Nov 2013 13:16:38 +0530
Message-ID: <CALK6XSj3=_krX24nX+G1V7c8Wq42XfU0G0qZ0oTpzm7+=emx_A@mail.gmail.com>
References: <CALK6XSgMA8KCJ1zBRpib6X-pUqwHFzh+uEj8OLm6OZfCi0wmDA@mail.gmail.com>
 <20131104230321.GA31503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 05 08:47:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdbLx-0007WO-RL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 08:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab3KEHrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 02:47:02 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:55827 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab3KEHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 02:46:59 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so6265332lbd.15
        for <git@vger.kernel.org>; Mon, 04 Nov 2013 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uKeto08L4rc3KzR7fNnHfSxPUDFLIMyNKly3ZwG2NyY=;
        b=VNPKCm7HaGa1ta2bIFviyM6mQCVpGKRKrzrl+PW6cUXSawu4VWCC6IcQb++vB2wpmM
         Rbb47K68mG7Nnwp5EiY9xBP0FNAGPHUEvPURfeQXwjrSr4SbcVTD1fhFQk4XsTbov+fE
         wImtbAq/zZaKq9lUWVhNKt0k1wtmyjmhfg3HcykaIh8mlJN8iJCjbRfDSF6gfB4Q7Xy+
         vtnlY3ZUAsCmYG9Y+ERsD2u9t7mc6AnZbAUKToNCtd16m4TbTvgZxKSXDJO3XUTptW+h
         dvehLUDh9PY5jYz1eEUKwdZsbAAgnqX5JFFRkg8qUqcAFVeKsriQNYvb5X7Hpw4Qdjmr
         BjlA==
X-Received: by 10.112.198.137 with SMTP id jc9mr120971lbc.52.1383637618231;
 Mon, 04 Nov 2013 23:46:58 -0800 (PST)
Received: by 10.112.198.170 with HTTP; Mon, 4 Nov 2013 23:46:38 -0800 (PST)
In-Reply-To: <20131104230321.GA31503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237324>

Thanks a lot for replying!

That exactly was the problem. We've configured gitosis to allow access
over 'ssh://' (Read / Write) while 'git://' access was limited (Read
only).
Changing the configuration worked out just fine.

-Thanks & Regards,
Sitesh

On Tue, Nov 5, 2013 at 4:33 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 01, 2013 at 04:02:10PM +0530, Sitesh Shrivastava wrote:
>
>> I'm using a gitosis server. Suddenly I'm not able to push to the
>> remote server. Everyone else is able to push to the same server. Btw I
>> can't push to *any repo* on the server. This is the error I get:
>>
>> Counting objects: 5, done.
>> Delta compression using up to 4 threads.
>> Compressing objects: 100% (3/3), done.
>> Writing objects: 100% (3/3), 353 bytes | 0 bytes/s, done.
>> Total 3 (delta 1), reused 0 (delta 0)
>> error: unpack failed: unpack-objects abnormal exit
>> To git://git.srv.net/code-repo.git
>>  ! [remote rejected] master -> master (n/a (unpacker error))
>> error: failed to push some refs to 'git://git.srv.net/code-repo.git'
>
> You are trying to push over the "git://" protocol. That isn't enabled by
> default (because it has no authentication at all). Did you enable it? If
> so, does the user running git-daemon have permission to write to the
> repository?
>
> The server notes that unpack-objects fails, but in older git versions
> the stderr of unpack-objects does not get sent to the client. If your
> git-daemon process is logging somewhere, you might check that log for
> more details.
>
> Since v1.7.12.3, that output is sent over the sideband channel to the
> client. So another option is to upgrade the version of git on the
> server.
>
>> Can something be wrong with my git installation?
>> git --version
>> git version 1.8.3.2
>
> That's your client version. The server version is older than that (in
> v1.7.12.3, the unpacker error message also dropped the "n/a" bit, so the
> output above comes from a server older than that).
>
> -Peff
