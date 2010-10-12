From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] Teach fast-import to print the id of each imported
 commit
Date: Tue, 12 Oct 2010 14:07:02 -0500
Message-ID: <20101012190702.GC16237@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-2-git-send-email-david.barr@cordelta.com>
 <AANLkTinRDoSHhzYnnvckPYyiZrsOX1mJECBMb5bNbMJ=@mail.gmail.com>
 <20101012184856.GA16103@burratino>
 <AANLkTikyc8qv6SCewrZLvZccOX5giqRPqQBtrf8o9Mtb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5kF6-0001MK-Pq
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163Ab0JLTK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 15:10:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54878 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab0JLTK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 15:10:26 -0400
Received: by gwj17 with SMTP id 17so1548519gwj.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vPd4SoGTrWonARkg0wmjO451IHX9K5Hdjn8+ZECNRV8=;
        b=toVJx7rPefy3L21PkpUZ3+TCuiA6kVaQ6Vt6cviOHvAPSFtjDjkb7Tkp72F9teK4WH
         sR5RxrVabdrugNJ6wpS9BzI3UM6e1MYX0HNeQ6OMScLFp457K/LniEBbMH/JR6Lm6a73
         zn+n2Wsa8eaiNHUFgEqiCqOTHtifd5pLaS3L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P4aVo+zYYT+NJgmKY7k9SQhY6zAqHPHhYSr7GGVV2bLfUal6slH2ZwbS/ot3C9OJd5
         wHIMv8HK1WmgvyE3cN5l3rzw31KiwbHbkTUrIvjVaRSgjUEwRLxx2sxb/Clyg/foNsZP
         CxGJQSBZ7wltCQHQ84V+foOvkU4zkPRLCZ7XI=
Received: by 10.151.50.14 with SMTP id c14mr4481965ybk.432.1286910624952;
        Tue, 12 Oct 2010 12:10:24 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id z16sm7113776ybm.16.2010.10.12.12.10.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 12:10:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikyc8qv6SCewrZLvZccOX5giqRPqQBtrf8o9Mtb@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158869>

Sverre Rabbelier wrote:

> Perhaps we can instead make '--report-fd' have a default value of
> 'stdout'?

Sounds sane.

> I don't see why we would want to _disallow_ the value from
> being specified in stream (we allow import/export-marks in-stream
> too), as long as they can be overruled by the commandline.

I do.  If the stream is not being piped to a process the frontend
started (maybe it's being sent over the wire to some fast-import
service instead), what would

	feature report-fd=7

even mean?  So we should discourage it, or better, forbid it now
while we have the chance.

By contrast, as you explained,

	feature relative-marks
	feature export-marks=MARKS1

is meaningful because without knowing anything about the underlying
filing system, a frontend can rely on a later

	feature relative-marks
	feature import-marks=MARKS1

picking up where it left off.
