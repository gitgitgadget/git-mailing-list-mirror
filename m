From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: SIGPIPE in t9300-fast-import
Date: Sun, 12 Dec 2010 15:49:09 -0600
Message-ID: <20101212214909.GA19709@burratino>
References: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 22:49:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRtnP-0004sQ-LU
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 22:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab0LLVt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 16:49:27 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36002 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0LLVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 16:49:26 -0500
Received: by gyb11 with SMTP id 11so2692076gyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U0+D/yPv70XmCaHL7964Rqwc7obwe2s1SjcbumLK/AM=;
        b=he7LcFeTWbAGZ6btU7FzYj8LDBzO+aNlv6BNWom/Cg2cB9DQhaM7GyVG4eAuyZ70wS
         26y+1vx5RAWd3X9GXoJRbrAPqE2EsSIwaAELT7CZ8VktPHiyAgVuuiDx2OOxFIPNZNNW
         LjooKc3pkSoGORwjNp9+1nyBk4wC3w/C2bt4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vVzYkCmLOJfdUGzgLSkNn5bVGzHTvB3/4AL2ugo4BDdSt9GgGdjSkvtR4g/hhDiNTN
         IlSTelUY5r8TpA7cj7wY0PpDPKOrltQqRotm8yEnqrp0mIOTneAyFgFydnd+AduI5VUS
         VNP/GBBW2pTL6eaiNdr0NsciNUAusDVm8YDeo=
Received: by 10.151.147.8 with SMTP id z8mr5004589ybn.101.1292190565686;
        Sun, 12 Dec 2010 13:49:25 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id q31sm3016080yba.18.2010.12.12.13.49.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 13:49:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163492>

Brian Gernhardt wrote:

> 	read blob_id type size <&3 &&
> 	echo "$blob_id $type $size" >response &&
> 	dd of=blob bs=$size count=1 <&3 &&
[...]
> 0+1 records in
> 0+1 records out
> 8139 bytes transferred in 0.000062 secs (131297847 bytes/sec)
> error: git-fast-import died of signal 13
[...]
> I can run help provide diagnostics, if anyone needs more data.

Hmm.  Any idea why dd is ending early?  Does using

	head -c "$size" >blob <&3 &&

or

	dd of=blob bs=1 count=$size <&3 &&

in its place work?  What does the Mac OS X equivalent of

	strace dd of=blob bs=$size count=1 <&3

(dtrace or ktrace, I guess) tell?

Thanks for noticing.
