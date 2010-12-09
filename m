From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 9 Dec 2010 16:52:11 -0600
Message-ID: <20101209225211.GA20426@burratino>
References: <201011041721.53371.jnareb@gmail.com>
 <4D00316F.9000305@eaglescrag.net>
 <201012092330.06688.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog9@eaglescrag.net>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	olaf@wundersolutions.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 23:54:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQpND-0002J1-HK
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 23:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab0LIWws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 17:52:48 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:52614 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab0LIWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 17:52:30 -0500
Received: by qyk4 with SMTP id 4so662963qyk.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2cQ6W+ihmdh8XR9IUjHBaeFRY3u8tVQ0a9x3V+HZWAw=;
        b=oUnfWQ3VMaUn4cMDNWAdyP+lf/cL7dTntTKPheKhHLN02OolczdDiqWmU1SCTx5xr2
         ke5NTaIYaVhLCPvfHPaFWO0P/9syoADFqdGtYy/MzGl5QCC4FdU/oBOf56cZsrI+CdNM
         UZnS4MqnbyqmavcW732EP+mWR7awvW6xQrrBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CCtZRt0Mi/mRUTgTQqP1VtCE95kEmxVgb3eLNM0OupWFFFDwcEWA/poeAONjqqFuZ6
         4oqNWa9C+CSkpwC+343ZmFV5YO4+B4Z9Qx1Va4n/5YcN+Ho6eMcASDbOatofMlqBgjCf
         ea9YOLx4ew91pggl75CxP1iMq0NM1pATmQJqI=
Received: by 10.224.89.19 with SMTP id c19mr8637594qam.247.1291935149927;
        Thu, 09 Dec 2010 14:52:29 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id k15sm1509228qcu.47.2010.12.09.14.52.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 14:52:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012092330.06688.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163354>

Jakub Narebski wrote:

> In my rewrite
>
>   [PATCHv6 17/24] gitweb: Show appropriate "Generating..." page when regenerating cache
>   http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163040
>   http://repo.or.cz/w/git/jnareb-git.git/commitdiff/48679f7985ccda16dc54fda97790841bab4a0ba2#patch1
>
> (see the browser_is_robot() subroutine:
>
>   http://repo.or.cz/w/git/jnareb-git.git/blob/48679f7985ccda16dc54fda97790841bab4a0ba2:/gitweb/gitweb.perl#l870
>
> I use HTTP::BrowserDetect package if available and it's ->robot() method.
>
> The fallback is to use *whitelist*, assuming that it would be better to
> not show "Generating..." page rather than download the wrong thing.
> I also guess that most (all?) web browsers use "Mozilla compatibile"
> somewhere in their User-Agent string, thus matching 'Mozilla'.

Interesting.  http://www.user-agents.org/ seems to suggest that many
robots do use Mozilla (though I don't think it's worth bending over
backwards to help them see the page correctly).

HTTP::BrowserDetect uses a blacklist as far as I can tell.  Maybe in
the long term it would be nice to add a whitelist ->human() method.

Cc-ing Olaf Alders for ideas.
