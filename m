From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 12:23:07 +0530
Message-ID: <CALkWK0mpVbHtEPS5d4FA8wjsF6L0bncUeJnOJccPSYwgM_v-rg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com> <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 08:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO0XR-0005hv-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 08:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481Ab3DEGxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 02:53:49 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44445 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3DEGxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 02:53:48 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so3885363iea.40
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zmYeLvFVH24X0sfF/qxeR1+NS2OQGtlsPA4p42eig4A=;
        b=zm8dhnM87jbsCTLzOhGIdsDVen4bkL6D12bAeHs3esENa2yZEdBp1YEJabJZiOgo6C
         JR6r0A2fxM6pomIc6SjJwRLo7nUQqp3DZl4256TiWx2vkI9W0qiQygqp68ys0aGFqlVl
         dT6zhyKyE75oUJaqBx1Y2RQQ/obfAyD2Ilr+bDLS4prPRcjyhepr9TiIAE3RB57qktoK
         dcPVGiigGGhMOUAAKee/hMCAaYrzz2K+/4WRymz7XwZDzXbS5xWLfFTIrrEtW75Icz5F
         Dr030taestZu5Unzfhqdqn/3rckv60HXgzmjNuAKpuYaErpGTyw6JoJvROoY/RLa1Vpb
         tG0w==
X-Received: by 10.50.117.3 with SMTP id ka3mr383737igb.107.1365144828154; Thu,
 04 Apr 2013 23:53:48 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 4 Apr 2013 23:53:07 -0700 (PDT)
In-Reply-To: <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220150>

Ramkumar Ramachandra wrote:
> After some discussion, I hope to be able to finalize a list of fields
> that will suffice for (nearly) everything.

The task is actually much easier than this.  All we have to do is
finalize the list of fields that will mandatorily be written to the
link object.  As I might have indicated in my series, this is:
upstream_url, checkout_rev, and ref_name.  Really, the user only needs
to supply a valid upstream_url: after a clone, everything else can be
inferred (with the exception of a ref_name conflict; I don't like
auto-mangling).

Other fields are like .git/config fields.  We can add new key/value
pairs in the future, without worrying about migration.  A problem
arises only if we want to add a new mandatory field, change the
default value of a key, or deprecate an existing key/value pair.
