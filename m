From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH maint-1.6.5 v2] block-sha1: avoid pointer conversion that
 violates alignment constraints
Date: Sat, 14 Jul 2012 13:56:17 -0700
Message-ID: <CA+55aFxHAPJi9cKVy6Mi7gunHT3PPLEQUwJBFQ4ftO2szc_dow@mail.gmail.com>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino> <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino> <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino> <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
 <20120714205049.GA28502@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:56:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq9OP-0000Yp-HP
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab2GNU4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 16:56:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42393 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab2GNU4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 16:56:38 -0400
Received: by weyx8 with SMTP id x8so3195655wey.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=b2qO6cu4YVPDT5yqMIpBoRMADmdjeYHeaesccZtX/L4=;
        b=U0wboxVyD5G7aBkESlarukxjmGWr+9dfFhhHjQeJMl6YEcf9d3H4qndvGF3Z2JyvPc
         IVO7Pam0g58vtMVNq5aUSUQKagU7kdUg0w1VN7LY7SGlFbNh4cwL9LP32kXFVXdu8oFh
         NiPR42SvhNR5e0so+uYO521s4RfWyX8XNfsSseTkqBM+dui62rhFHJrbYZpGlgr3ugEC
         CHJi4lPTxnyjAfD+XGOnjcvbOE6ISB2g6y2kNGOigAqxncpsK1cEhhH/qXoSaqcEDaFK
         8ejoIMFboUnQ79U7+RX7OyH8GaoEpmjLizYHOG5gOjDM0OY93pkxxnSa66WGbcARWloM
         pGMw==
Received: by 10.216.255.196 with SMTP id j46mr2932419wes.106.1342299397708;
 Sat, 14 Jul 2012 13:56:37 -0700 (PDT)
Received: by 10.216.142.14 with HTTP; Sat, 14 Jul 2012 13:56:17 -0700 (PDT)
In-Reply-To: <20120714205049.GA28502@burratino>
X-Google-Sender-Auth: cDiOJyoxUQcm7zX63dAX9gS_vmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201457>

Looks good to me. I'd suggest doing the macro argument expansion in

   #define SHA_SRC(t) get_be32((unsigned char *) block + t*4)

with parenthesis around 't', but that's a fairly independent thing.
The old code didn't do that either.

          Linus
