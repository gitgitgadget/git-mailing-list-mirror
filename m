From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test for '!' handling in rev-parse's named commits
Date: Wed, 03 Jun 2015 14:52:54 -0700
Message-ID: <xmqqbngwwjbd.fsf@gitster.dls.corp.google.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
	<1433364854-30088-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:53:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Gar-0005dM-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbbFCVw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 17:52:59 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35721 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbFCVw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 17:52:56 -0400
Received: by igbyr2 with SMTP id yr2so124350009igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=O3ItMg21QoTlfp3g8GheAKf7LGiJNB5Oynk6pMPBD/U=;
        b=Hty5BwCUcgm5Q8SOwhSWp/RVlXEZv+F7ngRJYhNiKDIvvXOGrbcg+VlUuRt8CcdDHs
         +ddWf2uiIl+2EQlyaY96nZW32fQNBZbNyjYwHfTK+AHbi2bM78uldKDhacgy+1tqAOis
         GdnCr3foeCZUjZG/KXAJ2x805JTQJWPU4BBOykxf/dEQM5gSjI2mWsmim3/D544PBw/b
         lRHuPmR7q8vh9G1U/wtZOYPNkn+pJIRi8PBYnHIGIu9eTA825qtlpFooLOzo3/ImIg7/
         HS9J2/o+TOnvbGpub0jIJwCo955kVxmAkr6MRCCv4Ng2GRQVJYcH8RixwsZPv1uCYScP
         H2hg==
X-Received: by 10.50.111.131 with SMTP id ii3mr29617288igb.47.1433368375881;
        Wed, 03 Jun 2015 14:52:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id 140sm48782ion.16.2015.06.03.14.52.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 14:52:55 -0700 (PDT)
In-Reply-To: <1433364854-30088-2-git-send-email-wmpalmer@gmail.com> (Will
	Palmer's message of "Wed, 3 Jun 2015 21:54:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270741>

Will Palmer <wmpalmer@gmail.com> writes:

> Specifically, as documented: '^{/!Message}' should fail, as this syntax
> is currently reserved; while '^{!!Message}' should search for a commit
> whose message contains the string "!Message".

The /! sequence being reserved does not mean it was planned to be
used only for a single thing in the future, though.

Think of it as a syntax to introduce extended features, the first
use of which was this:

	/!!string	-> find commit with "!string"

The above is just one "feature" that the reserved syntax allows,
namely, "to find a string that begins with an exclamation mark".
The anticipation is to use another feature introducer after "/!" to
enhance the matching, so that we can keep enhancing the syntax.

cf. http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477

Using "/!Message" to match commits that do not match Message
directly goes against that extensivility design.

We need to always remind ourselves that our latest shiny new toy
will not be the final new feature.  There always will be need to add
yet another new thing, and we need to keep the door open for them.

Perhaps

	/!-string	-> find commit without "string"

or something?
