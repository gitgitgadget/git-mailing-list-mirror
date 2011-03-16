From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 05:52:14 -0500
Message-ID: <20110316105214.GB8277@elie>
References: <20110316095632.GA8277@elie>
 <1300272453-25891-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzoL3-0007qu-Tl
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 11:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab1CPKwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 06:52:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51299 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab1CPKwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 06:52:20 -0400
Received: by gxk21 with SMTP id 21so598593gxk.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FdGVj7xDHCY14KsExDGRiLamaoe6swcS0VuW0QytDHc=;
        b=rvHgcMUAcJqz4vq49Sd3l6xthIXX3Nfng3lmfJXDt9Ih9ApbLiYCaAfJ9Lubsz6627
         ingTOfYYWrwfmc+wmydJ4VaaHMNmaAMu4yv4fzyaEU5xk6t+mQK32dgOzPDPKvv1AhT6
         JbjxPpAwZnT4YSgNRw4jX+Wj/Bh2HCZlMW+iY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x7MZNow5oVotFZjwStxy/IMcbKPpwtkz5WsbjbkyS4SiPIxRuaeNLplE+KhRZB7zQW
         N0KIKjarW3YieIL+XStyC7ipsoGJw28PTo5ZH/gSUZ4SSLkva4/9QUpeLv9hCSdf7X5A
         LDyZHHqaIRFtKEQGncqdK6q0LLy+vPWUIiSmQ=
Received: by 10.91.22.10 with SMTP id z10mr1136029agi.196.1300272739333;
        Wed, 16 Mar 2011 03:52:19 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id 37sm394552anr.24.2011.03.16.03.52.17
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 03:52:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300272453-25891-1-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169135>

Carlos Mart=C3=ADn Nieto wrote:

> The GNU C Library (glibc) uses SSE instructions to make strlen (among
> others) faster, loading 4 bytes at a time and reading past the end of
> the allocated memory. This read is safe and when the strlen function
> is inlined, it is (obviously) not replaced by valgrind, which reports
> a false-possitive.

This still makes no sense to me.  How is it possible to inline a
function from glibc?  When I look in /usr/include/string.h, I see

extern size_t strlen (__const char *__s)
     __THROW __attribute_pure__ __nonnull ((1));

> Tell valgrind to ignore this particular error, as the read is, in
> fact, safe.

I'm happy to see a workaround.  I would be even happier if it came
with documentation about which versions of valgrind need it.

Thanks again.
Jonathan
