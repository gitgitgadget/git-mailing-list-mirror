From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: remote-helpers and refs without a value
Date: Mon, 28 Mar 2011 15:22:57 +0800
Message-ID: <AANLkTi=cNin=XYqbAJMggWj7OcZ8=9PGCVGGg=JRO-bj@mail.gmail.com>
References: <20110327082428.GA4428@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:23:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q46n1-0008NB-B4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab1C1HW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:22:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44248 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1C1HW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 03:22:57 -0400
Received: by iwn34 with SMTP id 34so3354386iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HZitteFTohrTbXWtcZTdbQX94PEShpSphxGzU06Cvok=;
        b=E+znX9slOM/2ZWleUSHubWUKhy6uK6ggh7PtzfH8HvjGvj3qdm4rjU3ilBr/7qeO1U
         wN85GL3lT9rS59P6Dzl2+dEl5NbDwAoZYbSsM23iNhMJgVmF3l/BKNzUIG47/kOwZV7j
         kdmlJ6HRCWRMH895Z390xacU2tq7gjQ7/yBOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M+/D4z1vZSZ6QZ4sDNw+mVmBEPP5Gdc/ld9KIwelnjrgvAERFbc68sXOqrM+tOoeUI
         oSDE07nnELvU6I+WJVyo/cb+u+svJGd3v/G380EheUi7cQ8Ru1LRWVXiXD+9uiJpRwmg
         d5sDFHFFf/KvdPtQCKw23kj9VzVRca8btUj3w=
Received: by 10.42.134.135 with SMTP id l7mr5974880ict.234.1301296977141; Mon,
 28 Mar 2011 00:22:57 -0700 (PDT)
Received: by 10.42.230.1 with HTTP; Mon, 28 Mar 2011 00:22:57 -0700 (PDT)
In-Reply-To: <20110327082428.GA4428@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170103>

Hi,

On Sun, Mar 27, 2011 at 4:24 PM, Mike Hommey <mh@glandium.org> wrote:
> But when the helper returns a '?' value to the list command, I don't see
> how things are supposed to be updated. It looks like the helper is
> the only one, then, to be able to update the refs. But it also doesn't
> have any way to know which refs it needs to update...

I don't think that's right. The transport machinery (transport.c,
transport-helper.c) in git is the one who calls the shots - the
transport machinery first 1) asks for the list of refs, 2) does the
appropriate "matching" (of what refs to fetch/push), then 3) sends
this down to the remote helper.

If the remote helper sends back a '?', the transport machinery should
be implemented to fail and die. A quick scan of transport.c does not
show this, but I assume the failure would happen at the ref matching
level, leading to failure of the whole fetch/push.

-- 
Cheers,
Ray Chuan
