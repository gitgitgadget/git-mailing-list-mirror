From: Mark Lodato <lodatom@gmail.com>
Subject: Re: https, client certificate, pem pass phrase
Date: Thu, 11 Jun 2009 19:54:58 -0400
Message-ID: <ca433830906111654g629429d1j73722baf7ab02fc2@mail.gmail.com>
References: <alpine.OSX.2.00.0906110956370.945@xor.localnet>
	 <alpine.OSX.2.00.0906111801400.67531@xor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karsten Weiss <knweiss@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 12 01:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEu6u-0003sR-Pc
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZFKXy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZFKXy6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:54:58 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:61900 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZFKXy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:54:57 -0400
Received: by fxm12 with SMTP id 12so314505fxm.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6SvD06XJNZnphtoaIDbpRyan1UiPTCobMWSJbc+vUAY=;
        b=Jq49T9a9TdNZB2sdhnUlQXFNrKDEZ8S9diD9pW8UZNj3kuhoPL3UoqQNaJx3WB8PYX
         9lXzNpVrFFlPhJMwiSh5um5vAh10uNvJ8iOfTq8L6qnA8g7PCgxkff0Y5RYummterJub
         FJQgpX4I4pblEvkj0+ndY9VfR6qORneTzHwBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bG3w0BqWQtvP+F6tblnUpMIQLzFT72sQkpc3G/qLG3eKb89kNnckNR8gaqXQunnnwM
         TFMWULpVvXdSc0YDW27ocoYJDZFOUhP3ZrSAAagGxmUYTWKl05Mv6gpofyqhO7WH7cYS
         w+xSkllGO8wR/1NJPfjeA9RLkG0xp6Yj35Ghg=
Received: by 10.223.118.141 with SMTP id v13mr2451499faq.26.1244764499014; 
	Thu, 11 Jun 2009 16:54:59 -0700 (PDT)
In-Reply-To: <alpine.OSX.2.00.0906111801400.67531@xor.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121377>

On Thu, Jun 11, 2009 at 12:43 PM, Karsten Weiss<knweiss@gmx.de> wrote:
> On Thu, 11 Jun 2009, Karsten Weiss wrote:
>
>> However, it only works as long as I do *not* protect the client's private
>> key (PEM) with a pass phrase which is not secure (especially when using
>> FakeBasicAuth!). When I do protect the private key with a pass phrase *each*
>> git fetch/pull/push prompts the user *several* times with "Enter PEM pass
>> phrase:". Thus, it's not usable (even though it works).
>
> Somehow I managed to miss Mark Lodato's posting from 2009-05-28 before:
>
> [PATCH 1/2] http.c: prompt for SSL client certificate password
> http://marc.info/?l=git&m=124348062226665&w=4
> [PATCH 2/2] http.c: add http.sslCertNoPass option
> http://marc.info/?l=git&m=124348062326671&w=4
>
> I can confirm that his two patches solve the problem. I.e. there is now only
> a single passphrase prompt during each Git invocation that involves the
> https protocol. Great!

Glad to hear this works for you, and that there is interest in this
patch series!

> However, I want to add two additional suggestions:
>
> With the patch Git prompts for a "Certificate Password". IMHO it would be
> better to prompt for the "Certificate private key passphrase" because it's
> the private key which is protected and not the certificate itself.

I realize this is the case, but here's my reasoning for the wording:
The user is trying to use a client-side certificate, and a password is
needed for that certificate.  It doesn't really matter whether it's
the private key or the certificate itself - a password is needed to
perform this operation, thus the name "Certificate Password."
Furthermore, if only http.sslCert is given, asking for the "private
key" pass phrase might be confusing since http.sslKey was not set.
(Note that if *only* http.sslKey is set, it is ignored.)  I'm not
strongly tied to this wording, but I'd be interested to hear other
input on this.

On "password" vs "passphrase" vs "pass phrase", it should perhaps be
"pass phrase," since that's the term OpenSSL uses.

> The
> config flag IMHO also should be renamed from http.sslCertNoPass to
> http.sslKeyNoPassphrase.

I used "NoPass" to keep the name short.  I'm not tied to this, but I
prefer the shorter "NoPass," if there are no other opinions.

> (Of course it would be even nicer if the code could
> detect if the key has a passphrase and only prompt for it when really
> necessary)

I agree, this would really be best, but I do not think this is
possible without modifying libcurl or implementing our own,
OpenSSL-specific engine to open the key.  Neither seems worth the
effort to me.

> Regarding the caching of the passphrase in memory: Maybe the passphrase
> memory region could be mlock()ed to prevent the kernel from paging it to
> disk? But I'm not sure if this is worth effort.

Libcurl doesn't do this, so I didn't bother to either.  Like above, I
don't think it's worth the effort to do it now.  But I didn't know
about mlock(), so thanks for that tip!


Anyway, thanks for the feedback on the patch!

Mark
