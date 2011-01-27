From: David Borowitz <dave@bwitz.com>
Subject: Re: HTTP push not respecting .netrc
Date: Wed, 26 Jan 2011 18:47:56 -0800
Message-ID: <AANLkTi=k5m+90wZPLMjah3cnL=4PjF5Skp2zkaTXyD09@mail.gmail.com>
References: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
 <AANLkTi=4cE711TtqE0E-05s9Pk72C8OymNf_-5NhrfXS@mail.gmail.com>
 <7vy66p1vn3.fsf@alter.siamese.dyndns.org> <AANLkTikSV5OPrtbwq-X9SknNAEHQX_gHVFc8YZu0g4+N@mail.gmail.com>
 <AANLkTin8cxi_5_Rx6s_C2NjgGWYhUX+kdV5E1A_FYc_j@mail.gmail.com> <AANLkTi=cqsvXb3eywTfxAg9hH9cigumSQjoHqq5bnJfM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 03:48:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiHuM-000491-OB
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 03:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1A0CsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 21:48:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab1A0CsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 21:48:20 -0500
Received: by wwa36 with SMTP id 36so1699391wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=/MyYhfVQ+xVunppPZ0Duf2CsbnGgKMqCgSQluEQcoQk=;
        b=QzhWrmjMhdBsWcLbqLYAV42dFIc0HkG993OqOS8vTGzYndZ5CvqXoIa1esu/U4NGdM
         P7Zhc9AF0QCG5fr+E6sLuBKj+EOOOZbCwuRbofSapdhW5nanZ/m1c1Qu/KeokGo3DtxC
         IdXx8vIdpNe5jKGTn/103O7ilFRYK8KS4enE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=vyvFGg4U9CQMOTaFQcOFAr2QgRx3uz8SM4UY9QbiKhkQzbl6J9ujv3ZhrIF9j7hEqU
         IVRlD7oURDuFcWa8gI940m9ST5owmstl6ODuMaSFLX6cvrMp0oQPMkuBzKwc42HjFK6n
         RtI7YP0ROUNKbshPEdvmhBJS/Rs8X799SRlRI=
Received: by 10.216.13.194 with SMTP id b44mr1176594web.68.1296096498382; Wed,
 26 Jan 2011 18:48:18 -0800 (PST)
Received: by 10.216.60.77 with HTTP; Wed, 26 Jan 2011 18:47:56 -0800 (PST)
In-Reply-To: <AANLkTi=cqsvXb3eywTfxAg9hH9cigumSQjoHqq5bnJfM@mail.gmail.com>
X-Google-Sender-Auth: YJihmnqWFIBAUCc8YBVh9pVqSJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165570>

On Wed, Jan 26, 2011 at 18:00, David Borowitz <dave@bwitz.com> wrote:
> But this raises further questions:
> -Why does git/curl decide it's ok to retry with authentication in one
> case, but not in the other?

Poking further, it looks like curl is deciding not to retry because
the ioctl callback is failing to rewind the post buffer when clearly
it should be able to. So it's more likely a git bug than a curl issue
(the following question notwithstanding).

> -Why does curl send the auth header before ever receiving a 401, while
> git does not? (Would fixing this be as easy as setting another curl
> option?)
