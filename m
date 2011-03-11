From: Vicent Marti <tanoku@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Fri, 11 Mar 2011 14:22:25 +0200
Message-ID: <AANLkTinHhHk6U3wTDLUx2f4S17arLWGj4S1NSAw9yM-x@mail.gmail.com>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie> <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
 <20110310115549.GA31046@elie> <7vlj0m4vz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, libgit2@librelist.com,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 13:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py1Mq-00062m-9W
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 13:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab1CKMWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 07:22:47 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52309 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab1CKMWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 07:22:46 -0500
Received: by wya21 with SMTP id 21so2349646wya.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XIS0+UXrz/bgtEnA1n2Tp032Z3n1+rnwmVxmIj7x3sI=;
        b=kuzh+78EfG+FlCrQpJGhV22U4YH1ltFN7f5oc0mxCryZ3zUSwCC+o9zreaIjlMH4bj
         oovTwJhUu6k1VhOhZIovFzRoeAY1jlN8/ZJ3Pw5g4snLEzmu7ukGLEV+bCdCitm5ThHS
         YB8+GVDemGY5p3CuQEQwJRt1ElicnDnEDWDXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MLT2fLBCDmvQFqYtZ4dOHTU+SyJYsJ5xv7bUqhAM+gQe0oNd8CfNlb0E9gJIZeE4if
         WDHCxcqZEtvATzLkjzj0F6G2dOIcVk/7Qwh8aWRlFLsxtBV2jl0GcbM3/kPzRU7vSt8k
         EicJTXnhH19TF3gMkv1W97m4KKBsTmD1qdN7Q=
Received: by 10.216.145.154 with SMTP id p26mr7089360wej.11.1299846165096;
 Fri, 11 Mar 2011 04:22:45 -0800 (PST)
Received: by 10.216.244.10 with HTTP; Fri, 11 Mar 2011 04:22:25 -0800 (PST)
In-Reply-To: <7vlj0m4vz1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168893>

Hey,

On Thu, Mar 10, 2011 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> How big a performance penalty does libgit2 have to pay to depart from many
> "we run once and let exit take care of cleaning up after us" patterns used
> in git.git primarily in order to avoid the housekeeping cost?

It's not significant. We try to use custom memory allocation wherever
possible, and the most complex structures (interdependencies in parsed
objects from the DAG) are internally garbage collected, so we don't do
any unnecessary free's. We try to offset the cost of 'proper' memory
management by using smarter/more performance tuned algorithms. So far,
some stuff ranges from varying degrees of faster-than-git (see: new
revision walker, index writing, streaming loose object writes) to
slightly slower (see object parsing :/).

We are working on it. Performance is our main concern.

Cheers,
Vicent
