From: Sheng Yang <yasker@gmail.com>
Subject: Ambiguous -from of git-send-email
Date: Sun, 31 Aug 2008 13:57:10 +0800
Message-ID: <20080831055710.GA644@yukikaze>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 08:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZfzJ-000111-72
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 08:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYHaF5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 01:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYHaF5N
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 01:57:13 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:64248 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYHaF5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 01:57:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so794441tic.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :from;
        bh=h3DHNYE8PHiomTwEEU9oBRXle2gtwvBeXLg6AxBz45c=;
        b=tcdOuTsacTD0FVcEgVDE7we1YGJPWa6UowIEGlTLHt8zOmSZE4ZwoVg/BxhwhIMUKe
         /H55McFCTJLwLW6wp3wXttxT41mp55Nhejsxsc73HOlWlbYOP0KHwsDDXOSLiRAL9X6E
         ObTuoS7yL1+ssJUDjHqwsHgPyeeNJO49UHAZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:from;
        b=Bpt4Ip8VZSMKVqYcAn9IZBxEOOAMWRHZCAXWYyeY3Hiyu8FwwV5XUQ0pvIh8JJEdqE
         O04SRutryI4jxrRZzIU7XdySeuNbDvDABNi0mZM52z5WpGWE7x9nPOiSX4STEuhUZ8pl
         unCtkHzU/lG+IhQs9I3iPumFPBQQ05bp5dqL0=
Received: by 10.110.14.12 with SMTP id 12mr5676639tin.19.1220162229305;
        Sat, 30 Aug 2008 22:57:09 -0700 (PDT)
Received: from localhost.localdomain ( [58.38.142.61])
        by mx.google.com with ESMTPS id d4sm11026934tib.13.2008.08.30.22.57.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 22:57:08 -0700 (PDT)
Received: from yasker by localhost.localdomain with local (Exim 4.69)
	(envelope-from <yasker@yukikaze>)
	id 1KZfvy-0005Of-Ma
	for git@vger.kernel.org; Sun, 31 Aug 2008 13:57:10 +0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94455>

Hi, all

A trivial problem here, but I think it can be handled more clearly.

Recently when I begin to use git-send-email with my private email
account, I found it didn't work as I expected. The problem is "From" of
the patch. I have to specify my company email in the "From" which meant
the author, but when I go with default value of git-send-email, I found
it omit the additional "From" of patch in the mailbody.

For example, I specified "my@company.com" in patch's "From: " when used
git-format-patch to generate it. And I use "my@home.com" to send the
mail.  But if I go with default setting of git-send-email, it said the
mail would be sent as "from my@company.com"(of course it can't). At
last, the sent mail only got "From my@home.com" in mail header, and
"From my@company.com" was omitted.

I've checked the git-send-email code, and found what's the real meaning
of "-from" specify in git-send-email is the email account(sender) rather
than the author. And if the sender is the same as the author, the first
line of patch "From: xxx" was omitted. But at least on my machine, the
from specified in the mail would be overwritten by MTA/ISP(well, I am
not sure which of them did this), so what's the content of "-from" is
not important, but if "-from" is the same as "From" in the patch, the
"From" line in the patch is omitted, otherwise the line is kept.

Yeah, it's reasonable. But I think it's not that clear. "-from" of
git-send-email indicated the sender and "From" indicated the author is
very ambiguous.  Maybe use "-sender" here in parameter is more
reasonable? And do we need some notes in manual?

And can we add a something like "sendemail.sender" to specify the
sender? I think it's not that unusual to make author's email address is
different from sender, at least I think it's more common than
"sendmail.bcc".

If you agree, I'd like to offer a patch for "sendemail.sender"(maybe
also give some note in manual for "-from").

Thanks!

--
regards
Yang, Sheng
