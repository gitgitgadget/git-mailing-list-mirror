From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 1/3] Give NoRemoteRepositoryException better message
 in BasePackConnection
Date: Thu, 28 Aug 2008 04:40:22 +0200
Message-ID: <48B61016.7050401@gmail.com>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com> <20080828023501.GC8624@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXSA-0008WJ-Ne
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbYH1Cka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYH1Cka
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:40:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:3523 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYH1Ck3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:40:29 -0400
Received: by mu-out-0910.google.com with SMTP id g7so127867muf.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=B6j0/TQff/qDruML7vaDSSdWwqOJLsEU6l7w+qYPxJw=;
        b=tdpvL8V/dqqzB9VdQiUjtYgekmTNr82+WO+yAM6iJ+L9G9R3eXDylMZ7xzJp0n+QWB
         1rojsEiebxYFZDCwnoaFaYQUZY/ktDYfB5sgPm2NLqT8lSypR9xFSPf9XczLNukEccJC
         mV8IMJJJnbpxjkNstrVYtzGZWaNTLxNG/XvDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kzp34eb4vuZ2aoOb1dKLd/eE7Hlo+jlbaxuoAN3V4/sq2XcbTkDsCF+wd6avUnYyTQ
         JtElCMyroYMk6DxZkUDpgeopqLCbncgwOwWSIUD3xSVgQ6Rgj9ZGQzZ8+bToYhZXKyad
         jJgn3ujl/AGgTCApecFxJ7ZPL/evuAs1MZd6w=
Received: by 10.103.168.5 with SMTP id v5mr473534muo.35.1219891228108;
        Wed, 27 Aug 2008 19:40:28 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id y37sm488609mug.18.2008.08.27.19.40.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:40:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <20080828023501.GC8624@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94026>

Shawn O. Pearce wrote:
(...)
> +	@Override
> +	protected TransportException noRepository() {
> +		// Sadly we cannot tell the "invalid URI" case from "push not allowed".
> +		// Opening a fetch connection can help us tell the difference, as any
> +		// useful repository is going to support fetch if it also would allow
> +		// push. So if fetch throws NoRemoteRepositoryException we know the
> +		// URI is wrong. Otherwise we can correctly state push isn't allowed
> +		// as the fetch connection opened successfully.
> +		//
> +		try {
> +			transport.openFetch().close();
> +		} catch (NotSupportedException e) {
> +			// Fall through.
> +		} catch (NoRemoteRepositoryException e) {
> +			// Fetch concluded the repository doesn't exist.
> +			//
> +			return e;
> +		} catch (TransportException e) {
> +			// Fall through.
> +		}
> +		return new TransportException(uri, "push not permitted");
> +	}
> +

Nice idea, even if it's crazy and time-consuming, it's probably better 
than my previous one.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
