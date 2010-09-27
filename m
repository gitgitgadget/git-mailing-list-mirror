From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 08/12] gitweb: auxiliary function to group data
Date: Mon, 27 Sep 2010 21:17:49 +0200
Message-ID: <AANLkTinudc8zX33o=vxxo=nf0L9KxFiJR8UYNomMfajN@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009262347.15779.jnareb@gmail.com> <AANLkTimOJ7RXDWXy=tF+rZf1gnfB7_GHCZuU5bZ5Wc91@mail.gmail.com>
 <201009271012.23175.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 21:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0JDO-0007WC-UN
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 21:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413Ab0I0TSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 15:18:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47632 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933311Ab0I0TSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 15:18:10 -0400
Received: by ywh1 with SMTP id 1so1615368ywh.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sCl26892NEb5cN5h99O2wKxeF3EszwWyV8dC8oRvJXU=;
        b=WHF8VtvGvkBz/QYQ0SdV4E3AzzAlKHAdeS6mqoSqE6aXcxVQbsQTnchhUUW5kIrdIL
         jeUCIEXMC+7+Ed7hmuut1wKQca2/bzu1ZX6XWjXity4JwcmW/rx7wq5RKVdJwD4yvyZ3
         iJTV0AW9RNNNeaxyy8HtCqiuccSl/zn0R+4gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mWlkg49csSBJShHh/dJOVIK5f+yel6lMNIctRyvhNVe0eDk9Su20DboBJoLbIwsTas
         RC+PftsKIcRIaJ9R67CJ4ru5wRV1jsDtK8KinlGOE67ttFTk2gh53j/VFbayw8NnUKb+
         gxtKy9Xt1GyxXYfm0ASvz21y9oFb1b+UfyBBE=
Received: by 10.150.138.2 with SMTP id l2mr9268073ybd.41.1285615089615; Mon,
 27 Sep 2010 12:18:09 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Mon, 27 Sep 2010 12:17:49 -0700 (PDT)
In-Reply-To: <201009271012.23175.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157364>

2010/9/27 Jakub Narebski <jnareb@gmail.com>:
>>> =A0+ =A0 =A0 if (ref($content) eq 'CODE') {
>>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $content->();
>>> =A0+ =A0 =A0 } elsif (ref($content) eq 'ARRAY') {
>>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print @$content;
>
> The 'ARRAY' part is probably unnecessary overengineering.
>
>>> =A0+ =A0 =A0 } elsif (!ref($content) && defined($content)) {
>>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print $content;
>>> =A0+ =A0 =A0 }
>
> Or even (in the vein of further overengineering)
>
> =A0 =A0+ =A0 =A0 } elsif (ref($content) eq 'SCALAR') {
> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print esc_html($$content);
> =A0 =A0+ =A0 =A0 } elsif (!ref($content) && defined($content)) {
> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print $content;
> =A0 =A0+ =A0 =A0 }
>
> or vice versa ;-)
>
>>>
>>> Well, $content could be also open filehandle...
>
> Though I don't know how to check that. =A0ref on filehandles return
> 'GLOB'... well, we can use 'openhandle' from Scalar::Util (core).
> But that is probably unnecessary overengineering.

I have made cases for closures, scalar refs and scalar values. I've
also added a case for GLOB or IO::Handle to allow a file handle to be
passed as either *handle or *handle{IO}. I've also added a comment
block explaining the syntax better.

--=20
Giuseppe "Oblomov" Bilotta
