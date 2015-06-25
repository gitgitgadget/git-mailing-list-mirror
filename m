From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 10:32:36 -0700
Message-ID: <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 19:32:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8B13-0000rG-1y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 19:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbFYRcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 13:32:41 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33510 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbFYRcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 13:32:39 -0400
Received: by igbqq3 with SMTP id qq3so20076196igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L2NOPibp4ox/3+UsY0DkSKJ3woqcI/k8+cvT+B2pEXA=;
        b=p/tNKzTZdplAXPmlV7Yj8qGzgNJMtWzLgo69JvH6iNM/aXGzhFYcB4G50I/axWHOb8
         sE4GodpiUXzW5N8pfPg2fRUZtTLpiKAnSWIv+nq6QREhnR1Fcoyf9cS5whHenfzTnKZw
         9sBjeu0oCKIDfF1PENlAzzygVdhO0BGYrqW4TQOQylH+bJCyiApyNeF2n3RX9kNG2qTk
         vTzNqvNk4RYngU/Wr7Mtr/58Vfo0xbkE4dOR4tKaqY3SjLpN37FUPSxNL7Mennx4Cy+J
         /SPVzJ+OlW4KN3h8G+1tNcwD+GkemP4ETPPccbkYmU2bWpX7eKNqpta/lL1kh3Fgfevl
         XNTg==
X-Received: by 10.107.137.42 with SMTP id l42mr59664796iod.60.1435253558922;
        Thu, 25 Jun 2015 10:32:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id t7sm3732711ign.8.2015.06.25.10.32.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 10:32:38 -0700 (PDT)
In-Reply-To: <20150625155128.C3E9738005C@gemini.denx.de> (Wolfgang Denk's
	message of "Thu, 25 Jun 2015 17:51:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272703>

Wolfgang Denk <wd@denx.de> writes:

> it turns out that recent versions of git (i. e. git version 2.2.0 or
> later, resp. anything which includes commit 4d0d8975 "Make sure
> fsck_commit_buffer() does not run out of the buffer") throws errors on
> our git repository  git://git.denx.de/u-boot:
>
> -> git fsck --full
> Checking object directories: 100% (256/256), done.
> error in tag eb394f56db3e05d00891d6dc36a00df0025cf255: unterminated header
> error in tag 9bf86baaa3b35b25baa2d664e2f7f6cafad689ee: unterminated header
> error in tag c7071e6d645a8e13adb0d4cea2caad27213fa62f: unterminated header
> Checking objects: 100% (328644/328644), done.
> Checking connectivity: 325719, done.
>
> Apparently for some reason the tags  LABEL_2006_03_12_0025,
> LABEL_2006_04_18_1106, and LABEL_2006_05_19_1133 are missing newlines,
> which was undetected so far, but now is raised as an error.
>
> Question is: how can we fix that?

It could be that 4d0d8975 is buggy and barking at a non breakage.

If there is no message in the tag, i.e.

    -- 8< --
    object 84ef51a632063e8cb57b2e9a4252497512831ffe
    type commit
    tag LABEL_2006_03_12_0025
    tagger Wolfgang Denk <wd@pollux.denx.de> 1142119613 +0100
    -- >8 --

I do not offhand see why we want to require that there is a lone
blank line at the end.

Dscho?  What do you think?
