From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Fri, 24 Sep 2010 14:43:13 -0500
Message-ID: <20100924194313.GA8114@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <1284596048.3298.3.camel@wilber>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzEDo-0004o2-2X
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab0IXTqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 15:46:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33581 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab0IXTqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 15:46:10 -0400
Received: by yxp4 with SMTP id 4so1077959yxp.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ns8Aisg/3JNdEnOGOuNOpIKWYpHpCGiPooSNEioRHkU=;
        b=mEHA1arVRoOwQ7s5zmovBHBroxV1QXvc/4t5NXomEItgQ+zuKqNbm20EJzCcMHwoQa
         dd1dEPSedJ0GQOuLLwfRJwROnQOtK+x/sWWoIVg3UXQ/wxOjJR+nDT0VGmYQKuYL/Xr3
         gav85g8PbtltZxuQ1wjMG+tT779k8+CS03++k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cgtZ6cH7uD5c5jUbEVXie8tGe+9jplflsP0cycqaQYx3oT4Stku2HIplW/1A/DZAqh
         m64CxKsX0J89RT7mT3/FWrAQNTJ8ESjrDpIItI3AWVVBcqNhXP55DgfR3KYKEiTJBoKz
         J1E2JS37VNRCCDWu4DB8ADyHi1MKpgt3swIrc=
Received: by 10.100.164.4 with SMTP id m4mr4403037ane.135.1285357569579;
        Fri, 24 Sep 2010 12:46:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm2674699ibk.1.2010.09.24.12.46.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 12:46:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284596048.3298.3.camel@wilber>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157047>

Hi Sam,

Sam Vilain wrote:
> On Sat, 2010-09-04 at 22:15 -0500, Jonathan Nieder wrote:

>> It works like this:
>> 
>> frontend:
>> 	feature report-fd=3
>> 	commit refs/heads/master
>> 	... revision 1 ...
>> 
>> importer:
>> 	abc7856cba76bca87a65bca76bca8bca98bca78bca76
>
> This is probably quite a late comment, but I don't think that
> 'report-fd=3' is a good idea in a protocol like this.

Yes, I guess "feature report-fd=3" is a protocol layering violation.
Unfortunately import-marks and export-marks have already set a
precedent.

How about a "feature report-fd" (with no argument) that checks if the
report-fd was set and errors out if not?

Well-behaved streams could use that and rely on the fd to be set on
the command line, while poorly-behaved streams could still use
"feature report-fd=whatever" to get the effect of --report-fd=whatever
and avoid breaking UI consistency.
