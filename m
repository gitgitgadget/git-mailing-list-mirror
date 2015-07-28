From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 01/11] ref-filter: add "%(objectname:size=X)" option
Date: Tue, 28 Jul 2015 08:43:38 -0700
Message-ID: <xmqqzj2gffth.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK72h-00005D-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbbG1Pnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:43:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36681 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbbG1Pnl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:43:41 -0400
Received: by pachj5 with SMTP id hj5so71651269pac.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5lH9xYgZd0npo1anizjJQBdBtwib19vTPDq3cik84wI=;
        b=qIq7DZLA3g2S7Pj3fbI85h+mA17yVrglNukYhyZiWSrNXcOnWqa5ydTBMsE7hPx0+i
         4I1pcXdE+Zx8/ZDx4yQTd+fVHMsmfw35ZbBnguZ56/TVZ1AHW/rn5nBLml0y+nOz/5Rp
         y1EtpyjmPu37OUd29ncHQdo2zC971LqiIl590MyCtaLc36spRMwK5CEsye6dd6b7bcnO
         trwR/Zh0BZEl3rJEpEDLmQEcg2l49sf/MIgJ31pCv2lVxjv0BrLDGDeu1XGt3ZeOz5IE
         mT5kZILbuaWVYj9O+WcdxogexLc0gPRvFqgSVjmVptyOGIum5mI9OIs04n8BqoLrJxTY
         JM3A==
X-Received: by 10.66.65.205 with SMTP id z13mr82217544pas.65.1438098220982;
        Tue, 28 Jul 2015 08:43:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id qo6sm36106411pab.23.2015.07.28.08.43.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 08:43:39 -0700 (PDT)
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274777>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add support for %(objectname:size=X) where X is a number.
> This will print the first X characters of an objectname.
> The minimum value for X is 5. Hence any value lesser than
> 5 will default to 5 characters.

Is the reason why you do not call this "abbrev" because you are
allowing it to truncate to a non-unique prefix?

If so, wouldn't it make more sense to treat this kind of string
function in a way very similar to your earlier "padright"?  I.e.
"%(maxwidth:5)%(objectname)" or something?

If not, and if this is really an abbrev, then it makes sense to make
it specific to the objectname, e.g. "%(objectname:abbrev=7)".
