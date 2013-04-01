From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] send-email: use "return;" not "return undef;" on
 error codepaths
Date: Mon, 1 Apr 2013 00:08:15 -0400
Message-ID: <CAPig+cTzre7D93TOv9CV_qhX6hnxSmj_zL+mewKE5c9kaP+-Pg@mail.gmail.com>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
	<1364780442-6015-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 06:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMW34-0003RN-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 06:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab3DAEIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 00:08:19 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:52931 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3DAEIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 00:08:17 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so1823113lab.9
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 21:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=VaPnt+wC05nECPijsrQoXe5EV3jh5ix7okmx6WM8uLM=;
        b=O+CJVAhpDeZzpBuBjhhqK+tA6GmRHY+UjGpm6MM5AyZST87H9RZeJ3TzVz70B7iGci
         gFqvlBVkc/xBj61aXoZ9MqUt1M9X4suDKjdwb5hwsU1DdQMrREqO+3YJqW5c23DxGNiB
         qzqFiqVAyB7btT9l8bJfhibtQK3VabbO5XBgCWKJ+rY+S7GmacEfPC1RGN8dHhSedIvP
         R3Z4KDa7JpPGWwFPou/hiMWDSFxDQCPqdzwcQ3R9NPNytZOG87n86NhJAUdMGL18IfXD
         9eLDH1S/l0w2wofFP61z6VfHZAtxOLBKRahhpABGriMbccC6b7a0GgcvRC49wUH6kmG6
         qtkw==
X-Received: by 10.112.162.65 with SMTP id xy1mr4900384lbb.105.1364789295951;
 Sun, 31 Mar 2013 21:08:15 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 31 Mar 2013 21:08:15 -0700 (PDT)
In-Reply-To: <1364780442-6015-1-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: cLH8ttz9VR6SPC0EZLoIF9KSOpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219666>

On Sun, Mar 31, 2013 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> All the callers of "ask", "extract_valid_address", and "validate_patch"
> subroutines assign the return values from them to a single scaler:

s/scaler/scalar/g

(note the /g)

>
>         $var = subr(...);
>
> and "return undef;" in these subroutine can safely be turned into a
> simpler "return;".  Doing so will also future-proof a new caller that
> mistakenly does this:
>
>     @foo = ask(...);
>     if (@foo) { ... we got an answer ... } else { ... we did not ... }
>
> Note that we leave "return undef;" in validate_address on purpose,
> even though Perlcritic may complain.  The primary "return" site of
> the function returns whatever is in the scaler variable $address, so
> it is pointless to change only the other "return undef;" to "return".
> The caller must be prepared to see an array with a single undef as
> the return value from this subroutine anyway.
