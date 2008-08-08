From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Can't get git clone over https with proxy and invalid certificate...
Date: Fri, 8 Aug 2008 13:48:24 +0200
Message-ID: <c475e2e60808080448x40683db1wadcd834e94d7d263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 13:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRQTH-0006AU-Ij
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688AbYHHLs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbYHHLs1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:48:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:57185 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbYHHLs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:48:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so525227fgg.17
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HIONI1OlKq/vrloZktX+uwzsRK5jnsqlWgxgQzGZs/o=;
        b=PdJiQCF34AeEcmpKd9cuXecFCaRywOe/hd2EHU/K4FekuQpAiZFh+3qURBjspEiojj
         JQQsBRddxaOy+lBo+HzTJXarrHhH/dyI1xFgBdDg/xOz00F3GMnNAwgKdlNRDLrRZBa+
         Ec1VdceI0CaNTg2ymL5VIHyk7KT0LzPHIroq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ciRcHOpZq9H8gWZA3hc2d1kRxCiYe1el59NXaD+y9CvDdDEvVCtFXX+06L2x6+gcud
         mBxqIT8qZRw9U+YF2QBs19UcxrLJiobQR7ngwoINZb6WqCssZlnp5IkOmeCA8ycrJR4K
         RUErzFuUIEwGAzHvnQym6udUAFXeniOQvhxyU=
Received: by 10.187.238.1 with SMTP id p1mr179499far.67.1218196104371;
        Fri, 08 Aug 2008 04:48:24 -0700 (PDT)
Received: by 10.187.187.17 with HTTP; Fri, 8 Aug 2008 04:48:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91660>

Hi all,

I've been trying without success to clone a git repository over https.
I've got a complicated situation because I have a proxy which only
allows http/https and the server I'm trying to connect to has an
invalid certificate. I'm using git 1.5.6.4 and curl 7.18.1 compiled on
x86_64.

Ok, so I have created the following ~/.curlrc:
   netrc
   proxytunnel
   insecure
   proxy = http://proxyserver.com:8080
   proxy-user = proxyuser:proxypassword

accompanied by the following ~/.netrc:
   machine remoteserver.com
   login remoteuser
   password remotepassword

and the following ~/.gitconfig:
   [user]
      name = My Name
      email = my.em@il.com
   [http]
      sslVerify = false

All above files permissions are set to 600 and I have also set the
environment variables http_proxy, https_proxy and all_proxy (one never
knows) to:
   http://proxyuser:proxypassword@proxyserver.com:8080

Ok, now lets try:

$ wget -q --no-check-certificate
https://remoteuser@remoteserver.com/.git/HEAD && cat HEAD && rm HEAD
ref: refs/heads/master
$ curl https://remoteuser@remoteserver.com/.git/HEAD
ref: refs/heads/master
$ git clone https://remoteuser@remoteserver.com/.git/
Initialized empty Git repository in /home/user/.git/
error: Proxy requires authorization!
warning: remote HEAD refers to nonexistent ref, unable to checkout.

Both wget and curl work, but git won't! Any clues?

Thanks in advance and best regards,
-- Giovanni
