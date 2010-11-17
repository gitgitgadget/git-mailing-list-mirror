From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Wed, 17 Nov 2010 16:33:56 +0700
Message-ID: <AANLkTinOFZ=qbCeeUmN7FcPFJT=SZqXEMsuof98ZW-Wh@mail.gmail.com>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
 <20101116112406.GA18259@do> <AANLkTikeaj6kfq+pv+F0mOUSC7yJKnwyUgy9k8GPTpxg@mail.gmail.com>
 <vpqtyjgxrqk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 17 10:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIePM-0005Zh-Np
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 10:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934667Ab0KQJeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 04:34:22 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39527 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934588Ab0KQJeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 04:34:21 -0500
Received: by wwa36 with SMTP id 36so1787229wwa.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=YETY77ogtVMwdj1087kKFHbwngk7G3o254x+Mceqmlk=;
        b=XpHGnFU9DFw4vNwGL0yRoyHI7lKNGANvIT7rIGW0WriADtRYbmPBFKx2DmXSVI+W2X
         bOGb1kS0yK7CA7tjfV/QNZ22TGpF+PM/SwOxwQvpAo1B3C6UZKZFm0we6NeDG+/I+Ob+
         F2PcFrkaGVuXhnS6q3j5QNMRkCzgrBp0o2OcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=co36jCUU7eGxmS7GKq30bejqbA6UUOUg7SG2GHc+sWmmE5f8TeIrfNnfgMppOVKQCW
         9mP/lotu7kgm+lkdOLCVdIpivaXLZQTG8B0dXNr+43q1ERnXD7Fgo/lUj/CUyh0SIx7Z
         SSdFZ6m2dt8Vk1JGWRoolwoKkGGpTgNHVgsks=
Received: by 10.216.255.148 with SMTP id j20mr7786344wes.11.1289986459229;
 Wed, 17 Nov 2010 01:34:19 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 17 Nov 2010 01:33:56 -0800 (PST)
In-Reply-To: <vpqtyjgxrqk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161606>

On Wed, Nov 17, 2010 at 3:46 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> Even better, do a file size check here. If it's not equal, there's no
>> point in calling the expensive index_path().
>
> I think you also need to check mode changes here.

Hmm.. ce_compare_data() does the same thing as identical_content() and
will be called by ie_match_stat() in racy condition. I think we should
add another flag to ie_match_stat() and let it call ce_compare_data(),
instead of creating a new function identical_content().

ie_match_stat() does check mode changes and other stuff so if it
returns 0 (with ce_compare_data() called), it's safe.
-- 
Duy
