From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: "git stash" changes owners and permissions
Date: Wed, 6 Apr 2011 17:12:05 -0500
Message-ID: <20110406221205.GB2894@elie>
References: <878vvnfp60.fsf@kiva6.ethz.ch>
 <20110406184938.GE1220@elie>
 <20110406200640.GF12557@sym.noone.org>
 <20110406205212.GC1922@elie>
 <7voc4jgig7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Axel Beckert <abe@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7axW-0000HH-4U
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 00:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab1DFWML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 18:12:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44500 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369Ab1DFWMK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 18:12:10 -0400
Received: by ywj3 with SMTP id 3so763042ywj.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v+9HJbRsvMTnYp3jQr+sPGXZqW96QyKDg0mzAenkSjY=;
        b=ZppmHqrUYuShDlxInmvHY6ESUjppYuLPzHuq/UYGZoK2CDkkK4CRQfqS+sOZJmh0p9
         OXG+v4KdswD1O1k0waNJ3lU1kckv4pa4GtDfRQrUQzrl0bS6dJquxEwtzFai42KeqGQZ
         YwMhMvT2wbBcwRVtLhxoVSepzDabXqzhWjQNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AmLtw+xmNUNx98sgXoS2cU0XkQGKqVWQgE9EsQiAzPci+Sjxdcx/8L819JD91DW9sc
         McoR3BXqrO7Zqksb3rMtpQEmzdbisvkqXDq7L58Ao7KAaO1W7nuc54a0eZjb/A8cGvHD
         6OBdibiopanVYum7TTmF3wRoKMCjtFry2/6SI=
Received: by 10.91.21.27 with SMTP id y27mr153201agi.25.1302127929803;
        Wed, 06 Apr 2011 15:12:09 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id x37sm1114830ana.8.2011.04.06.15.12.08
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 15:12:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voc4jgig7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171023>

Junio C Hamano wrote:

> How does this "rsync" solve "the wrong order" and "creates windows"
> problems?  It will update the paths in the order rsync happens to discover
> and there is a wondow between the time the first path is updated and the
> whole directory gets finally in sync.

All true.  It's a little better than "git checkout" because rsync
will stage files and then rename them into place rather than leaving
a window with files unlinked[1], but it is not much better.

In fact the rsync was a misleading placeholder.  What I really meant
to convey is that this is not something "git checkout" and "git reset
--hard" are designed to do, and that when this much control is needed,
it can be easier to update files out-of-band.

> If you truly want an atomicity, you can make /etc/interesting-subdir a
> symbolic link that points to either interesting-subdir-{0,1}, do the above
> procedure of yours against interesting-subdir-0 (or 1) that is currently
> not pointed by the symbolic link, and when everything in that one is Ok,
> atomically switch the symbolic link to point at it.

True.  Though in practice, a little race might be considered ok. :)

Thanks for clarifying.
Jonathan

[1] rsync with --files-from can update files in a specific order,
which might be appropriate in some cases.
