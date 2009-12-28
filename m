From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Smart-http: check if repository is OK to export
	before serving it
Date: Mon, 28 Dec 2009 09:08:11 -0800
Message-ID: <20091228170811.GE2252@spearce.org>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org> <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com> <1261870153-57572-2-git-send-email-tarmigan+git@gmail.com> <20091227211033.GB609@spearce.org> <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com> <20091228155931.GC2252@spearce.org> <905315640912280857g710b45fcne21a21d53ff0fedf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	rctay89@gmail.com, drizzd@aon.at, warthog9@kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 18:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPJ5r-00050Z-Jy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 18:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZL1RIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 12:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZL1RIP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 12:08:15 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37841 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZL1RIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 12:08:15 -0500
Received: by ywh6 with SMTP id 6so10543917ywh.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 09:08:14 -0800 (PST)
Received: by 10.150.19.4 with SMTP id 4mr10333141ybs.216.1262020094437;
        Mon, 28 Dec 2009 09:08:14 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm4109420ywd.38.2009.12.28.09.08.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 09:08:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <905315640912280857g710b45fcne21a21d53ff0fedf@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135748>

Tarmigan <tarmigan+git@gmail.com> wrote:
> On Mon, Dec 28, 2009 at 10:59 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Tarmigan <tarmigan+git@gmail.com> wrote:
> >> I've been thinking that the not_found() to a forbidden() instead.
> >
> > Because you can't resolve the access error by authenticating to
> > the server, we may actually want to just return not_found() here
> > with a message in the log of "Repository not exported: '%s'".
> 
> I'm no http expert, but isn't that what 401 would be?  From
> http://tools.ietf.org/html/rfc2616#section-10.4.4
> 403 Forbidden
>    The server understood the request, but is refusing to fulfill it.
>    Authorization will not help and the request SHOULD NOT be repeated.
>    If the request method was not HEAD and the server wishes to make
>    public why the request has not been fulfilled, it SHOULD describe the
>    reason for the refusal in the entity.  If the server does not wish to
>    make this information available to the client, the status code 404
>    (Not Found) can be used instead.
> which to me points to 403 instead of 404.

Good point, that is 403.  But the last sentance leads me to believe
404 might be a better use here.  Under git-daemon we don't tell
the client the difference between "Not Found" and "Not Exported",
so I think we should be doing the same thing here under HTTP.
 
-- 
Shawn.
