From: Robert Buck <buck.robert.j@gmail.com>
Subject: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Thu, 9 Sep 2010 18:31:31 -0400
Message-ID: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 10 00:35:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otphv-0003Uj-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 00:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab0IIWbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 18:31:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53732 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab0IIWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 18:31:33 -0400
Received: by eyb6 with SMTP id 6so1330341eyb.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ITAHC18dczuheWJSI8/kpVtsrJoWVdPFgWam76tb8VE=;
        b=VQ3RtohhnUSYUIjKacRCQFGJI6IZ0T2Y00/oM6i3SvYctgsxpxuiFf1WiMTr3Blc6j
         w+z2SfDHzQOF5n1FIliV5Kr7uv8HPYHTnDXZip8LMf+6LLdWWKn/q+dGcG6Z+ehAql+E
         RiviJjc3qoMSyq0Ut/hYqZIVppuZdJpeWTyWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=TGNKlV9cRelwW6ktQQ1HjzDWtEq3iCZioZQh/hnATWUTQTawvm0EH/E3jps3qpCZTd
         /98VyyfT1rjBgAaUnpfiuLm2rLyvbYWDoyLJm1jsIFrKBFS3IjV9OcUNM7jVvCKL2Qmm
         cCpX5M1P71jtKJpNJuWnxMTE4LB9xH5wPv5FI=
Received: by 10.14.13.206 with SMTP id b54mr230203eeb.26.1284071492138; Thu,
 09 Sep 2010 15:31:32 -0700 (PDT)
Received: by 10.14.4.11 with HTTP; Thu, 9 Sep 2010 15:31:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155908>

I start with a repository containing only four files:

  * lf.xml
  * lf.sln
  * crlf.xml
  * crlf.sln

The files whose names are prefixed by LF contain Unix LF EOL
characters. The files whose names are prefixed by CRLF contain Windows
CRLF EOL characters. Each file contains two lines, on one line 'jim',
the second line contains 'tim'.

I later add and commit a .gitattributes file containing the following rules:

  *.sln  eol=crlf
  *.xml eol=lf

I _then_ clone the repository and open each file in binary mode to find:

  * the crlf.xml file contains CRLF when it should contain only LF
<<<<<<< BUG ???
  * the crlf.sln file contains CRLF as it rightly should
  * the lf.xml file contains LF as it rightly should
  * the lf.sln file contains CRLF as it rightly should

Conversion of LF-EOL files to CRLF works fine, but conversion of CRLF
to LF fails to occur.

The doc is a little unclear if this is expected behavior, which if I
recall correctly from the email threads related to the new eol
support, this should not have occurred.

Guidance appreciated.
