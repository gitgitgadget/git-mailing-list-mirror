From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 11:07:09 -0700
Message-ID: <20140715180709.GK12427@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
 <1403275409-28173-44-git-send-email-sahlberg@google.com>
 <53BC07FC.8080601@alum.mit.edu>
 <CAL=YDW=3aYhMNjCtT7BV=RDkRN2=Ac0uC_iEiQrO45i4C3zeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X778J-0004Yv-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 20:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbaGOSHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 14:07:15 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58699 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbaGOSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 14:07:12 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so1295650pad.11
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i4hHS9BTYg23cYzQieWecslFETchUo//siho7OitbMw=;
        b=AVskThSjxadJtR5Jk/j80uS1ZhOZxZr6OiDni1BmGmZBhSW/tuPP04rD0LJN12y2Gl
         JDiQyzoME+JiUWC19aMN233B4YTSrktAEmaiw5F72pD+DA7ns/Axi1lli0p4VU1N1Oki
         KlzMkvNkhuDyGMbNGAbOrdou7QvpH+TObRdp1TtxpzBrZp/b7ezht/2osdbAt4tYl/cL
         9y4oueECn7YR5nIRLgp7M0fmDHWflJ5IUd2wMx3RHgUaeFYdYdOHco81n2bDSb3N10+j
         US7YZ5u98E6az5MsPMtcPDj2cOkaZvuylwtKBWtKUWDu5tvYValCN96sskLpzOgrhz/2
         yC7A==
X-Received: by 10.68.201.167 with SMTP id kb7mr24657389pbc.38.1405447631651;
        Tue, 15 Jul 2014 11:07:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:888a:1e2f:d307:1d55])
        by mx.google.com with ESMTPSA id u8sm19461095pds.92.2014.07.15.11.07.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 11:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=3aYhMNjCtT7BV=RDkRN2=Ac0uC_iEiQrO45i4C3zeDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253577>

Ronnie Sahlberg wrote:

> What I suggest doing here is to create a new patch towards the end of
> the series that will :
> * change the resolve_ref_unsafe(... , int reading, ...) argument to be
> a bitmask of flags with
>     #define RESOLVE_REF_READING 0x01  (== current flag)
>     #define RESOLVE_REF_ALLOW_BAD_NAME 0x02  (== disable checking the
> refname format during resolve)
> * then provide the flag for RESOLVE_REF_ALLOW_BAD_NAME for the cases
> where we try to resolve a ref in builtin/branch.c where we try to
> delete a ref
>
> * then also pass the same flag to lock_ref_sha1_basic when we are
> deleting a ref from transaction_commit so we can disable the "check
> refname" check there too.

Yeah, that sounds lovely.

I wasn't able to reproduce a regression or convince myself there is
one so I think it's okay if that happens in a separate series.  But
doing it now would be fine, too.

Thanks,
Jonathan
