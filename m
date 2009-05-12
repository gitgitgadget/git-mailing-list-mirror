From: Esko Luontola <esko.luontola@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 18:06:05 +0300
Message-ID: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 17:07:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ta7-0004wL-MQ
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756123AbZELPGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755097AbZELPGK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:06:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:44236 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbZELPGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:06:09 -0400
Received: by mu-out-0910.google.com with SMTP id i2so12908mue.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=fHZgNIPzvS3JjfcKcQxeLJM4EddoHjdYaBf3L+BiY6E=;
        b=IqMxpOC6aKqtpX2ehrHnH7X5DTIlwMPCfIxVjrYNSkUmup5SU+2Cxt0ELcgI24By8w
         1jDZtGH3u6JElIrjAX3OoMBY3mftckiKQzJwVOHO4etMNVLQifaTqg5DfiYxZ1b27xR7
         nVy0QedaqbLBzk3ziNJeP8LuSSkcydV7Nkjqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=uk82fpnyTcw6pUP0eBwpKDR0oLiwHaQzRIdcGBKv2cpKHMTt+c6U99ZeUHI/w1g+E4
         MakUmvXaCkQHiRLuGMKClrxUkfhgpFwPcqHkrHwq/IXCgramGhTTE2WyM3qR2lhH4UC9
         DfhcxWJZGv1W6SLKrBviDDgZ1HN8K+5YWPAPU=
Received: by 10.103.231.16 with SMTP id i16mr5378793mur.7.1242140768652;
        Tue, 12 May 2009 08:06:08 -0700 (PDT)
Received: from ku-hupnet59-74.hupnet.helsinki.fi (vallila-gw.hupnet.helsinki.fi [128.214.20.122])
        by mx.google.com with ESMTPS id u9sm2356600muf.7.2009.05.12.08.06.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 08:06:08 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118901>

A good start for making Git cross-platform, would be storing the text  
encoding of every file name and commit message together with the  
commit. Currently, because Git is oblivious to the encodings and just  
considers them as a series of bytes, there is no way to make them  
cross-platform. It's as http://www.joelonsoftware.com/articles/Unicode.html 
  says, "It does not make sense to have a string without knowing what  
encoding it uses." Without explicit encoding information, making a  
system that works even on the three main platforms, let alone in all  
countries and languages, is simply not possible.

On the other hand, if the encoding is explicitly stated in the  
repository, then it is possible for platform and locale aware Git  
clients to handle the file names and commit messages in whatever way  
makes most sense for the platform (for example convert the file names  
to the platform's encoding, if it differs from the committer's  
platform encoding). Then it would also be possible to create a Mac  
version of Git, which compensates for Mac OS X's file system's file  
name encoding peculiarities. Also the system could then warn (on "git  
add") if the data does not look like it has been encoded with the said  
encoding.

If the platform's and the repository's encoding happen to be the same  
(which in reality might be possible only inside a small company where  
everybody is forced to use the same OS and is configured by a single  
sysadmin), then no conversions need to be done. Also Git purists, who  
think that the byte sequence representing a file name are more  
important than the human readable version of the file name, may use  
some configuration switch that disables all conversions - but even  
then the current encoding should be stored together with the commit.

Are there any plans on storing the encoding information of file names  
and commit messages in the Git repository? How much time would  
implementing it take? Any ideas on how to maintain backwards  
compatibility (for old commits that do not have the encoding  
information)?

- Esko
