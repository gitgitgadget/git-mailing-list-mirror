From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Check return value of ftruncate call in http.c. Remove 
	possible mem leak
Date: Mon, 10 Aug 2009 23:47:20 +0800
Message-ID: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
References: <1249911747-28490-1-git-send-email-jeff.lasslett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff Lasslett <jeff.lasslett@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaX6d-0007zZ-RN
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbZHJPr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZHJPr0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:47:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:41821 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbZHJPrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 11:47:25 -0400
Received: by ywh31 with SMTP id 31so3993979ywh.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lhL4TT83DwTH7eUjB+WV1enqVQZ+FqGj1IAJM4wJrFY=;
        b=Rq7SorQvYMehnmVbZue6lmlyr/Fz+iws1jyx5eZ9u5dIwW4m80MRnZz45sXHGmW7xg
         NslA1KqqNgM/YeiYRMnbT6JR4B2a3Lm2o5XNbl1M7LaLHo1RYqVRyB/Aiy0h339YR/fV
         TpAj0py3dS0udmP4OZjO83+NU4LVFStN1yH5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pKSpYMo2pWa/32FCxTaadzvVOwDHu1POAh+bvb8ImWficsUvvSMwXkNci10An7s6vu
         1ALCS1fQvnCyZwSevD1yTD/LQ6LXw/k931d9FfpCsKN6CJOc0s/4IfWVsM3EjMCu516Z
         EZZurUSKj5tk0niHFv90fEoM2dPuYixX5PfQ0=
Received: by 10.231.11.136 with SMTP id t8mr1567604ibt.50.1249919240243; Mon, 
	10 Aug 2009 08:47:20 -0700 (PDT)
In-Reply-To: <1249911747-28490-1-git-send-email-jeff.lasslett@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125467>

Hi,

On Mon, Aug 10, 2009 at 9:42 PM, Jeff Lasslett<jeff.lasslett@gmail.com>=
 wrote:
> @@ -1216,10 +1220,12 @@ struct http_object_request *new_http_object_r=
equest(const char *base_url,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CURLO=
PT_HTTPHEADER, range_header);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 free(url);
> =A0 =A0 =A0 =A0return freq;
>
> - =A0 =A0 =A0 free(url);

=46reeing after the return didn't make sense. Thanks for spotting this.

On a side note, you could simply do away with the 'url' variable,
since you're going to pass freq->url to curl_setopt.

--=20
Cheers,
Ray Chuan
