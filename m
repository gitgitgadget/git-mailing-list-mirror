From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3] gitweb: Simplify some gitweb URLs generation
Date: Fri, 2 Nov 2007 01:18:43 +0100
Message-ID: <200711020118.44015.jnareb@gmail.com>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com> <7v1wb98twi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 01:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InkFh-0000L3-0j
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbXKBASz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 20:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXKBASz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:18:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11283 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbXKBASy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 20:18:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so565440ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=InbMSAruo15YflTCYmEsjiyil3CBkbbl1gP/KfF3v6Y=;
        b=IrQBXLdaDOPzdaEe6nVIv4bFVE9IKoKLpw5H1uuNiSbXeSD9/z8EUdiFtriS0ZskBkYCcJRAbpKYsYW1haVbsep6RjYL98qaISrz6gwU3gTjZmHY2ZI8S7AUZ37oueBEK/MkMbRoTOwomLq2GzmNqTyJAEwy5ipipmuGi5Qr43s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Du2fsSExqjrlHks5lFTyK+cQ87RAbFIBcf9fqKh/55LEJmrK387HdgtVe9Tl8WKTqFnnvx8K7xTLKCvqZUXMwis5bdueouP3CrD+kerNy5hkJ/UVTmvqtor4/f7MJ5q8DTFHbYPfXnXTE0WSQyIK9c0XZg57QPxlr0ZjczejbmM=
Received: by 10.67.19.17 with SMTP id w17mr365724ugi.1193962732430;
        Thu, 01 Nov 2007 17:18:52 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.154])
        by mx.google.com with ESMTPS id y7sm6954586ugc.2007.11.01.17.18.50
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 17:18:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wb98twi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63040>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> This series of patches simplifies some gitweb URLs generation by
>> providing -replay option to href() subroutine, and then using this
>> feature in gitweb code.
>>
>> Shortlog:
>>  gitweb: Easier adding/changing parameters to current URL
>>  gitweb: Use href(-replay=>1, page=>...) to generate pagination links
>>  gitweb: Use href(-replay=>1, action=>...) to generate alternate views
>>
>> Diffstat:
>>  gitweb/gitweb.perl |   82 ++++++++++++++++++++++-----------------------------
>>  1 files changed, 35 insertions(+), 47 deletions(-)
> 
> If this "-replay" is used carelessly, it could add parameters
> that were passed to the page that the original code stripped
> away from passing on purpose.  Have you checked if the
> conversion done with 2/3 and 3/3 are correct (I haven't)?

First, I guess that I should have marked this series of patches as
an RFC, but not for the reason you mentioned. This series changes
somewhat gitweb behaviour (patches 2/3 and 3/3 to be more exact) in
a way that before gitweb passed 'expanded' hashes to page / alternate
view links. For example before this series link to second page for
shortlog view starting from 'HEAD' passed literal sha1 for 'h' parameter,
ans second page started where first page ended. After this patch, if
refs have changed between viewing first page and clicking on the link
to second page, the resulting view would be second page of _new_ 'HEAD',
not of old (shown) 'HEAD'.

Second, you do not need to worry about adding parameters, because in 2/3
and 3/3 -replay is used to change view to the one which differs from
current by one parameter. Please take into account that some parameters
are just not important.

-- 
Jakub Narebski
Poland
