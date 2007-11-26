From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:17:55 +0100
Message-ID: <200711262117.56326.jnareb@gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkPV-0005ph-4R
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbXKZUSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbXKZUSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:18:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:45826 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbXKZUSI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 15:18:08 -0500
Received: by nf-out-0910.google.com with SMTP id g13so861676nfb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=A+Khz5LV8wqFfUpc3OkTRhc05Yy5DNQBnFnsyQxBlsw=;
        b=EJSm2pQgSJpgYPcqT2HY6BqTFCvshdoP5v5jj/VURKZ0R2XrqhthcPMLmjbNxbmrt2eWMn6g87CYP9vYjlSUfeZgq3dbMLd7Z0J4ogtSuTCyXypLX50lwHfi4vUqrkYnnBbxf5pW2l+fxwNkvB4YNqPcNKKWivNVLMT8R7ebDcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UUyYFZnkg7S62+ETCqSQatut/hEknlpAe69IWTneKI/LQHSwtU9oFGXXotzcY+rc9Z1b6I5vwBFoi+Xn+C3bHN+xZNN9wi3GTO//1KeDd8VgU0WiqB910DNwCq41jSi6uOwMIZqOsp3rSbK571jkTWEc60Gls7S6F/NJALhC0aY=
Received: by 10.86.68.20 with SMTP id q20mr3075112fga.1196108280473;
        Mon, 26 Nov 2007 12:18:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.183])
        by mx.google.com with ESMTPS id 3sm2649542fge.2007.11.26.12.17.58
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Nov 2007 12:17:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66110>

On Mon, 26 Nov 2007, Dana How wrote:
> On Nov 25, 2007 1:48 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> > If you would write git from scratch now, from the beginning, without
> > concerns for backwards compatibility, what would you change, or what
> > would you want to have changed?
> 
> Currently data can be quickly copied from pack to pack,
> but data cannot be quickly copied blob->pack or pack->blob
> (there was an alternate blob format that supported this,
>  but it was deprecated).  Using the pack format for blobs
> would fix this.  It would also mean blobs wouldn't need to
> be uncompressed to get the blob type or size I believe.

Could you do some benchmark for repository with your large objects
as loose objects created with and without core.legacyHeaders (created 
with git pre 1.5.3), and as single blob packs, perhaps kept, with 
_undocumented_ (except for RelNotes) gitattribute delta unset for
those files?


>From Documentation/RelNotes-1.5.3:

  - We used to have core.legacyheaders configuration, when
    set to false, allowed git to write loose objects in a format
    that mimicks the format used by objects stored in packs.  It
    turns out that this was not so useful.  Although we will
    continue to read objects written in that format, we do not
    honor that configuration anymore and create loose objects in
    the legacy/traditional format.

  - "pack-objects" honors "delta" attribute set in
    .gitattributes.  It does not attempt to deltify blobs that
    come from paths with delta attribute set to false.

  - diff-delta code that is used for packing has been improved
    to work better on big files.

The last part is thanks to your comments, complaints and efforts, Dana.

-- 
Jakub Narebski
Poland
