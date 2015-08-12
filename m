From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 12:09:22 -0700
Message-ID: <xmqqa8twl3x9.fsf@gitster.dls.corp.google.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
	<xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
	<CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbOz-0007RK-9W
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbbHLTJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:09:25 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35347 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbHLTJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:09:24 -0400
Received: by pacgr6 with SMTP id gr6so20298662pac.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LC1of3S2BRmn/X/brvF04JL3x5vI8+/4hSzN0nhoptQ=;
        b=EwBYvirriCmZCaqdyQLfNDCk7Iuhts+djrwLyZVh/GVLvl+wzpdTSznkSvc/C8uvlm
         f3EVkDrzewfNulMxrRW8pstAhW52g6Egt6QjTkRd50OY922wcMEx8f4QhqucqeX4Yys5
         CrCHXh0zGXnYnQ8nBY6pm8/FcSqjg3y3NWPs1y1cKTW1lEWG2RPU0NARlU+1gegB9hvY
         HoA+DBKX2VJgCf6KSMpRDX73NRxhufdoM77i6YSnJNxDkdIn2eEKrFdZ4rLsJ24VeqTC
         e5d6LwA+vkIDuzzxEu1Bb82kV5nbglbRjbU0iBlsEJzLGChgD/Ta2bqhmzZG8hiqd9cK
         VFqA==
X-Received: by 10.68.69.34 with SMTP id b2mr69414233pbu.119.1439406564380;
        Wed, 12 Aug 2015 12:09:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id u16sm7339953pdl.71.2015.08.12.12.09.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:09:23 -0700 (PDT)
In-Reply-To: <CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
	(Jacob Keller's message of "Wed, 12 Aug 2015 12:05:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275798>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Aug 11, 2015 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> I know that we don't yet have a "proper" place to put remote notes refs,
>>> but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
>>> use the <localref> notation in the documentation below). Thus, I believe
>>> we can presume that the local notes ref must live under refs/notes/*,
>>> and hence drop the "refs/notes/" prefix from the config key (just like
>>> branch.<name>.* can presume that <name> lives under refs/heads/*).
>>
>> I am OK going in that direction, as long as we promise that "notes
>> merge" will forever refuse to work on --notes=$ref where $ref does
>> not begin with refs/notes/.
>
> It appears that notes merge already allows operating on refs not in "refs/notes"

If that is the case, then the only sane choice left to us is to
accept only fully qualified refname, e.g. refs/notes/commit, in
notes.<ref>.mergestrategy, without shortening, I would think.
