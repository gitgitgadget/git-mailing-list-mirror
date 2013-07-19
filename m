From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Fri, 19 Jul 2013 19:37:28 +0200
Message-ID: <87vc46lacn.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com> <87ehb0cgqt.fsf@gmail.com> <CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com> <87oba1siz6.fsf@gmail.com> <7v7ggo68o9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 19:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Ecl-0004gN-DR
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 19:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982Ab3GSRhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 13:37:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58813 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759814Ab3GSRhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 13:37:42 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so4529629pdj.14
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=CIBE6PAFqXSvdxVaVwufq5qEdGtSvTOx5sQFcZvWtn8=;
        b=P/mHPa4JhmQlBfGXq8rqK5l+PDM07nsVfTbpZKgvZrhJxIepbBA7qd1CrKFSyFPnVG
         vnqcroQqAndPaIwFgfdbp3GVrPll/nYt+BglaNW9cKaMDZn2Tde29aHn3voNtxk6z76n
         h3zyDN4wW7PxC++LpDSf7Xp/4lmMgIMt/xf8jECRoFyptiwM+BCoLLOCi75kNS5lzE30
         ZIZ0VAja1OIxsfaoqehqhIrOsF+pMlcy2zNLo1LHtsA/tCRHDHkio+OsnHe21ngisaJ7
         +EHFrGWyrjRIvEisTNZBmlsGo2Yg5t0tLK0U9oFbnxcxFxNljFmuXJKQGhb2sMSjcQ1H
         bg8A==
X-Received: by 10.66.246.194 with SMTP id xy2mr19417756pac.131.1374255462099;
        Fri, 19 Jul 2013 10:37:42 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id iq3sm20700992pbb.20.2013.07.19.10.37.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 10:37:41 -0700 (PDT)
In-Reply-To: <7v7ggo68o9.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230832>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> Ah ok, I understand.  I think it's best to add a GIT_INDEX_VERSION=x
>> config option to config.mak, where x is the index version that should be
>> tested.
>
> Whatever you do, please do not call it GIT_INDEX_VERSION _if_ it is
> only to be used while testing.  Have string "TEST" somewhere in the
> name, and make t/test-lib-functions.sh take notice.
>
> Currently, the way for the user to show the preference as to which
> index version to use is to explicitly set the version once, and then
> we will (try to) propagate it inside the repository.
>
> I would not mind if we add a mechanism to make write_index() notice
> the environment variable GIT_INDEX_VERSION and write the index in
> that version.  But that is conceptually very different from whatever
> you give "make VARIABLE=blah" from the command line when building
> Git (or set in config.mak which amounts to the same thing).

What I currently did is add a environment variable GIT_INDEX_VERSION
that is used only if there is no index yet, to make sure existing
repositories aren't affected and still have to be converted explicitly
by using git update-index.

For the tests I simply did export GIT_INDEX_VERSION in test-lib.sh to
allow the addition of GIT_INDEX_VERSION in config.mak.  Should I rename
that to GIT_INDEX_VERSION_TEST and do something like

set_index_version() {
        export GIT_INDEX_VERSION=$GIT_INDEX_VERSION_TEST
}

in test-lib-functions.sh instead, does that make sense?
