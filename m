From: "Dana How" <danahow@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 11:18:41 -0800
Message-ID: <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:19:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjU4-0007uw-NV
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbXKZTSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbXKZTSp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:18:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:5795 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbXKZTSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:18:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1000496ugc
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LqsgECny6iVWP6OPJz4LZ2j2s/tQovJjIEHVcmDJOlo=;
        b=lgUlTvKxMJka6vp7Peubb40+x3EUUqnNSb1rAH8thoqVrPmQK21GPvZKSwxiaSjwz0+LGGkbpJrfMw7H6ffxvKFkQ6ozIrBw6L+PK9ySCC4z9Np8z+FUSOKwokKH8SrLb5lFuQCRAKFTVXim9BqLrh2Zy9+xgCWPatbnKi1BS44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gyk6cOeojU2NbkpMUXOsaW65T2tivF2l6RGMiD0irlvGy5oZ7myNBAiRD6ZqzgFzUtK+adHfse/O/+UF7txtomut5vpEs3+SU/5EjLRsyCw0b7bDf1YVJDlfdUQ20PrPrsBj2dJ3LEYYWV8SQn+GnFWzreaiOdAMBqrpGCiPv+0=
Received: by 10.78.180.18 with SMTP id c18mr3381067huf.1196104721832;
        Mon, 26 Nov 2007 11:18:41 -0800 (PST)
Received: by 10.78.177.20 with HTTP; Mon, 26 Nov 2007 11:18:41 -0800 (PST)
In-Reply-To: <200711252248.27904.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66094>

On Nov 25, 2007 1:48 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> If you would write git from scratch now, from the beginning, without
> concerns for backwards compatibility, what would you change, or what
> would you want to have changed?

Currently data can be quickly copied from pack to pack,
but data cannot be quickly copied blob->pack or pack->blob
(there was an alternate blob format that supported this,
 but it was deprecated).  Using the pack format for blobs
would fix this.  It would also mean blobs wouldn't need to
be uncompressed to get the blob type or size I believe.

So far this has prevented me from deploying git here
(and is half the reason I have not been active recently).
Currently we use p4 and we have large files.
When a large file is checked in (submitted),
it is compressed *once* and sent over the network --
these are the only delays that end-users experience.

The equivalent operation in git would require the creation of
the blob,  and then of a temporary pack to send to the server.
This requires 3 calls to zlib for each blob,  which for very
large files is not acceptable at my site.

Yes,  git has much better features.
But 80%+ of my workgroup will not use them,
and only notice that git is "slower".

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
