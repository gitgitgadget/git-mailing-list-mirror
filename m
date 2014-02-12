From: Stefan Zager <szager@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:15:26 -0800
Message-ID: <CAHOQ7J-uHmUgepV+0rDkUgHSQzXJHME2yd8ZOz3bPy0x8k_ejA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<robbat2-20140212T015847-248245854Z@orbis-terrarum.net>
	<CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeLP-00043a-2i
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbaBLSP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:15:28 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:59102 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbaBLSP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:15:27 -0500
Received: by mail-ve0-f179.google.com with SMTP id jx11so7516161veb.24
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R/VmM+sINgG1myC9ViJ1wSur5KnZ4289shxUMLpDUmM=;
        b=cFbuki3K78BNajAEzGM8g/elhxGQ3Wt1VeSSTbi7tzGQM0wkCEjmI95Vtu7Z5F9pYn
         +ZQJZSyrcaMCCwEF41O1Jg1FIYMSjot9sRLO4E3Yxpcm0K3sCpbo2OiTKgfW+aJ+jlrs
         FBim/S8B349lCY6pO7DXq0xyRtdIewFaEDyBqdIQYCCB385V2leJDY1I9dZTkbhpKv/v
         9F2GIxYqqkYqcBEievlCjSFpI5TM2wkl9qlcNUuKv2Ny3ClnPpcJakCzv6Jf3WQTCzle
         2jk0AvhdZVjCSPTdETPcXdM9xs0kHZ/Qn9yQakhIIPWkieRNMfyWa1onT3x4pUNG1IIE
         Wz5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=R/VmM+sINgG1myC9ViJ1wSur5KnZ4289shxUMLpDUmM=;
        b=OE1D5DCTJ998W4Afqb58K+nskGuGff4FOzLD0zmZE1uUSqc2aP/YgHWShwRQxEQIZj
         dXEZczEy+PGdm6f0zqjqEeYtpnWaSRCRka0nbbcBTqzeROSvOJBNsgt9aY6GIHIPVv7+
         Sf7BH7JWhNagdL0gZB/b3iSk6mFKJ/TUKlsz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=R/VmM+sINgG1myC9ViJ1wSur5KnZ4289shxUMLpDUmM=;
        b=ELdL/0sl427mqow+UfMoHJAmQ8WCqpfA0f5IYZWZciGdKOVm1H0XMVQJLHOJ5S6Kcw
         zgto43JvgVO7jthGUtP81TFON5il2J/ag8Q2BdsOU00Km9w6GU4R9b5FNYqtUcg5NtRw
         mzQ3u7N2K2XApbKLThp2JSGAPMxh/fVrQ6UVPfJi8+hzPSqncWYVVPK1IEfyDkkTEl6W
         /KwRU4Q0Eh2Cun7JP7Pjk7ww8Kkztiww0rVtqx08WoeQurgzjxbZ/reJjSKjzV+4sda0
         AvvryvDBaRV7JwJmA0ENDQLnCnd39/vablDbGKqK2o9BEH4cuS27shOnpc3Ag24gyl4c
         JeHg==
X-Gm-Message-State: ALoCoQkx84lMvzS7pJ3cfDHQSxmDKUXMnIwqRZul1rea6dQbIBZnRc49A3HI5uWiJ/tX+LxwOhmMbZTpHQoFhPCgPTAoRT47vXB52CQ9Bo335miGENF3EHCyVnQqt2hiq048mi2yFhaGFOw9vodexUpYykWKeYuA1OOwtEddh8oIArQbWUMQcPNfamKfnIWF13oiWLrxUCzs
X-Received: by 10.58.118.233 with SMTP id kp9mr255278veb.52.1392228926406;
 Wed, 12 Feb 2014 10:15:26 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:15:26 -0800 (PST)
In-Reply-To: <CACsJy8AStrZBtSqRiwBtonfW5y0ar=9Z371fE2Krwj=P-w7ERw@mail.gmail.com>
X-Google-Sender-Auth: ilO0PhoEsu-vgc1z8ah2bSxNcds
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242001>

On Tue, Feb 11, 2014 at 7:43 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> From v1.9 shallow clone should work for all push/pull/clone... so
> history depth does not matter (on the client side). As for
> gentoo-x86's large worktree, using index v4 and avoid full-tree
> operations (e.g. "status .", not "status"..) should make all
> operations reasonably fast. I plan to make "status" fast even without
> path limiting with the help of inotify, but that's not going to be
> finished soon. Did I miss anything else?

Chromium developers frequently want to run status over their entire
checkout, and a lot of them run 'git commit -a'.  We want to do
everything possible to speed this up.
