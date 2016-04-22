From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Fri, 22 Apr 2016 09:55:09 +0200
Message-ID: <CAHGBnuN_Tck3TY0DO38HpXLbe5mew-76Y0okaxmJtGEGs2g04A@mail.gmail.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
	<1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
	<xmqq60vcuh9v.fsf@gitster.mtv.corp.google.com>
	<780ED4D6-AD96-4BAF-A522-C724C3938EED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, luke@diamand.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 09:55:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atVvr-0000Kc-Mm
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 09:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcDVHzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 03:55:13 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33745 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbcDVHzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 03:55:10 -0400
Received: by mail-vk0-f54.google.com with SMTP id n62so126678033vkb.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FQwww5FaIOJE0R0ps9UrgK7ZdM5gEJgweK2u2PX8GQw=;
        b=ZDNex5Nx6m+QaTOdkHawSklVU0sZyRj9Kkiw4Uf7x89jBxsdmk3YJuJchc2K4rVRRf
         ulP7YtHAXGYHr653VGLBR/5FoN9EPROj9hJu5oDcoxBTrHcj+OYP+qg84MqoUAcuaMx4
         S4ehvVXKuaeHi6m+hms2AsR9Px47IFzailnBxxpm6HxRxavmX9bqzX7g35N9FlpSw8wQ
         zUUl1/aV/CJSPzP6Q+q5s0CS4R6GvGWf8Hc2hKGAs5edZ0b8LL9HNsp1BHIhxnD0i3Rr
         Ijyf/gffXzNwgFUcuwTf2fzltHjVmO0m/tovv1gyJrcoAranubNp9Ncgpp3Ln8JheEF5
         OwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FQwww5FaIOJE0R0ps9UrgK7ZdM5gEJgweK2u2PX8GQw=;
        b=A3izQ7RRurfDbUgqMd46cGSKKwU3cW/BRbtF0GAPBPGD6JIqYEHVFFsXmUr1mRdiR+
         lSESKdZ780vsktJAoLURly+6OUFdmzLFlKZZQFI5XY6TBqSPE/eHJ4GTxR10QUWOrYrx
         Uahr4d5sHqPeZyDVAV2XiFZOpeWxdkxOt+WvQ04zxjUD5DLvrMT7X5ig5NN63RBj5kAT
         rqxrr1gC50AEeImkIqNIMG4wtc5NfQwR/Rtq4id73xbhJt3Q0fLYJtM/4EANgOGUFQg5
         cwHKlahqPVrugQkoD92I4wFNvAS6EIIW3tqfjbAFl1n7wskU7F6IiRYsJ/4NmWvlJDWe
         Hlwg==
X-Gm-Message-State: AOPr4FWD15R2aq5Llvq46Di5gE6hsCVj599TmJMJomuJjZxuXJ1qDSaZ/VuFpH8c0CkOxvhWBDZ6pclWOgeZ0w==
X-Received: by 10.159.37.245 with SMTP id 108mr9867272uaf.140.1461311709270;
 Fri, 22 Apr 2016 00:55:09 -0700 (PDT)
Received: by 10.176.5.2 with HTTP; Fri, 22 Apr 2016 00:55:09 -0700 (PDT)
In-Reply-To: <780ED4D6-AD96-4BAF-A522-C724C3938EED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292178>

On Fri, Apr 22, 2016 at 9:53 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:

> What would be the best way forward? A v3 with a better commit message
> mentioning the array -> string change?

I'd vote for that, yes. Also v3 could then properly incorporate my regexp.

-- 
Sebastian Schuberth
