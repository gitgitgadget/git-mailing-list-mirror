From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 10:28:52 -0700
Message-ID: <xmqqlhce420b.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:29:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5ed-0002Fe-Om
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbbIJR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:28:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36193 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbIJR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:28:55 -0400
Received: by padhk3 with SMTP id hk3so48472906pad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7mOM6uPV10iuc6HennMb8z1E7GsffQZwY4gSCfu3iTQ=;
        b=bLnJYDf2W3kHLJC7MGnnf+RCk63NqKXlKE+fO/13orfhm4Ta6dw7bPPKv/p9RN2NJ6
         mZc2mw6AO1f8RtaCaVZJneWvXxvNNeF4o9M+w7o9iZWd0YSO6UBQh8IzyOo6hsCEnfum
         HYJZmeNO80g92ER5G2zsQo+P8mIQNfLb/yTw62vHIQhA6JekBp3Gr+SCWjJKiAaItrOr
         NP+WcS9DlAivTnGrhnYQV94enJagt/KE3l38tNRQxAoSe5CgaMZgccpBHO5kuWFTTfjy
         iszM6Zg/1MyhvgEa8ybJGrNi44Kr2lH1GYLcfiBf1ojC/8+ui/swW14t/xkhxJ51oNR/
         23Lg==
X-Received: by 10.68.108.67 with SMTP id hi3mr28763434pbb.36.1441906134450;
        Thu, 10 Sep 2015 10:28:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id ey3sm13142214pbd.28.2015.09.10.10.28.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 10:28:53 -0700 (PDT)
In-Reply-To: <CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 10 Sep 2015 22:30:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277610>

Karthik Nayak <karthik.188@gmail.com> writes:

> The check was for checking if there is anything after the colon,

Why do you even care?  If %(color) expects more specific
customization by adding colon followed by specific data after it,
i.e. %(color:something), %(color:) should clearly be that "%(color)"
thing with no customization---if it is "not enough customization" or
"leaving everything default" depends on each atom, match_atom_name()
is not a good place to make that policy decision (i.e. Mattheiu's
rewrite to clear *valp to NULL when %(color:) is seen).  Instead,
point *val to body + 1 just as usual, and let the caller tell
between *val being NULL (not even any colon) and *val pointing at a
NUL byte (nothing after colon) if it cares.
