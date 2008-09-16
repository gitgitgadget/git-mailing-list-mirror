From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 08:24:39 +0200
Message-ID: <48CF5127.5040507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 08:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfU2R-0002DI-Ef
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 08:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYIPG0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 02:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYIPG0o
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 02:26:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:19419 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYIPG0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 02:26:43 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1118110eyi.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:sender;
        bh=c66b+FK1Lk8e3FTvaUrOCrztXwo6SsZmF9qeu+zge9o=;
        b=WhxfbkxyTAF8dAHtlt/DU8eXt3OzC+ZJZPd6Y7CrRMTa8iWiviBM7hv4dnnoG9VbRe
         YbUgLxczTZ25FHI2mFygRmZaZHcRhUZlO4j1KVW3zQMYIV5DoStxA+G9e6alsZCdf0AW
         +XNMsTeP2pWzbLGz+NYnoQ15Mnd8Yuw+lJxJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:sender;
        b=L71ZS3QUYPDlBkg3HevkFknbijoGKlz3UawhaEG8Hnqvvu8ob39VOgPOOc3i0kn0De
         czrnVl1VptuEtma9E1YLNtJeFoypyTDLaqJfRX/OwUgltof5TWR8i7MKy+FrRImEu1wW
         XhntMDE9wS+XOWFZHPihnbOj70tzSLCvrQ2hc=
Received: by 10.86.95.20 with SMTP id s20mr387979fgb.49.1221546401682;
        Mon, 15 Sep 2008 23:26:41 -0700 (PDT)
Received: from scientist-2.local ( [213.55.131.23])
        by mx.google.com with ESMTPS id e20sm16063255fga.1.2008.09.15.23.26.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 23:26:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95979>

>                 profile_unzip=PROFILE_UNZIP_${profile}
>                 profile_zip=PROFILE_ZIP_${profile}
>                 UNZIP_OPTS=${!profile_unzip}
>                 ZIP_OPTS=${!profile_zip}

Can be written (in pure bourne shell) as

  eval UNZIP_OPTS=\$PROFILE_UNZIP_${profile}
  eval ZIP_OPTS=\$PROFILE_ZIP_${profile}

>         --unzip_opts)
>             UNZIP_OPTS=${UNZIP_OPTS} $2

Missing quotes:

  UNZIP_OPTS="${UNZIP_OPTS} $2"

It could also be a good idea to do

  UNZIP_OPTS="${UNZIP_OPTS} `echo $2 | sed 'y/,/ /' `"

(compare with the -Wa/-Wl/-Wp options of gcc) so you can do

  [filter "opendocument"]
        clean = "rezip --unzip-opts -b,-qq,-X --zip-opts -q,-r,-D,-0"
        smudge = "rezip --unzip-opts -b,-qq,-X --zip-opts -q,-r,-D,-6"

And maybe -b,-qq,-X and -q,-r respectively could be added by default?

Anyway, nice script, thanks!

Paolo
