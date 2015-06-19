From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/19] Introduce an internal API to interact with the fsck machinery
Date: Fri, 19 Jun 2015 10:33:50 -0700
Message-ID: <xmqqfv5na9hd.fsf@gitster.dls.corp.google.com>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
	<cover.1434657920.git.johannes.schindelin@gmx.de>
	<xmqq8ubgd5vt.fsf@gitster.dls.corp.google.com>
	<e3f2c023e59c3608ebbb7e88a6f18d27@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60Aw-0001Wk-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbFSRdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:33:55 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35612 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFSRdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:33:53 -0400
Received: by iefd2 with SMTP id d2so22796775ief.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=W04YPt9S4kh7iaqfbyvEz6NRsziiIwtZ+mtJ8+/GVHw=;
        b=qfO4W11mV0hlHznWX7ezUWwqYaAnJyRPZuVfxYBMvHS6rhZNKi/75iZpWNRMkuT4MA
         1f/9ZtxdfgTr459coVG5Gqt6HT00FipWYFW5dohDQRceLxsCR6jGUvXxfdWC3b4sfZwW
         Wf0e1J4ydj5nPElB8GDsjqVkl3oQgDkvZz3buOuY+hR1cFLJCq4BXQgpaZcCX5IvFhO0
         Dsg9vdIJGq66wRvXlfNk/4ree3KWBD8OVf/h+/QD/NRWQL6pzHoExHsczbh4796VO+eM
         4POWpTND8bLXMELH4YGWYmmj+MthsElReCrz9NsijJJiizFtsNRJcZxxiYLhV07Gr9Cy
         XqQA==
X-Received: by 10.50.64.243 with SMTP id r19mr6030961igs.5.1434735232570;
        Fri, 19 Jun 2015 10:33:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id p196sm7439870iop.15.2015.06.19.10.33.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 10:33:51 -0700 (PDT)
In-Reply-To: <e3f2c023e59c3608ebbb7e88a6f18d27@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 19 Jun 2015 02:04:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272171>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> I basically made up names on the go, based on the messages.
>
>> Some of the questionable groups are:
>> 
>>     BAD_DATE DATE_OVERFLOW
>
> I guess it should be BAD_DATE_OVERFLOW to be more consistent?

I am not sure about "consistency", but surely a common prefix would
help readers to group things.  But for this particular group, I was
wondering if singling out "integer overflow", "zero stuffed
timestamp", etc. into such a finer sub-errors of "you have a bad
timestamp" was beneficial.

>>     BAD_TREE_SHA1 INVALID_OBJECT_SHA1 INVALID_TREE
>> 
>>     BAD_PARENT_SHA1 INVALID_OBJECT_SHA1
>
> So how about s/INVALID_/BAD_/g?

It is not just about distinction between INVAID and BAD.

I was basically wondering what rule decides which one among
BAD_TREE_SHA1, INVALID_OBJECT_SHA1 and INVALID_TREE I would get when
I have a random non-hexdigit string in various places, e.g. after
'tree ' in the object header of a commit object, after 'tag ' in a
tag object that says 'type tree', etc.

>> Also it is unclear if NOT_SORTED is to be used ever for any error
>> other than a tree object sorted incorrectly, or if we start noticing
>> a new error that something is not sorted, we will reuse this one.
>
> s/NOT_SORTED/TREE_&/ maybe?

If that error is specific to tree sorting order, then that would be
a definite improvement.

Thanks.
