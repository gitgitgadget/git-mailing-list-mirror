From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] rebase --onto doesn't abort properly
Date: Tue, 7 Jan 2014 00:25:07 +0530
Message-ID: <CALkWK0=a-jh_r0c-hYstyVAatfF4nwBk3uYQ6RX+0=8VsPasVQ@mail.gmail.com>
References: <CALkWK0mEN=LjWKKdWznCXk5YwRQXVDPwtxUvVJnrG9zPPvH-Rw@mail.gmail.com>
 <xmqqha9hhrvz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FLA-0000gY-7t
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbaAFSzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:55:50 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47564 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbaAFSzt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:55:49 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so18448836ief.24
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wKiPWbvAh+Tm5OMGuJT0aeKfKQ8hdmbBT9xBjHM/B2I=;
        b=BePVk3WGWpFl4vcDxzJWxpbcLl7wWm+BiIaaxw1h8b33dvFpk26f1zMEvW3V9wv3NI
         2Yr8rrsJ6m+vea5bBJY5WHmjYWj3JN3/R2sVg46v01as60aWL4xsEj2XRyvsRpUmrGYB
         k9x17wvDxQQGe4/U4stQE1daPANbIeCIqU3BT8QUPyn7ai7Hiw2paiIkkIBQyw0d3/fa
         vPXGPqvF60DZKMqhrwsSawjaEY6VLXx5DY/9C7+gCoQZobXU19I3PASCTDrbanPhdSS0
         5QvkXVAC+6dd4ePsUpKtDbnZCYkLHw0nqMyZ8klPOB24toliAmiGA12WIyc2miZxE+L/
         fvVw==
X-Received: by 10.50.25.227 with SMTP id f3mr21554416igg.16.1389034549043;
 Mon, 06 Jan 2014 10:55:49 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 10:55:07 -0800 (PST)
In-Reply-To: <xmqqha9hhrvz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240048>

Junio C Hamano wrote:
> I do not think --abort was designed to abort an uncontrolled stop
> like ^C in the first place.

Why not? All it requires is a reset --hard to
.git/rebase-apply/head-name, as usual, no?

> To allow that kind of "recovery", you
> need to teach "rebase" to first record the state you would want to
> go back to before doing anything, but then what happens if the ^C
> comes when you are still in the middle of doing so?

I'm a bit puzzled: doesn't rebase write_basic_state() as soon as it
starts? It's true that we can't recover from a ^C before that, but I
would expect to be able to recover after a ^C somewhere in the middle.
