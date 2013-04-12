From: Magnus Therning <magnus@therning.org>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Fri, 12 Apr 2013 09:22:36 +0200
Message-ID: <CAAExw5upfDU=U9Vntph4DECtDp_EVGps+Fgpxabaeq_c4WHqAA@mail.gmail.com>
References: <20130409054553.GA1537@mteis.lan>
	<20130409171247.GD21972@sigill.intra.peff.net>
	<5165DA13.8010100@gmail.com>
	<20130410214722.GA6215@sigill.intra.peff.net>
	<20130410231919.GA1315@mteis.lan>
	<20130411015613.GA8455@sigill.intra.peff.net>
	<CAAExw5t3rk_R1GB9OMVKjPYEMRQg1gNSUGQtEK71m1Ux01N27w@mail.gmail.com>
	<20130411193434.GE3177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQYJu-0001TT-00
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab3DLHWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:22:38 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:62943 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab3DLHWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:22:37 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so3017328iec.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=AxyH1beobn/oUeNPJkWKQZyLGZyQ6rctIhsTUteZSWs=;
        b=BOkNvOhV3/dblCKBSZrC8Z8fE44GMIr3/oorIHuEgjAooo/91nPhhn5xyENnnuMuaJ
         pOYQIxeOaFZt5iSoh4r0Bh6Gn6WaN7p0+q49EXcwplP32UMCKIzWauVbheWnInPaq/7s
         N/ds3Bn6u711qH74N0C1+j7Q/RZ3UZt5EzSN8Rg0xs2UKDmf4nlk6x2u0gaBrTQ6BW4i
         yP5F+0lpzRLa09toOKcbxycwj8mIHe6MK/MjfLa5L1DEGAwesXdEH+t9lstehzgd+kxE
         by+gQkcYr/b7DnzEb3vtp/QH/KaxdnMqzvEsfT1Kt5T44t2n/pldKyFKnqqdaZEuTeSK
         YF+w==
X-Received: by 10.42.64.135 with SMTP id g7mr5696666ici.37.1365751356912; Fri,
 12 Apr 2013 00:22:36 -0700 (PDT)
Received: by 10.64.163.35 with HTTP; Fri, 12 Apr 2013 00:22:36 -0700 (PDT)
In-Reply-To: <20130411193434.GE3177@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQll1afYca8l7msbh79/oDT9cI9HULIzPz3rhqhUjEnMRsZZa+2HzZ3qZXAAYG9v/+R5vCAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220970>

On Thu, Apr 11, 2013 at 9:34 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 11, 2013 at 08:52:56AM +0200, Magnus Therning wrote:
>
>> > The documentation should probably make the use of http.receivepack more
>> > clear in this situation.
>>
>> I think that'd be good.  The fact that it wasn't until several mails
>> into the thread that anyone thought of the http.receivepack setting
>> also suggests that its use is a bit un-intuitive (even though it
>> probably makes perfect sense and is a good solution).
>
> Yeah, I did not even think of http.receivepack because I have never had
> to set it before (it was turned on in the original tests that I built
> top of). I have the impression that the anonymous-read/authenticated-write
> setup you are using has not been all that commonly used. The example in
> the manpage dates back to 2009, but it was only in 2012 that we got a
> bug report that the client-side authentication handler has problems with
> it.

Really?  I certainly think it deserves a bit more attention than that.
 It may be that gitosis and other SSH-based solutions have been around
longer than git-http-backend, but from what I've understood from
reading, it fits very nicely in between git-daemon and the rather
heavy SSH-based stuff.

>> > But your fix under lighttpd is much better, as it asks for the
>> > credentials up front (which means the client does not go to any work
>> > creating a packfile just to find out that it does not have access).
>>
>> Yes, I think it also helps with my particular scenario where new repos
>> will be added from time to time.  This way there is no second step,
>> after `git init`, that must be remembered.
>
> Yeah, avoiding setting http.receivepack at all is helpful. Though note
> that you can also set it in /etc/gitconfig for the whole system at once.

Good point.

/M

-- 
Magnus Therning                      OpenPGP: 0xAB4DFBA4
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus
