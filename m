From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 09:03:31 +0000
Message-ID: <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0802281159550.22527@racer.site>
	 <200803052221.12495.johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0803052317350.15786@racer.site>
	 <7vir00lski.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0803052327570.15786@racer.site>
	 <alpine.LSU.1.00.0803060212170.15786@racer.site>
	 <20080306063331.GA7325@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 10:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXC1X-0008PR-AU
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 10:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbYCFJDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 04:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756513AbYCFJDg
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 04:03:36 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:14421 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbYCFJDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 04:03:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1190978rvb.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E69wbwLmrxa0hdOKf2f8rx+FC/bw5Wl6cqE58T1S+ms=;
        b=LK92ifJSA0rnWlrNzI3HMhItLMhyrQxRgcwyVo+PGbgx/pcuvpAvpHFiLa1bisbfoi3Jf4FQ9TMU+HY/R7B+2Gxgg+/qQMPfXZCBzpgSChYa4Ct6g+kTyyt9vjYAtuZOIkjuiVtRhKEfl/IhAcYcmTt/ISDrIl706H6ycHkQ1kI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0BgjLKnQ1gUsaZo0pAHtodCNSDyU3BwOoO8vS7hKhk4IVtkqz3s5VGltPZBzSFo7vEnJVXooz/tSJqafsd+sUIWKXn4GFi49wwl8dOBdpYrktWuyke+90LVrnsLB2bIQbxAjIVJBsuMWsYqkXebQMvVHaqyFNlOs+7ScLfJ5Zs=
Received: by 10.141.20.7 with SMTP id x7mr474853rvi.34.1204794211300;
        Thu, 06 Mar 2008 01:03:31 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Thu, 6 Mar 2008 01:03:31 -0800 (PST)
In-Reply-To: <20080306063331.GA7325@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76356>

On 06/03/2008, Mike Hommey <mh@glandium.org> wrote:
> On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
>  >
>  > The most common use of addf() was to init a strbuf and addf() right away.
>  > Since it is so common, it makes sense to have a function strbuf_initf()
>  > to wrap both calls into one.
>  >
>  > Unfortunately, C (and cpp) has no way to make this easy without code
>  > duplication, as we need to va_init() in strbuf_addf() possibly a few
>  > times.  So the code for addf() is copied.  Fortunately, the code is
>  > pretty short, so not too much had to be copied as-is.
>
>
> The problem with code duplication is not about code size, but more about
>  not forgetting to fix bugs in all incarnations of the duplicated code.
>
>  Is it so ugly to use a macro ?

Why not have a strbuf_vaddf and strbuf_vinitf that take a va_arg as a
parameter. This would mean that you don't have code duplication, and
it is flexible enough if you want to add more customisations in the
future. No macro needed. This is what the printf/scanf family of
functions do.

- Reece
