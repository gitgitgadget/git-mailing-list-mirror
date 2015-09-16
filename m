From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Wed, 16 Sep 2015 15:34:32 -0700
Message-ID: <xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
	<1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLHi-0008Mv-L9
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbbIPWef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:34:35 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33154 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbIPWee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:34:34 -0400
Received: by pacex6 with SMTP id ex6so662868pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X9ocSPNBuv+CHhuDquk2t3MeUBxVurBHyXqYKhXQ59Y=;
        b=Ne6BBy4mGuKluRiB78alZbjELP43UxHcSQQUnQowIxdVry1UO+/fmJNF15gnHRGvxk
         C1mFqPsPSt42Zg4bXY+qvZYefDgRRkvUVvaEFsVYh1TiSL5wuEPtOBBjq5ifQSQTjOk6
         GwtB2vWZPbPGKszv7jSGxNbWRIHc2haWfTflVknBq3d6kIdEckgUOo5t3NH3IRGkzepY
         +01LP+uDLEzCzduQ1QRG1V7RWNTxepOBgMVaZoSES+x+RGK1accCNgBWG6vzTucev5I+
         odu9Dfpdw+q5ut4ZoMZy4niz8gBGOBQFtxr4hTyJC87rbN8+E35kPOvohbwWJiE5o5r3
         pyEw==
X-Received: by 10.66.193.132 with SMTP id ho4mr66268063pac.154.1442442874377;
        Wed, 16 Sep 2015 15:34:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id z6sm136061pbt.51.2015.09.16.15.34.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 15:34:33 -0700 (PDT)
In-Reply-To: <1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Wed, 16 Sep 2015 15:06:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278081>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The documentation for --refs says that it will treat unqualified refs as
> under refs/notes. Current behavior is to prefix refs/notes to all
> strings that do not start with refs/notes or notes/, resulting in
> performing actions on refs such as "refs/notes/refs/foo/bar" instead of
> attempting to perform actions on "refs/foo/bar".

That actually sounds like a sensible thing to do, if you replace
'foo' with 'heads', for example, i.e. refs/notes/refs/heads/bar is a
notes about commits reachable from the branch whose name is 'bar'.

So given "refs/heads/bar", which is unqualified in the context of
talking about references that hold notes trees, the current
behaviour to turn it into "refs/notes/refs/heads/bar" is very
sensible, I would think.
